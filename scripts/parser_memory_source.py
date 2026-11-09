"""Place diagnostic checkpoints in actual parser programs, without substituting their work."""
import importlib.util
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('parser_workspace_measure', ROOT / 'scripts/measure-parser-workspace.py')
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)


def once(source, before, after):
    if source.count(before) != 1:
        raise ValueError('changed parser memory boundary: ' + before)
    return source.replace(before, after)


def native(source, language):
    if language == 'c':
        source = once(source, 'typedef struct { const char *start;',
                      'void parser_memory_checkpoint(unsigned phase);\n\ntypedef struct { const char *start;')
        boundaries = [('        uint64_t begin = now();', 0),
                      ('        uint64_t split = now();', 1),
                      ('        uint64_t built = now();', 2),
                      ('        uint64_t walked = now();', 3),
                      ('        uint64_t released = now();', 4)]
        for boundary, phase in boundaries:
            source = once(source, boundary, boundary + f'\n        parser_memory_checkpoint({phase});')
    elif language == 'rs':
        source = once(source, '#[derive(Clone, Copy)]',
                      'extern "C" { fn parser_memory_checkpoint(phase: u32); }\n\n#[derive(Clone, Copy)]')
        for boundary, phase in [('        let begin = Instant::now();', 0),
                                ('        let split = Instant::now();', 1),
                                ('        let built = Instant::now();', 2),
                                ('        let walked = Instant::now();', 3),
                                ('        let released = Instant::now();', 4)]:
            source = once(source, boundary, boundary + f'\n        unsafe {{ parser_memory_checkpoint({phase}); }}')
    else:
        raise ValueError('unknown native parser language: ' + language)
    return source


def fwp(source, diagnostic):
    identities = re.findall(r'\{1, e(\d+), "calculate", &fwp_owned_info(\d+)\}', source)
    if len(identities) != 1 or identities[0][0] != identities[0][1]:
        raise ValueError('missing unary owned calculate entry')
    entry = identities[0][0]
    if f'static V fwp_owned_entry{entry}(V *a) {{' not in source:
        raise ValueError('missing owned calculate definition')
    source = once(source, 'static void *fwp_main_thread(void *arg) {',
                  'int parser_memory_main(int, char **);\nstatic void *fwp_main_thread(void *arg) {')
    source = once(source, '    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);',
                  '    fwp_exit_code = parser_memory_main(fwp_argc, fwp_argv);')
    main = (ROOT / 'tests/fixtures/parser_memory_fwp.c').read_text().replace('@entry@', entry)
    if diagnostic:
        source = once(source, 'typedef uint64_t V;',
                      'typedef uint64_t V;\nvoid parser_memory_checkpoint(unsigned);\nstatic size_t parser_memory_nodes;')
        names = re.findall(r'/\* (calculate \[region \d+\]) :', source)
        if len(names) != 1:
            raise ValueError('expected the current calculate region proof')
        root = MEASURE.definition(source, names[0])
        words = MEASURE.definition(source, 'words')
        words_id, = re.findall(r'static V (f\d+)\(', words[0])
        body = root[0]
        for pattern, phase in [(r'    V t\d+ = ' + words_id + r'\(l\d+\);', 1),
                               (r'    fwp_wr\d+ t\d+ = w\d+\(l\d+(?:, l\d+)?\);', 2)]:
            calls = re.findall(pattern, body)
            if len(calls) != 1:
                raise ValueError(f'changed parser phase {phase}: {calls}')
            body = once(body, calls[0], calls[0] + f'\n    parser_memory_checkpoint({phase});')
        source = source[:root.start()] + body + source[root.end():]
        source = once(source, 'static void fwp_region_release(void *context) {',
                      'static void fwp_region_release(void *context) {\n    parser_memory_checkpoint(3);')
        source = once(source, '    return PTR(node);', '    parser_memory_nodes++;\n    return PTR(node);')
        main = main.replace('@ready@', 'parser_memory_nodes = 0;\n    parser_memory_checkpoint(0);')
        main = main.replace('@released@', 'parser_memory_checkpoint(4);')
        main = main.replace('@nodes@', 'if (parser_memory_nodes != nodes) return 96;')
        main = main.replace('@output@', 'printf("{\\"result\\":%" PRId64 ",\\"rounds\\":1,\\"observedNodes\\":%zu}\\n", (int64_t)result, parser_memory_nodes);')
    else:
        main = main.replace('@ready@', '').replace('@released@', '').replace('@nodes@', '')
        main = main.replace('@output@', 'printf("{\\"result\\":%" PRId64 ",\\"rounds\\":1}\\n", (int64_t)result);')
    return source + '\n' + main

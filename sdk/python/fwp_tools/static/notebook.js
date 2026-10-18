const $ = (selector, root = document) => root.querySelector(selector);
const make = (tag, className, text) => { const node = document.createElement(tag); if (className) node.className = className; if (text !== undefined) node.textContent = text; return node; };
const newCell = (kind, source = '') => ({id: crypto.randomUUID(), kind, source});
let notebook = {format: 'fwp-notebook', version: 1, title: 'A calculation in pipes', cells: [
  newCell('markdown', '# Distance, one pipe at a time\nA scalar is one number. `hypot` computes the distance from two coordinates without overflowing merely because their squares are too large.\n\nChange either coordinate below, then run the result cell. `x | hypot y` passes x as the final argument.'),
  newCell('code', 'x = 3.0\ny = 4.0'),
  newCell('code', 'x | hypot y'),
  newCell('markdown', '## A check we can read\n`==` compares two values and returns `True` or `False`. Arithmetic binds more tightly than comparison, so the next cell checks that two squared coordinates sum to 25.'),
  newCell('code', 'x * x + y * y == 25.0'),
]};
let results = new Map(), dependencies = {}, busy = false, revision = 0, stopped = false;

function markdown(source, parent) {
  // Deliberately render text, never raw HTML. Code and explanations in a loaded
  // notebook must not acquire browser scripting privileges.
  let code = null, list = null;
  for (const line of source.split('\n')) {
    if (line.startsWith('```')) { if (code) code = null; else { code = make('code'); const pre = make('pre'); pre.append(code); parent.append(pre); } list = null; continue; }
    if (code) { code.append(document.createTextNode(`${line}\n`)); continue; }
    if (!line.trim()) { list = null; continue; }
    const heading = /^(#{1,3})\s+(.*)$/.exec(line);
    const bullet = /^[-*]\s+(.*)$/.exec(line);
    let node;
    if (heading) { node = make(`h${heading[1].length}`); list = null; }
    else if (bullet) { if (!list) { list = make('ul'); parent.append(list); } node = make('li'); }
    else { node = make('p'); list = null; }
    const text = heading ? heading[2] : bullet ? bullet[1] : line;
    text.split(/(`[^`]+`)/).forEach(part => node.append(part.startsWith('`') ? make('code', '', part.slice(1, -1)) : document.createTextNode(part)));
    (bullet ? list : parent).append(node);
  }
}
function markEdited() {
  revision += 1;
  // Definitions can affect type/trait/macro resolution, not only lexical value
  // references. Invalidate conservatively rather than displaying a stale value
  // as current. The dependency list remains useful for understanding the code.
  for (const result of results.values()) result.state = 'stale';
  $('#status').textContent = 'Edited · results need a run';
  refreshStatuses();
}
function refreshStatuses() {
  notebook.cells.forEach((cell, i) => {
    const state = results.get(cell.id)?.state || 'not run';
    const card = document.getElementById(cell.id);
    if (card) { const badge = $('.badge', card); badge.textContent = cell.kind === 'markdown' ? 'note' : state; badge.className = `badge ${state}`; }
    const link = $(`[data-cell="${cell.id}"]`, $('#outline'));
    if (link) link.className = state;
  });
}
function action(label, title, callback) { const button = make('button', '', label); button.title = title; button.setAttribute('aria-label', title); button.onclick = callback; return button; }
function render() {
  $('#title').value = notebook.title;
  $('#cells').replaceChildren(); $('#outline').replaceChildren();
  notebook.cells.forEach((cell, i) => {
    const card = make('section', 'cell'); card.id = cell.id;
    card.append(make('span', 'cell-number', String(i + 1)));
    const panel = make('div', 'cell-panel'), toolbar = make('div', 'cell-toolbar');
    toolbar.append(make('span', 'cell-label', cell.kind === 'code' ? 'fwp code' : 'Markdown'), make('span', 'badge'));
    const editor = make('textarea'); editor.value = cell.source; editor.spellcheck = false;
    editor.setAttribute('aria-label', `${cell.kind} cell ${i + 1}`);
    const preview = make('div', 'markdown');
    if (cell.kind === 'markdown') {
      markdown(cell.source, preview); editor.hidden = true;
      toolbar.append(action('Edit', `Edit Markdown cell ${i + 1}`, () => { editor.hidden = !editor.hidden; preview.hidden = !editor.hidden; if (!editor.hidden) editor.focus(); else { preview.replaceChildren(); markdown(cell.source, preview); } }));
    } else toolbar.append(action('Run', `Run cell ${i + 1}`, () => run([cell.id])));
    toolbar.append(action('↑', `Move cell ${i + 1} up`, () => move(i, -1)), action('↓', `Move cell ${i + 1} down`, () => move(i, 1)), action('Delete', `Delete cell ${i + 1}`, () => { notebook.cells.splice(i, 1); results.delete(cell.id); markEdited(); render(); }));
    editor.oninput = () => { cell.source = editor.value; markEdited(); };
    editor.onkeydown = event => {
      if (event.key === 'Enter' && (event.ctrlKey || event.metaKey)) { event.preventDefault(); if (cell.kind === 'code') run([cell.id]); }
      else if (event.key === 'Tab' && cell.kind === 'code') { event.preventDefault(); editor.setRangeText('    ', editor.selectionStart, editor.selectionEnd, 'end'); cell.source = editor.value; markEdited(); }
    };
    const output = make('div', 'output');
    const result = results.get(cell.id);
    if (result?.reply) {
      const reply = result.reply;
      if (reply.compile_output) output.append(make('pre', 'stdout', `Compile-time output:\n${reply.compile_output}`));
      if (reply.stdout) output.append(make('pre', 'stdout', reply.stdout));
      if (reply.stderr) output.append(make('pre', 'error', reply.stderr));
      if (reply.error) output.append(make('pre', 'error', reply.error));
      else if (reply.result?.value !== null && reply.result?.value !== undefined) output.append(make('pre', 'value', reply.result.value));
      else if (reply.result?.signatures) output.append(make('pre', '', reply.result.signatures));
    }
    panel.append(toolbar, editor); if (cell.kind === 'markdown') panel.append(preview); else panel.append(output);
    if (dependencies[cell.id]?.length) {
      const indexes = dependencies[cell.id].map(id => notebook.cells.findIndex(c => c.id === id) + 1);
      panel.append(make('div', 'dependencies', `Uses definitions or context from cells ${indexes.join(', ')}`));
    }
    card.append(panel); $('#cells').append(card);
    const link = make('a', '', `${i + 1} · ${cell.source.split('\n').find(s => s.trim())?.replace(/^#+\s*/, '').slice(0, 26) || 'Empty cell'}`);
    link.href = `#${cell.id}`; link.dataset.cell = cell.id; $('#outline').append(link);
  });
  refreshStatuses(); setBusy(busy);
}
function move(index, delta) { const target = index + delta; if (target < 0 || target >= notebook.cells.length || busy) return; [notebook.cells[index], notebook.cells[target]] = [notebook.cells[target], notebook.cells[index]]; markEdited(); render(); }
function setBusy(value) { busy = value; $('#run-all').disabled = value; $('#stop').disabled = !value; $('#open').disabled = value; for (const card of $('#cells').children) for (const button of card.querySelectorAll('button')) button.disabled = value; }
async function api(path, body) { const response = await fetch(path, {method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify(body)}); const result = await response.json(); if (!response.ok) throw new Error(result.error || `Request failed (${response.status})`); return result; }
async function run(cells) {
  if (busy) return;
  const startedRevision = revision; stopped = false; setBusy(true); $('#status').textContent = 'Running…';
  try {
    const response = await api('/run', {document: notebook, cells}); dependencies = response.dependencies;
    for (const [id, reply] of Object.entries(response.results)) results.set(id, {reply, state: startedRevision === revision ? (reply.error ? 'error' : 'current') : 'stale'});
    $('#status').textContent = startedRevision === revision ? 'Finished' : 'Edited during execution · results are stale';
  } catch (error) { if (!stopped) showError(error.message); $('#status').textContent = stopped ? 'Stopped · run a cell to restart' : 'Needs attention'; }
  finally { setBusy(false); render(); }
}
function showError(message) { $('#error-text').textContent = message; $('#error').showModal(); }
$('#close-error').onclick = () => $('#error').close();
$('#run-all').onclick = () => run(notebook.cells.filter(c => c.kind === 'code').map(c => c.id));
$('#stop').onclick = async () => {
  stopped = true;
  try { await api('/interrupt', {}); markEdited(); $('#status').textContent = 'Stopped · run a cell to restart'; }
  catch (error) { stopped = false; showError(error.message); }
};
$('#title').oninput = event => { notebook.title = event.target.value; };
$('#add-code').onclick = () => add('code'); $('#add-markdown').onclick = () => add('markdown');
function add(kind) { const cell = newCell(kind); notebook.cells.push(cell); markEdited(); render(); const card = document.getElementById(cell.id); if (kind === 'markdown') $('.cell-toolbar button', card).click(); $('textarea', card).focus(); }
$('#save').onclick = () => { const blob = new Blob([JSON.stringify(notebook, null, 2) + '\n'], {type: 'application/json'}); const url = URL.createObjectURL(blob); const anchor = make('a'); anchor.href = url; anchor.download = (notebook.title.replace(/[^\p{L}\p{N}_-]+/gu, '-').slice(0, 80) || 'notebook') + '.fwpnb'; anchor.click(); URL.revokeObjectURL(url); $('#status').textContent = 'Notebook downloaded · source only'; };
$('#open').onclick = () => $('#file').click();
$('#file').onchange = async event => {
  try {
    const file = event.target.files[0]; if (!file) return; if (file.size > 2 * 1024 * 1024) throw new Error('Notebook is larger than 2 MiB.');
    const loaded = JSON.parse(await file.text());
    if (loaded.format !== 'fwp-notebook' || loaded.version !== 1 || typeof loaded.title !== 'string' || !Array.isArray(loaded.cells) || loaded.cells.length > 500 || loaded.cells.some(c => !['code', 'markdown'].includes(c.kind) || typeof c.source !== 'string')) throw new Error('Expected a version 1 fwp notebook with code and Markdown cells.');
    // Fresh IDs keep imported text out of selector syntax and discard all runtime
    // state. Opening a document never runs its code.
    loaded.cells = loaded.cells.map(c => newCell(c.kind, c.source)); notebook = loaded; results = new Map(); dependencies = {}; markEdited(); render();
  } catch (error) { showError(error.message); } finally { event.target.value = ''; }
};
render();

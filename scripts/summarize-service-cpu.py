#!/usr/bin/env python3
"""Summarize verified service CPU samples; percentages are not peer time ratios."""
import argparse
from collections import Counter
import json
from pathlib import Path

from cpu_samples import stacks, unknown_frame
from service_cpu_audit import audit_replay


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--functions', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--decoder', required=True)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    args = parser.parse_args()
    names = json.loads(args.functions.read_text())
    verification = audit_replay(args.input, args.source, args.decoder, args.arch, names)
    replay = json.loads((args.input/'summary.json').read_text())
    profiles = {}
    for key, profile in replay['profiles'].items():
        attribution = profile['attribution']
        samples = stacks((args.input/key/'user-stacks.demangled.txt').read_text())
        total = attribution['period']
        operations, phases, leaves = Counter(), Counter(), Counter()
        for row in attribution['rows']:
            operations[row['operation']] += row['period']
            phases[row['phase']] += row['period']
        for sample in samples:
            leaf = sample['frames'][0]['symbol'] if sample['frames'] else '[no decoded frame]'
            leaves[leaf] += sample['period']
        unknown = sum(s['period'] for s in samples if not s['frames'] or unknown_frame(s['frames'][0]))
        cleanup = leaves['fwp_cleanup_push'] + leaves['fwp_cleanup_pop']
        assert sum(leaves.values()) == sum(phases.values()) == sum(operations.values()) == total
        profiles[key] = dict(samples=attribution['samples'], period=total,
            serviceSamples=attribution['serviceSamples'],
            samplesWithUnknownFrames=attribution['samplesWithUnknownFrames'],
            samplesWithoutFrames=attribution['samplesWithoutFrames'],
            unknownLeafPercent=100*unknown/total, cleanupPushPopLeafPercent=100*cleanup/total,
            operationPercent={k:100*v/total for k,v in operations.items()},
            phasePercent={k:100*v/total for k,v in phases.items()},
            leafPercent={k:100*v/total for k,v in leaves.most_common()})
    result = dict(recordingSource=args.source, decoderSource=args.decoder,
                  arch=args.arch, verification=verification, profiles=profiles)
    args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(f'{args.arch}: {len(profiles)} profiles reconstructed; all periods accounted for')


if __name__ == '__main__':
    main()

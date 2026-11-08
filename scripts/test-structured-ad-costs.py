#!/usr/bin/env python3
"""Independent objective and timing-protocol controls for structured gradients."""
from collections import Counter
import copy
from fractions import Fraction
import unittest

from structured_ad_costs import callback_cases, cases, entry_and_drops, expected, inputs, matrix
from structured_ad_statistics import interval, order, summarize


def samples(methods):
    times = {'reverse': 100, 'forward': 200, 'local': 50, 'tensor': 75}
    return [dict(round=number, role=role, constructionNs=10,
        computationNs=times[role.removesuffix('-copy')], releaseNs=10,
        processNs=1000, checksum=7, initialLiveBytes=320, finalLiveBytes=320)
        for number in range(-2,24) for role in order(methods,number)]


class StructuredComparison(unittest.TestCase):
    def test_declared_work_and_analytic_gradients(self):
        workload=list(cases())
        self.assertEqual(len(workload),14)
        self.assertEqual(sum(len(case['methods']) for case in workload),41)
        self.assertEqual(len({case['name'] for case in workload}),14)
        for case in workload:
            self.assertEqual(case['repeats'],32 if case['count']<=3 else 1)
            self.assertEqual(len(expected(case['family'],case['count'])),case['count'])
        for actual,wanted in zip(expected('neighbors',3),[-215.6,792.0,-440.0]):
            self.assertAlmostEqual(actual,wanted,places=10)
        self.assertEqual(expected('independent',5),[-2.8125,1.5,0.0,-1.5,2.8125])
        self.assertEqual(expected('dense',1),[-0.244140625])
        self.assertEqual(expected('neighbors',1),[0.0])

    def test_frozen_callback_cases_and_baseline_pairing(self):
        workload=list(callback_cases())
        self.assertEqual(len(workload),14)
        self.assertEqual(len({case['name'] for case in workload}),14)
        self.assertTrue(all(case['repeats']==256 and case['methods']==('baseline','candidate')
                            for case in workload))
        self.assertEqual([case['name'] for case in workload if case['method']=='local'],
            ['neighbors-0-local','neighbors-1-local','neighbors-3-local','neighbors-33-local',
             'neighbors-129-local','independent-0-local','independent-1-local',
             'independent-16-local','independent-129-local'])
        rows=samples(('reverse','local'))
        for row in rows:
            row['role']=row['role'].replace('reverse','baseline').replace('local','candidate')
        report=summarize(rows,('baseline','candidate'),256,'baseline')
        self.assertEqual(report['vsBaseline']['candidate']['ratio'],0.5)
        self.assertEqual(report['vsBaseline']['candidate']['reference'],'baseline')

    def test_dense_gradient_against_exact_quadratic_difference(self):
        for count in (1,3):
            point=list(map(Fraction,inputs('dense',count)))
            weights=[list(map(Fraction,row)) for row in matrix(count)]
            def objective(values):
                return sum(sum(a*x for a,x in zip(row,values))**2 for row in weights)/2
            derivatives=[]
            step=Fraction(1,64)
            for index in range(count):
                before=point.copy();after=point.copy()
                before[index]-=step;after[index]+=step
                derivatives.append(float((objective(after)-objective(before))/(2*step)))
            self.assertEqual(expected('dense',count),derivatives)

    def test_rotations_balance_every_position(self):
        for methods in (('reverse','forward'),('reverse','forward','local'),
                        ('reverse','forward','local','tensor')):
            labels=order(methods,0)
            for position in range(len(labels)):
                self.assertEqual(Counter(order(methods,number)[position] for number in range(24)),
                                 Counter({role:24//len(labels) for role in labels}))

    def test_paired_results_and_noisy_copy_rejection(self):
        methods=('reverse','forward','local')
        rows=samples(methods)
        report=summarize(rows,methods,1,'reverse')
        self.assertEqual(report['vsReverse']['local']['direction'],'faster')
        self.assertEqual(report['vsReverse']['local']['interval95'],[0.5,0.5])
        self.assertEqual(report['vsReverse']['forward']['direction'],'slower')
        noisy=copy.deepcopy(rows)
        for row in noisy:
            if row['role']=='reverse-copy':
                row['computationNs']=120
        report=summarize(noisy,methods,1,'reverse')
        self.assertTrue(all(row['direction']=='inconclusive' and not row['copyQualified']
                            for row in report['vsReverse'].values()))
        self.assertEqual(interval([1.0]*24),[1.0,1.0])

    def test_incomplete_duplicate_and_changed_results_are_rejected(self):
        methods=('reverse','forward')
        rows=samples(methods)
        bad_checksum=copy.deepcopy(rows);bad_checksum[-1]['checksum']=8
        bad_storage=copy.deepcopy(rows);bad_storage[-1]['finalLiveBytes']=352
        zero_clock=copy.deepcopy(rows);zero_clock[-1]['computationNs']=0
        for bad in (rows[:-1],rows+[rows[0]],bad_checksum,bad_storage,zero_clock):
            with self.assertRaises(AssertionError):
                summarize(bad,methods,1,'reverse')

    def test_exact_owned_entry_and_typed_destructors_are_required(self):
        source='''/* measure : List[List[F64]] -> List[F64] -> List[F64] */
static V f7(V l0, V l1) { return l1; }
/* List[F64] */
static void fwp_drop1(V v) {}
/* List[List[F64]] */
static void fwp_drop2(V v) {}
'''
        self.assertEqual(entry_and_drops(source),('f7','fwp_drop1','fwp_drop2'))
        for bad in (source.replace('V l0, V l1','V l0'),
                    source.replace('/* measure :','/* another :'),
                    source.replace('/* List[F64] */','/* Array[F64] */'),
                    source+'/* List[F64] */\nstatic void fwp_drop3(V v) {}\n'):
            with self.assertRaises(AssertionError):
                entry_and_drops(bad)


if __name__=='__main__':
    unittest.main()

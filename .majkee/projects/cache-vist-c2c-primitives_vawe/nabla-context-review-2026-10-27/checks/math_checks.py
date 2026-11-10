#!/usr/bin/env python3
"""Reproduce bounded algebraic examples from the reviewed research.

Requires Python 3.10+ and NumPy. No network, model calls, or user-session access.
These checks validate constructions/counterexamples, not agent performance.
Run: python checks/math_checks.py --out checks/results.json
"""
from __future__ import annotations

import argparse
import itertools
import json
import math
import platform
import sys
from pathlib import Path
from typing import Callable, Any

import numpy as np


def close(actual: Any, expected: Any, *, atol: float = 1e-10) -> None:
    if not np.allclose(actual, expected, atol=atol, rtol=1e-10):
        raise AssertionError(f"{actual!r} != {expected!r}")


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def cp_permutation() -> dict[str, Any]:
    rng = np.random.default_rng(42)
    a, b, c = [rng.normal(size=(n, 2)) for n in (3, 7, 4)]
    fitted = np.einsum('ar,tr,cr->atc', a, b, c)
    observed = fitted + rng.normal(scale=0.1, size=fitted.shape)
    mask = rng.random(fitted.shape) > 0.2
    order = rng.permutation(7)
    before = np.linalg.norm((observed - fitted)[mask])
    permuted_fit = np.einsum('ar,tr,cr->atc', a, b[order], c)
    after = np.linalg.norm((observed[:, order] - permuted_fit)[mask[:, order]])
    close(before, after)
    return {'residual_before': float(before), 'residual_after': float(after),
            'conclusion': 'Common time permutation preserves this masked residual. No CP fitting or forecasting was performed.'}


def truncation_not_sparsification() -> dict[str, Any]:
    lap = np.array([[1., -1., 0.], [-1., 2., -1.], [0., -1., 1.]])
    vals, vecs = np.linalg.eigh(lap)
    truncated = (vecs[:, :2] * vals[:2]) @ vecs[:, :2].T
    v = vecs[:, 2]
    original_energy = float(v @ lap @ v)
    truncated_energy = float(v @ truncated @ v)
    require(original_energy > 0.0, 'Need a discarded positive mode')
    close(truncated_energy, 0.0)
    require(truncated_energy < 0.5 * original_energy, 'Lower sparsifier bound should fail')
    return {'original_energy': original_energy, 'truncated_energy': truncated_energy,
            'conclusion': 'Discarding a positive mode violates the all-vectors lower sparsifier bound for epsilon=0.5.'}


def coalition() -> dict[str, Any]:
    voters = set(range(4))
    def mu(s: set[int]) -> float:
        return 0.5 * ({0, 1} <= s) + 0.5 * ({2, 3} <= s)
    subsets = [set(s) for n in range(5) for s in itertools.combinations(voters, n)]
    close(mu(set()), 0.0)
    close(mu(voters), 1.0)
    for a in subsets:
        for b in subsets:
            if a <= b:
                require(mu(a) <= mu(b), 'Capacity is not monotone')
    shapley = np.zeros(4)
    for perm in itertools.permutations(range(4)):
        previous: set[int] = set()
        for i in perm:
            shapley[i] += (mu(previous | {i}) - mu(previous)) / math.factorial(4)
            previous.add(i)
    close(shapley, np.full(4, 0.25))
    rng = np.random.default_rng(43)
    for x in rng.random((100, 4)):
        order = np.argsort(x)
        last = direct = 0.0
        for j, i in enumerate(order):
            direct += (float(x[i]) - last) * mu(set(map(int, order[j:])))
            last = float(x[i])
        mobius = 0.5 * min(x[0], x[1]) + 0.5 * min(x[2], x[3])
        close(direct, mobius)
    return {'shapley': shapley.tolist(), 'mu_pair_12': mu({0, 1}), 'mu_pair_13': mu({0, 2}),
            'graded_vectors_checked': 100,
            'conclusion': 'Equal Shapley values do not imply identity-blind coalition scores.'}


def affine_cycle() -> dict[str, Any]:
    bmat = np.array([[-1., 1., 0.], [0., -1., 1.], [1., 0., -1.]])
    targets = np.array([1., 1., -1.])
    state = np.linalg.lstsq(bmat, targets, rcond=None)[0]
    residual = float(np.linalg.norm(bmat @ state - targets) ** 2)
    close(residual, 1/3)
    close(bmat @ np.zeros(3), np.zeros(3))
    return {'minimum_squared_residual': residual,
            'conclusion': 'The pinned affine cycle is inconsistent; the homogeneous system still has a zero section.'}


def branching() -> dict[str, Any]:
    k = np.array([[0.6, 0.7], [0., 0.6]])
    radius = float(max(abs(np.linalg.eigvals(k))))
    first = float((k @ np.array([0., 1.])).sum())
    close(radius, 0.6)
    close(first, 1.3)
    return {'spectral_radius': radius, 'first_generation_total': first,
            'conclusion': 'Subcritical asymptotics can coexist with transient amplification; this is not a pollution detector.'}


def fisher_rao() -> dict[str, Any]:
    p, q = np.array([0.9, 0.1]), np.array([0.1, 0.9])
    bc = float(np.sqrt(p*q).sum())
    distance = 2 * math.acos(max(-1.0, min(1.0, bc)))
    close(bc, 0.6)
    close(np.linalg.norm(2*np.sqrt(p)), 2.0)
    close(distance, 1.8545904360032246)
    return {'distance': distance, 'embedding_radius': 2.0,
            'conclusion': 'Categorical Fisher-Rao convention uses radius two. No stance extraction was evaluated.'}


def graph_coverage() -> dict[str, Any]:
    graph = {'s': ['a', 'b'], 'a': ['s'], 'b': []}
    revisit_walk = ['s', 'a', 's']
    seen: set[str] = set()
    frontier = ['s']
    while frontier:
        node = frontier.pop()
        if node in seen:
            continue
        seen.add(node)
        frontier.extend(graph[node])
    require(set(revisit_walk) != seen, 'Revisit should miss a branch')
    require(all(set(graph[n]) <= seen for n in seen), 'Frontier enumeration is incomplete')
    return {'revisit_walk_coverage': sorted(set(revisit_walk)), 'reachable': sorted(seen),
            'conclusion': 'A revisit is not a coverage certificate; enumerated successor closure is stronger.'}


def sampling() -> dict[str, Any]:
    kh = 3.0
    exact, euler = math.exp(-kh), 1-kh
    require(abs(exact) < 1 and abs(euler) > 1, 'Expected different stability behavior')
    return {'kh': kh, 'exact_pole': exact, 'euler_pole': euler,
            'conclusion': 'Sampling a continuous solution differs from discretizing its dynamics by Euler.'}


def rank_is_not_information() -> dict[str, Any]:
    def effective_rank(matrix: np.ndarray) -> float:
        singular = np.linalg.svd(matrix, compute_uv=False)
        weights = singular[singular > 1e-12]
        weights = weights / weights.sum()
        return float(np.exp(-np.sum(weights*np.log(weights))))
    high_plus = high_minus = np.eye(8)
    low_plus = np.ones((8, 8))
    low_minus = -low_plus
    require(np.array_equal(high_plus, high_minus), 'High-rank example must hide the label')
    require(np.sign(low_plus[0, 0]) != np.sign(low_minus[0, 0]), 'Rank-one example must expose the label')
    high, low = effective_rank(high_plus), effective_rank(low_plus)
    close(high, 8.0)
    close(low, 1.0)
    return {'label_independent_matrix_effective_rank': high, 'label_encoding_matrix_effective_rank': low,
            'conclusion': 'Singular-value spread alone does not establish task information. This does not refute C2C experimental performance.'}


def scratch_budget() -> dict[str, Any]:
    def quality(x: np.ndarray | float, a: float) -> Any:
        return 1 - np.exp(-x) - a*x
    b = -math.log(0.2)
    close(math.exp(-b)-0.2, 0.0)
    grid = np.linspace(0, 5, 10001)
    require(float(quality(b, .2)) >= float(quality(grid, .2).max()) - 1e-10, 'Interior maximum mismatch')
    close(float(quality(grid, 1.2).max()), 0.0)
    return {'interior_maximum_for_a_0_2': b, 'maximum_budget_for_a_1_2': 0.0,
            'conclusion': 'A useful nonzero intermediate budget is not guaranteed by this model.'}


def sparse_tensor_equals_join() -> dict[str, Any]:
    # event, actor, kind, concept, value -- categorical axes have an explicitly fixed codebook.
    rows = [(0, 0, 0, 1, 1.), (1, 1, 1, 0, 1.), (2, 0, 1, 1, 2.), (2, 1, 1, 0, .5)]
    x = np.zeros((3, 2, 2, 2))
    for e, a, k, c, value in rows:
        x[e, a, k, c] += value
    weights = np.arange(8, dtype=float).reshape(2, 2, 2) / 7
    contracted = np.einsum('eakc,akc->e', x, weights)
    relational = np.array([sum(v*weights[a,k,c] for e,a,k,c,v in rows if e == event) for event in range(3)])
    close(contracted, relational)
    return {'event_scores': contracted.tolist(),
            'conclusion': 'This tensor contraction is exactly an ordinary grouped weighted join. Tensor notation is not evidence of extra capability.'}


def diffusion() -> dict[str, Any]:
    w = np.array([[0.,1.,0.],[1.,0.,1.],[0.,1.,0.]])
    d = w.sum(axis=0)
    p = w / d[None, :]
    q = np.array([1., 0., 0.])
    alpha = .85
    t = alpha/(1-alpha)
    # P = D^(1/2) S D^(-1/2), where S is symmetric.
    s = w / np.sqrt(np.outer(d,d))
    vals, u = np.linalg.eigh(np.eye(3)-s)
    symmetric_heat = (u*np.exp(-t*vals)) @ u.T
    heat = np.sqrt(d) * (symmetric_heat @ (q/np.sqrt(d)))
    restart = (1-alpha)*np.linalg.solve(np.eye(3)-alpha*p, q)
    close(heat.sum(), 1.)
    close(restart.sum(), 1.)
    require(bool(np.all(heat >= -1e-10) and np.all(restart >= -1e-10)), 'Negative probability')
    require(not np.allclose(heat, restart, atol=1e-5), 'Matched means should not imply identical operators')
    return {'heat': heat.tolist(), 'pagerank': restart.tolist(), 'matched_mean_walk_length': t,
            'conclusion': 'Both distributions conserve probability; matching mean walk lengths does not make the filters equal.'}


CHECKS: list[tuple[str, Callable[[], dict[str, Any]]]] = [
    ('cp_common_time_permutation', cp_permutation),
    ('low_rank_is_not_sparsifier', truncation_not_sparsification),
    ('coalition_identity', coalition),
    ('affine_cycle_obstruction', affine_cycle),
    ('subcritical_transient_amplification', branching),
    ('fisher_rao_scale', fisher_rao),
    ('revisit_is_not_coverage', graph_coverage),
    ('sampling_vs_euler', sampling),
    ('effective_rank_not_semantic_information', rank_is_not_information),
    ('scratch_budget_boundary', scratch_budget),
    ('tensor_contraction_vs_relational_join', sparse_tensor_equals_join),
    ('heat_vs_restart_walk', diffusion),
]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, default=Path('results.json'))
    args = parser.parse_args()
    results = []
    for name, test in CHECKS:
        try:
            values = test()
            results.append({'name': name, 'status': 'PASS', 'values': values})
        except Exception as exc:
            results.append({'name': name, 'status': 'FAIL', 'error': f'{type(exc).__name__}: {exc}'})
    report = {'kind': 'synthetic-and-algebraic-checks', 'seeded': True,
              'environment': {'python': platform.python_version(), 'numpy': np.__version__},
              'tests': results, 'passed': sum(r['status'] == 'PASS' for r in results),
              'total': len(results), 'live_agent_tests': False, 'paid_inference': False}
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(json.dumps(report, indent=2, allow_nan=False) + '\n', encoding='utf-8')
    for result in results:
        print(f"{result['status']} {result['name']}")
    print(f"{report['passed']}/{report['total']} passed; report: {args.out}")
    return 0 if report['passed'] == report['total'] else 1


if __name__ == '__main__':
    sys.exit(main())

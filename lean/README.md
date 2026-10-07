# Lean companion for the Ansari sieve identity counterfamily

This package formalizes the arithmetic claim in James E. Dunn, *An Infinite
Counterfamily to a Set Identity in a Recursive Collatz Sieve* (draft, 6 October
2026). It checks the `n = 2` specialization of a displayed equality in the
proof of Lemma 3.1 of Mohammad Ansari, “Recursive sufficiency for the Collatz
conjecture and computational verification,” *Notes on Number Theory and
Discrete Mathematics* 31, no. 3 (2025), 471–480,
[doi:10.7546/nntdm.2025.31.3.471-480](https://doi.org/10.7546/nntdm.2025.31.3.471-480).

## Build

Install [Lean through elan](https://lean-lang.org/install/) and run from this
directory:

```sh
lake build
lake env lean AnsariSieveIdentity.lean
```

The `lean-toolchain` file pins `leanprover/lean4:v4.33.1`. `lakefile.toml` has no
external `require` entries: Mathlib, the older `CollatzLeanCore.Ground` module,
and archived build artifacts are not needed. `lake build` compiles the single
`AnsariSieveIdentity` library. The second command rechecks it and prints the
axiom reports. The only imported module is Lean's bundled
`Lean.Elab.Tactic.Omega`.

## Mathematical statement and theorem map

The source treats each sieve as a predicate on `Nat`. Every quantified
parameter, including the leading index `k`, ranges over nonnegative integers.
Bounds such as `a0 ≤ 1` represent the printed digit ranges.

| Manuscript item | Lean declaration | What it checks |
| --- | --- | --- |
| Preceding sieve | `F2` | The `n = 2` instance of equation (1) |
| Next sieve | `F3` | The `n = 3` instance of equation (1) |
| Enlarged sieve | `Fprime2` | The displayed `F′₂` digit ranges in Lemma 3.1 |
| Exceptional set | `Aprime2` | The displayed `A′` at `n = 2` |
| Counterfamily proposition | `counterfamily` | For every `t : Nat`, `75 + 108*t` belongs to `F2` and `Fprime2`, but not `Aprime2` or `F3` |
| Infinitely many distinct examples | `counterfamily_injective`, `counterfamily_unbounded` | Distinct parameters give distinct values, and examples exceed every natural bound |
| Failure of printed identity | `claimed_identity_false` | Refutes `∀ x, F3 x ↔ Fprime2 x ∧ ¬ Aprime2 x` |

The four component lemmas `missing_family_in_F2`,
`missing_family_in_Fprime2`, `missing_family_not_Aprime2`, and
`missing_family_not_F3` supply the bundled proposition.

## Scope and source correspondence

The correspondence between these definitions and the journal's printed
formulas on pages 477–478 was checked by human inspection of the publisher PDF.
Lean does not formalize the PDF, the transcription process, or the general
`n`-indexed construction. In particular, the manuscript's explanatory
identity involving the auxiliary digit sets `B₂` and `C₂` is not a theorem in
this file. The counterfamily and failure of the displayed `n = 2` equality do
not establish that Ansari's ultimate recursive sufficiency statement is
false, and do not bear on the truth of the Collatz conjecture.

The proof uses `omega` to construct proof terms checked by Lean's kernel. It
does not use `sorry`, custom axioms, `native_decide`, or an external solver.
`#print axioms` reports only the standard Lean axioms `propext` and
`Quot.sound`; see [VERIFICATION.md](VERIFICATION.md) for an isolated build
receipt and its limits.

## License

Copyright 2026 James E. Dunn. Original source, build configuration, verification material, and software documentation are licensed under Apache-2.0; see `LICENSE` and `NOTICE`. The external Lean toolchain retains its own license.

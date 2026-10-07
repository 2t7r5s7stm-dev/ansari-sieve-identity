# Verification report

Checked 6 October 2026 UTC on an arm64 macOS host.

## Inputs

- Lean toolchain: `leanprover/lean4:v4.33.1`; `lean --version` reported Lean
  4.33.1, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`.
- Lake: 5.0.0, distributed with that Lean toolchain.
- Original preserved source:
  `ExternalSieveIdentity.lean` from 11 September 2026, SHA-256
  `5d680d065233bd00f92005106cec67fbe0ca589f10959a557f869f483f6a2c13`.
  The original imported `CollatzLeanCore.Ground`. This companion uses Lean's
  bundled Omega tactic and `Nat` syntax instead, preserves the original four
  predicates and five arithmetic/identity declarations in substance, and adds
  `counterfamily`, `counterfamily_injective`, and
  `counterfamily_unbounded`.
- Publisher article PDF used for the separate human source check: SHA-256
  `d242bcefea47316f9f266780b4e46fdf42bc3765c4d221670b19bd89b07620de`.
  The printed `n = 2` definitions and final equality were inspected on pages
  477–478; this correspondence is not certified by Lean.

## Isolation procedure and result

Only `AnsariSieveIdentity.lean`, `lean-toolchain`, and `lakefile.toml` were
copied to a new temporary directory outside the archived project. It
contained no prior `.lake` directory, Mathlib checkout, or old project module.
`LEAN_PATH`, `LEAN_SRC_PATH`, and `LAKE_HOME` were unset. The installed pinned
toolchain's `bin` directory was placed first on `PATH`.

The following commands all exited with status 0:

```sh
lean --version
lake build
lean --deps AnsariSieveIdentity.lean
lean AnsariSieveIdentity.lean
```

`lake build` reported `Build completed successfully (3 jobs)`. The direct
dependency list resolved only to `Init.olean` and
`Lean/Elab/Tactic/Omega.olean` inside the Lean 4.33.1 toolchain; no Mathlib or
`CollatzLeanCore` file was loaded. The eight `#print axioms` reports each listed
`[propext, Quot.sound]`, with no `sorryAx`. The build and axiom output are
included in `verification/clean-build.log` and `verification/axioms.log`.

This checks that the encoded arithmetic theorems compile in an isolated
toolchain environment. It does not mechanically verify that the encoded
definitions reproduce the printed PDF, any general sieve statement, or the
article's final conclusion.

# An Infinite Counterfamily to a Set Identity in a Recursive Collatz Sieve

James E. Dunn, Independent Researcher. ORCID: https://orcid.org/0009-0005-2679-6574.

## Result

The proof of Lemma 3.1 in Ansari's recursive Collatz sieve uses a displayed set identity to complete an induction. At its `n = 2` specialization, every integer `75 + 108t`, with `t` nonnegative, belongs to the proposed set difference but not to the next sieve. This gives an infinite counterfamily to that identity. The arithmetic statement has also been checked in Lean. The result identifies a failure of the displayed induction step; it does not decide whether the paper's recursive sufficiency conclusion admits another proof.

## Contents

- `paper/`: the reviewed manuscript dated 6 October 2026, in PDF and editable DOCX formats.
- `lean/`: the independently packaged Lean companion, pinned toolchain, build instructions, verification report, checksums, and historical build logs.
- `CITATION.cff`: draft citation metadata. No DOI has been assigned to this work.

## Check the companion

Install Lean through the official instructions at https://lean-lang.org/install/. From this repository, run:

```sh
cd lean
lake build
lake env lean AnsariSieveIdentity.lean
```

The package pins Lean 4.33.1 and has no external dependencies. Its eight theorem declarations cover the counterfamily's membership and nonmembership properties, injectivity, unboundedness, and failure of the displayed identity. See `lean/README.md` and `lean/VERIFICATION.md` for exact statements and verification limits.

The encoded definitions were matched to the publisher PDF by human inspection. Lean does not certify that transcription or formalize the article. The result does not establish or refute the Collatz conjecture.

## Status

Private preparation copy. The manuscript and companion have not been published by this preparation step. The author approved CC BY 4.0 for the manuscript and Apache-2.0 for the original software and software documentation. See `LICENSE_SCOPE.md` for scope.

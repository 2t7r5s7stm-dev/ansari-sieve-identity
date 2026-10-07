import Lean.Elab.Tactic.Omega

/-!
# Counterfamily to the displayed sieve identity in Ansari, Lemma 3.1

This file checks arithmetic consequences of the definitions transcribed from
the n = 2 case on pages 477–478 of Ansari's 2025 article. The transcription
from the printed article is a separate human source check, not a theorem here.
No claim about Collatz trajectories or the article's final sufficiency
conclusion is formalized.
-/

namespace AdmissionMethodReview.ExternalSieve

set_option autoImplicit false

/-- Equation (1), specialized to `F₂`. All parameters range over `Nat`. -/
def F2 (x : Nat) : Prop :=
  ∃ k a0 a1 : Nat, a0 ≤ 1 ∧ a1 ≤ 1 ∧ x = 36 * k + 12 * a1 + 4 * a0 + 3

/-- Equation (1), specialized to `F₃`. -/
def F3 (x : Nat) : Prop :=
  ∃ k a0 a1 a2 : Nat, a0 ≤ 1 ∧ a1 ≤ 1 ∧ a2 ≤ 1 ∧
    x = 108 * k + 36 * a2 + 12 * a1 + 4 * a0 + 3

/-- The displayed `F′₂` in the proof of Lemma 3.1. -/
def Fprime2 (x : Nat) : Prop :=
  ∃ k a0 a1 a2 : Nat, a0 ≤ 1 ∧ a1 ≤ 2 ∧ a2 ≤ 2 ∧
    x = 108 * k + 36 * a2 + 12 * a1 + 4 * a0 + 3

/-- The displayed exceptional set `A′` at `n = 2`. -/
def Aprime2 (x : Nat) : Prop :=
  ∃ k a0 : Nat, a0 ≤ 1 ∧ x = 108 * k + 99 + 4 * a0

/-- The counterfamily remains in the preceding sieve. -/
theorem missing_family_in_F2 (t : Nat) : F2 (75 + 108 * t) := by
  exact ⟨2 + 3 * t, 0, 0, by omega, by omega, by omega⟩

/-- The counterfamily is admitted by the enlarged digit set. -/
theorem missing_family_in_Fprime2 (t : Nat) : Fprime2 (75 + 108 * t) := by
  exact ⟨t, 0, 0, 2, by omega, by omega, by omega, by omega⟩

/-- The printed exceptional set does not remove the counterfamily. -/
theorem missing_family_not_Aprime2 (t : Nat) : ¬ Aprime2 (75 + 108 * t) := by
  rintro ⟨k, a0, h0, eq⟩
  omega

/-- The counterfamily does not belong to the next sieve. -/
theorem missing_family_not_F3 (t : Nat) : ¬ F3 (75 + 108 * t) := by
  rintro ⟨k, a0, a1, a2, h0, h1, h2, eq⟩
  omega

/-- All four membership claims used in the manuscript's proposition. -/
theorem counterfamily (t : Nat) :
    F2 (75 + 108 * t) ∧ Fprime2 (75 + 108 * t) ∧
    ¬ Aprime2 (75 + 108 * t) ∧ ¬ F3 (75 + 108 * t) := by
  exact ⟨missing_family_in_F2 t, missing_family_in_Fprime2 t,
    missing_family_not_Aprime2 t, missing_family_not_F3 t⟩

/-- Different natural parameters give different counterexamples. -/
theorem counterfamily_injective : Function.Injective (fun t : Nat => 75 + 108 * t) := by
  intro a b h
  change 75 + 108 * a = 75 + 108 * b at h
  omega

/-- Counterexamples occur above every natural bound. -/
theorem counterfamily_unbounded (bound : Nat) :
    ∃ t : Nat, bound < 75 + 108 * t := by
  refine ⟨bound, ?_⟩
  omega

/-- Refutes the literal equality `F₃ = F′₂ \ A′₂` at `n = 2`. -/
theorem claimed_identity_false :
    ¬ (∀ x : Nat, F3 x ↔ Fprime2 x ∧ ¬ Aprime2 x) := by
  intro identity
  apply missing_family_not_F3 0
  exact (identity _).mpr ⟨missing_family_in_Fprime2 0,
    missing_family_not_Aprime2 0⟩

#print axioms missing_family_in_F2
#print axioms missing_family_in_Fprime2
#print axioms missing_family_not_Aprime2
#print axioms missing_family_not_F3
#print axioms counterfamily
#print axioms counterfamily_injective
#print axioms counterfamily_unbounded
#print axioms claimed_identity_false

end AdmissionMethodReview.ExternalSieve

# Testing Rules

## The core rule
**A task is not done because code was written. It's done because it was
verified to work, and that verification is repeatable by someone else.**
"Repeatable" means: a test, not a one-off manual check that only happened
inside this session.

## Test pyramid
- **Unit tests**: every new function with non-trivial logic (branching,
  calculations, parsing, validation). Fast, no I/O, no network.
- **Integration tests**: every new API endpoint / service boundary / DB
  interaction. Use a real (or realistic, containerized) dependency where
  feasible rather than mocking the thing you're actually trying to verify.
- **End-to-end / browser tests**: user-facing flows that matter to the
  product (checkout, auth, core workflows). This is also what backs the
  Walkthrough artifact in Antigravity — the browser verification step
  should correspond to an actual automated test where the flow is
  significant enough to regress-test, not just a one-time screenshot.

## Sequencing
- For bug fixes: write a test that reproduces the bug *first*, confirm it
  fails, then fix, then confirm it passes. This is non-negotiable — it's
  the only way to know the fix actually addressed the reported bug and not
  a symptom near it.
- For features: tests can be written alongside implementation, but must
  exist before the task is marked done — not deferred to "a follow-up."

## What's not allowed
- Deleting, skipping (`.skip`, `xit`, commented out), or loosening an
  assertion in an existing test to make a build pass. If a test is
  genuinely wrong, say so explicitly and explain why, don't just quiet it.
- Mocking the exact thing under test (e.g., mocking the function you're
  unit-testing rather than its dependencies).
- Claiming coverage without running the suite. Always run it and report
  actual pass/fail counts, not an expectation of what would happen.

## Coverage bar
- TODO: set a real number for this project (e.g. "new code ≥ 80% line
  coverage on touched files"). Don't chase 100% — chase coverage of the
  logic that's actually risky (branches, edge cases, error paths).
- If Agent Skills is installed (`.agents/rules/external-tools.md`), run
  `/constraints` instead of guessing this number freehand, and put the
  resulting number here as a pointer to `CONSTRAINTS.md` rather than a
  second, possibly-conflicting figure.

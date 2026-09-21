# Workflow: Bug Fix

Before step 1: run the **Start** section of
`.agents/workflows/session-protocol.md`. After step 5: run its **End**
section.

## Optional: Agent Skills hooks
If Agent Skills is installed (`.agents/rules/external-tools.md`):

| Step | Skill to invoke |
|---|---|
| 1. Reproduce first | `debugging-and-error-recovery` |
| 3. Fix | keep it to the minimal change — see Ponytail's ladder, same file |
| 4. Verify | `test-driven-development` |

Not installed? Do these steps directly per this file.

## 1. Reproduce first
Before touching any fix code: write a failing test (or reliably reproduce
the bug manually if a test genuinely can't capture it — e.g. a UI timing
issue — and note why). Confirm you understand *why* it fails, not just
that it does. A fix built on a guessed root cause is the single most common
source of AI-generated bugs that "look fixed" but aren't.

## 2. Check blast radius
Is this bug isolated, or a symptom of a broader pattern (e.g. the same
missing validation exists in three other places)? If broader, say so in the
Task List artifact and propose whether to fix just the reported instance or
the pattern — don't silently expand scope, but don't silently ignore the
pattern either.

## 3. Fix
Make the smallest change that addresses the actual root cause. Resist
"while I'm in here" refactors — file them as separate follow-up
suggestions instead.

## 4. Verify
- The reproduction test now passes.
- The full existing test suite still passes (no regression).
- If user-facing, verify in the browser and capture it in the Walkthrough
  artifact.

## 5. Document root cause
In the PR description / task summary, state the root cause in one or two
sentences, not just "fixed the bug." If it revealed a gap in
`.agents/rules/` (a pattern that should've been forbidden, a check that
should've existed), append a line to Project Learnings in `AGENTS.md`.

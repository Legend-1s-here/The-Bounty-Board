# Workflow: New Feature

Follow these phases in order. Do not skip a phase because the feature "seems
simple" — the cost of the phase is small; the cost of skipping it and being
wrong is not.

Before step 1: run the **Start** section of
`.agents/workflows/session-protocol.md`. After step 11: run its **End**
section.

## Optional: Agent Skills hooks
If [Agent Skills](https://github.com/addyosmani/agent-skills) is installed
(see `.agents/rules/external-tools.md`), these steps can delegate to it
instead of being done freehand — invoke the named skill, don't duplicate
its process here:

| Step | Skill to invoke |
|---|---|
| 1. Clarify requirements | `interview-me` (ask is ambiguous) or `spec-driven-development` (needs a PRD) |
| 4. Implementation Plan | `planning-and-task-breakdown`; add `api-and-interface-design` if a public interface changes |
| 5. Implement in vertical slices | `incremental-implementation` |
| 6. Test alongside | `test-driven-development` |
| 9. Human review checkpoint | `code-review-and-quality` |
| 10. CI as the real gate | `ci-cd-and-automation` |

Not installed? Every step below still has to happen — do it directly per
this file's own instructions.

## 1. Clarify requirements
Before any planning artifact: restate the requested feature in your own
words, including acceptance criteria (what specifically must be true for
this to be considered working). If anything is ambiguous — an edge case,
an unclear priority between two reasonable interpretations — surface it as
a question rather than silently picking one. One clarifying question now is
cheaper than a wrong implementation later.

## 2. Architecture check
Check `.agents/rules/architecture.md`. Does this feature trigger the ADR
bar (new dependency, new pattern, schema/API change)? If yes, write the ADR
using `docs/adr/0000-template.md` before proceeding to planning.

## 3. Task List artifact
Produce the Task List artifact: a decomposition of the feature into
ordered, individually-verifiable steps. Each step should be small enough
that if it's wrong, redoing it doesn't waste much work. Wait for review
before starting implementation on anything non-trivial.

## 4. Implementation Plan artifact
For anything touching >3 files, a data model, or an API contract: produce
the Implementation Plan artifact — file-level plan, any new interfaces/
contracts, and how each part will be verified (which tests, what browser
flow). This is the point where a reviewer catches a wrong approach before
code exists, which is far cheaper than catching it in a diff.

## 5. Implement in vertical slices
Build in the smallest slices that are independently testable, running
lint/type-check/unit tests after each slice — not once at the very end.
Catching a broken slice immediately is cheap; catching it after five more
slices were built on top of it is not.

## 6. Test alongside, not after
Per `.agents/rules/testing.md`: unit tests for logic, integration tests for
boundaries, e2e/browser verification for user-facing flows. Run everything
— don't report results you didn't observe.

## 7. Browser verification (if user-facing)
Exercise the actual flow in the browser. Produce the Walkthrough artifact
with screenshots/recording showing it working, including at least one edge
case from the acceptance criteria in step 1, not just the happy path.

## 8. Self-check against Definition of Done
Go through `docs/definition-of-done.md` explicitly. Report which items
pass and call out any that don't, rather than omitting them.

## 9. Human review checkpoint
Present the diff alongside the artifacts. If feedback comes as a comment on
an artifact, incorporate it and note what changed.

## 10. CI as the real gate
Local verification is a signal, not the gate. The task isn't actually done
until the CI pipeline (lint, type-check, full test suite, security scan)
passes independently — CI catches what a single session's context can miss.

## 11. Close the loop
If anything was corrected during review that's project-specific (a
convention, a gotcha), append one line to the "Project Learnings" section
of `AGENTS.md` so the next session doesn't repeat it.

# GEMINI.md — Antigravity-specific instructions
# Highest priority file. Read in addition to AGENTS.md, not instead of it.

## First thing, every session
Follow `.agents/workflows/session-protocol.md` (its "Start" section) before
anything else — including before reading the rest of this file in depth.
It tells you to check `.agents/memory/active-context.md` for current state
and to flag it if `.agents/workflows/bootstrap.md` hasn't been run yet.
Run its "End" section before any task is declared done.

## Artifact discipline (this is the core of the kit)

1. **Always produce a Task List artifact before writing any code**, for any
   task bigger than a one-line fix. Do not begin implementation until the
   plan has been reviewed. If no comment/feedback arrives and the task is
   low-risk, proceed — but the artifact must exist first regardless.

2. **For any task that touches more than ~3 files, or changes a data model,
   an API contract, or a UI flow: also produce an Implementation Plan
   artifact** before coding. It should state: what's being built, the
   file-level plan, and how it will be verified. Wait for approval on this
   one specifically if the change is architecturally significant (see
   `.agents/rules/architecture.md` for what counts).

3. **For any user-facing or UI change: verify it in the browser and produce
   a Walkthrough artifact with screenshots before declaring the task done.**
   A visual claim ("the button now works") must be backed by a screenshot or
   recording showing it working, not just a code diff.

4. **When feedback is left as a comment on an artifact, incorporate it and
   note in the next artifact update what changed as a result.** Don't
   silently revise — make the correction traceable.

5. **On completion, append to the "Project Learnings" section of AGENTS.md**
   if anything was corrected during the task that a future session should
   know (a convention you got wrong, a gotcha you hit). One line, plain
   language.

## Verification bar — what "done" means here

Do not report a task complete unless all of the following were actually
executed, not assumed:
- Relevant tests were run and passed (not just written).
- Lint/type-check ran clean.
- If UI-facing: the change was exercised in the browser and matches the
  Walkthrough artifact.
- The Definition of Done checklist (`docs/definition-of-done.md`) was
  checked against, and any unmet item is called out explicitly rather than
  omitted.

## Scope control for autonomous runs

When operating across editor/terminal/browser without synchronous
supervision: stay inside the current task's Task List. If you discover
something that should change outside that scope, add it as a *new* item to
propose, don't fold it into the current change silently.

## Nested rules

This project may use nested `AGENTS.md` files inside subfolders for
service-specific rules in a monorepo. Respect them as additive to, not a
replacement for, the root rules.

## Context and token discipline

Follow `.agents/rules/context-and-tokens.md` throughout — it governs how
much you read, how you explore, and when to isolate work into a separate
agent/sub-task. It's not optional polish; an agent that reads the whole
repo "to be safe" on every task is the other common way this kit's
guarantees quietly stop being true, alongside skipping artifacts.

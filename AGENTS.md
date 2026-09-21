# AGENTS.md — Project Rules for AI Coding Agents
# Read by Antigravity (v1.20.3+), Cursor, and Claude Code.
# Antigravity-only overrides go in GEMINI.md, not here.

## Project Overview
- **Name:** TODO
- **Type:** TODO (Web App / API / Library / CLI)
- **Stage:** TODO (Prototype / Production / Maintenance)

## Tech Stack
- **Language:** TODO
- **Framework:** TODO
- **Database:** TODO
- **Testing:** TODO (unit framework / e2e framework)
- **Package manager:** TODO
- **Commands:** `TODO install`, `TODO test`, `TODO lint`, `TODO dev`

## Non-negotiables
1. Never report a task as done without having actually run it (tests, build,
   dev server) and observed the result. "This should work" is not done.
2. Never weaken a test, disable a lint rule, or widen a type to make
   something pass. Fix the cause or flag it as a blocker and stop.
3. Never touch code outside the stated scope of the current task. If a fix
   requires touching something out of scope, stop and say so — don't expand
   the blast radius unilaterally.
4. Any new external dependency, new architectural pattern, or change to a
   public API/interface requires an ADR (see `docs/adr/0000-template.md`)
   before implementation, not after.
5. For anything destructive or hard to reverse (schema migrations,
   deployments, deleting data, force-pushing, rotating credentials): stop and
   get explicit human confirmation before acting.
6. Keep `.agents/memory/active-context.md` current and `.antigravityignore`
   up to date as the project grows — see `.agents/workflows/session-protocol.md`
   and `.agents/rules/context-and-tokens.md`.

## Forbidden areas
- TODO: list any directories/files the agent should never edit (generated
  code, vendored deps, secrets, CI credentials, etc.)

## Workflow pointers
- **First time in this repo → follow `.agents/workflows/bootstrap.md`.**
  Fills in every `TODO` below by inspecting the repo and asking plain
  questions — don't hand-fill these files from a blank page.
- Start / end of every session → `.agents/workflows/session-protocol.md`
- New feature → follow `.agents/workflows/new-feature.md`
- Bug fix → follow `.agents/workflows/bug-fix.md`
- Domain rules → `.agents/rules/architecture.md`, `code-quality.md`,
  `testing.md`, `security.md`, `context-and-tokens.md`
- Optional companion tools (Ponytail, Graphify, Agent Skills) →
  `.agents/rules/external-tools.md`
- Project memory (current state, not fixed rules) → `.agents/memory/`
- Unfamiliar term in any of these files → `docs/glossary.md`

## Git conventions
- Conventional commits (`feat:`, `fix:`, `chore:`, `refactor:`, `test:`,
  `docs:`).
- Keep PRs to one logical change. If a task naturally splits into unrelated
  changes, say so and propose separate PRs instead of bundling them.

---

## Project Learnings
<!--
This section starts empty. Every time you (the agent) get corrected on
something project-specific — a convention, a gotcha, a "we don't do it that
way here" — add ONE line here yourself, in your own words, dated. This is
what stops the same mistake from happening twice. Do not let this section
be edited only by humans; it's most useful when the agent maintains it.
-->

- (none yet)

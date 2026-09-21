# Glossary

Plain-language explanations of the terms used throughout this kit. If
`.agents/workflows/bootstrap.md` asks something and the reasoning isn't
clear, or a term in one of the rule files is unfamiliar, it should be here.

**SDLC / SSDLC** — Software Development Life Cycle (the (S)ecure version
adds security checkpoints throughout). The stages software normally goes
through: figure out requirements, design it, build it, test it, review it,
ship it, maintain it. This kit exists to make sure an AI agent doesn't skip
straight from "requirements" to "shipped."

**ADR (Architecture Decision Record)** — A short written note capturing
one decision: what was decided, what else was considered, and why. Not a
big design doc — a few paragraphs. The point is that six months later,
nobody has to guess "why did we do it this way?"

**DoD (Definition of Done)** — A checklist of things that all have to be
true before a task counts as finished (tests pass, linter's clean, docs
updated, etc.). Exists so "done" means something specific and checkable,
not a feeling.

**Coverage bar** — What percentage of new/changed code is exercised by
automated tests. 100% isn't the goal — the goal is that the risky
logic (branches, edge cases, error handling) is actually tested, not that
every line technically ran once.

**Layering** — Organizing code into levels that only talk to the level
below them (e.g., the code that handles a web request → the code that
contains business logic → the code that talks to the database). Stops
business logic from ending up scattered across the UI, the database
layer, and everywhere in between.

**Cyclomatic complexity** — A rough measure of how many different paths
a function can take (each `if`/loop/branch adds one). High complexity
means "hard to be sure you've tested every case," not just "long."

**Blast radius** — How much else could break if this change goes wrong,
and how far the damage could spread. A one-line CSS fix has a small blast
radius; a database migration has a large one.

**Vertical slice** — A small, complete, independently-testable piece of a
feature (e.g., "one API endpoint, working end to end") rather than
building all the backend first, then all the frontend. Lets you catch a
wrong turn after one slice instead of after the whole feature.

**Context window / context** — Everything the AI model can "see" at once
for a given response — the conversation so far, any files it's read, its
instructions. It's finite; filling it with things that don't matter pushes
out room for things that do.

**Token** — Roughly, a chunk of a word — the unit the model actually reads
and is priced/limited by. "Token efficiency" means not spending that
limited budget on things that don't help (re-reading a whole file to
change one line, restating history the model already has).

**Compaction** — What happens automatically when a conversation gets too
long for the context window: older parts get summarized or dropped to make
room. Useful, but not guaranteed to keep the exact detail you cared about —
hence writing important things down in a file instead of trusting it
stayed "in context."

**Memory bank** — The `.agents/memory/` files in this kit: a small set of
files describing the project's current state (not fixed rules) that the
agent reads at the start of a session instead of re-figuring everything
out from the code every time.

**Repo map** — A short list/tree of what's in the project and what it's
for, so an agent (or a new teammate) doesn't have to explore the whole
codebase file-by-file to get oriented.

**Task List / Implementation Plan / Walkthrough (artifacts)** — Antigravity's
built-in checkpoints: a Task List is the plan for what will be done, an
Implementation Plan is the technical detail of how, and a Walkthrough is
proof (screenshots/recording) that a user-facing change actually works.
This kit turns them from optional status updates into required checkpoints.

**Agent default — unconfirmed** (in `decisions-log.md`) — A decision
nobody had a strong opinion on, so the agent picked the conventional/safe
option instead of blocking. Not wrong, just worth a second look once
someone with more context is available.

**Ponytail** — An optional companion tool that makes an agent write the
minimum code a task actually needs (reuse what exists, prefer the
standard library or a native feature over a new dependency) instead of
over-building. Never cuts security, validation, or accessibility to get
there. See `.agents/rules/external-tools.md`.

**Graphify** — An optional companion tool that reads a folder (code, docs,
images, video) and builds a queryable "knowledge graph" of how everything
in it relates, so an agent can look something up instead of re-reading
every file. See `.agents/rules/external-tools.md`.

**Agent Skills** — An optional companion pack of 25 workflows (spec
writing, TDD, code review, shipping, and more) that give an agent a
detailed, step-by-step process for each phase of building software,
instead of leaving it to improvise one. See `.agents/rules/external-tools.md`.

**AST (Abstract Syntax Tree)** — A structured, tree-shaped representation
of code's actual grammar (this is a function, this calls that, this is a
class), built by parsing rather than by an LLM reading prose. Tools like
Graphify use it to map a codebase's structure without spending any
tokens on that step.

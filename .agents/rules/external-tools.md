# External Tools (optional companions)

Three third-party tools are worth wiring into this kit: **Ponytail**
(don't write code that doesn't need to exist), **Graphify** (turn the repo
into a queryable knowledge graph instead of grepping it cold), and **Agent
Skills** (25 senior-engineer workflows, one per SDLC phase). None of them
are required — the kit's own gates (artifacts, Definition of Done, memory
bank) work standalone and are never bypassed by any of the three. Treat
these as accelerants, not dependencies.

## Verify before installing — all three
Each of these has attracted forks/mirrors and, in Graphify's case,
namespace-squatting on PyPI. Install from the canonical source only, and
treat any of the three the same way `security.md` says to treat any
third-party code with filesystem/shell access: read what it actually does
before trusting it, especially anything that injects itself into every
turn.
- **Ponytail** — canonical repo: `DietrichGebert/ponytail`.
- **Graphify** — canonical repo: `safishamsi/graphify`. PyPI package is
  `graphifyy` (double-y) — `pip install graphify` installs an unrelated
  package. The project's own README states this explicitly.
- **Agent Skills** — canonical repo: `addyosmani/agent-skills`, created by
  Addy Osmani.

---

## Ponytail — code-volume discipline

**What it does:** before writing code, it works down a fixed ladder and
stops at the first rung that holds, rather than defaulting to building
something bespoke:
1. Does this need to exist at all? (YAGNI — if not, skip it)
2. Already in this codebase? Reuse it, don't rewrite.
3. Does the stdlib do it? Use that.
4. Native platform/browser feature? Use that.
5. An already-installed dependency? Use that.
6. Is it one line? Make it one line.
7. Only then: the minimum implementation that actually works.

It reads and traces the actual code path *before* picking a rung — it's
lazy about the solution, not about understanding the problem. And it never
cuts corners on trust-boundary validation, data-loss handling, security, or
accessibility regardless of mode — those aren't on the ladder at all.

**Honest numbers** (the project's own corrected, agentic-session
benchmark, not the flashier single-shot figure it superseded): roughly
-54% lines of code, -22% tokens, -20% cost, -27% time vs. the same agent
with no skill, with safety held at 100% — measured on real Claude Code
sessions against a real FastAPI+React repo. The reduction is largest where
an agent would have over-built (e.g. reaching for a library-backed date
picker instead of `<input type="date">`) and near zero where the code was
already minimal.

**Install for Antigravity:**
- Antigravity IDE (this kit's target): Ponytail's own docs list Antigravity
  among the "instruction-only" hosts — no slash commands, just the
  always-on ruleset. Drop its compact ruleset file into
  `.agents/rules/ponytail.md` (the repo ships it ready for exactly this).
- Antigravity CLI (`agy`, the renamed Gemini CLI): `agy plugin install
  https://github.com/DietrichGebert/ponytail` — this converts the
  `/ponytail`, `/ponytail-review`, `/ponytail-audit`, `/ponytail-debt`,
  `/ponytail-gain` commands into chat-invokable skills. These commands are
  a CLI-only feature; the IDE gets the ruleset without them.

**The one rule that matters here — read this even if you skip everything
else in this file:** Ponytail's laziness governs *how much code gets
written*. It never governs *whether the process in `GEMINI.md` and
`docs/definition-of-done.md` happens*. A Task List artifact, an
Implementation Plan for anything crossing the ADR bar, a Walkthrough for
UI changes, running the actual test suite — none of that is "code that
doesn't need to exist." If Ponytail's ruleset and this kit's process ever
seem to be pulling in different directions, the process wins; report the
tension rather than silently resolving it by skipping a gate.

---

## Graphify — knowledge graph instead of cold grep

**What it does:** `/graphify .` reads a folder (code, docs, PDFs, images,
video) and builds a queryable knowledge graph — output lands in
`graphify-out/`: `GRAPH_REPORT.md` (god nodes, notable connections,
suggested questions — the part meant to be read as text), `graph.html`
(interactive, for a human in a browser), and `graph.json` (queried via
`graphify query "..."`, not read wholesale). Code is parsed locally via
tree-sitter with no LLM call; docs/images/papers go through the assistant's
own model API for extraction. Nothing here is required for the kit to
function — it's a stronger, automated alternative to the hand-annotated
`.agents/memory/architecture-map.md` and to grep-based exploration.

**Install:** `pip install graphifyy && graphify install`, then
`graphify antigravity install`.

**Where this actually lands — verify it:** Graphify's own installer writes
`.agent/rules/graphify.md` and `.agent/workflows/graphify.md` — **singular
`.agent`**, not the plural `.agents/` this kit uses everywhere else and
that Antigravity's own current documentation specifies. That may simply
not load. After running `graphify antigravity install`, check whether
Antigravity is actually picking up the always-on graph reminder; if not,
move (or symlink) `graphify.md` into `.agents/rules/` and
`.agents/workflows/` instead.

**How it changes `context-and-tokens.md` in practice:** if
`graphify-out/GRAPH_REPORT.md` exists, read it before grepping the repo —
it's a stronger version of "consult the architecture map before exploring
by hand." For a specific question rather than general orientation, run
`graphify query "<question>" --graph graphify-out/graph.json` and hand the
(small) output to the task instead of pasting raw files. The project's own
benchmark reports roughly 70x fewer tokens per query on a large mixed
corpus versus reading raw files — the gain scales with corpus size and is
close to zero on a handful of files.

**Housekeeping:**
- Add a `.graphifyignore` (same syntax as `.gitignore`) and keep it in
  sync with `.antigravityignore` — the two tools shouldn't disagree about
  what counts as noise (vendored code, build output).
- `graphify-out/graph.html` and `graphify-out/cache/` are for a human's
  browser and for re-run performance respectively, not for the agent to
  read as context — they're already covered by `.antigravityignore`.
  `GRAPH_REPORT.md` is deliberately not excluded; that's the file meant to
  be read.
- **Privacy:** docs, images, and papers get sent to whatever model API the
  assistant uses for extraction (per Graphify's own README). Code doesn't
  leave the machine — that path is local tree-sitter parsing only. Worth
  knowing before pointing it at a folder with sensitive non-code content.

---

## Agent Skills — senior-engineer workflows per phase

**What it does:** 25 skills (24 lifecycle + one meta-skill,
`using-agent-skills`, that picks the right one) covering the entire
lifecycle: Define → Plan → Build → Verify → Review → Ship, triggered by 9
slash commands (`/spec`, `/plan`, `/build`, `/test`, `/constraints`,
`/review`, `/webperf`, `/code-simplify`, `/ship`) or invoked by name
directly.

**Install:** `agy plugin install https://github.com/addyosmani/agent-skills.git`
(Antigravity CLI, native plugin) or `git clone` + `agy plugin install
./agent-skills` for a local checkout. Skills are plain Markdown underneath,
so they also work loaded as instruction files if the plugin path doesn't
apply to your Antigravity build.

**How this kit's workflows delegate to it** — `new-feature.md` and
`bug-fix.md` each have an "Optional: Agent Skills hooks" table mapping
their own steps to the matching named skill (e.g. step 1 → `interview-me`
or `spec-driven-development`; the test step → `test-driven-development`;
review → `code-review-and-quality`). Invoke the named skill instead of
duplicating its process freehand when it's installed; when it isn't, this
kit's own instructions for that step still stand on their own.

**Where it overlaps this kit — resolve in favor of one source, not two:**
- `constraint-driven-development` (`/constraints`) interviews for a
  quality bar and writes `CONSTRAINTS.md`. This is the same question as
  `testing.md`'s coverage-bar `TODO`. **If Agent Skills is installed, run
  `/constraints` and have `testing.md`'s coverage bar cite `CONSTRAINTS.md`
  rather than restating a possibly-different number** — one source of
  truth, not two places a reviewer has to reconcile.
- `spec-driven-development` / `interview-me` cover the same ground as this
  kit's `bootstrap.md` at the level of one project's foundational brief.
  They're not actually redundant: `bootstrap.md` runs once, at project
  start, to fill in *this kit's own* config (`AGENTS.md`, the memory bank).
  The Agent Skills versions run *per feature*, inside `new-feature.md` step
  1, to produce that feature's spec. Different scope — keep both.
- `documentation-and-adrs` covers the same ground as this kit's
  `docs/adr/0000-template.md`. Use whichever template you started with
  for a given project; don't run both and end up with two ADR formats in
  the same repo.

**Full skill list**, for reference (grouped as the pack itself groups
them):

| Phase | Skills |
|---|---|
| Meta | `using-agent-skills` |
| Define | `interview-me`, `idea-refine`, `spec-driven-development`, `constraint-driven-development` |
| Plan | `planning-and-task-breakdown` |
| Build | `incremental-implementation`, `test-driven-development`, `context-engineering`, `source-driven-development`, `doubt-driven-development`, `frontend-ui-engineering`, `api-and-interface-design` |
| Verify | `browser-testing-with-devtools`, `debugging-and-error-recovery` |
| Review | `code-review-and-quality`, `code-simplification`, `security-and-hardening`, `performance-optimization` |
| Ship | `git-workflow-and-versioning`, `ci-cd-and-automation`, `deprecation-and-migration`, `documentation-and-adrs`, `observability-and-instrumentation`, `shipping-and-launch` |

Note the pack's own `context-engineering` skill covers similar ground to
this kit's `context-and-tokens.md` (rules files, context packing). Treat
them as complementary rather than picking one — its focus is what to feed
the agent per session; this kit's is what the agent does with tokens once
it has that context.

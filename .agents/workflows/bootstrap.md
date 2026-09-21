# Workflow: Bootstrap (run this once, first)

## Why this workflow exists
Every other file in this kit has `TODO` markers that assume someone already
knows what a "layering pattern" is, what a reasonable test-coverage bar is,
or what counts as an architecturally significant change. Most people
dropping this kit into a project do not have that background, and
shouldn't need to go learn software architecture before they're allowed to
start — that would just mean the TODOs never get filled in, or get filled
in with copy-pasted boilerplate that doesn't fit the project, which is the
exact "generic template gets skimmed and ignored" failure this kit is
supposed to prevent.

The fix: the agent does the expert part. It inspects the actual repo,
proposes the standard/sensible answer for whatever it finds, and only asks
the human questions a human can actually answer — plain-language questions
about the *business*, not the architecture. The human's job in this
workflow is to correct wrong guesses and answer questions about intent, not
to author technical policy from a blank page.

## Order of operations — always in this order
For every TODO across the kit: **detect first, ask second, default last.**
Never ask a question the repo already answers. Never leave something
unresolved because the human might not know — that's what step 3 is for.

### 1. Detect from the repo
Inspect before asking anything:
- **Language / framework / package manager** — from `package.json`,
  `pyproject.toml`/`requirements.txt`, `go.mod`, `Gemfile`, `composer.json`,
  `Cargo.toml`, whichever is present.
- **Test framework** — from existing test files/config
  (`jest.config`, `pytest.ini`, `*_test.go`, etc.) or the manifest's
  dev dependencies.
- **Lint/format commands** — from existing config
  (`.eslintrc*`, `ruff.toml`, `.rubocop.yml`) and `scripts`/`Makefile`
  entries.
- **Existing layering pattern** — from the actual directory structure, if
  there's existing code. Don't invent a new pattern if one is already in
  use, even an inconsistent one; note the inconsistency instead (see
  `architecture.md`'s "consistency over novelty" rule).
- **Repo shape** — run `scripts/generate-repo-map.sh` and use its output
  as the first draft of `.agents/memory/architecture-map.md`.

Fill in every kit file directly with what you find. Don't present detected,
verifiable facts as questions — that wastes the human's attention on
things they'd just have to confirm anyway. State what you filled in and
move on; they can correct anything wrong when they review the Setup
Summary at the end (step 4).

### 2. Ask only what genuinely can't be detected — in plain language
For anything left, ask **one question at a time**, in plain language, and
say in one sentence why it matters. Translate the jargon yourself — the
human should never have to know the technical term to answer.

| What the kit needs | Don't ask this | Ask this instead |
|---|---|---|
| Project stage (prototype vs. production) | "Is this pre-GA or post-GA?" | "Is this something people are actually relying on already, or still early enough that breaking it wouldn't hurt anyone yet? This changes how strict I should be about tests and review before shipping." |
| ADR trigger / forbidden patterns | "What's your architectural decision record policy?" | "Is there anything you'd want a human to always look at before I proceed — like adding a new third-party library, or changing how two parts of the system talk to each other?" |
| Coverage bar | "What line-coverage percentage do you want?" | "How bad would it be if a bug slipped through in this app — annoying, or actually costly (money, data, safety)? And is there a specific part (payments, auth, anything handling personal data) where that's especially true?" |
| Forbidden areas | "What's out of scope for agent edits?" | "Is there anything in this repo you'd rather I never touch without asking first — generated files, a vendor folder, anything with secrets in it?" |
| Project brief (goals/non-goals/constraints/users) | "State your product requirements." | "In a sentence or two, what does this thing do and who's it for? Anything you're deliberately *not* trying to do? Any hard deadlines, budget, or rules (like data-privacy law) I should treat as non-negotiable?" |

Ask these in a batch of short questions if the interface supports it, not
as one long form — a wall of questions is as offputting as a wall of
jargon.

### 3. If the human doesn't know, or says "you decide": propose the standard default, and say so
This is the expected path for most solo builders and small teams, not an
edge case. Don't block waiting for expertise that isn't there.
- Pick whatever is the conventional, boring default for the detected stack
  (e.g. controller → service → repository for a typical REST API; 70-80%
  line coverage on new/touched code as a starting bar; treat payments,
  auth, and PII handling as needing an ADR and extra test coverage by
  default even without being told, since that's true almost universally).
- State the default plainly with a one-line reason, don't just silently
  fill it in.
- Record it as an agent default, not a human decision — write `agent
  default — unconfirmed` in the "Made by" column of
  `.agents/memory/decisions-log.md` for anything non-trivial this applies
  to (see that file's template). This is what lets a later, more
  experienced reviewer (a hired engineer, a future version of the same
  person) find every place a real decision still hasn't actually been made
  by a human, instead of it being invisibly baked in.

### 4. Write it all in, then hand back a Setup Summary — don't make the human author it
Fill in, directly:
- `AGENTS.md` — Project Overview, Tech Stack, Forbidden areas.
- `.agents/rules/architecture.md` — Layering, Forbidden patterns.
- `.agents/rules/testing.md` — Coverage bar.
- `.agents/memory/project-brief.md` — all sections.
- `.agents/memory/architecture-map.md` — Repo shape, Entry points, Key
  modules (best-effort if there's existing code; leave a short note that
  this fills in as the codebase grows if it's a greenfield project).

Then produce a plain-language **Setup Summary** (a Task List-style
artifact, not a wall of diffs) listing every decision made, tagged by
source:
- `detected` — found in the repo, not asked about.
- `you said` — came directly from an answer.
- `default — confirm?` — the agent picked the standard option because
  nobody had an opinion; flag these specifically for a quick yes/no.

This turns "review everything I just wrote across seven files" into "skim
one list and correct anything tagged `default — confirm?`" — the same
principle the rest of this kit applies to code review, applied to its own
setup.

### 5. Offer the optional companion tools — don't install anything unasked
Check for markers that Ponytail, Graphify, or Agent Skills are already
present (a `.ponytail` state file or `.agents/rules/ponytail.md`, a
`graphify-out/` folder, an installed `agent-skills` plugin). For anything
missing, ask **one plain-language question**, not three separate technical
pitches:

> "There are three optional add-ons that can cut down how much code gets
> written, make me faster at understanding this repo, and add
> senior-engineer-style checklists for testing/review/shipping. Want me to
> set any of these up? (You can skip this and add them later.)"

If yes, install per `.agents/rules/external-tools.md` and confirm each one
actually took effect (Ponytail's mode banner, Graphify's `GRAPH_REPORT.md`
appearing, Agent Skills' commands showing up) rather than assuming the
install command succeeding means it's active. If no, or no response,
move on — these are accelerants, not requirements, and re-asking on every
future session would be noise.

## If the project already has real content (README, existing docs, an
## existing brief)
Draft `project-brief.md` from that content first, then ask only what's
missing or ambiguous — don't ask questions the project has already
answered somewhere else in the repo.

## Re-running this later
Bootstrap is safe to re-run after a major pivot (new stage, new major
feature area, a rewrite). It should update existing answers, not silently
overwrite a human's prior correction with a re-detected or re-defaulted
value — if something previously marked `you said` would now detect
differently, flag the conflict instead of resolving it silently.

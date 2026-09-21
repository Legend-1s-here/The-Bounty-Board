# Memory Bank

Antigravity agents don't carry memory between sessions — every new session
starts from zero, and having the model re-derive project state by reading
the codebase from scratch is expensive, not just slow. `.agents/rules/` (read
every session) is the right place for anything that's *always* true. Memory
Bank is for everything else: the current state of the project, which drifts,
and which no fixed rule file can capture.

This is a written adaptation of the "Memory Bank" pattern popularized by
Cline, fitted to Antigravity's rules-loading model. Antigravity does not
auto-ingest these files the way it auto-ingests `.agents/rules/` — that's
what `.agents/workflows/session-protocol.md` is for: it's the enforced
instruction that turns "these files exist" into "the agent actually reads
and updates them." Read that file for the protocol; this one just explains
what each piece is for.

## Files

| File | Updated | Purpose |
|---|---|---|
| `project-brief.md` | Rarely — only when scope genuinely changes | What this project is, for whom, and what it explicitly is *not*. The foundation everything else should agree with. |
| `architecture-map.md` | Occasionally — when structure changes | A short, human-annotated map of where things live. Read this instead of re-scanning the whole tree every session. |
| `decisions-log.md` | Whenever an ADR is accepted | One line per ADR — a cheap index so the agent doesn't have to open every ADR file to know what's already been decided. |
| `active-context.md` | Every session | What's being worked on right now, what changed last session, what's next. The highest-value file here — read it first, always. |

## Why this lives in the repo, not in Antigravity's own memory

Antigravity keeps its own per-conversation artifacts locally (task lists,
plans, walkthroughs), but that store lives on one machine, isn't committed
to git, and isn't something a teammate or a fresh session on another machine
can see. Anything from a session worth keeping belongs in a file the whole
team actually reads — that's this directory (for project state) or
`AGENTS.md`'s Project Learnings section (for durable rules). See the last
step of `session-protocol.md`.

## What doesn't belong here
- Anything that's always true regardless of project state — that's a rule
  (`.agents/rules/`), not memory.
- Full ADRs — those live in `docs/adr/`; `decisions-log.md` only indexes
  them.
- Secrets, credentials, customer data, anything covered by
  `.agents/rules/security.md`'s forbidden list. Never write these into a
  file an agent re-reads every session and might echo into an artifact.

## Keeping it cheap to read
This whole directory should be small enough to read in full at the start of
a session without it becoming the token cost it's meant to prevent. If any
file here grows past a page or two, that's a sign it needs trimming, not
that the project got more complex — move detail into `docs/` and leave a
pointer.

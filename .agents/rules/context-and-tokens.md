# Context & Token Discipline

Every extra file read, every re-explained piece of history, every wall of
prose produced "to be thorough" costs tokens — and past a point it's worse
than wasteful: a bloated context makes the *next* response worse, because
the actual task is diluted by noise. This file is about protecting signal,
not about being cheap.

## Read narrowly
- Default to the file being edited, its direct interface/contract, one
  representative test, and relevant config — not the surrounding directory
  "for context." Needing more is a sign the task wasn't scoped tightly
  enough (see `new-feature.md` step 1), not a reason to read more files.
- Search before you read. Grep/symbol-search for the specific thing you
  need, note the line number, then read a narrow window around it — not
  the whole file, and never the whole directory. Reading full files "just
  in case" is the single largest avoidable token cost in agentic coding.
- Consult `.agents/memory/architecture-map.md` before exploring the repo
  structure by hand. If it's stale or missing what you need, update it —
  don't re-derive the map from scratch every session.
- If `graphify-out/GRAPH_REPORT.md` exists (see the Graphify section of
  `.agents/rules/external-tools.md`), read that first — it's a stronger,
  automated version of the architecture map above. For a specific
  question rather than general orientation, `graphify query "<question>"`
  against `graphify-out/graph.json` instead of grepping across files.

## Bound your output
- When a diff, a patch, or a short ranked list answers the question, give
  that — not restated prose. Long explanatory output doesn't just cost
  output tokens; it becomes clutter later turns have to read back in.
- Don't reprint a whole file to show a small change. Show the diff.
- Compress before you carry forward. If a test run, log, or build output
  is long, summarize the relevant result before it goes into the next
  step's context — don't paste raw output wholesale.

## Isolate exploration
- For open-ended research, broad codebase exploration, or a subtask that
  doesn't need to share state with the main task: push it into a separate
  agent/sub-task via Antigravity's Manager surface, and bring back a
  compact written summary — not the full transcript. This keeps the main
  session's context clean for the actual decision-making.
- Don't isolate tightly sequential work that genuinely needs the
  accumulated context of the steps before it. Spawning a fresh agent per
  step of one coherent task multiplies total token cost without the
  isolation benefit paying for itself.

## Route by complexity
- Mechanical, low-risk, single-file changes (typos, formatting, a CSS
  tweak, a doc update) don't need the same reasoning depth as an
  architectural change. Use the lighter/faster model mode for these if
  your Antigravity version exposes one (check Settings → Agents; the
  toggle's exact name has moved between releases) and reserve full
  reasoning depth for work that meets the ADR bar in `architecture.md`.
- This is a cost/latency decision, not a quality shortcut. If a task turns
  out more ambiguous than it looked, escalate back to full reasoning
  rather than forcing a fast-mode answer to a hard question.

## Start new sessions on purpose
- A new bug, a new subsystem, or a new unrelated question is a new
  session, not a continuation. Carrying unrelated history forward risks
  the agent quietly reasoning from stale assumptions left over from the
  last topic — it doesn't save time.
- Long single tasks will eventually trigger automatic context compaction.
  Don't rely on it to preserve what matters to you specifically —
  compaction optimizes for "doesn't crash," not "kept the detail you
  cared about." Write anything load-bearing into the Task List artifact
  or `.agents/memory/active-context.md` *before* the session gets long, so
  it survives as text, not as something you're hoping stayed in context.

## Keep the ignore file current
`.antigravityignore` (root) controls what gets indexed into Agentic
Context by default. When the project grows a new generated-code folder, a
fixtures directory, or a large asset folder, add it there the same day —
an unindexed dependency tree or generated client is pure token cost with
zero signal.

## If you're calling this via the API for CI or scheduled agentic workflows
Log token and cache-hit counts per call and alert on a sustained drop in
cache hit rate — that's usually the first symptom of a prompt structure
that stopped being cache-friendly (e.g. dynamic content got moved ahead of
the stable system/rules prefix), and it's cheap to catch immediately and
expensive to notice a month later in the bill.

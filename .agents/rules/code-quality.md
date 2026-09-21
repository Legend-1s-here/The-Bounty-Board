# Code Quality Rules

These rules govern *how* code is organized once it's written. For *how
much* code should get written in the first place, see the Ponytail section
of `.agents/rules/external-tools.md` — an optional companion tool aimed
squarely at that question; this file doesn't duplicate it.

## Size limits (split, don't cram)
- Max file length: ~300 lines — extract modules past this.
- Max function length: ~40 lines.
- Max function parameters: 4 — bundle into an options object past this.
- Cyclomatic complexity: keep it low enough that the function's behavior is
  obvious from a single read. If you need a comment to explain *what* a
  block does (not *why*), it should probably be its own named function.

## Style
- Follow the existing linter/formatter config exactly. Do not reformat files
  you weren't asked to touch — a diff should show only the lines that
  changed, not the whole file re-indented.
- Prefer explicit, boring code over clever one-liners. This codebase is read
  far more often than it's written, by humans and future agent sessions
  both.
- No dead code, no commented-out code blocks, no TODO comments without a
  linked issue/ticket.

## Error handling
- No silent catches. Every caught error is either handled meaningfully,
  logged with context, or re-thrown — never swallowed.
- No bare `except:` / catch-all without specifying what's expected.
- Fail loudly in development, fail gracefully (with logging) in production.

## Observability
- Any new service call, external API call, or non-trivial background job
  gets a log line on failure at minimum, with enough context to debug
  without reproducing locally.
- Don't add logging so verbose it drowns the signal — log decisions and
  failures, not every function entry/exit.

## Naming
- Names describe what something is/does, not how it's implemented
  (`getActiveUsers`, not `filterArrayWhereActive`).
- No abbreviations that aren't already standard in this codebase or
  language ecosystem.

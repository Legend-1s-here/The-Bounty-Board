# Definition of Done

A task is done when every applicable item below is true — not assumed,
*observed*. If an item doesn't apply, say so explicitly rather than
silently skipping it.

## Correctness
- [ ] Acceptance criteria from the original request are all met.
- [ ] Edge cases discussed during planning are handled, not just the happy
      path.

## Tests
- [ ] Unit tests written and passing for new logic.
- [ ] Integration tests written and passing for new boundaries (API, DB,
      external service).
- [ ] For bug fixes: a reproduction test existed, failed, then passed after
      the fix.
- [ ] Full existing test suite still passes (no regressions).

## Quality gates
- [ ] Linter clean.
- [ ] Type-checker clean.
- [ ] No `console.log`/debug prints left in.
- [ ] No commented-out code, no unresolved TODOs without a linked issue.

## Architecture
- [ ] If a new dependency, pattern, schema change, or API contract change
      was introduced: an ADR exists for it.
- [ ] No inconsistent duplicate pattern introduced where an existing one
      already covers the same concern.

## Security
- [ ] No secrets committed.
- [ ] New input paths validated at the boundary.
- [ ] New endpoints/actions have explicit, server-side authz checks.

## Verification
- [ ] For user-facing changes: verified in the browser, with a Walkthrough
      artifact (screenshot/recording) covering the happy path and at least
      one edge case.
- [ ] CI pipeline passes independently of local verification.

## Documentation & knowledge
- [ ] Any project-specific correction made during this task was appended to
      the "Project Learnings" section of `AGENTS.md`.
- [ ] User-facing docs/README updated if behavior visible to users or other
      developers changed.

## Memory & context
- [ ] `.agents/memory/active-context.md` reflects the state *after* this
      task, not the state before it (see `session-protocol.md`).
- [ ] Any ADR accepted this session is indexed in
      `.agents/memory/decisions-log.md`.
- [ ] If the repo's structure changed, `.agents/memory/architecture-map.md`
      was updated to match.
- [ ] Anything worth keeping that only exists in local session artifacts
      was pulled into a git-tracked file — nothing useful was left stranded
      somewhere only this machine can see.

## If installed (optional companion tools — skip if not present)
- [ ] Ponytail: `/ponytail-review` (or a manual re-read against its
      ladder) turned up nothing worth deleting in this diff.
- [ ] Agent Skills: the `shipping-and-launch` skill's checklist was
      followed before this was marked ready to ship.

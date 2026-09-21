# Workflow: Session Start / End Protocol

Run this regardless of what the task is — it wraps `new-feature.md`,
`bug-fix.md`, or anything else. Read the "Start" section before doing
anything else in a session; run the "End" section before declaring any
task done.

## Start
1. Read `.agents/memory/active-context.md` first. This tells you what's in
   flight, what changed last session, and what's next — cheaper and more
   reliable than re-deriving project state from the code itself.
2. **If `.agents/memory/project-brief.md` still contains unfilled `TODO`
   placeholders, stop and flag it** rather than guessing at business goals
   to fill the gap yourself. Tell the human that
   `.agents/workflows/bootstrap.md` hasn't been run yet and offer to run it
   before continuing with the requested task. Proceeding on a real feature
   without a real brief means every judgment call downstream is a guess.
3. If the task touches unfamiliar territory, check
   `.agents/memory/architecture-map.md` before exploring the repo by hand.
4. If the task might already be covered by a past decision, check
   `.agents/memory/decisions-log.md` before proposing a new approach.
5. If `active-context.md` describes an in-flight task that doesn't match
   what you're being asked to do now, say so explicitly rather than
   silently abandoning or silently continuing it — the human may not know
   it's still marked in-flight.

## End
1. Update `.agents/memory/active-context.md`: what changed, what's next,
   any open question — replace stale content, don't just append forever.
2. If a new ADR was accepted this session, add its one-line entry to
   `.agents/memory/decisions-log.md`.
3. If the codebase's *structure* changed (new module, new service, moved
   boundary), update `.agents/memory/architecture-map.md`. Routine changes
   that don't change the shape of the repo don't need this.
4. Per `GEMINI.md`: if anything project-specific was corrected this
   session, append it to Project Learnings in `AGENTS.md`. That's for
   durable rules; `active-context.md` is for current state — don't confuse
   the two or duplicate between them.
5. Anything from this session worth keeping that only exists in the local
   per-conversation artifact history (Antigravity's own local artifact
   store) and nowhere else: pull it into the memory bank or `AGENTS.md`
   now. That store is per-machine and isn't shared with teammates or
   committed to git — if it's worth keeping, it belongs in a file the team
   actually sees.

---
name: bit-retro
description: End-of-cycle retrospective for the bit-* pipeline. Reviews the scope, plan, and check artifacts to surface what worked and what to improve for next time. Also covers collaboration quality and user instruction clarity. Use this whenever the user says "bit-retro", "retro", "retrospective", "how did this cycle go", or after a bit-check completes and the user wants to close the loop. This is the feedback mechanism that makes the pipeline self-improving.
---

# Pipeline Retrospective

You close the feedback loop on a completed bit-* cycle (scope → plan → run → check). Your job is to surface what worked, what didn't, and what should change — then save the lessons that matter to memory so future cycles improve.

You produce no output file. This is a conversation that ends with lessons written to memory.

---

## Context reality

This retro often runs after one or more `/compact` calls — meaning you may have lost the full conversation history. Don't pretend you remember what you don't. Instead, reconstruct the cycle from durable signals:

- The artifacts themselves (scope, plan, check files)
- `git log --oneline main..HEAD` — what actually shipped
- The check file's findings and "what went well" section
- Ask the user to fill gaps — they remember the experience, you remember the documents

If you're unsure whether something happened, say so and ask rather than inventing a narrative.

---

## Finding the artifacts

Scan the repo root for the cycle's documents:
- `*-scope.md` — the scope (bit-scope output)
- `*-plan.md` — the plan (bit-plan output)
- `*-check.md` — the audit (bit-check output)

If multiple sets exist, pick the most recent (by git log or file modification time), or ask if it's ambiguous. If no check file exists yet, note that — you can still retro the scope and plan, but the check feedback section becomes "not yet run."

Read all three before starting the conversation.

---

## The conversation

Walk through each section below. Be specific — cite the actual documents, actual findings, actual moments. No generalities.

### 1. Scope quality

Look at the scope doc and ask:

- **Readability**: Could you skim it in under 2 minutes and understand the shape of the work? If the scope was too long or too detailed, say so.
- **Phase accuracy**: Did the phases match what actually got built? Were any phases missing that surfaced during planning or execution? Were any phases in the scope that turned out to be unnecessary?
- **Risk identification**: Were the risks/unknowns called out early enough? Did anything surprise you during execution that the scope could have flagged?

Ask the user: *"Was the scope the right size? Anything you'd add or cut next time?"*

### 2. Plan quality

Look at the plan doc and ask:

- **Step granularity**: Were steps the right size — each one a single commit's worth of work? Any steps that felt too large (needed mid-step correction) or too small (trivial, just noise)?
- **TDD effectiveness**: Did the test-first approach catch anything that would have otherwise shipped broken? Were there steps where writing the test first felt forced rather than useful?
- **Execution smoothness**: Did bit-run make it through all steps without handing back to bit-plan for replanning? If it did hand back, that's a signal the plan wasn't detailed enough at that point.
- **Step count**: Note the total number of steps and how many sessions it took. Ask the user if the plan felt like the right amount of work for the feature, or if it was over/under-scoped.

Ask the user: *"How did the plan feel to work through? Too many steps? Too few? Any steps that needed rework?"*

### 3. Check findings

Look at the check doc (if it exists) and ask:

- **Finding count and categories**: Report what bit-check found. Were the findings mostly doc-cleanup (process noise) or actual code issues?
- **Avoidable findings**: For each finding, ask — could better scope or planning have prevented this? If yes, that's a process improvement.
- **Pattern recognition**: If this isn't the first cycle, look at previous check files. Are the same categories recurring? That's a signal the upstream skills need adjustment.

Ask the user: *"Anything from the check that felt avoidable with a better scope or plan?"*

### 4. Collaboration and instructions

This section is about how the *user* and *Claude* worked together during this cycle. Be direct — the user has asked to be held accountable.

- **Ambiguity cost**: Were there moments where vague instructions led to wrong approaches or wasted effort? Name them.
- **Context gaps**: Was there context the user had but didn't share until it caused a problem?
- **What worked**: Were there moments where clear instructions made things land on the first try? Name those too — reinforce the pattern.
- **Interaction shape**: For pipeline-length work (multi-session, multi-step), was the user's engagement pattern effective? (e.g., reviewing each step vs. batching reviews, providing feedback early vs. late)

Ask the user: *"Anything you'd do differently in how you gave instructions or reviewed work?"*

### 5. What went well

Identify things that worked across the whole cycle:
- Clean handoffs between pipeline stages
- Features that landed without rework
- Times the process caught something early
- Efficient collaboration moments

### 6. Permission & configuration signals

Think back through the session (or ask the user): were there moments where Claude asked for permission to run a tool? Each permission prompt is a signal — the user might want to:
- **Auto-approve** it in future (add to allowed tools/patterns)
- **Explicitly block** it (if it was unwanted)
- **Leave as-is** (the prompt was appropriate)

Surface any you noticed and ask: *"Were there any permission prompts that felt unnecessary? Anything you'd auto-approve or block for next time?"*

This keeps the tool permission surface healthy without needing a separate config audit skill.

### 7. What to change

Present each proposed change as an **accept/reject decision**. Don't just list suggestions — the user needs to say yes or no to each one, because accepted skill changes should get implemented (via skill-creator if non-trivial).

Format proposals like:

> **Proposal:** [concrete change to a specific skill or process]
> **Why:** [what went wrong or could be better]
> **Accept / Reject?**

Categories:
- **Skill changes**: Should bit-scope, bit-plan, bit-run, or bit-check behave differently?
- **Process changes**: Should the user's workflow change?
- **Memory saves**: Things to remember for next time

For accepted skill changes: ask the user if they want to implement the change now (you'll invoke skill-creator) or defer to a future session.

### 8. Lessons to save

For each lesson worth persisting, classify:

- **Project-specific** — tied to this codebase's conventions, stack, or tooling. Save to the project memory directory.
- **Language-specific** — applies to all projects in a given language. Save to `~/.claude/rules/<language>.md`.
- **Universal** — applies regardless of language or project. Save to `~/.claude/CLAUDE.md` under `## General Habits`.
- **Skill improvement** — a specific change to one of the bit-* skills. Don't save to memory — instead, note it clearly so the user can act on it (update the skill in a separate session, or ask you to do it now).

Present the classification for each lesson. Write only after the user confirms.

---

## Avoiding staleness

The first retro on a new pipeline is high-signal. Subsequent retros risk producing diminishing returns — you start surfacing obvious things or repeating lessons already in memory.

Guard against this:
- **Check memory first.** Before suggesting a lesson, check if it's already saved. Don't re-propose what's already known.
- **Raise the bar each time.** If the check file had zero code findings and the scope was tight, say "this cycle was clean — nothing structural to change" and move on quickly. Don't manufacture issues to fill sections.
- **It's OK to be short.** A retro that says "scope was right-sized, plan executed cleanly, one doc-cleanup finding that's already a known pattern — nothing new to save" is a valid retro. Five minutes of the user's time, not thirty.
- **Focus on surprises.** What was unexpected? What contradicted an assumption? What would you bet will go differently next time? Those are the high-value observations.

If you find yourself reaching for trivial observations to fill a section, skip it. The user will notice and disengage.

---

## Tone

Be honest, specific, and direct. Cite actual step numbers, actual finding categories, actual file names. The user values signal density — don't pad with pleasantries or hedge language. If something went well, say it plainly. If something was a waste of time, say that too.

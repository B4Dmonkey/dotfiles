---
name: bit-retro
description: Conduct an end-of-session retrospective. Reviews what went well, what went wrong, how to improve collaboration, and saves lessons to memory.
---

# Skill: bit-retro

Conduct an end-of-session retrospective. TRIGGER when the user invokes /bit-retro or asks to review how the session went.

## Instructions

Walk through each section below with the user. Be honest and specific — cite actual moments from the session, not generalities. Use direct language.

### 1. What went wrong?

Identify things that didn't work well:
- Misunderstandings or miscommunications
- Wasted effort (wrong approaches, unnecessary changes, rabbit holes)
- Bugs introduced, regressions, or things that broke
- Times I overcomplicated something or under-delivered

### 2. What went right?

Identify things that worked well:
- Efficient solutions, clean implementations
- Good collaboration moments
- Problems solved on the first try

### 3. What should we keep doing?

Patterns or practices worth repeating in future sessions.

### 4. What should we explicitly avoid?

Anti-patterns to watch out for. Be concrete — name the specific behavior, not a vague principle.

### 5. How can the user interact with me better?

This is critical. Hold the user accountable. Evaluate their instructions and flag:
- Ambiguous or underspecified requests that led to wrong outcomes
- Missing context that would have saved time
- Cases where earlier clarification would have prevented rework
- Suggestions for how to phrase requests more effectively

Be direct. The user has explicitly asked to be held accountable for poor instructions. Do not soften feedback — give actionable, specific suggestions.

### 6. Configuration health check

Do a web search for current Claude Code best practices and configuration options. Look for:
- New features or configuration mechanisms that have been added (rules, hooks, agents, plugins, .claudeignore, etc.)
- Common misconfigurations or gaps in typical setups
- Improvements to how memory, CLAUDE.md, and hooks work together

Report any gaps or opportunities specific to this project's current setup. Be concrete — name specific files or settings to add/change, not general advice.

### 7. Lessons to remember

For each lesson worth saving, classify it into one of three buckets before writing:

- **Project-specific** — tied to this codebase's conventions, stack, or tooling (e.g. `ENV` must be `"prod"`, just module path behaviour). Save to the project memory directory.
- **Language-specific** — a habit that applies to all projects in a given language (e.g. Python packaging conventions, test mirroring). Save to `~/.claude/rules/<language>.md`, creating the file if it doesn't exist. If the current project's CLAUDE.md doesn't already import that rules file, add `@~/.claude/rules/<language>.md` at the top.
- **Universal** — applies regardless of language or project (e.g. collaboration habits, tool-use patterns). Save to `~/.claude/CLAUDE.md` under a `## General Habits` section. Keep this list short — only rules that would genuinely apply everywhere.

Present the classification to the user for each lesson and ask for confirmation before writing anything.

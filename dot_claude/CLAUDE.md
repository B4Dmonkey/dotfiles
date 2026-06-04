# Global Instructions

## Constraint Gathering

When a user asks for a recommendation involving infrastructure, tooling, or services, ask clarifying questions about constraints before proposing solutions. Specifically:
- Cost tolerance (free vs paid — assume free unless stated otherwise)
- Existing setup (what's already in place)
- Any relevant access or visibility requirements (e.g. public/private repo, auth, permissions)

Do not skip this even if the user seems to want an answer quickly.

## General Habits

- **Apply memory proactively** — treat memory as a pre-flight checklist, not a diagnostic tool. When writing code that touches a known footgun, check the relevant memory entry before submitting, not after the error appears.
- **Grep before editing stale files** — if a file hasn't been read recently in the session, grep for the exact target string before constructing an Edit call.
- **Read existing patterns before writing** — before writing any new code that extends a pattern, read all related existing files first. Don't infer from memory.
- **Verify before calling something a bug** — note it as a question ("this might not work because X — intentional?") and verify the full execution context before declaring a bug.
- **Probe server state before proposing steps** — when the user expresses uncertainty ("I think X", "I'm not sure"), ask 2-3 targeted diagnostic questions to confirm actual state first.
- **12-factor config — ignore unknown env vars** — apps should only read what they know about and silently ignore the rest. The environment is shared; unknown vars are not app errors. Use `extra="ignore"` (pydantic-settings) or equivalent in your framework.
- **Clarify "up to date" before editing docs** — when asked to update a document, ask what that means before rewriting: remove the entry, annotate it, rewrite it, or something else. Don't pick an interpretation unilaterally.
- **Verify tool syntax before using it** — before using any non-obvious syntax (regex flags, config fields, CLI options), look it up or say you're unsure. This applies to regex engines, editor configs, CI schemas, anything. Do not guess. This rule has been violated twice — treat it as a hard stop.
- **Implement CLI commands literally** — when asked to add a command or script, use exactly what was specified. Don't inherit flags, filters, or options from similar existing commands without being asked.
- **Make shebang scripts executable at creation** — any new file with a `#!/usr/bin/env` shebang must be `chmod +x`'d in the same turn it's written. Don't wait for a permission error at runtime to catch this.
- **Audit full `.gitignore` before unignoring a path** — when removing a path from `.gitignore` or adding a negation rule, scan the entire file for existing glob patterns (e.g. `*.zip`, `*.csv`) that would still match and silently re-ignore the target.
- **Inspect reference format before building output to match it; verify after** — when generating output meant to match a reference file (xlsx, CSV, report), read the reference first and state the structure before writing code. After generating, compare the output against the reference structurally before reporting done.
- **Place project CLAUDE.md in `.claude/CLAUDE.md`** — not the project root. Always check for or create the `.claude/` directory before writing.

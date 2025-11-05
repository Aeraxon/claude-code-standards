# Claude Code Project Setup Guide (2025 Best Practices)

> **Usage:** For new projects, use `/project-init` command (see DEPLOYMENT_TUTORIAL.md)

## Table of Contents
1. [Core Principles](#core-principles)
2. [Initial Project Setup](#initial-project-setup)
3. [Required Files & Structure](#required-files--structure)
4. [Documentation Rules](#documentation-rules)
5. [CLAUDE.md Template](#claudemd-template)
6. [Custom Commands Setup](#custom-commands-setup)
7. [Session Management](#session-management)
8. [Workflow Patterns](#workflow-patterns)
9. [Configuration Best Practices](#configuration-best-practices)

---

## Core Principles

### 1. Context Quality Over Quantity
- Keep CLAUDE.md files **under 100 lines** each
- Clear context regularly with `/clear` after 1-3 messages
- **Disable auto-compact** in `/config` to reclaim 40k+ tokens
- Use hierarchical CLAUDE.md files (root + subdirectories)

### 2. Plan Before Code
- Always create a plan first, get approval, then implement
- Use `/clear` between planning and implementation phases
- Store approved plans in `docs/plans/` for reference
- Separate exploration noise from focused execution

### 3. Explicit Over Implicit
- Be specific in prompts: "add tests for foo.py covering edge case X" > "add tests"
- Document non-obvious patterns and pitfalls in CLAUDE.md
- Type hints and docstrings for all public functions
- Explain "why" not just "what" in documentation

### 4. Session Continuity
- Maintain `docs/SESSION_NOTES.md` - update before ending each session
- Use `docs/WORK_IN_PROGRESS.md` for current task state
- Update `docs/ARCHITECTURE.md` for design decisions
- Commit frequently with descriptive messages

### 5. Documentation Discipline
- **CRITICAL:** Limit documentation proliferation
- Core docs only: ARCHITECTURE.md, SESSION_NOTES.md, WORK_IN_PROGRESS.md, README.md
- Per-component: Only README.md (+ 1 additional doc if extremely complex)
- **NO** implementation summaries during tasks
- **NO** task-specific temp docs that linger

---

## Initial Project Setup

### 3-Phase Approach

#### Phase 1: Installation (One-time per host)
See `DEPLOYMENT_TUTORIAL.md` for detailed instructions.

#### Phase 2: Project Initialization
Use `/project-init` command to:
1. Gather project information
2. **Research phase** - Design without coding
3. **Setup phase** - Create structure after approval

#### Phase 3: Development
Follow workflow patterns with proper documentation discipline.

### Directory Structure

Create this base structure (adapt to project type):

```
project_name/
├── CLAUDE.md                    # Project context (mandatory)
├── README.md                    # User-facing documentation
├── .claude/
│   ├── commands/                # Custom slash commands
│   │   ├── project-init.md     # Initialization command
│   │   ├── plan.md
│   │   ├── session-start.md
│   │   └── session-end.md
│   ├── agents/                  # Subagents (optional)
│   ├── skills/                  # Skills (optional)
│   └── settings.json            # Project-specific settings
├── .claude-standards/           # Cloned standards repo
│   ├── guides/                  # Reference guides
│   └── commands/                # Standard commands
├── src/                         # Source code
├── tests/                       # Test suite
├── docs/
│   ├── ARCHITECTURE.md          # System design
│   ├── SESSION_NOTES.md         # Running session log
│   ├── WORK_IN_PROGRESS.md      # Current task/sprint state
│   └── plans/                   # Approved implementation plans
├── config/                      # Configuration files
└── scripts/                     # Utility scripts
```

### Git Initialization

```bash
git init
echo "CLAUDE.local.md" >> .gitignore
echo "__pycache__/" >> .gitignore
echo ".venv/" >> .gitignore
echo "node_modules/" >> .gitignore
echo ".DS_Store" >> .gitignore
```

### Core Files

**Mandatory files to create:**
1. `CLAUDE.md` - Project context (see template below)
2. `README.md` - Project overview
3. `docs/SESSION_NOTES.md` - Session tracking
4. `docs/ARCHITECTURE.md` - Design documentation
5. `docs/WORK_IN_PROGRESS.md` - Current task state

---

## Required Files & Structure

### 1. CLAUDE.md (Root Directory)

**Must include:**
- Project overview (1-2 sentences)
- Tech stack
- Project structure
- Coding standards
- Common commands
- Key architectural patterns
- Non-obvious gotchas
- Session continuity instructions

**Locations:**
- `./CLAUDE.md` - Project-wide (commit to git)
- `./CLAUDE.local.md` - Local-only overrides (gitignore)
- `~/CLAUDE.md` - Personal defaults (applies across all projects)
- Subdirectories: `./frontend/CLAUDE.md`, `./backend/CLAUDE.md`, etc.

**Note:** Commands and guides are project-local in `.claude/` and `.claude-standards/` directories.

### 2. docs/SESSION_NOTES.md

**Purpose:** Long-term session history

**Template:**
```markdown
# Session Notes

## [Date: YYYY-MM-DD] Session [N]

### What Was Done
- Implemented feature X
- Fixed bug Y
- Created test suite for Z

### Decisions Made
- Chose library A over B because...
- Decided to postpone feature C due to...

### Current Blockers
- Need clarification on requirement X
- Waiting for API access

### Next Steps
1. Complete feature X
2. Review and merge PR
3. Update documentation

### Context for Next Session
- Currently working on file: `src/module/component.py:123`
- Key decision: We're using pattern X for Y
- Watch out: Z is a known gotcha
```

### 3. docs/WORK_IN_PROGRESS.md

**Purpose:** Current task/sprint state - for recovery if session breaks

**CRITICAL RULES:**
- Only for IN-PROGRESS work
- Must be SHORT and CONCISE
- Full detail but minimal words
- **MUST be cleared** when work moves to other docs
- Think of it as "session breakpoint"

**Template:**
```markdown
# Work In Progress

> **Status:** [Active/Paused/Blocked]  
> **Started:** YYYY-MM-DD  
> **Last Updated:** YYYY-MM-DD HH:MM

## Current Task
[One-line description of what you're working on]

## Goal
[Expected outcome]

## Progress
- ✅ [Completed step]
- 🔄 [In progress - currently at...]
- ⏸️ [Pending step]

## Current State
**Working on:** `path/to/file.py:123`  
**Branch:** `feature/xyz`  
**Last commit:** `abc1234 - commit message`

## Context
[Minimal context needed to resume - what approach you're taking, why]

## Blockers
- [Blocker 1 if any]

## Next Steps (When Resuming)
1. [Next concrete action]
2. [Then this]
3. [Then this]

## Decisions Made This Sprint
- [Decision 1: Why and what]

## To Archive
When this task is complete:
- [ ] Move decisions to ARCHITECTURE.md
- [ ] Update SESSION_NOTES.md
- [ ] Clear this file for next task
- [ ] Update README if needed
```

**Usage Pattern:**
```
START TASK → Create WIP entry
WORK → Update WIP
SESSION BREAK → WIP has recovery info
RESUME → Read WIP
COMPLETE TASK → Archive to proper docs → Clear WIP
```

### 4. docs/ARCHITECTURE.md

**Purpose:** Design decisions and system overview

**Template:**
```markdown
# Architecture Documentation

## System Overview
[High-level description]

## Core Components
### Component 1: [Name]
- **Purpose:** What it does
- **Location:** `src/path/`
- **Dependencies:** What it needs
- **Interfaces:** How to interact

## Data Flow
[Diagram or description of data movement]

## Key Design Decisions
### Decision 1: [Title]
- **Date:** YYYY-MM-DD
- **Context:** Why this decision was needed
- **Decision:** What was chosen
- **Alternatives:** What was considered
- **Consequences:** Trade-offs

## Patterns & Conventions
- Pattern 1: When to use, example
- Pattern 2: When to use, example

## Known Limitations
- Limitation 1: Description and workaround
```

### 5. Component READMEs

**Rules for Microservices/Components:**
- Each gets **ONE** README.md
- If extremely complex: Max ONE additional doc
- **NO** implementation summaries
- **NO** task-specific docs

**Template for component README:**
```markdown
# Component Name

## Purpose
[What this component does]

## API/Interface
[How to use it]

## Configuration
[Required setup]

## Development
```bash
# Setup, test, run commands
```

## Architecture
[Brief overview - detail goes in main ARCHITECTURE.md]

## Known Issues
[Current limitations]
```

---

## Documentation Rules

### CRITICAL: Prevent Documentation Proliferation

**Allowed Documentation:**
- `docs/ARCHITECTURE.md` - System design
- `docs/SESSION_NOTES.md` - Session history
- `docs/WORK_IN_PROGRESS.md` - Current task state
- `docs/plans/*.md` - Approved plans
- `README.md` (root)
- One `README.md` per component/service
- **If component is EXTREMELY complex:** Max 1 additional doc

**FORBIDDEN During Tasks:**
- ❌ Implementation summaries
- ❌ Task-specific documentation files
- ❌ Multiple docs per component
- ❌ Temporary docs that don't get cleaned up
- ❌ Docs duplicating what's in code comments
- ❌ Meeting notes (unless in SESSION_NOTES)
- ❌ Research notes (use WIP then archive)

**Subagent Instructions:**
When creating subagents, include:
```markdown
## Documentation Policy
You MUST follow strict documentation rules:

1. **Core docs only:** ARCHITECTURE.md, SESSION_NOTES.md, WORK_IN_PROGRESS.md
2. **Per-component:** Only README.md (max 1 additional if extremely complex)
3. **FORBIDDEN:**
   - Implementation summaries
   - Task-specific temp docs
   - Multiple docs per component
   - Docs that duplicate code comments

4. **Update existing docs** rather than creating new ones
5. **Use WORK_IN_PROGRESS.md** for current task state, then archive

Ask yourself: "Does this NEED a new document or can it go in existing docs?"
Default: Update existing docs.
```

### When to Create New Documentation

**Ask these questions:**
1. Is this information already in ARCHITECTURE.md? → Update it
2. Is this temporary task state? → Use WORK_IN_PROGRESS.md
3. Is this a session summary? → Use SESSION_NOTES.md
4. Is this component documentation? → README.md
5. Is this a plan? → docs/plans/
6. None of the above AND permanent AND cannot fit elsewhere? → **Maybe** new doc

**Test:** If you're creating a new doc, justify it in commit message.

---

## CLAUDE.md Template

Use this template and customize for your project:

```markdown
# [Project Name]

## Project Overview
[1-2 sentence description of what this project does and why it exists]

**Tech Stack:** [Language, framework, key libraries]
**Type:** [CLI tool / Web app / API / Library / etc.]
**Status:** [Active development / Maintenance / Prototype]

## Project Structure

[Paste your directory tree here - keep it concise, focus on key directories]

## Tech Stack

**Language:** [Python 3.11 / TypeScript / Rust / etc.]
**Framework:** [FastAPI / React / Express / etc.]
**Database:** [PostgreSQL / MongoDB / SQLite / None]
**Key Libraries:**
- [Library 1] - [Purpose]
- [Library 2] - [Purpose]

## Coding Standards

**[Language] Style:**
- [Style guide: PEP 8 / Airbnb / Standard]
- [Formatter: Black / Prettier / rustfmt]
- [Linter: ruff / ESLint / clippy]
- [Line length: 100 / 120]

**Naming Conventions:**
- Files: [snake_case / kebab-case / PascalCase]
- Classes: [PascalCase]
- Functions: [snake_case / camelCase]
- Constants: [UPPER_SNAKE_CASE]

**Type Safety:**
- [Use type hints / TypeScript strict mode / etc.]
- [Required for all public APIs / Optional]

**Documentation:**
- [Docstring style: Google / NumPy / JSDoc]
- Required for: [All public functions / Complex logic only]

## Common Commands

**Development:**
```bash
# Install dependencies
[command]

# Run development server
[command]

# Run tests
[command]

# Format code
[command]

# Lint code
[command]
```

**Testing:**
```bash
# Run all tests
[command]

# Run specific test file
[command]

# Run with coverage
[command]
```

## Key Architectural Patterns

### Pattern 1: [Name]
[When to use this pattern and example]

### Pattern 2: [Name]
[When to use this pattern and example]

## Testing Strategy

**Unit Tests:**
- [What to unit test]
- [Testing framework and conventions]

**Integration Tests:**
- [What to integration test]
- [How to set up test environment]

**Manual Testing:**
- [Critical paths to manually verify]

## Documentation Policy

⚠️ **STRICT RULES** - Follow religiously:

**Core Docs:**
- `docs/ARCHITECTURE.md` - System design
- `docs/SESSION_NOTES.md` - Session history
- `docs/WORK_IN_PROGRESS.md` - Current task state
- `docs/plans/` - Approved plans

**Component Docs:**
- One `README.md` per component
- Max 1 additional doc if EXTREMELY complex

**FORBIDDEN:**
- Implementation summaries
- Task-specific temp docs
- Multiple docs per component
- Documentation proliferation

**Default:** Update existing docs, don't create new ones.

## Session Continuity

**Before starting work:**
1. Read `docs/WORK_IN_PROGRESS.md` first (current task)
2. Read `docs/SESSION_NOTES.md` for recent context
3. Check git log for recent changes
4. Review `docs/ARCHITECTURE.md` for relevant components

**During work:**
1. Update `docs/WORK_IN_PROGRESS.md` as you progress
2. Keep it SHORT and focused on recovery

**Before ending session:**
1. Update `docs/SESSION_NOTES.md` with progress
2. Ensure `docs/WORK_IN_PROGRESS.md` has recovery info
3. Document design decisions in `docs/ARCHITECTURE.md`
4. Commit work with descriptive messages

**When completing task:**
1. Archive WIP decisions to ARCHITECTURE.md
2. Update SESSION_NOTES.md with completion
3. **Clear WORK_IN_PROGRESS.md** for next task
4. Update README if needed

## Non-Obvious Gotchas

⚠️ [Gotcha 1: Description and workaround]

⚠️ [Gotcha 2: Description and workaround]

⚠️ [Gotcha 3: Description and workaround]

## Important Context

**[Custom section for anything critical to your project]**

---

**Last Updated:** [Date]
**Primary Contact:** [Name/Email]
```

---

## Custom Commands Setup

### Essential Commands to Create

Commands are stored in `.claude/commands/` and copied from `.claude-standards/commands/` during setup.

**1. `.claude/commands/project-init.md`**
See `commands/project-init.md` for full template.

**2. `.claude/commands/plan.md`**
```markdown
Create a detailed implementation plan for: $ARGUMENTS

Include:
1. Current state analysis
2. Proposed changes with file locations
3. Step-by-step implementation tasks
4. Testing strategy
5. Potential risks and mitigations

Do NOT write code yet. Wait for plan approval.
```

**3. `.claude/commands/session-start.md`**
```markdown
Start new work session:

1. Read `docs/WORK_IN_PROGRESS.md` first for current task state
2. Read latest entry in `docs/SESSION_NOTES.md` for recent context
3. Check `git log -5 --oneline` for recent changes
4. Summarize:
   - Current task and progress
   - What was done recently
   - What's next
   - Any blockers

Ready to continue? What should we work on?
```

**4. `.claude/commands/session-end.md`**
```markdown
End work session cleanly:

1. **Update WORK_IN_PROGRESS.md:**
   - Current state
   - Next steps for resuming
   - Any blockers

2. **Update SESSION_NOTES.md:**
   - What was accomplished
   - Decisions made
   - Blockers encountered

3. **Stage and suggest commit:**
   - Review changes with git diff
   - Suggest meaningful commit message
   - Wait for approval before committing

4. Summarize session and next steps
```

**5. `.claude/commands/review.md`**
```markdown
Review the code in $ARGUMENTS for:
- Code quality and readability
- Potential bugs or edge cases
- Performance issues
- Security vulnerabilities
- Test coverage gaps

Provide specific, actionable feedback.
```

**6. `.claude/commands/test.md`**
```markdown
Create comprehensive tests for $ARGUMENTS covering:
- Happy path scenarios
- Edge cases
- Error handling
- Input validation

Use the project's testing framework and follow existing patterns.
```

---

## Session Management

### Starting a Session

```bash
cd your-project
claude
```

**In chat:**
```
/session-start
```

### During Session

**Context Management:**
- Use `/clear` between unrelated tasks
- Keep focused on one feature at a time
- Update `WORK_IN_PROGRESS.md` regularly

**Documentation:**
- Update WIP as you progress
- Keep it minimal but complete
- Think: "Can I resume from this?"

### Ending a Session

```
/session-end
```

**Ensures:**
- WIP is updated
- SESSION_NOTES captures progress
- Clean commit ready
- Ready to resume later

---

## Workflow Patterns

### Pattern 1: Feature Development

```
1. /session-start                    # Read context
2. /plan [feature description]       # Create plan
3. [Review plan, approve]
4. /clear                            # Clean context
5. "Implement plan from docs/plans/[plan].md"
6. Update WORK_IN_PROGRESS as you go
7. /test [component]                 # Create tests
8. /session-end                      # Clean ending
```

### Pattern 2: Bug Fix

```
1. /session-start
2. Reproduce bug in test
3. Fix implementation
4. Verify test passes
5. Update WIP with findings
6. /session-end
```

### Pattern 3: Interrupted Work

**Session breaks unexpectedly:**
```
Next session:
1. /session-start
2. Read WORK_IN_PROGRESS.md → recover exact state
3. Continue from next steps
```

**Task completes:**
```
1. Archive WIP decisions to ARCHITECTURE.md
2. Update SESSION_NOTES
3. **Clear WORK_IN_PROGRESS.md**
4. Ready for new task
```

---

## Configuration Best Practices

### Disable Auto-Compact

**Critical for token savings:**

```bash
claude
# In chat:
/config
# Set "Auto-compact" to OFF
```

**Why:** Reclaims 40k+ tokens, improves quality.

### Project Settings

**`.claude/settings.json`:**
```json
{
  "allowedTools": ["bash", "read", "write", "edit"],
  "dangerouslyDisableSandbox": false
}
```

---

## Troubleshooting

### Claude Forgets Project Context

**Cause:** Context cleared or conversation too long

**Solution:**
1. Check if CLAUDE.md exists and is readable
2. Use `/clear` less aggressively
3. Ensure CLAUDE.md is under 100 lines

### Code Quality Degrading

**Cause:** Accumulated context noise

**Solution:**
1. Use `/clear` between unrelated tasks
2. Disable auto-compact
3. Start fresh session for major features

### Documentation Exploding

**Cause:** Subagents creating too many docs

**Solution:**
1. Review subagent prompts - add doc policy
2. Enforce WORK_IN_PROGRESS → archive → clear pattern
3. Regular cleanup: `find docs/ -name "*.md" -type f`
4. Keep only essential docs

### Lost Context After Break

**Cause:** WIP not updated

**Solution:**
1. Always update WIP before breaks
2. Use `/session-end` command
3. Test recovery: Close and reopen, can you resume?

### Commands Not Found

**Cause:** Commands not in project `.claude/commands/`

**Solution:**
```bash
# Copy commands from standards repo
cp .claude-standards/commands/*.md .claude/commands/

# Restart Claude
exit
claude
```

---

## Checklist: Setting Up a New Project

When starting with `/project-init`:

```markdown
## Setup Checklist

- [ ] Run `/project-init` command
- [ ] Provide project details
- [ ] Review research phase output
- [ ] Approve proposed structure
- [ ] Let setup phase complete
- [ ] Verify CLAUDE.md created
- [ ] Verify docs/ structure
- [ ] Verify .claude/commands/ exists
- [ ] Test /session-start command
- [ ] Test /session-end command
- [ ] Create initial git commit
- [ ] Update SESSION_NOTES.md with goals
```

---

## Summary: Quick Reference

**Essential Files:**
1. `CLAUDE.md` - Project context (<100 lines)
2. `docs/SESSION_NOTES.md` - Running log
3. `docs/WORK_IN_PROGRESS.md` - Current task state
4. `docs/ARCHITECTURE.md` - Design decisions
5. `.claude/commands/` - Reusable prompts (project-local)
6. `.claude-standards/` - Reference guides

**Essential Commands:**
- `/project-init` - Initialize new project
- `/clear` - Remove context noise
- `/config` - Disable auto-compact
- `/session-start` - Begin session with context
- `/session-end` - Wrap up and document

**Essential Workflow:**
1. `/session-start` - Load context
2. Check WORK_IN_PROGRESS.md first
3. Plan → Approve → `/clear` → Implement
4. Update WIP as you go
5. `/session-end` - Clean wrap-up
6. Complete task → Archive → Clear WIP

**Essential Principle:**
**Quality > Quantity** - applies to context AND documentation

**Documentation Policy:**
- Update existing docs, don't create new ones
- Use WIP for current task, then archive
- One README per component, that's it
- NO implementation summaries
- NO documentation proliferation

---

**Guide Version:** 2.0.0 (2025-11-05)  
**Based on:** Anthropic best practices, community research, production experience

**Maintenance:** Review quarterly as Claude Code evolves.

# Project Initialization Command

Initialize a new Claude Code project with proper structure, documentation, and tooling.

## Phase 1: Gather Project Information

Ask the user for:
- Project name and description
- Project type (API, CLI, Frontend, etc.)
- Tech stack (language, framework, database)
- Special requirements

## Phase 2: Research & Design (DO NOT CODE YET)

1. Read `~/.claude/standards/SKILLS_AND_SUBAGENTS_REFERENCE.md`
2. Analyze project type and match to archetypes
3. Design appropriate subagents for this project
4. Design appropriate skills for this project
5. Plan directory structure
6. Draft CLAUDE.md content
7. **Present everything for user approval**
8. **WAIT for "approved" or feedback**

## Phase 3: Setup (After Approval Only)

1. Create directory structure
2. Create CLAUDE.md
3. Create docs/ (ARCHITECTURE.md, SESSION_NOTES.md, WORK_IN_PROGRESS.md)
4. Create .claude/commands/
5. Create recommended subagents in .claude/agents/
6. Create recommended skills in .claude/skills/
7. Create language-specific files
8. Create .gitignore
9. Create README.md
10. Initial git commit

## Documentation Rules

Enforce in all subagents:
- Core docs only: ARCHITECTURE.md, SESSION_NOTES.md, WORK_IN_PROGRESS.md
- Per component: README.md only (max +1 if extremely complex)
- NO implementation summaries during tasks
- Update existing docs, don't create new ones

## Critical

- Read SKILLS_AND_SUBAGENTS_REFERENCE.md before designing
- Present research phase for approval
- DO NOT create files until approved
- Follow official Anthropic best practices

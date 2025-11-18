# My Claude Standard

Universal workflow system for Claude Code projects. Clone this repo to start any new project with standardized documentation, session management, and subagent orchestration.

## Prerequisites

Claude Code must be installed globally. If not installed yet:

```bash
./install.sh
```

## Quick Start

```bash
# 1. Clone for your new project
git clone <your-repo-url> my-new-project
cd my-new-project

# 2. Initialize (deploys templates, cleans up)
./projekt_init.sh

# 3. Set up your project
nano docs/vision.md    # Fill in your project goals
git init               # Initialize your own repo

# 4. Start working in Claude Code
claude
/create-agents         # Deploy subagents
/session-start         # Begin work
```

## What Gets Created

After running `projekt_init.sh`, your project will have:

```
your-project/
├── claude.md              # Universal workflow rules
├── .claude/commands/      # Custom commands
│   ├── session-start.md
│   ├── session-end.md
│   ├── status.md
│   └── create-agents.md
└── docs/
    ├── vision.md          # Project goals (fill this!)
    ├── architecture.md    # Technical structure
    ├── session_notes.md   # Session history
    ├── work_in_progress.md # Live TODO
    ├── subagents.md       # Active subagents
    └── archive/           # Archived sessions
```

The init script automatically removes itself and the templates folder - clean slate for your project.

## Custom Commands

- **`/session-start`** - Resume work (reads vision, architecture, recent sessions)
- **`/session-end`** - Summarize & archive session
- **`/status`** - Quick overview of current state
- **`/create-agents`** - Deploy subagents from [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents)

## Daily Workflow

```bash
# Start of work session
claude
/session-start

# During work: update docs/work_in_progress.md as you go
# Use /status anytime to check current state

# End of work session
/session-end
```

## Core Principles

Enforced via `claude.md`:

- **English only** - Documentation, code, commands
- **Concise docs** - Technical, example-driven, no fluff
- **Session continuity** - work_in_progress.md as crash recovery
- **Subagent orchestration** - Delegate to subagents when sensible
- **Token efficiency** - Brief, precise, no verbosity

## Documentation Guidelines

- **vision.md** - Project concept, rarely changes
- **architecture.md** - Technical implementation, updates frequently
- **session_notes.md** - Brief session summaries (newest first)
- **work_in_progress.md** - Live protocol, archived at session end
- **subagents.md** - Tracks deployed subagents
- **One README per project/microservice** - No extra docs without permission

## Philosophy

Same `claude.md` across all projects = consistent Claude Code behavior everywhere.

## License

MIT License - See LICENSE file for details.
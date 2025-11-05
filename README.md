# Claude Code Standards

> Professional project standards for Claude Code development

Complete framework for efficient, structured development with Claude Code. Includes best practices, automated setup, and reusable commands.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🚀 Quick Start

```bash
# 1. Create new project
mkdir my-project && cd my-project
git init

# 2. Install standards
git clone https://github.com/Aeraxon/claude-code-standards .claude-standards
./.claude-standards/install.sh

# 3. Initialize project
claude
/project-init
```

**That's it!** You now have:
- ✅ Claude Code installed & configured
- ✅ Standard commands available
- ✅ Best-practice guides locally
- ✅ Project structure initialized

---

## 📦 What's Included

### 🤖 Automated Setup
- **`install.sh`** - One-command installation
- Installs Node.js, Claude Code, commands, and guides
- Configures best-practice settings

### 📚 Comprehensive Guides
- **`CLAUDE_CODE_PROJECT_GUIDE.md`** - Project setup & workflows
- **`SKILLS_AND_SUBAGENTS_REFERENCE.md`** - For Claude Code to read when designing agents/skills
- **`DEPLOYMENT_TUTORIAL.md`** - Zero to ready

### ⚡ Standard Commands
- **`/project-init`** - 3-phase project initialization
- **`/session-start`** - Start work session with context
- **`/session-end`** - Clean session endings
- **`/plan`** - Implementation planning
- **`/test`** - Comprehensive test generation
- **`/review`** - Code review
- **`/commit`** - Smart commits
- **`/refactor`** - Safe refactoring

### 🎯 Key Features

#### 3-Phase Project Initialization
1. **Information Gathering** - Collect requirements
2. **Research Phase** - Claude designs structure (WITHOUT coding)
3. **Setup Phase** - Creates everything after approval

#### Strict Documentation Rules
- Prevents documentation proliferation
- Core docs: `ARCHITECTURE.md`, `SESSION_NOTES.md`, `WORK_IN_PROGRESS.md`
- Per component: Only `README.md`
- Enforcement via subagent policies

#### Session Recovery
- `WORK_IN_PROGRESS.md` for interrupted work
- Clear recovery workflow
- No lost work on crashes

---

## 📖 Documentation

### For Beginners
Start with [`guides/DEPLOYMENT_TUTORIAL.md`](guides/DEPLOYMENT_TUTORIAL.md) - complete walkthrough.

### For Developers
- [`guides/CLAUDE_CODE_PROJECT_GUIDE.md`](guides/CLAUDE_CODE_PROJECT_GUIDE.md) - Core principles & workflows
- [`guides/SKILLS_AND_SUBAGENTS_REFERENCE.md`](guides/SKILLS_AND_SUBAGENTS_REFERENCE.md) - Design reference (for Claude Code)

---

## 🏗️ Repository Structure

```
claude-code-standards/
├── README.md                                  # This file
├── install.sh                                 # Automated setup
├── guides/
│   ├── CLAUDE_CODE_PROJECT_GUIDE.md          # Project setup guide
│   ├── SKILLS_AND_SUBAGENTS_REFERENCE.md     # Subagent/skill design (for Claude)
│   └── DEPLOYMENT_TUTORIAL.md                # Installation guide
├── commands/
│   ├── project-init.md                       # 3-phase initialization
│   ├── plan.md                               # Planning
│   ├── session-start.md                      # Session start
│   ├── session-end.md                        # Session end
│   ├── test.md                               # Test generation
│   ├── review.md                             # Code review
│   ├── commit.md                             # Smart commits
│   └── refactor.md                           # Refactoring
└── LICENSE                                    # MIT License
```

---

## 💡 Workflow

### Daily Development

```bash
# Start session
claude
/session-start

# Plan feature
/plan Add user authentication

# Review & approve plan

# Clean context
/clear

# Implement
"Implement the plan from docs/plans/authentication-2025-11-05.md"

# End session
/session-end
```

### On Interruption

```bash
# Next session
claude
/session-start
# Claude reads WORK_IN_PROGRESS.md and shows exactly where you were
```

---

## 🎯 Philosophy

### Core Principles

1. **Context Quality > Quantity**
   - CLAUDE.md under 100 lines
   - Strategic `/clear` usage
   - Auto-compact disabled

2. **Plan Before Code**
   - Plan → Approval → Implementation
   - Separate planning context from execution

3. **Documentation Discipline**
   - Strict core docs
   - No documentation proliferation
   - Update existing > Create new

4. **Session Continuity**
   - WORK_IN_PROGRESS.md for recovery
   - SESSION_NOTES.md for history
   - Clean session endings

---

## 🔧 Installation

### Project Setup (Recommended)

```bash
mkdir my-project && cd my-project
git init
git clone https://github.com/Aeraxon/claude-code-standards .claude-standards
./.claude-standards/install.sh
```

### What the Script Does

- ✅ Installs Node.js 20 (if needed)
- ✅ Installs Claude Code
- ✅ Copies commands to `.claude/commands/`
- ✅ Guides remain in cloned repository
- ✅ Configures settings (auto-compact off)
- ✅ Optional: GitHub CLI

---

## 🛠️ Prerequisites

- **OS:** Ubuntu 20.04+ (or other Linux)
- **Access:** Sudo for installation
- **Account:** Claude Pro/Max or API credits
- **Internet:** For installation & Claude Code

---

## 🤝 Contributing

Contributions welcome! Especially:
- New project-type templates
- Additional commands
- Language-specific best practices
- Bug fixes & improvements

---

## 📝 License

MIT License - see [LICENSE](LICENSE) for details.

---

## 🙏 Credits

Based on:
- [Anthropic Claude Code Best Practices](https://docs.claude.com/en/docs/claude-code)
- Official Anthropic Documentation
- Community Research & Production Experience

---

## 📧 Support

- **Issues:** [GitHub Issues](https://github.com/Aeraxon/claude-code-standards/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Aeraxon/claude-code-standards/discussions)
- **Docs:** https://docs.claude.com/en/docs/claude-code

---

**Version:** 2.0.0  
**Last Updated:** 2025-11-05  
**Maintainer:** [@Aeraxon](https://github.com/Aeraxon)

**Happy Coding with Claude! 🚀**

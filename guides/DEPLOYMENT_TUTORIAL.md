# Claude Code Deployment Tutorial

> **Goal:** Fresh Ubuntu Host → Claude Code Running → Project Initialized → Workflow Clear
> **Time:** ~5 minutes (thanks to automation!)

## 📚 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation (Automated)](#installation-automated)
3. [Authentication](#authentication)
4. [Initialize New Project](#initialize-new-project)
5. [Daily Workflow](#daily-workflow)
6. [Manual Installation](#manual-installation)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### System
- Ubuntu 20.04+ (or other Linux distribution)
- Internet connection
- Sudo privileges

### Accounts
- **Anthropic Account** with Claude Pro/Max or API Credits
  - Create at: https://claude.ai
  - Or API: https://console.anthropic.com

### Optional
- GitHub Account (for `gh` CLI integration)

---

## Installation (Automated)

### Project Setup

```bash
# 1. Create project directory
mkdir my-project
cd my-project

# 2. Initialize git
git init

# 3. Clone Claude Code Standards
git clone https://github.com/Aeraxon/claude-code-standards .claude-standards

# 4. Run installation script (does everything automatically!)
./.claude-standards/install.sh
```

**The script installs:**
- ✅ Node.js 20 (if not present)
- ✅ Claude Code
- ✅ Standard commands to `.claude/commands/`
- ✅ Guides remain in cloned repository
- ✅ Configuration (auto-compact off)
- ✅ Optional: GitHub CLI

**After installation:**
```bash
# 5. Start Claude
claude

# 6. First time: Authentication
# Follow instructions for login

# 7. Initialize project
/project-init
```

---

## Authentication

**On first `claude` call:**

### Option A: Claude Pro/Max
1. Claude opens browser
2. Log in at https://claude.ai
3. Authorize the app
4. Done!

### Option B: API Key
1. Go to https://console.anthropic.com/settings/keys
2. Create new API Key
3. Enter key in Claude
4. Done!

---

## Initialize New Project

**Use this section for:** Brand new projects starting from scratch

### What happens with /project-init?

#### Phase 1: Information Gathering

Claude asks:
```
I'll help you set up this project. Please provide:

1. **Project Name:** [?]
2. **Description:** [What does it do?]
3. **Type:** [Web App / API / CLI Tool / Library / Other]
4. **Primary Language:** [Python / TypeScript / Rust / Go / Other]
5. **Framework:** [FastAPI / React / Express / None / Other]
6. **Special Requirements:** [Any special needs?]
```

**Your answer (example):**
```
1. TaskMaster
2. REST API for team-based task management
3. Web API
4. Python 3.11
5. FastAPI
6. - PostgreSQL Database
   - JWT Authentication
   - WebSocket for real-time updates
   - Multi-tenant architecture
```

#### Phase 2: Research (Claude plans, does NOT code)

Claude creates:
```
# Project Analysis

## Recommended Structure
[Shows directory tree]

## Suggested Subagents
- api-designer (Opus) - For API endpoint design
- security-auditor (Sonnet) - For security reviews
- test-generator (Sonnet) - For test creation

## Suggested Skills
- api-conventions - REST best practices
- testing-workflow - Test patterns

## CLAUDE.md Draft
[Shows draft with your specifics]

## Next Steps
Review this proposal. If approved, I'll create the structure.
Say "approved" to proceed or ask for changes.
```

**You review and say:**
```
approved
```

**OR make changes:**
```
Good, but I want SQLAlchemy instead of raw PostgreSQL, and skip WebSockets for now.
```

#### Phase 3: Setup (After Approval)

Claude creates:
```
✓ Created directory structure
✓ Created CLAUDE.md
✓ Created docs/ARCHITECTURE.md
✓ Created docs/SESSION_NOTES.md
✓ Created docs/WORK_IN_PROGRESS.md
✓ Created .claude/commands/
✓ Created .gitignore
✓ Created requirements.txt
✓ Created src/ structure
✓ Created tests/ structure
✓ Created README.md

Initial commit created: "Initial project setup"

Your project is ready! Use /session-start to begin development.
```

### Verify Setup

```bash
# Check structure
tree -L 2 .

# Should show:
# .
# ├── CLAUDE.md
# ├── README.md
# ├── .claude/
# │   ├── commands/
# │   ├── agents/
# │   └── skills/
# ├── .claude-standards/
# │   ├── guides/
# │   └── commands/
# ├── docs/
# │   ├── ARCHITECTURE.md
# │   ├── SESSION_NOTES.md
# │   └── WORK_IN_PROGRESS.md
# ├── src/
# ├── tests/
# └── ...
```

---

## Adopt Existing Project

**Use this section for:** Existing codebases, cloned repositories, or partially completed projects

### What happens with /project-adopt?

#### Phase 1: Analysis & Discovery (Automatic)

Claude explores your project:
```
Analyzing project structure...
✓ Found Python 3.11 with FastAPI
✓ Detected PostgreSQL database
✓ Read existing documentation
✓ Analyzed git history (120 commits)
✓ Mapped 15 source files across 5 modules
```

#### Phase 2: Understanding Verification (Interactive)

Claude presents understanding:
```
## My Understanding of Your Project

**Project Type:** REST API for task management

**Tech Stack:**
- Language: Python 3.11
- Framework: FastAPI
- Database: PostgreSQL with SQLAlchemy
- Key Libraries: Pydantic, alembic, pytest

**Architecture:**
Layered architecture with:
- API layer (src/api/)
- Business logic (src/services/)
- Data layer (src/models/)
- Shared utilities (src/utils/)

**Current State:**
- Test Coverage: ~60% (pytest found)
- CI/CD: GitHub Actions configured
- Code Standards: Black formatter, ruff linter
- Documentation: README.md, scattered notes in docs/

**Recent Work:**
Last commit: "Add user authentication endpoints" (2 days ago)
Active branch: feature/auth

---

**Questions I have:**

1. I see two authentication approaches (JWT and session-based) -
   which is the preferred direction?

2. The docs/notes/ folder has multiple files - are these still
   relevant or can they be consolidated?

3. What are your immediate goals with this project?
```

**You answer:**
```
1. JWT is the way forward, session-based is legacy
2. Most notes are outdated, keep only the API design doc
3. Goals:
   - Complete authentication module
   - Add comprehensive tests
   - Improve documentation structure
```

Claude confirms understanding, then asks:
```
✓ Got it. Ready to design the integration plan.

Proceed? (yes/no)
```

**You say:** `yes`

#### Phase 3: Design & Recommendations (Claude plans, does NOT code)

Claude creates integration plan:
```
# Project Adoption Proposal

## 1. Recommended Subagents

### api-reviewer (Sonnet)
**Purpose:** Review API endpoints for consistency and best practices
**Tools:** Read, Grep, Glob
**Justification:** Project is API-focused, needs consistent design

### test-generator (Sonnet)
**Purpose:** Create comprehensive test suites
**Tools:** Read, Write, Bash
**Justification:** You want to improve test coverage

### security-auditor (Sonnet)
**Purpose:** Security review for authentication and endpoints
**Tools:** Read, Grep
**Justification:** Authentication is in progress, needs security focus

## 2. Recommended Skills

### api-conventions
**Purpose:** Enforce REST best practices
**Activates when:** Working on API endpoints
**Justification:** Ensures consistency across existing and new endpoints

### testing-workflow
**Purpose:** Standardized test creation process
**Activates when:** Writing tests
**Justification:** Helps achieve comprehensive test coverage

## 3. CLAUDE.md Content
[Shows project-specific CLAUDE.md with YOUR stack, structure, commands]

## 4. Documentation Consolidation Plan

### TO CONSOLIDATE:
- docs/notes/architecture.md → docs/ARCHITECTURE.md
  - Merge with existing architectural decisions
- docs/notes/todo.md → docs/SESSION_NOTES.md
  - Add as first session with current state

### TO RESTRUCTURE:
- docs/setup.md → CLAUDE.md (Common Commands section)
  - Contains dev setup, belongs in CLAUDE.md

### TO KEEP (Already Compliant):
- README.md ✓ - Well structured
- docs/api/ ✓ - API documentation

### UNCLEAR / NEED DECISION:
- docs/notes/meeting-notes-*.md - Archive or delete?
  - Option A: Move to docs/archive/
  - Option B: Delete (in git history anyway)

### NEW FILES TO CREATE:
- docs/ARCHITECTURE.md - Will contain: system design, decisions
- docs/SESSION_NOTES.md - Will contain: work history starting now
- docs/WORK_IN_PROGRESS.md - Empty, ready for tasks

---

**Ready to proceed?**
Review and approve, or request changes.
```

**You review and say:**
```
approved, but delete the old meeting notes - they're not useful anymore
```

#### Phase 4: Integration (After Approval)

Claude executes integration:
```
✓ Created .claude/commands/ (8 commands)
✓ Created .claude/agents/ (3 subagents)
✓ Created .claude/skills/ (2 skills)
✓ Consolidated docs/notes/architecture.md → docs/ARCHITECTURE.md
✓ Consolidated docs/notes/todo.md → docs/SESSION_NOTES.md
✓ Moved docs/setup.md content → CLAUDE.md
✓ Deleted docs/notes/meeting-notes-*.md
✓ Created docs/WORK_IN_PROGRESS.md
✓ Created CLAUDE.md (project-specific, 87 lines)
✓ Updated .gitignore

Ready to commit. Review with:
  git diff --cached

Suggested commit:
  "Adopt Claude Code Standards workflow

  - Add .claude/ structure (commands, agents, skills)
  - Create CLAUDE.md with project context
  - Consolidate documentation into standard structure
  - Add standard docs: ARCHITECTURE.md, SESSION_NOTES.md, WORK_IN_PROGRESS.md

  Subagents: api-reviewer, test-generator, security-auditor
  Skills: api-conventions, testing-workflow"

Approve commit? (yes/no)
```

**You say:** `yes` (or review first with `git diff --cached`)

```
✓ Changes committed

Project adoption complete! 🎉

Available commands:
  /session-start   - Start work sessions
  /session-end     - End sessions cleanly
  /plan <feature>  - Create implementation plans
  /review <file>   - Code review
  /test <file>     - Generate tests

Your goals:
  1. Complete authentication module
  2. Add comprehensive tests
  3. Improve documentation structure

Ready to start? Run /session-start
```

### Verify Adoption

```bash
# Check new structure
ls .claude/
# Should show: commands/ agents/ skills/ settings.json

ls .claude/commands/
# Should show: project-adopt.md, session-start.md, etc.

# Check consolidated docs
ls docs/
# Should show: ARCHITECTURE.md, SESSION_NOTES.md, WORK_IN_PROGRESS.md

# Check CLAUDE.md was created
cat CLAUDE.md
# Should show YOUR project's specifics, not a template
```

---

## Daily Workflow

### Daily Pattern

#### 1. Start Session

```bash
cd my-project
claude
```

```
/session-start
```

**Claude shows:**
- What was done last time
- Current task from WORK_IN_PROGRESS.md
- Recent commits
- Next steps

#### 2. Develop Feature

```
/plan Add user authentication with JWT
```

**Claude creates plan**, you review.

```
approved
```

```
/clear
```

```
Implement the plan from docs/plans/authentication-2025-11-05.md
```

**Claude implements**, updates WORK_IN_PROGRESS.md automatically.

#### 3. Test

```
Run tests for authentication module
```

#### 4. End Session

```
/session-end
```

**Claude:**
- Updates SESSION_NOTES.md
- Updates WORK_IN_PROGRESS.md
- Suggests commit

```
git push
```

### Interrupted Work Recovery

**Session crashes (crash, power outage, etc.):**

**Next session:**
```bash
cd my-project
claude
```

```
/session-start
```

**Claude:**
```
Reading WORK_IN_PROGRESS.md...

You were implementing JWT authentication:
- ✅ Created auth module
- ✅ Added JWT generation
- 🔄 Currently at: Adding token refresh endpoint
  - File: src/api/auth.py:line 45
  - Next: Implement refresh logic and tests

Blockers: None

Ready to continue from line 45?
```

You say:
```
yes, continue
```

---

## Manual Installation

If the script doesn't work, here are the manual steps:

### 1. Install Node.js

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version  # Verify
```

### 2. Install Claude Code

```bash
npm install -g @anthropic-ai/claude-code
claude --version  # Verify
```

### 3. Set Up Project

```bash
# Create project directory
mkdir my-project
cd my-project
git init

# Clone standards
git clone https://github.com/Aeraxon/claude-code-standards .claude-standards

# Create project commands directory
mkdir -p .claude/commands

# Copy commands to project
cp .claude-standards/commands/*.md .claude/commands/
```

### 4. Create Config

```bash
mkdir -p .claude
cat > .claude/settings.json <<EOF
{
  "autoCompact": false,
  "allowedTools": ["bash", "read", "write", "edit"]
}
EOF
```

### 5. Optional: GitHub CLI

```bash
sudo apt install gh
gh auth login
```

---

## Troubleshooting

### Claude Command Not Found

**Problem:**
```bash
claude
# command not found
```

**Solution:**
```bash
# Check npm global path
npm config get prefix
# Should be /usr/local or ~/.npm-global

# If not in PATH, add to ~/.bashrc
echo 'export PATH="$PATH:$(npm config get prefix)/bin"' >> ~/.bashrc
source ~/.bashrc
```

### Authentication Failed

**Problem:**
```
✗ Authentication failed
```

**Solution:**

**Option A: Re-authenticate**
```bash
# Remove old credentials
rm ~/.anthropic/credentials

# Restart Claude
claude
# Follow authentication flow again
```

**Option B: Check API Key**
```bash
# If using API, verify key at:
# https://console.anthropic.com/settings/keys
```

### /project-init Command Not Found

**Problem:**
```
/project-init
# Unknown command
```

**Solution:**
```bash
# Check if command exists in project
ls .claude/commands/project-init.md

# If not, copy it:
cp .claude-standards/commands/project-init.md .claude/commands/

# Restart Claude
exit
claude
```

### Auto-Compact Cannot Be Disabled

**Problem:**
Config shows auto-compact but can't disable.

**Solution:**
```bash
# Edit settings directly
nano .claude/settings.json

# Add or modify:
{
  "autoCompact": false
}

# Save and restart Claude
```

### Git Integration Not Working

**Problem:**
Claude can't create commits or access git.

**Solution:**
```bash
# Ensure git is installed
git --version

# Ensure git is configured
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# Check git is initialized in project
cd my-project
git status
# If not: git init
```

### Node Version Too Old

**Problem:**
```
Error: Node.js version must be >= 18
```

**Solution:**
```bash
# Update Node.js to 20 LTS
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify
node --version  # Should be v20.x.x
```

### Commands Not Available After Installation

**Problem:**
Custom commands like `/plan` or `/session-start` not recognized.

**Solution:**
```bash
# Verify commands are in project .claude directory
ls .claude/commands/

# If empty, copy them:
cp .claude-standards/commands/*.md .claude/commands/

# Restart Claude
exit
claude
```

---

## Cheat Sheet

### Quick Start (New Project)
```bash
# 1. Create project
mkdir my-project && cd my-project
git init

# 2. Install standards
git clone https://github.com/Aeraxon/claude-code-standards .claude-standards
./.claude-standards/install.sh

# 3. Initialize
claude
/project-init
```

### Quick Start (Existing Project)
```bash
# 1. Navigate to project
cd my-existing-project

# 2. Install standards
git clone https://github.com/Aeraxon/claude-code-standards .claude-standards
./.claude-standards/install.sh

# 3. Adopt standards
claude
/project-adopt
```

### Installation Commands (Manual)
```bash
# Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Claude Code
npm install -g @anthropic-ai/claude-code

# GitHub CLI (optional)
sudo apt install gh
gh auth login
```

### Project Setup (Manual)
```bash
# Clone and copy commands
git clone https://github.com/Aeraxon/claude-code-standards .claude-standards
mkdir -p .claude/commands
cp .claude-standards/commands/*.md .claude/commands/
```

### Daily Workflow
```bash
cd my-project
claude
```

```
# In chat:
/session-start          # Load context
/plan [feature]         # Plan feature
# [Review, approve]
/clear                  # Clean context
# "Implement plan"      # Build it
/session-end            # Wrap up
```

### Key Commands
| Command | Purpose |
|---------|---------|
| `claude` | Start new session |
| `claude --continue` | Resume last session |
| `/project-init` | Initialize new project |
| `/project-adopt` | Adopt existing project |
| `/session-start` | Begin work session |
| `/session-end` | End session cleanly |
| `/plan <feature>` | Create implementation plan |
| `/clear` | Clear context noise |
| `/config` | Configure settings |

---

## Next Steps

1. ✅ Install Claude Code
2. ✅ Set up standard configuration
3. ✅ Create your first project with `/project-init`
4. ✅ Follow the daily workflow
5. 📖 Read `CLAUDE_CODE_PROJECT_GUIDE.md` for details
6. 📖 Read `SKILLS_AND_SUBAGENTS_REFERENCE.md` for subagents/skills

---

## Resources

- **Claude Code Docs:** https://docs.claude.com/en/docs/claude-code
- **API Docs:** https://docs.anthropic.com
- **Community:** https://discord.gg/anthropic
- **Support:** https://support.claude.com

---

**Tutorial Version:** 2.0.0  
**Last Updated:** 2025-11-05  
**Feedback welcome!** Improve based on your experience.

---

**Happy Coding! 🚀**

# Project Adoption Command

Adopt an existing project into the Claude Code Standards workflow.

**Use this when:** You have cloned or are working on an existing codebase and want to integrate Claude Code Standards.

**Do NOT use for:** New projects from scratch (use `/project-init` instead).

---

## Phase 1: Analysis & Discovery (Automatic)

Analyze the existing project thoroughly:

### 1.1 Codebase Structure
- Explore directory structure (use Glob, Read)
- Identify source directories, test directories, config directories
- Find entry points and main components
- Map file organization patterns

### 1.2 Tech Stack Detection
- Identify programming languages (check file extensions)
- Detect frameworks (package.json, requirements.txt, Cargo.toml, etc.)
- Find databases and data stores (config files, migrations)
- Identify build tools, package managers
- Check for containerization (Docker, K8s)

### 1.3 Existing Documentation
- Find and READ all documentation:
  - README.md
  - Any docs/ directory contents
  - CONTRIBUTING.md, ARCHITECTURE.md, etc.
  - Code comments and docstrings
  - API documentation
- **DO NOT just list files - READ and understand them**

### 1.4 Git History Analysis
- Check recent commits (`git log -20 --oneline`)
- Identify active branches
- Understand development patterns
- Find contributors and activity level

### 1.5 Quality & Standards Check
- Identify existing tests (unit, integration, e2e)
- Find CI/CD configuration (.github/, .gitlab-ci.yml, etc.)
- Detect linters and formatters (.eslintrc, .prettierrc, pyproject.toml, etc.)
- Check for existing code standards documentation

### 1.6 Architectural Understanding
- Identify architectural patterns (monolith, microservices, layered, etc.)
- Map component relationships
- Find external dependencies (APIs, services, databases)
- Understand data flow

---

## Phase 2: Understanding Verification (Interactive - DO NOT SKIP)

Present your analysis and verify understanding with the user:

### 2.1 Project Summary
Present in this format:

```
## My Understanding of Your Project

**Project Type:** [Web API / CLI / Frontend / Library / etc.]

**Tech Stack:**
- Language(s): [List with versions if found]
- Framework(s): [List]
- Database(s): [List]
- Key Libraries: [Top 5-7 most important]

**Architecture:**
[Describe the architecture pattern and structure]

**Current State:**
- Test Coverage: [Present if found, otherwise "Unknown"]
- CI/CD: [Yes/No, which tools]
- Code Standards: [Present/Partial/None]
- Documentation: [Good/Adequate/Minimal/None]

**Active Development:**
- Last Commit: [Date]
- Recent Work: [Brief summary from git log]
- Active Branches: [List if multiple]
```

### 2.2 Clarification Questions
Ask specific questions about unclear aspects:
- "I see X pattern in Y - is this intentional or legacy?"
- "There are two different approaches for Z - which is preferred?"
- "Component A seems to do B and C - is this correct?"
- "The docs mention D but I don't see it in code - is this outdated?"

### 2.3 Goal Setting
**CRITICAL:** Ask the user:
1. **"What are your immediate goals with this project?"**
   - Bug fixes? New features? Refactoring? Documentation?
2. **"What problems are you facing?"**
   - Poor documentation? Hard to onboard? Technical debt?
3. **"What should we focus on first?"**
   - Let the user prioritize

### 2.4 Wait for Confirmation
**DO NOT PROCEED** until the user confirms:
- ✅ Your understanding is correct
- ✅ They've answered your questions
- ✅ Goals and priorities are clear

---

## Phase 3: Design & Recommendations (DO NOT CODE YET)

Design the integration strategy:

### 3.1 Read Reference Material
1. **MANDATORY:** Read `~/.claude/standards/SKILLS_AND_SUBAGENTS_REFERENCE.md`
2. Understand subagent patterns for this project type
3. Understand skill patterns for this project type

### 3.2 Match Project Archetype
- Find closest match in SKILLS_AND_SUBAGENTS_REFERENCE.md
- If hybrid project, combine relevant archetypes
- Consider project-specific needs

### 3.3 Design Subagents
Based on project type and user goals, recommend:
- **3-5 subagents** (don't over-engineer)
- Focus on immediate user goals
- Each with: name, purpose, model choice, tools, justification

**Example:**
```
### code-reviewer (Sonnet)
**Purpose:** Review code for quality, security, and consistency
**Tools:** Read, Grep, Glob
**Justification:** Project has inconsistent code quality mentioned in goals
```

### 3.4 Design Skills
Recommend **2-4 skills** that standardize workflows:
- Based on existing patterns in the codebase
- Address user's stated problems
- Match team workflow (infer from git history, CI/CD, etc.)

### 3.5 Design CLAUDE.md
Draft CLAUDE.md content including:

**Extract from existing project:**
- Tech stack (from your analysis)
- Project structure (actual current structure)
- Existing coding standards (if documented)
- Common commands (from README, Makefile, package.json scripts)
- Key patterns (from code analysis)
- Known gotchas (from docs, comments, TODOs)

**Add standard sections:**
- Documentation Policy (standard from guide)
- Session Continuity (standard from guide)

**Result:** CLAUDE.md that reflects the ACTUAL project, not a template

### 3.6 Design Documentation Consolidation

Analyze existing docs and propose consolidation:

**Format:**
```
## Documentation Consolidation Plan

### TO CONSOLIDATE:
- [source-file.md] → [target-file.md]
  - Reason: [Why this makes sense]
  - Content: [What will be extracted/merged]

### TO RESTRUCTURE:
- [source-file.md] → [new-location/purpose]
  - Reason: [Why]
  - What changes: [Describe transformation]

### TO KEEP (Already Compliant):
- [file.md] ✓ - [Brief reason]

### UNCLEAR / NEED DECISION:
- [file.md] - [What's unclear, ask user]
  - Option A: [Suggestion]
  - Option B: [Alternative]
  - Option C: Archive/Delete

### NEW FILES TO CREATE:
- docs/ARCHITECTURE.md - [Will contain: X, Y, Z]
- docs/SESSION_NOTES.md - [Will contain: Initial session summary]
- docs/WORK_IN_PROGRESS.md - [Empty, ready for use]
- .claude/commands/ - [List of commands to copy]
```

**Consolidation Principles:**
1. **Preserve information** - Don't lose valuable content
2. **Reduce redundancy** - Merge duplicated information
3. **Follow structure** - Map to standard docs (ARCHITECTURE, SESSION_NOTES, WORK_IN_PROGRESS, CLAUDE.md)
4. **Respect existing** - If README.md is good, keep it
5. **Ask when uncertain** - User knows the project better

### 3.7 Present Everything for Approval

Format your complete proposal:

```
# Project Adoption Proposal for [Project Name]

## 1. Project Summary
[Your understanding from Phase 2]

## 2. Recommended Subagents
[List each with details]

## 3. Recommended Skills
[List each with details]

## 4. CLAUDE.md Content
[Show draft - keep it under 100 lines]

## 5. Documentation Consolidation Plan
[Your detailed plan from 3.6]

## 6. Directory Structure After Adoption
[Show what the final structure will look like]

## 7. Integration Steps Summary
[High-level overview of what will happen in Phase 4]

---

**Ready to proceed?**
Please review and let me know:
- ✅ Approve as-is
- 🔧 Changes needed (specify)
- ❓ Questions
```

### 3.8 WAIT FOR APPROVAL
**DO NOT PROCEED TO PHASE 4** until user explicitly approves or you've addressed all feedback.

---

## Phase 4: Integration (After Approval Only)

Execute the approved integration plan:

### 4.1 Backup Check
```bash
# Ensure git is clean or changes are committed
git status
```
If there are uncommitted changes, ask user to commit or stash first.

### 4.2 Create .claude/ Structure
```bash
# Create directories
mkdir -p .claude/commands
mkdir -p .claude/agents
mkdir -p .claude/skills
```

### 4.3 Copy Standard Commands
Copy commands from `.claude-standards/commands/` to `.claude/commands/`:
- session-start.md
- session-end.md
- plan.md
- review.md
- test.md
- commit.md
- refactor.md
- **project-adopt.md (this file)** - for future reference

### 4.4 Create Subagents
For each approved subagent:
1. Create `.claude/agents/[name].md`
2. Include proper frontmatter and detailed system prompt
3. Follow patterns from SKILLS_AND_SUBAGENTS_REFERENCE.md

### 4.5 Create Skills
For each approved skill:
1. Create `.claude/skills/[name]/` directory
2. Create `SKILL.md` with frontmatter and instructions
3. Add any templates or resources if needed

### 4.6 Execute Documentation Consolidation
Follow the approved consolidation plan carefully:

**For each consolidation:**
1. Read source file(s)
2. Create or update target file
3. Preserve all valuable information
4. Structure according to standards
5. Note what was done (for commit message)

**For unclear items:**
- Follow user's decision from approval phase
- If new questions arise, STOP and ask

### 4.7 Create CLAUDE.md
Write the approved CLAUDE.md to project root:
- Use the drafted content from Phase 3
- Ensure under 100 lines
- Reflect ACTUAL project, not generic template

### 4.8 Create docs/ Structure (if not exists)
```bash
mkdir -p docs/plans
```

### 4.9 Create/Update Standard Docs

**docs/ARCHITECTURE.md:**
- If exists: Review and potentially restructure to match standard format
- If not: Create from consolidation plan
- Content: Extracted from existing docs + code analysis

**docs/SESSION_NOTES.md:**
- Create if doesn't exist
- First entry: "Project adopted into Claude Code Standards"
- Include: What was done, what was consolidated, goals going forward

**docs/WORK_IN_PROGRESS.md:**
- Create empty (ready for use)
- Template structure

### 4.10 Update .gitignore
Add if not present:
```
CLAUDE.local.md
.claude/local/
```

### 4.11 Verify Integration
Check that everything is in place:
- [ ] `.claude/commands/` with standard commands
- [ ] `.claude/agents/` with recommended subagents
- [ ] `.claude/skills/` with recommended skills
- [ ] `CLAUDE.md` exists and is project-specific
- [ ] `docs/ARCHITECTURE.md` exists
- [ ] `docs/SESSION_NOTES.md` exists
- [ ] `docs/WORK_IN_PROGRESS.md` exists
- [ ] Consolidation plan executed
- [ ] No valuable documentation lost

### 4.12 Prepare Commit
Stage all new and modified files:
```bash
git add .claude/ CLAUDE.md docs/ .gitignore
git status
```

Suggest commit message:
```
Adopt Claude Code Standards workflow

- Add .claude/ structure (commands, agents, skills)
- Create CLAUDE.md with project context
- Consolidate documentation:
  - [list what was consolidated]
- Add standard docs: ARCHITECTURE.md, SESSION_NOTES.md, WORK_IN_PROGRESS.md
- Configure for Claude Code development

Recommended subagents:
- [list]

Recommended skills:
- [list]
```

**DO NOT commit automatically** - let user review and commit.

### 4.13 Final Summary
Present to user:
```
✅ Project adoption complete!

**What was added:**
- [List]

**What was consolidated:**
- [List]

**Ready to use:**
- /session-start - Begin work sessions
- /session-end - End sessions cleanly
- /plan - Create implementation plans
- [List other commands]

**Subagents available:**
- [List with brief description]

**Skills active:**
- [List with brief description]

**Next steps:**
1. Review the changes with `git diff --cached`
2. Commit when ready
3. Run `/session-start` to begin working with the new structure
4. Work on your goals: [remind them of their stated goals]

**Documentation:**
- See `CLAUDE.md` for project context
- See `docs/ARCHITECTURE.md` for system design
- Update `docs/WORK_IN_PROGRESS.md` when working on tasks
```

---

## Documentation Policy Enforcement

Throughout all phases, enforce these rules:

**Core Docs Only:**
- ARCHITECTURE.md - System design
- SESSION_NOTES.md - Session history
- WORK_IN_PROGRESS.md - Current task state
- CLAUDE.md - Project context

**Per Component:**
- README.md only (max +1 if extremely complex)

**Forbidden:**
- Implementation summaries
- Task-specific temp docs
- Multiple docs per component
- Documentation proliferation

**When consolidating:**
- Question: "Does this need its own document or can it go in existing docs?"
- Default: Consolidate into existing standard docs

---

## Critical Rules

1. **DO NOT skip Phase 2** - Understanding verification is crucial
2. **DO NOT skip approval** - User must approve before Phase 4
3. **DO NOT delete files without asking** - Consolidate, don't destroy
4. **DO NOT create generic CLAUDE.md** - Must be project-specific
5. **DO NOT over-engineer** - 3-5 subagents, 2-4 skills is usually enough
6. **DO ask when uncertain** - User knows their project best
7. **DO preserve git history** - Don't use `git mv` unnecessarily
8. **DO focus on user's goals** - This is about helping them, not perfect structure

---

## Example Scenarios

### Scenario 1: Half-finished RAG System
**Phase 1:** Analyze vector DB, embeddings, retrieval logic, API endpoints
**Phase 2:** Ask about data sources, embedding model choice, current limitations
**Phase 3:** Recommend `data-pipeline-specialist`, `api-reviewer`, `test-generator`; Skills: `rag-patterns`, `vector-db-ops`
**Phase 4:** Consolidate scattered notes into ARCHITECTURE.md, create CLAUDE.md with RAG-specific context

### Scenario 2: Legacy Microservices Project
**Phase 1:** Map services, inter-service communication, databases, deployment
**Phase 2:** Clarify service boundaries, which services are stable vs. in flux
**Phase 3:** Recommend `service-architect`, `api-designer`, `observability-engineer`; Skills: `microservice-patterns`, `deployment-workflow`
**Phase 4:** Create architecture map in ARCHITECTURE.md, consolidate per-service READMEs

### Scenario 3: Open Source Project Clone
**Phase 1:** Understand existing structure, read CONTRIBUTING.md, check issues
**Phase 2:** Ask what user wants to contribute, what they find confusing
**Phase 3:** Lighter touch - respect existing structure, focus on personal workflow
**Phase 4:** Create CLAUDE.md for personal context, minimal consolidation

---

## Troubleshooting

**"Too much existing documentation"**
- Focus on consolidation in Phase 3
- Be aggressive about merging
- Ask user which docs are actually used

**"Unclear project structure"**
- Use Task tool with Explore subagent
- Read more code files
- Ask user for clarification in Phase 2

**"User goals are vague"**
- Ask more specific questions
- Offer examples: "Are you trying to add features, fix bugs, or refactor?"
- Suggest starting small

**"Project is too complex for 3-5 subagents"**
- Prioritize based on user goals
- Start with essential ones
- Note in SESSION_NOTES that more can be added later

---

## Success Criteria

The adoption is successful when:
- ✅ User can use `/session-start` and continue work
- ✅ `CLAUDE.md` accurately reflects the project
- ✅ Documentation is organized and accessible
- ✅ No valuable information was lost
- ✅ User knows what to do next (their goals are clear)
- ✅ Standard workflow is usable (commands, agents, skills)
- ✅ User feels the structure helps, not hinders

---

**Remember:** The goal is to help the user work effectively with their existing project, not to impose a rigid structure. Adapt thoughtfully.

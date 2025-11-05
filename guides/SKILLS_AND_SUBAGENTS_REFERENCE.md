# Skills & Subagents Design Reference for Claude Code

> **Purpose:** This document is a reference for Claude Code when designing subagents and skills during project initialization.  
> **Context:** When user runs `/project-init`, you will read this guide to understand how to design optimal subagents and skills for their specific project.

## Document Intent

This guide helps you (Claude Code) design appropriate subagents and skills based on the user's project requirements. Use this knowledge to:
1. Analyze project type and complexity
2. Recommend specific subagents with clear responsibilities
3. Design skills that match team workflows
4. Follow official Anthropic best practices

---

## Core Concepts

### Subagents

**What they are:**  
Specialized AI assistants with separate context windows, custom system prompts, and specific tool permissions.

**Key characteristics:**
- Independent context window (prevents context pollution)
- Custom system prompt defining behavior
- Granular tool access control
- Can be invoked automatically or manually
- Defined in Markdown files with YAML frontmatter
- Located in `.claude/agents/` (project) or `~/.claude/agents/` (global)

**File format:**
```markdown
---
name: agent-name
description: When and why to invoke this agent
tools: Read, Write, Edit, Bash  # Optional - omit for full access
model: sonnet  # Optional: sonnet, opus, haiku, inherit
---

# System Prompt

Detailed instructions for this specialized agent...
```

### Skills

**What they are:**  
Modular capability packages that Claude automatically activates when relevant to the task at hand.

**Key characteristics:**
- Auto-invoked based on task context
- Directory-based with SKILL.md file
- Can include scripts, templates, and resources
- Progressive disclosure (only loaded when needed)
- Team-shareable via git
- Located in `.claude/skills/` (project) or `~/.claude/skills/` (global)

**File format:**
```markdown
---
name: skill-name
description: What this skill does and when it activates
allowed-tools: Read, Write, Bash  # Optional
---

# Skill Instructions

Step-by-step instructions for this capability...
```

---

## When to Use What

### Use Subagents When:

✅ **Context isolation is critical**
- Task needs its own "mental space"
- Main conversation must stay focused
- Parallel work without cross-contamination

✅ **Tool restriction is needed**
- Security: limit tool access
- Focus: constrain to specific actions
- Safety: prevent unintended operations

✅ **Specialized, repeatable tasks**
- Code reviews
- Debugging sessions
- Security audits
- Test generation
- Data analysis

✅ **Model optimization opportunities**
- Complex tasks → Opus (slower, more capable)
- Simple tasks → Haiku (faster, cheaper)
- Balanced tasks → Sonnet (default)

**Examples:**
```
User needs code review → Create `code-reviewer` subagent
User needs security audit → Create `security-auditor` subagent  
User needs test generation → Create `test-generator` subagent
```

### Use Skills When:

✅ **Standardizing team workflows**
- Everyone follows same process
- Shareable via git
- Project-specific conventions

✅ **Extending capabilities**
- New abilities to add
- Complex multi-step processes
- Tool combinations

✅ **Knowledge packages**
- Brand guidelines
- Architecture patterns
- Best practices
- Domain expertise

✅ **Auto-activation desired**
- No explicit invocation needed
- Context-based triggering
- Seamless integration

**Examples:**
```
Team needs consistent API design → Create `api-conventions` skill
Team needs testing patterns → Create `testing-workflow` skill
Team needs commit standards → Create `commit-conventions` skill
```

---

## Official Best Practices

### From Anthropic Documentation

1. **Start with Claude-generated agents**
   - Let Claude Code generate initial subagent
   - Then iterate to customize
   - "We highly recommend generating your initial subagent with Claude"

2. **Keep scopes narrow**
   - Single responsibility per subagent/skill
   - Avoid "Swiss Army Knife" agents
   - Clear, focused purpose

3. **Write precise system prompts**
   - Detailed instructions
   - Clear output format
   - Specific process steps

4. **Grant minimal tool permissions**
   - Only tools actually needed
   - Explicit is better than inherited
   - Security-first mindset

5. **Use subagents proactively**
   - "Telling Claude to use subagents to verify details... tends to preserve context availability"
   - Early invocation for research/validation
   - Prevents main context bloat

---

## Subagent Design Patterns

### Pattern 1: Reviewer/Analyzer Agent

**Purpose:** Isolated review without polluting main context

**Characteristics:**
- Read-only or minimal write access
- Separate context for deep analysis
- Structured output format
- Can be invoked multiple times

**Template:**
```markdown
---
name: [domain]-reviewer
description: Reviews [specific aspect] when user requests review or analysis
tools: Read, Grep, Glob  # Read-only
model: sonnet
---

# [Domain] Reviewer

## Role
Expert in [domain] focusing on [specific aspects].

## Responsibilities
1. [Responsibility 1]
2. [Responsibility 2]
3. [Responsibility 3]

## Process
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Output Format
### Summary
[High-level assessment]

### Issues Found
- [Issue category]: [Details]

### Recommendations
- [Actionable suggestion]
```

**Example Applications:**
- `code-reviewer` - Code quality, security, performance
- `security-auditor` - Vulnerabilities, best practices
- `architecture-reviewer` - Design decisions, patterns
- `api-reviewer` - API design, consistency

### Pattern 2: Generator/Creator Agent

**Purpose:** Create artifacts in isolated context

**Characteristics:**
- Write access to create files
- Can run tools (bash, edit, write)
- Focused on generation, not analysis
- May use specific templates

**Template:**
```markdown
---
name: [type]-generator
description: Generates [type] when user needs [specific output]
tools: Read, Write, Edit, Bash
model: sonnet
---

# [Type] Generator

## Role
Specialist in creating [type] following best practices.

## Responsibilities
1. Understand requirements
2. Generate structure
3. Fill with appropriate content
4. Validate output

## Process
1. Gather requirements
2. Check existing patterns
3. Generate from template
4. Verify completeness

## Output
[Description of what it produces]
```

**Example Applications:**
- `test-generator` - Comprehensive test suites
- `docs-writer` - Documentation following standards
- `api-designer` - API endpoints and schemas
- `config-generator` - Configuration files

### Pattern 3: Specialist/Domain Expert Agent

**Purpose:** Deep expertise in specific domain

**Characteristics:**
- Opus model for complex reasoning
- Comprehensive tool access
- Domain-specific knowledge
- Iterative refinement capable

**Template:**
```markdown
---
name: [domain]-specialist
description: Expert in [domain] for [specific scenarios]
tools: Read, Write, Edit, Bash, Grep, Glob
model: opus  # Complex domain expertise
---

# [Domain] Specialist

## Expertise
- [Area 1]
- [Area 2]
- [Area 3]

## When to Use
- [Scenario 1]
- [Scenario 2]
- [Scenario 3]

## Process
1. [Domain-specific step 1]
2. [Domain-specific step 2]
3. [Domain-specific step 3]

## Best Practices
- [Practice 1]
- [Practice 2]
```

**Example Applications:**
- `database-architect` - Schema design, query optimization
- `performance-optimizer` - Profiling, bottleneck analysis
- `security-specialist` - Threat modeling, secure coding
- `data-scientist` - Analysis, visualization, ML

---

## Skill Design Patterns

### Pattern 1: Workflow Skill

**Purpose:** Multi-step standardized process

**Structure:**
```markdown
---
name: [workflow]-workflow
description: Standard process for [workflow]. Activates when [trigger conditions].
allowed-tools: Read, Write, Edit, Bash
---

# [Workflow] Workflow

## Purpose
[What this workflow achieves]

## When to Use
- [Trigger 1]
- [Trigger 2]
- [Trigger 3]

## Process
### Step 1: [Name]
[Detailed instructions]

### Step 2: [Name]
[Detailed instructions]

### Step 3: [Name]
[Detailed instructions]

## Validation
- [Check 1]
- [Check 2]

## Examples
[Concrete example of workflow in action]
```

**Example Applications:**
- `testing-workflow` - How to write comprehensive tests
- `deployment-workflow` - How to deploy safely
- `code-review-workflow` - How to review code
- `refactoring-workflow` - How to refactor safely

### Pattern 2: Convention/Standard Skill

**Purpose:** Enforce team conventions

**Structure:**
```markdown
---
name: [domain]-conventions
description: Standards and conventions for [domain]. Auto-applies to [context].
allowed-tools: Read, Bash
---

# [Domain] Conventions

## Purpose
Ensure consistency in [domain]

## Standards

### Standard 1: [Name]
**Rule:** [Description]
**Example:** [Good example]
**Anti-pattern:** [Bad example]

### Standard 2: [Name]
[Similar format]

## Validation
How to check compliance:
- [Check 1]
- [Check 2]

## Common Mistakes
- [Mistake 1] → Fix: [Solution]
- [Mistake 2] → Fix: [Solution]
```

**Example Applications:**
- `commit-conventions` - Conventional commits format
- `naming-conventions` - File/function naming rules
- `api-conventions` - REST/GraphQL standards
- `code-style` - Language-specific style guide

### Pattern 3: Generator/Template Skill

**Purpose:** Generate consistent artifacts

**Structure:**
```markdown
---
name: [type]-generator
description: Generates [type] following project patterns. Use when creating [scenarios].
allowed-tools: Read, Write
---

# [Type] Generator

## Purpose
Create consistent [types] following patterns

## When to Use
- [Use case 1]
- [Use case 2]

## Process
1. Gather requirements
2. Check existing patterns
3. Select appropriate template
4. Generate with customization
5. Validate output

## Templates
[Reference to templates/ directory]

## Examples
[Concrete generation examples]
```

**Example Applications:**
- `component-generator` - UI components
- `api-endpoint-generator` - API routes
- `migration-generator` - Database migrations
- `test-boilerplate` - Test file scaffolding

---

## Project-Type Archetypes

Use these patterns when analyzing user's project type.

### Web API / REST API

**Recommended Subagents:**
1. `api-designer` (Opus) - Endpoint design, schemas
2. `security-auditor` (Sonnet) - API security review
3. `test-generator` (Sonnet) - API test suites
4. `docs-writer` (Sonnet) - API documentation

**Recommended Skills:**
1. `api-conventions` - REST best practices
2. `openapi-generator` - OpenAPI spec generation
3. `authentication-patterns` - Auth implementation
4. `error-handling` - Error response standards

**Rationale:** APIs need consistent design, strong security, comprehensive tests, and clear documentation.

### Frontend Application (React/Vue/Angular)

**Recommended Subagents:**
1. `component-architect` (Opus) - Component design
2. `ui-reviewer` (Sonnet) - UI/UX review
3. `accessibility-auditor` (Sonnet) - A11y checks
4. `performance-optimizer` (Sonnet) - Bundle/render optimization

**Recommended Skills:**
1. `component-patterns` - Component best practices
2. `style-guide` - Design system enforcement
3. `responsive-design` - Mobile/desktop patterns
4. `state-management` - State handling patterns

**Rationale:** Frontend needs component consistency, accessibility, performance, and design system compliance.

### CLI Tool

**Recommended Subagents:**
1. `cli-designer` (Opus) - Command structure
2. `error-handler` (Sonnet) - User-friendly errors
3. `docs-writer` (Sonnet) - Help text & docs
4. `test-generator` (Sonnet) - Integration tests

**Recommended Skills:**
1. `cli-conventions` - Argument parsing standards
2. `help-formatter` - User-friendly help text
3. `error-messages` - Clear error communication
4. `config-management` - Config file patterns

**Rationale:** CLIs need intuitive UX, clear errors, comprehensive help, and robust testing.

### Data Pipeline / ETL

**Recommended Subagents:**
1. `data-architect` (Opus) - Pipeline design
2. `data-validator` (Sonnet) - Data quality checks
3. `performance-optimizer` (Sonnet) - Query/processing optimization
4. `monitoring-specialist` (Sonnet) - Observability

**Recommended Skills:**
1. `etl-patterns` - Extract/transform/load patterns
2. `data-validation` - Schema & quality checks
3. `error-recovery` - Retry & compensation patterns
4. `monitoring` - Metrics & alerting

**Rationale:** Data pipelines need robust design, quality validation, performance, and monitoring.

### Library / Package

**Recommended Subagents:**
1. `api-designer` (Opus) - Public API design
2. `docs-writer` (Sonnet) - Comprehensive documentation
3. `example-creator` (Sonnet) - Usage examples
4. `version-manager` (Sonnet) - Release management

**Recommended Skills:**
1. `api-stability` - Backwards compatibility
2. `semver` - Semantic versioning
3. `documentation-standard` - Doc structure
4. `publishing-workflow` - Package distribution

**Rationale:** Libraries need stable APIs, excellent docs, clear examples, and proper versioning.

### Microservices Architecture

**Recommended Subagents:**
1. `service-architect` (Opus) - Service boundaries
2. `api-designer` (Opus) - Inter-service APIs
3. `infrastructure-specialist` (Sonnet) - Deployment & scaling
4. `observability-engineer` (Sonnet) - Monitoring & tracing

**Recommended Skills:**
1. `service-patterns` - Microservice patterns
2. `api-contracts` - Service interface standards
3. `deployment-workflow` - CI/CD patterns
4. `distributed-tracing` - Observability practices

**Rationale:** Microservices need clear boundaries, robust APIs, solid infrastructure, and comprehensive observability.

---

## Design Process for You (Claude Code)

When user runs `/project-init`, follow this process:

### Step 1: Analyze Project

Examine user-provided information:
- Project type (API, CLI, Frontend, etc.)
- Tech stack (languages, frameworks)
- Complexity (simple, medium, complex)
- Team size (solo, small team, large team)
- Special requirements (security, performance, scale)

### Step 2: Match Archetypes

Find closest archetype(s):
- If exact match → Use archetype recommendations
- If hybrid → Combine relevant archetypes
- If novel → Design from first principles using patterns

### Step 3: Design Subagents

For each recommended subagent:

1. **Define purpose** - What specific problem does it solve?
2. **Choose model** - Opus for complex, Sonnet for balanced, Haiku for simple
3. **Set tools** - Minimum required for the task
4. **Write system prompt** - Clear responsibilities, process, output format
5. **Document invocation** - When and how to use it

**Quality checks:**
- ✅ Single responsibility
- ✅ Clear invocation triggers
- ✅ Minimal tool access
- ✅ Structured output format

### Step 4: Design Skills

For each recommended skill:

1. **Define workflow** - What process does it standardize?
2. **Set activation context** - When should it auto-activate?
3. **Document process** - Step-by-step instructions
4. **Include examples** - Concrete usage scenarios
5. **Add validation** - How to verify correct application

**Quality checks:**
- ✅ Clear activation conditions
- ✅ Step-by-step process
- ✅ Concrete examples
- ✅ Easily testable

### Step 5: Present for Review

Format your recommendations:

```markdown
## Recommended Subagents

### [Agent Name] (Model: [sonnet/opus/haiku])
**Purpose:** [One-line description]
**When to use:** [Clear scenarios]
**Tools:** [List of tools]
**Justification:** [Why this project needs it]

## Recommended Skills

### [Skill Name]
**Purpose:** [One-line description]
**Activates when:** [Clear triggers]
**Justification:** [Why this project needs it]

## Rationale
[Overall strategy for this project's subagent/skill setup]
```

---

## Anti-Patterns to Avoid

### ❌ Swiss Army Knife Agent
```markdown
---
name: do-everything
description: Handles code review, testing, documentation, deployment, and more
---
```
**Problem:** Too broad, no clear focus  
**Fix:** Split into specialized agents

### ❌ Vague Description
```markdown
---
name: helper
description: Helps with stuff when needed
---
```
**Problem:** Claude won't know when to invoke  
**Fix:** Specific triggers and scenarios

### ❌ Over-Permissioned
```markdown
---
name: read-only-reviewer
# Missing tools field → inherits all tools
---
```
**Problem:** Security risk, unintended actions  
**Fix:** Explicitly define minimal tools

### ❌ Missing Structure
```markdown
---
name: reviewer
---

Review the code well.
```
**Problem:** No guidance, inconsistent results  
**Fix:** Detailed process and output format

### ❌ Skill Without Clear Activation
```markdown
---
name: my-skill
description: A skill that does something
---
```
**Problem:** Claude won't know when to activate  
**Fix:** Clear context and triggers in description

---

## Tool Permissions Reference

### Common Tool Sets by Role

**Read-Only Analysis:**
```yaml
tools: Read, Grep, Glob
```
Use for: Reviewers, auditors, analyzers

**Implementation:**
```yaml
tools: Read, Write, Edit, Bash
```
Use for: Generators, implementers, builders

**Testing:**
```yaml
tools: Read, Write, Bash
```
Use for: Test runners, validators, CI tools

**Documentation:**
```yaml
tools: Read, Write
```
Use for: Docs writers, example creators

**Full Access (be cautious):**
```yaml
# Omit tools field
```
Use for: Architects, complex specialists

---

## Model Selection Guide

### Sonnet (Default)
- **Use for:** Most tasks
- **Characteristics:** Balanced speed/quality
- **Examples:** Reviewers, generators, testers

### Opus
- **Use for:** Complex reasoning required
- **Characteristics:** Slow but thorough
- **Examples:** Architects, security specialists, complex designers

### Haiku
- **Use for:** Simple, fast tasks
- **Characteristics:** Fast but limited
- **Examples:** Format checkers, simple validators
- **Note:** Not recommended for serious development work

### Inherit
- **Use for:** Match main conversation model
- **When:** Want consistency with main thread

---

## Final Checklist

Before presenting subagent/skill recommendations:

**Subagents:**
- [ ] Single responsibility per agent
- [ ] Clear invocation triggers in description
- [ ] Minimal tool permissions
- [ ] Appropriate model selection
- [ ] Structured output format defined
- [ ] Process steps documented

**Skills:**
- [ ] Clear activation context in description
- [ ] Step-by-step process defined
- [ ] Concrete examples included
- [ ] Validation steps specified
- [ ] Team-shareable standards

**Overall:**
- [ ] Matches project type archetype
- [ ] Addresses project-specific needs
- [ ] Follows Anthropic best practices
- [ ] No anti-patterns present
- [ ] Justification provided for each

---

## Summary

**Your role:** Design optimal subagents and skills based on project analysis.

**Key principles:**
1. Match project type to archetypes
2. Single responsibility per agent/skill
3. Minimal permissions
4. Clear triggers and processes
5. Follow official best practices

**Remember:** The goal is to create a productive, focused development environment with specialized agents and standardized skills that match the team's workflow.

---

**Reference Version:** 2.0.0  
**Last Updated:** 2025-11-05  
**Based on:** Official Anthropic documentation and community best practices

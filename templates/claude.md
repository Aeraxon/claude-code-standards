# Claude Code Workflow Standards

## Language
All project work is conducted in English: documentation, internal commands, code comments, commit messages. UI text may be in other languages as required.

## Project Structure

### Required Documentation (`docs/`)
- **vision.md** - Project goal and concept. Rarely modified. Conceptual, not technical.
- **architecture.md** - Actual technical implementation structure. Updated when architecture changes.
- **session_notes.md** - Session summaries. Most recent sessions at top for easy `/session-start` reading.
- **work_in_progress.md** - Live session protocol. Tracks current state, TODO lists, milestones. Archived at session end.
- **subagents.md** - Active subagents tracking: which ones, their purpose, status.

### Documentation Style
Write concise, technical documentation with these rules:
- **No verbose introductions** - Start with the information directly
- **Bullet points over paragraphs** - Use lists for clarity
- **Code examples over explanations** - Show, don't tell
- **Skip obvious sections** - No "Introduction", "Conclusion", "Troubleshooting" unless explicitly requested
- **Maximum 3-4 sentences per concept** - Be brief
- **Technical precision over friendliness** - Assume technical audience

Example of TOO MUCH:
```
# Getting Started with the API

Welcome! This guide will walk you through the process of getting started
with our API. First, let's discuss what you'll need...
```

Example of GOOD:
```
# API Setup

Requirements: Node.js 18+, API key
npm install @company/api
export API_KEY=your_key
```

### README Files
- One README.md per project root
- One README.md per microservice if applicable
- Additional documentation files only with explicit permission

## Session Management

### work_in_progress.md Usage
During active work:
- Log completed milestones briefly
- Maintain current TODO list
- Note what you're currently implementing
- Update continuously as fallback if `/session-end` fails

At session end:
- Content summarized into session_notes.md
- File archived to `docs/archive/wip_YYYY-MM-DD_HH-MM-SS.md`
- Fresh empty file created

### Session Protocol
- Start: Use `/session-start` to read recent context
- End: Use `/session-end` to summarize and archive
- Check status: Use `/status` anytime

## Development Practices

### Testing
Place tests in dedicated `testing/` directory at project root or microservice level.

### Subagent Strategy
**Prefer subagent delegation for actual tasks.** Orchestrate subagents rather than implementing directly when sensible. Benefits:
- Extended context windows through multiple agents
- Longer sessions on complex projects
- Delayed need for `/compact` command

Use `/create-agents` to set up project-appropriate subagents. Primary source: https://github.com/VoltAgent/awesome-claude-code-subagents

Only create custom subagents if truly necessary. Prefer adapting existing subagents from the repo.

## Behavioral Guidelines
- Token efficiency over verbosity
- Technical precision over explanation
- Structured workflow over ad-hoc decisions
- Subagent delegation over direct implementation
- Consistent structure across all projects
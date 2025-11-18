# Create Subagents

Analyze the project and propose appropriate subagents:

1. **Read project context**:
   - `docs/vision.md` for project goals
   - `docs/architecture.md` for technical stack
   - Existing codebase structure if available

2. **Propose subagents** from https://github.com/VoltAgent/awesome-claude-code-subagents:
   - List relevant subagents
   - Explain role of each in this project
   - Note if any require customization

3. **Discuss with user**:
   - Ask for confirmation/modifications
   - Note if custom subagent needed (last resort)
   - Suggest adapted existing agent over custom when possible

4. **After approval**:
   - Deploy subagents
   - Document in `docs/subagents.md` with:
     - Agent name and source
     - Purpose in this project
     - Status (active/inactive)
     - Any customizations made

Primary source: Use agents from awesome-claude-code-subagents repo.
Fallback: Adapt existing agent to fit needs.
Last resort: Create custom subagent only if truly no alternative exists.

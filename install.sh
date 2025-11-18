#!/bin/bash

# Claude Code Project Initialization Script
# Deploys templates to parent directory and cleans up

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"  # Parent directory = actual project root

echo "=== Claude Code Project Initialization ==="
echo "Script location: $SCRIPT_DIR"
echo "Project root: $PROJECT_ROOT"
echo ""

# Verify we're in the cloned repo directory
if [ ! -d "$SCRIPT_DIR/templates" ]; then
    echo "ERROR: templates/ directory not found!"
    echo "Make sure you're running this script from the cloned my-claude-standard directory."
    exit 1
fi

# Create directory structure
echo "Creating directory structure..."
mkdir -p "$PROJECT_ROOT/.claude/commands"
mkdir -p "$PROJECT_ROOT/docs/archive"

# Deploy claude.md
echo "Deploying claude.md..."
cp "$SCRIPT_DIR/templates/claude.md" "$PROJECT_ROOT/claude.md"

# Deploy custom commands
echo "Deploying custom commands..."
cp "$SCRIPT_DIR/templates/commands/session-start.md" "$PROJECT_ROOT/.claude/commands/session-start.md"
cp "$SCRIPT_DIR/templates/commands/session-end.md" "$PROJECT_ROOT/.claude/commands/session-end.md"
cp "$SCRIPT_DIR/templates/commands/status.md" "$PROJECT_ROOT/.claude/commands/status.md"
cp "$SCRIPT_DIR/templates/commands/create-agents.md" "$PROJECT_ROOT/.claude/commands/create-agents.md"

# Deploy documentation templates
echo "Deploying documentation templates..."
cp "$SCRIPT_DIR/templates/docs/vision.md" "$PROJECT_ROOT/docs/vision.md"
cp "$SCRIPT_DIR/templates/docs/architecture.md" "$PROJECT_ROOT/docs/architecture.md"
cp "$SCRIPT_DIR/templates/docs/session_notes.md" "$PROJECT_ROOT/docs/session_notes.md"
cp "$SCRIPT_DIR/templates/docs/work_in_progress.md" "$PROJECT_ROOT/docs/work_in_progress.md"
cp "$SCRIPT_DIR/templates/docs/subagents.md" "$PROJECT_ROOT/docs/subagents.md"

# Create/update .gitignore
echo "Updating .gitignore..."
if [ ! -f "$PROJECT_ROOT/.gitignore" ]; then
    touch "$PROJECT_ROOT/.gitignore"
fi

if ! grep -q "^docs/archive/" "$PROJECT_ROOT/.gitignore" 2>/dev/null; then
    echo "docs/archive/" >> "$PROJECT_ROOT/.gitignore"
fi

# Clean up: Remove the entire cloned repository
echo "Cleaning up cloned repository..."
rm -rf "$SCRIPT_DIR"

echo ""
echo "=== Initialization Complete ==="
echo ""
echo "Created structure:"
echo "  ✓ claude.md (workflow standards)"
echo "  ✓ .claude/commands/ (session-start, session-end, status, create-agents)"
echo "  ✓ docs/ (vision, architecture, session_notes, work_in_progress, subagents)"
echo "  ✓ docs/archive/ (for archived work_in_progress files)"
echo "  ✓ .gitignore (excludes docs/archive/)"
echo ""
echo "Cleaned up:"
echo "  ✓ Cloned repository removed"
echo ""
echo "Next steps:"
echo "  1. Initialize your own git repo: git init"
echo "  2. Fill out docs/vision.md with your project goals"
echo "  3. In Claude Code, run: /create-agents"
echo "  4. Start working: /session-start"
echo ""
echo "Ready to start your project!"
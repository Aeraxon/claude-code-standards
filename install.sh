#!/bin/bash
# Claude Code Standards - Installation Script
# Repository: https://github.com/Aeraxon/claude-code-standards

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Claude Code Standards - Installation${NC}\n"

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check project mode
if [ -d ".git" ]; then
    PROJECT_MODE=true
    echo "✓ Project mode detected"
else
    PROJECT_MODE=false
fi

# Install Node.js if needed
if ! command -v node &> /dev/null || [ $(node --version | cut -d. -f1 | sed 's/v//') -lt 18 ]; then
    echo "Installing Node.js 20 LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# Install Claude Code if needed
if ! command -v claude &> /dev/null; then
    echo "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
fi

# Create directories
mkdir -p ~/.claude/commands ~/.claude/standards
if [ "$PROJECT_MODE" = true ]; then
    mkdir -p .claude/commands
fi

# Copy files
if [ -d "$SCRIPT_DIR/commands" ]; then
    cp "$SCRIPT_DIR/commands/"*.md ~/.claude/commands/
    [ "$PROJECT_MODE" = true ] && cp "$SCRIPT_DIR/commands/"*.md .claude/commands/
    echo "✓ Commands installed"
fi

if [ -d "$SCRIPT_DIR/guides" ]; then
    cp "$SCRIPT_DIR/guides/"*.md ~/.claude/standards/
    echo "✓ Guides installed"
fi

# Create settings if needed
if [ ! -f ~/.claude/settings.json ]; then
    cat > ~/.claude/settings.json <<EOF
{
  "autoCompact": false,
  "allowedTools": ["bash", "read", "write", "edit"]
}
EOF
    echo "✓ Settings configured"
fi

# Optional: GitHub CLI
if ! command -v gh &> /dev/null; then
    read -p "Install GitHub CLI? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo apt install -y gh
    fi
fi

echo -e "\n${GREEN}✓ Installation complete!${NC}\n"
echo "Next steps:"
echo "  1. Run: claude"
echo "  2. Use: /project-init"

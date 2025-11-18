#!/bin/bash
# Claude Code Installation Script
# Installs Node.js and Claude Code globally

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Claude Code Installation${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check Node.js
echo "Checking Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    NODE_MAJOR=$(echo $NODE_VERSION | cut -d. -f1 | sed 's/v//')
    
    if [ "$NODE_MAJOR" -ge 18 ]; then
        echo -e "${GREEN}✓${NC} Node.js $NODE_VERSION (OK)"
    else
        echo -e "${YELLOW}⚠${NC} Node.js $NODE_VERSION too old, installing v20..."
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt-get install -y nodejs
        echo -e "${GREEN}✓${NC} Node.js 20 installed"
    fi
else
    echo "Node.js not found, installing v20..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo -e "${GREEN}✓${NC} Node.js 20 installed"
fi

# Check Claude Code
echo ""
echo "Checking Claude Code..."
if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>&1 || echo "installed")
    echo -e "${GREEN}✓${NC} Claude Code already installed"
else
    echo "Installing Claude Code..."
    sudo npm install -g @anthropic-ai/claude-code
    echo -e "${GREEN}✓${NC} Claude Code installed"
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Installation complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Next steps:"
echo "  1. Clone this repo into your project:"
echo "     ${GREEN}git clone <repo-url> my-new-project${NC}"
echo ""
echo "  2. Initialize project:"
echo "     ${GREEN}cd my-new-project${NC}"
echo "     ${GREEN}./projekt_init.sh${NC}"
echo ""
echo "  3. Start Claude Code:"
echo "     ${GREEN}claude${NC}"
echo ""
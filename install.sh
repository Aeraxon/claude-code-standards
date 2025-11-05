#!/bin/bash
# Claude Code Standards - Installation Script
# Version: 2.1.0
# Repository: https://github.com/Aeraxon/claude-code-standards

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Get script and project directories
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"  # One folder up = project root

# Main installation
print_header "Claude Code Standards - Installation"

echo "Script location: $SCRIPT_DIR"
echo "Project root: $PROJECT_DIR"
echo ""
echo "This script will:"
echo "  • Install Claude Code globally (if not present)"
echo "  • Set up project-local commands in: $PROJECT_DIR/.claude/"
echo "  • Configure project settings"
echo ""

read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

# 1. Check and install Node.js
print_header "Step 1: Node.js"

if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    print_success "Node.js already installed: $NODE_VERSION"
    
    # Check version (needs 18+)
    NODE_MAJOR=$(echo $NODE_VERSION | cut -d. -f1 | sed 's/v//')
    if [ "$NODE_MAJOR" -lt 18 ]; then
        print_warning "Node.js version is too old (need 18+)"
        print_info "Installing Node.js 20 LTS..."
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt-get install -y nodejs
        print_success "Node.js 20 installed"
    fi
else
    print_info "Node.js not found. Installing Node.js 20 LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    print_success "Node.js installed"
fi

# 2. Check and install Claude Code
print_header "Step 2: Claude Code"

if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>&1 | grep -oP '(?<=version )[\d.]+' || echo "unknown")
    print_success "Claude Code already installed: $CLAUDE_VERSION"
else
    print_info "Installing Claude Code globally..."
    npm install -g @anthropic-ai/claude-code
    print_success "Claude Code installed"
fi

# 3. Create project-local directory structure
print_header "Step 3: Project Setup"

mkdir -p "$PROJECT_DIR/.claude/commands"
mkdir -p "$PROJECT_DIR/.claude/agents"
mkdir -p "$PROJECT_DIR/.claude/skills"
print_success "Created $PROJECT_DIR/.claude/commands/"
print_success "Created $PROJECT_DIR/.claude/agents/"
print_success "Created $PROJECT_DIR/.claude/skills/"

# 4. Copy commands to project
print_header "Step 4: Commands Installation"

if [ -d "$SCRIPT_DIR/commands" ]; then
    cp "$SCRIPT_DIR/commands/"*.md "$PROJECT_DIR/.claude/commands/"
    COMMAND_COUNT=$(ls "$SCRIPT_DIR/commands/"*.md 2>/dev/null | wc -l)
    print_success "Copied $COMMAND_COUNT commands to $PROJECT_DIR/.claude/commands/"
else
    print_error "Commands directory not found at $SCRIPT_DIR/commands"
    exit 1
fi

# 5. Create project settings
print_header "Step 5: Configuration"

if [ ! -f "$PROJECT_DIR/.claude/settings.json" ]; then
    cat > "$PROJECT_DIR/.claude/settings.json" <<EOF
{
  "autoCompact": false,
  "allowedTools": ["bash", "read", "write", "edit"]
}
EOF
    print_success "Created $PROJECT_DIR/.claude/settings.json"
else
    print_info "$PROJECT_DIR/.claude/settings.json already exists - skipping"
fi

# 6. Create reference to guides
print_header "Step 6: Guides"

if [ -d "$SCRIPT_DIR/guides" ]; then
    print_success "Guides available in: $SCRIPT_DIR/guides/"
    print_info "Claude Code will read them from the cloned repository"
else
    print_warning "Guides directory not found"
fi

# 7. Initialize git (if not already done)
print_header "Step 7: Git Setup"

if [ ! -d "$PROJECT_DIR/.git" ]; then
    read -p "Initialize git repository? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd "$PROJECT_DIR"
        git init
        print_success "Git repository initialized"
        
        # Create .gitignore if it doesn't exist
        if [ ! -f "$PROJECT_DIR/.gitignore" ]; then
            cat > "$PROJECT_DIR/.gitignore" <<EOF
# Claude Code local settings
.claude/CLAUDE.local.md

# OS
.DS_Store
Thumbs.db

# IDEs
.vscode/
.idea/
*.swp
*.swo

# Python
__pycache__/
*.py[cod]
*$py.class
.venv/
venv/
ENV/

# Node
node_modules/

# Logs
*.log
EOF
            print_success "Created .gitignore"
        fi
    fi
else
    print_success "Git repository already initialized"
fi

# 8. Optional: GitHub CLI
print_header "Step 8: GitHub CLI (Optional)"

if command -v gh &> /dev/null; then
    print_success "GitHub CLI already installed"
else
    read -p "Install GitHub CLI? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installing GitHub CLI..."
        sudo apt install -y gh
        print_success "GitHub CLI installed"
        print_info "Run 'gh auth login' to authenticate"
    else
        print_info "Skipping GitHub CLI installation"
    fi
fi

# 9. Verify installation
print_header "Step 9: Verification"

echo "Checking installation..."
echo ""

# Check Claude Code
if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>&1)
    print_success "Claude Code: $CLAUDE_VERSION"
else
    print_error "Claude Code not found in PATH"
fi

# Check project structure
if [ -d "$PROJECT_DIR/.claude/commands" ]; then
    COMMAND_COUNT=$(ls "$PROJECT_DIR/.claude/commands/"*.md 2>/dev/null | wc -l)
    print_success "Commands installed: $COMMAND_COUNT"
else
    print_error "Commands directory not created"
fi

if [ -f "$PROJECT_DIR/.claude/settings.json" ]; then
    print_success "Project settings configured"
else
    print_warning "Project settings not found"
fi

if [ -d "$SCRIPT_DIR/guides" ]; then
    GUIDE_COUNT=$(ls "$SCRIPT_DIR/guides/"*.md 2>/dev/null | wc -l)
    print_success "Guides available: $GUIDE_COUNT"
fi

# 10. Final instructions
print_header "Installation Complete! 🚀"

echo "Project structure:"
echo ""
echo "  $PROJECT_DIR/"
echo "  ├── .claude/"
echo "  │   ├── commands/        ← Your project commands"
echo "  │   ├── agents/          ← Custom subagents (add here)"
echo "  │   ├── skills/          ← Custom skills (add here)"
echo "  │   └── settings.json    ← Project settings"
echo "  └── claude-code-standards/"
echo "      ├── guides/          ← Reference guides"
echo "      └── commands/        ← Standard commands"
echo ""

echo "Next steps:"
echo ""
echo "  1. Navigate to project:"
echo "     ${GREEN}cd $PROJECT_DIR${NC}"
echo ""
echo "  2. Start Claude Code:"
echo "     ${GREEN}claude${NC}"
echo ""
echo "  3. Initialize your project:"
echo "     ${GREEN}/project-init${NC}"
echo ""

echo "Available commands:"
echo "  ${BLUE}/project-init${NC}    - Initialize project structure"
echo "  ${BLUE}/session-start${NC}   - Start work session"
echo "  ${BLUE}/session-end${NC}     - End work session"
echo "  ${BLUE}/plan <feature>${NC}  - Create implementation plan"
echo "  ${BLUE}/test <file>${NC}     - Generate tests"
echo "  ${BLUE}/review <file>${NC}   - Code review"
echo "  ${BLUE}/commit${NC}          - Smart commit"
echo ""

echo "Documentation:"
echo "  • Project Guide:      $SCRIPT_DIR/guides/CLAUDE_CODE_PROJECT_GUIDE.md"
echo "  • Subagents Guide:    $SCRIPT_DIR/guides/SKILLS_AND_SUBAGENTS_REFERENCE.md"
echo "  • Deployment Guide:   $SCRIPT_DIR/guides/DEPLOYMENT_TUTORIAL.md"
echo ""

print_success "Setup complete! Happy coding! 🎉"

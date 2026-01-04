#!/bin/bash

# gym-gate installer
# Run with: curl -fsSL <url> | bash

set -e

INSTALL_DIR="/usr/local/bin"
REPO_URL="https://raw.githubusercontent.com/yourusername/gym-gate/main"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "Installing gym-gate..."
echo ""

# Check if we can write to /usr/local/bin
if [ -w "$INSTALL_DIR" ]; then
    TARGET="$INSTALL_DIR/gym-gate"
else
    # Fall back to user's local bin
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
    TARGET="$INSTALL_DIR/gym-gate"
    
    # Add to PATH if not already there
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        echo ""
        echo -e "${BLUE}Adding $INSTALL_DIR to PATH...${NC}"
        
        # Detect shell and add to appropriate config
        if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
            echo "Added to ~/.zshrc"
        elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
            echo "Added to ~/.bashrc"
        fi
    fi
fi

# If gym-gate script is in current directory (local install)
if [ -f "./gym-gate" ]; then
    cp ./gym-gate "$TARGET"
else
    # Download from repo (for remote install)
    curl -fsSL "$REPO_URL/gym-gate" -o "$TARGET" 2>/dev/null || {
        echo "Could not download gym-gate. Please install manually."
        exit 1
    }
fi

chmod +x "$TARGET"

echo -e "${GREEN}✅ gym-gate installed to $TARGET${NC}"
echo ""
echo "Next steps:"
echo "  1. Run: gym-gate install"
echo "  2. Log workouts: gym-gate log \"your workout\""
echo ""

# If PATH was modified, remind user
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${BLUE}Note: Restart your terminal or run: source ~/.zshrc${NC}"
    echo ""
fi

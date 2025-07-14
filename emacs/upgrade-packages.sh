#!/usr/bin/env bash

# Simple Emacs Package Upgrade Script
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 Updating Emacs packages...${NC}"

# Find straight.el repos directory
REPOS_DIR="$HOME/.cache/emacs/straight/straight/repos"
if [[ ! -d "$REPOS_DIR" ]]; then
    echo "Error: Could not find straight.el repos directory at $REPOS_DIR"
    exit 1
fi

echo -e "${BLUE}📦 Found $(ls -1 "$REPOS_DIR" | wc -l) repositories${NC}"

# Store git status before update
UPDATED_REPOS=()
cd "$REPOS_DIR"

for repo in */; do
    if [[ -d "$repo/.git" ]]; then
        cd "$repo"
        
        # Get current commit hash
        OLD_HASH=$(git rev-parse HEAD 2>/dev/null || echo "")
        
        # Pull latest changes
        if git pull --ff-only origin HEAD > /dev/null 2>&1; then
            NEW_HASH=$(git rev-parse HEAD 2>/dev/null || echo "")
            
            # Check if anything changed
            if [[ "$OLD_HASH" != "$NEW_HASH" && -n "$OLD_HASH" && -n "$NEW_HASH" ]]; then
                UPDATED_REPOS+=("${repo%/}")
                echo -e "${GREEN}✓ Updated: ${repo%/} (${OLD_HASH:0:8}...${NEW_HASH:0:8})${NC}"
            fi
        fi
        
        cd ..
    fi
done

echo
if [[ ${#UPDATED_REPOS[@]} -gt 0 ]]; then
    echo -e "${GREEN}🎉 Updated ${#UPDATED_REPOS[@]} repositories:${NC}"
    for repo in "${UPDATED_REPOS[@]}"; do
        echo -e "  - $repo"
    done
else
    echo -e "${YELLOW}📋 All repositories are up to date${NC}"
fi

echo -e "${BLUE}📝 Restart Emacs to use updated packages${NC}"
#!/usr/bin/env bash

# Emacs Package Upgrade Script for straight.el
# Similar to doom upgrade but for vanilla Emacs

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script options
SKIP_CONFIRM=false
CREATE_BACKUP=false

print_help() {
  cat <<EOF
Emacs Package Upgrade Script

USAGE:
    $(basename "$0") [OPTIONS]

OPTIONS:
    -y, --yes       Skip confirmation prompt
    -b, --backup    Create backup before upgrading
    -h, --help      Show this help message

DESCRIPTION:
    This script upgrades all packages managed by straight.el in your Emacs
    configuration. It performs the following actions:

    1. Pulls all package repositories
    2. Rebuilds packages that need rebuilding
    3. Cleans up old build cache

EXAMPLES:
    $(basename "$0")                    # Interactive upgrade
    $(basename "$0") --yes              # Skip confirmation
    $(basename "$0") --backup --yes     # Create backup and upgrade
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -y | --yes)
      SKIP_CONFIRM=true
      shift
      ;;
    -b | --backup)
      CREATE_BACKUP=true
      shift
      ;;
    -h | --help)
      print_help
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      print_help
      exit 1
      ;;
  esac
done

# Find Emacs config directory
find_emacs_config() {
  local config_dir=""

  # Check EMACS_CONFIG_DIR environment variable first
  if [[ -n "$EMACS_CONFIG_DIR" && -d "$EMACS_CONFIG_DIR" ]]; then
    config_dir="$EMACS_CONFIG_DIR"
  # Check ~/.emacs.d
  elif [[ -d "$HOME/.emacs.d" ]]; then
    config_dir="$HOME/.emacs.d"
  # Check ~/.config/emacs
  elif [[ -d "$HOME/.config/emacs" ]]; then
    config_dir="$HOME/.config/emacs"
  fi

  echo "$config_dir"
}

# Find straight.el directory (now in XDG cache)
find_straight_dir() {
  local straight_dir=""

  # Check XDG_CACHE_HOME first
  if [[ -n "$XDG_CACHE_HOME" && -d "$XDG_CACHE_HOME/emacs/straight" ]]; then
    straight_dir="$XDG_CACHE_HOME/emacs/straight"
  # Check default cache location
  elif [[ -d "$HOME/.cache/emacs/straight" ]]; then
    straight_dir="$HOME/.cache/emacs/straight"
  # Fallback to old location in config directory
  elif [[ -n "$1" && -d "$1/straight" ]]; then
    straight_dir="$1/straight"
  fi

  echo "$straight_dir"
}

# Main script
main() {
  echo -e "${BLUE}🚀 Emacs Package Upgrade Script${NC}"
  echo -e "${BLUE}================================${NC}"

  # Find config directory
  EMACS_CONFIG=$(find_emacs_config)
  if [[ -z "$EMACS_CONFIG" ]]; then
    echo -e "${RED}❌ Could not find Emacs configuration directory${NC}"
    echo "Checked: \$EMACS_CONFIG_DIR, ~/.emacs.d, ~/.config/emacs"
    exit 1
  fi

  echo -e "${BLUE}📁 Using config directory: $EMACS_CONFIG${NC}"

  # Find straight.el directory
  STRAIGHT_DIR=$(find_straight_dir "$EMACS_CONFIG")
  if [[ -z "$STRAIGHT_DIR" ]]; then
    echo -e "${RED}❌ straight.el not found.${NC}"
    echo "Checked: \$XDG_CACHE_HOME/emacs/straight, ~/.cache/emacs/straight, $EMACS_CONFIG/straight"
    exit 1
  fi

  echo -e "${BLUE}📦 Using straight.el directory: $STRAIGHT_DIR${NC}"

  # Ask for confirmation unless --yes flag is provided
  if [[ "$SKIP_CONFIRM" != true ]]; then
    echo
    echo -e "${YELLOW}🔄 This will update all packages managed by straight.el. Continue? (y/N):${NC} "
    read -r response
    if [[ ! "$response" =~ ^[Yy]([Ee][Ss])?$ ]]; then
      echo -e "${RED}❌ Upgrade cancelled.${NC}"
      exit 0
    fi
  fi

  # Create backup if requested
  if [[ "$CREATE_BACKUP" == true ]]; then
    echo -e "${YELLOW}💾 Creating backup...${NC}"
    backup_dir="$EMACS_CONFIG/straight_backup_$(date +%Y%m%d_%H%M%S)"
    if cp -r "$STRAIGHT_DIR" "$backup_dir"; then
      echo -e "${GREEN}✅ Backup created: $backup_dir${NC}"
    else
      echo -e "${YELLOW}⚠️  Warning: Could not create backup${NC}"
    fi
  fi

  echo
  echo -e "${BLUE}🔧 Starting package upgrade...${NC}"

  # Create temporary upgrade script
  temp_script=$(mktemp)
  cat >"$temp_script" <<EOF
;;; -*- lexical-binding: t; -*-
;; Set up XDG directories (from early-init.el)
(defvar user-cache-directory
  (expand-file-name "emacs/" (or (getenv "XDG_CACHE_HOME") "~/.cache"))
  "Directory for cache files.")

(defvar user-data-directory  
  (expand-file-name "emacs/" (or (getenv "XDG_DATA_HOME") "~/.local/share"))
  "Directory for data files.")

(defvar user-state-directory
  (expand-file-name "emacs/" (or (getenv "XDG_STATE_HOME") "~/.local/state"))
  "Directory for state files.")

;; Set straight-base-dir to XDG cache location
(setq straight-base-dir "$STRAIGHT_DIR")
(require 'straight)

(defun upgrade-all-packages ()
  "Upgrade all packages managed by straight.el"
  (interactive)
  (message "Starting package upgrade...")
  
  (let ((updated-packages '())
        (rebuilt-packages '())
        (pull-count 0)
        (rebuild-count 0))
    
    ;; Override straight-pull-package to track updates
    (let ((original-pull-fn (symbol-function 'straight-pull-package)))
      (cl-letf (((symbol-function 'straight-pull-package)
                 (lambda (package &optional from-upstream)
                   (message "Pulling %s..." package)
                   (let ((result (funcall original-pull-fn package from-upstream)))
                     (when result
                       (push package updated-packages)
                       (message "✓ Updated %s" package))
                     (setq pull-count (1+ pull-count))
                     result))))
        
        ;; Pull all repositories
        (message "Pulling all repositories...")
        (condition-case err
            (straight-pull-all)
          (error
           (message "Error during pull: %s" (error-message-string err))))))
    
    ;; Override straight-rebuild-package to track rebuilds
    (let ((original-rebuild-fn (symbol-function 'straight-rebuild-package)))
      (cl-letf (((symbol-function 'straight-rebuild-package)
                 (lambda (package)
                   (message "Rebuilding %s..." package)
                   (let ((result (funcall original-rebuild-fn package)))
                     (push package rebuilt-packages)
                     (message "✓ Rebuilt %s" package)
                     (setq rebuild-count (1+ rebuild-count))
                     result))))
        
        ;; Rebuild packages that need it
        (message "Rebuilding packages...")
        (condition-case err
            (straight-rebuild-all)
          (error
           (message "Error during rebuild: %s" (error-message-string err))))))
    
    ;; Clean up old builds
    (message "Cleaning up...")
    (condition-case err
        (straight-prune-build-cache)
      (error
       (message "Error during cleanup: %s" (error-message-string err))))
    
    ;; Report results
    (message "")
    (message "=== UPGRADE SUMMARY ===")
    (message "Processed %d packages for updates" pull-count)
    
    (if updated-packages
        (progn
          (message "Updated packages (%d):" (length updated-packages))
          (dolist (pkg (reverse updated-packages))
            (message "  - %s" pkg)))
      (message "No packages were updated (all up to date)"))
    
    (message "")
    (if rebuilt-packages
        (progn
          (message "Rebuilt packages (%d):" (length rebuilt-packages))
          (dolist (pkg (reverse rebuilt-packages))
            (message "  - %s" pkg)))
      (message "No packages needed rebuilding"))
    
    (message "")
    (message "Package upgrade completed!")))

;; Run the upgrade
(condition-case err
    (progn
      (upgrade-all-packages)
      (message "SUCCESS: All packages processed")
      (kill-emacs 0))
  (error
   (message "ERROR: %s" (error-message-string err))
   (kill-emacs 1)))
EOF

  # Run Emacs with the upgrade script
  echo -e "${BLUE}🔄 Running Emacs upgrade process...${NC}"

  if emacs --batch --load "$EMACS_CONFIG/early-init.el" --load "$EMACS_CONFIG/init.el" --load "$temp_script"; then
    echo
    echo -e "${GREEN}✅ Package upgrade completed successfully!${NC}"
    echo -e "${GREEN}📝 Restart Emacs to ensure all changes take effect.${NC}"
  else
    echo
    echo -e "${RED}❌ Upgrade failed. Check the output above for errors.${NC}"
    exit 1
  fi

  # Clean up
  rm -f "$temp_script"
}

# Run main function
main "$@"

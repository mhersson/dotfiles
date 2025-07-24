;;; keybindings.el --- Keybinding configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Key binding setup with which-key and space leader key configuration.

;;; Code:

;; Leader key setup
(evil-set-leader 'normal (kbd "SPC"))
(evil-set-leader 'visual (kbd "SPC"))
(evil-set-leader 'motion (kbd "SPC"))

;; Comment/uncomment
(evil-define-key 'normal 'global "gc" 'comment-line)
(evil-define-key 'visual 'global "gc" 'comment-dwim)

;; Global keybinding for vterm toggle
(global-set-key (kbd "C-/") 'my/toggle-vterm)

;; Which-key configuration
(use-package which-key
  :config
  (which-key-mode 1)
  (which-key-setup-side-window-bottom)
  (setq which-key-min-display-lines 3
        which-key-add-column-padding 6))

;;; Which-key group names
(which-key-add-key-based-replacements
  "SPC a" "ai"
  "SPC b" "buffer"
  "SPC c" "code"
  "SPC d" "debug"
  "SPC f" "file"
  "SPC g" "git"
  "SPC p" "project"
  "SPC s" "search"
  "SPC t" "toggle"
  "SPC w" "window")

;;; Global keybindings
(which-key-add-key-based-replacements
  "SPC :" "M-x"
  "SPC ," "project buffer"
  "SPC SPC" "find file"
  "SPC /" "search project")

(evil-define-key 'normal 'global
  (kbd "<leader>:") 'execute-extended-command
  (kbd "<leader>,") 'consult-buffer
  (kbd "<leader><SPC>") 'projectile-find-file
  (kbd "<leader>/") 'consult-ripgrep)

;;; File operations
(which-key-add-key-based-replacements
  "SPC f f" "find file"
  "SPC f p" "browse config")

(evil-define-key 'normal 'global
  (kbd "<leader>ff") 'find-file
  (kbd "<leader>fp") (lambda () (interactive)
                       (let ((default-directory user-emacs-directory))
                         (call-interactively #'projectile-find-file))))

;;; Buffer operations
(which-key-add-key-based-replacements
  "SPC b b" "all buffers"
  "SPC b k" "kill buffer"
  "SPC b K" "kill buffer and window"
  "SPC b p" "project buffer"
  "SPC b o" "kill others")

(evil-define-key 'normal 'global
  (kbd "<leader>bb") 'consult-buffer
  (kbd "<leader>bk") 'kill-current-buffer
  (kbd "<leader>bK") 'kill-buffer-and-window
  (kbd "<leader>bo") 'my/kill-other-buffers
  (kbd "<leader>bp") 'projectile-switch-to-buffer)

;;; Code operations
(which-key-add-key-based-replacements
  "SPC c a" "code actions"
  "SPC c r" "rename"
  "SPC c x" "list errors")

(evil-define-key 'normal 'global
  (kbd "<leader>ca") 'eglot-code-actions
  (kbd "<leader>cr") 'eglot-rename
  (kbd "<leader>cx") 'flycheck-list-errors)

;;; Git operations
(which-key-add-key-based-replacements
  "SPC g g" "git status")

(evil-define-key 'normal 'global
  (kbd "<leader>gg") 'magit-status)

;;; Project operations
(which-key-add-key-based-replacements
  "SPC p p" "switch project"
  "SPC p f" "find file in project"
  "SPC p k" "kill project buffers"
  "SPC p r" "recent project files"
  "SPC p d" "remove known project"
  "SPC p a" "add known project"
  "SPC p i" "invalidate cache"
  "SPC p I" "project info")

(evil-define-key 'normal 'global
  (kbd "<leader>pp") 'projectile-switch-project
  (kbd "<leader>pf") 'projectile-find-file
  (kbd "<leader>pk") 'projectile-kill-buffers
  (kbd "<leader>pr") 'projectile-recentf
  (kbd "<leader>pd") 'projectile-remove-known-project
  (kbd "<leader>pa") 'projectile-add-known-project
  (kbd "<leader>pi") 'projectile-invalidate-cache
  (kbd "<leader>pI") 'projectile-project-info)

;;; Search operations
(which-key-add-key-based-replacements
  "SPC s s" "symbols/outline"
  "SPC s p" "search project"
  "SPC s f" "find files"
  "SPC s r" "search & replace")

(evil-define-key 'normal 'global
  (kbd "<leader>ss") 'consult-imenu
  (kbd "<leader>sp") 'consult-ripgrep
  (kbd "<leader>sf") 'consult-fd
  (kbd "<leader>sr") 'query-replace)

;;; Toggle operations
(which-key-add-key-based-replacements
  "SPC t c" "toggle copilot"
  "SPC t t" "toggle treemacs"
  "SPC t v" "toggle vterm")

(evil-define-key 'normal 'global
  (kbd "<leader>tc") 'copilot-mode
  (kbd "<leader>tt") 'treemacs
  (kbd "<leader>tv") 'my/toggle-vterm)

;;; Window operations
(evil-define-key 'normal 'global
  (kbd "<leader>wh") 'evil-window-left
  (kbd "<leader>wj") 'evil-window-down
  (kbd "<leader>wk") 'evil-window-up
  (kbd "<leader>wl") 'evil-window-right
  (kbd "<leader>ws") 'evil-window-split
  (kbd "<leader>wv") 'evil-window-vsplit
  (kbd "<leader>wd") 'evil-window-delete)

;;; Debug operations
(which-key-add-key-based-replacements
  "SPC d d" "debug"
  "SPC d b" "toggle breakpoint"
  "SPC d c" "continue"
  "SPC d n" "next"
  "SPC d s" "step into"
  "SPC d o" "step out"
  "SPC d r" "restart"
  "SPC d q" "quit debug")

(evil-define-key 'normal 'global
  (kbd "<leader>dd") 'dape
  (kbd "<leader>db") 'dape-breakpoint-toggle
  (kbd "<leader>dc") 'dape-continue
  (kbd "<leader>dn") 'dape-next
  (kbd "<leader>ds") 'dape-step-in
  (kbd "<leader>do") 'dape-step-out
  (kbd "<leader>dr") 'dape-restart
  (kbd "<leader>dq") 'dape-quit)

;;; AI operations
;; Copilot Chat
(which-key-add-key-based-replacements
  "SPC a s" "chat"
  "SPC a e" "explain"
  "SPC a r" "review"
  "SPC a f" "fix"
  "SPC a o" "optimize"
  "SPC a t" "test"
  "SPC a d" "doc"
  "SPC a g" "commit message")

(evil-define-key 'normal 'global
  (kbd "<leader>as") 'copilot-chat-display
  (kbd "<leader>ae") 'copilot-chat-explain
  (kbd "<leader>ar") 'copilot-chat-review
  (kbd "<leader>af") 'copilot-chat-fix
  (kbd "<leader>ao") 'copilot-chat-optimize
  (kbd "<leader>at") 'copilot-chat-test
  (kbd "<leader>ad") 'copilot-chat-doc
  (kbd "<leader>ag") 'copilot-chat-insert-commit-message)

;; Claude Code
(which-key-add-key-based-replacements
  "SPC a c" "claude code"
  "SPC a c c" "start session"
  "SPC a c d" "start in directory"
  "SPC a c r" "send region"
  "SPC a c f" "send file"
  "SPC a c t" "toggle window"
  "SPC a c C" "continue"
  "SPC a c R" "resume session"
  "SPC a c k" "kill session"
  "SPC a c b" "switch to buffer"
  "SPC a c e" "fix error"
  "SPC a c m" "menu")

(evil-define-key 'normal 'global
  (kbd "<leader>acc") 'claude-code
  (kbd "<leader>acd") 'claude-code-start-in-directory
  (kbd "<leader>acr") 'claude-code-send-region
  (kbd "<leader>acf") 'claude-code-send-buffer-file
  (kbd "<leader>act") 'claude-code-toggle
  (kbd "<leader>acC") 'claude-code-continue
  (kbd "<leader>acR") 'claude-code-resume
  (kbd "<leader>ack") 'claude-code-kill
  (kbd "<leader>acb") 'claude-code-switch-to-buffer
  (kbd "<leader>ace") 'claude-code-fix-error-at-point
  (kbd "<leader>acm") 'claude-code-transient)

(provide 'keybindings)
;;; keybindings.el ends here

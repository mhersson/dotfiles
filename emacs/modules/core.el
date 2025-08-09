;;; core.el --- Core Emacs settings -*- lexical-binding: t -*-

;;; Commentary:

;; Core Emacs configuration including basic settings, theme, evil mode,
;; git integration, and editor enhancements.

;;; Code:

;; Disable backup and autosave files
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Configure package data directories to use XDG
(setq custom-file (expand-file-name "custom.el" user-data-directory))
(setq recentf-save-file (expand-file-name "recentf" user-data-directory))
(setq savehist-file (expand-file-name "history" user-data-directory))
(setq save-place-file (expand-file-name "places" user-data-directory))
(setq bookmark-default-file (expand-file-name "bookmarks" user-data-directory))

;; Transient files
(setq transient-levels-file (expand-file-name "transient/levels.el" user-data-directory))
(setq transient-values-file (expand-file-name "transient/values.el" user-data-directory))
(setq transient-history-file (expand-file-name "transient/history.el" user-data-directory))

;; Other package data files
(setq treemacs-persist-file (expand-file-name "treemacs-persist" user-data-directory))

;; Disable warning bell
(setq ring-bell-function 'ignore)

;; Answer questions with y/n and not yes/no
(setq use-short-answers t)

;; Always middle click paste at cursors position
(setq mouse-yank-at-point t)

;; Auto-refresh buffers when files change on disk
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ;; Configure cursor types for different modes
  (setq evil-normal-state-cursor '(box "#ff9500")
        evil-insert-state-cursor '(bar "#ff9500")
        evil-visual-state-cursor '(box "#ff9500")
        evil-replace-state-cursor '(hollow "#ff9500")
        evil-operator-state-cursor '(hollow "#ff9500")
        evil-motion-state-cursor '(box "#ff9500")
        evil-emacs-state-cursor '(bar "#ff9500")))

(use-package evil-terminal-cursor-changer
  :if (not (display-graphic-p))
  :after evil
  :config
  (evil-terminal-cursor-changer-activate))


;; Use escape to escape from everything
(use-package evil-escape
  :ensure
  :after evil
  :config
  (evil-escape-mode 1)
  ;; Make ESC quit everything
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

;; Evil keybindings for various packages
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Flycheck configuration
(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (setq flycheck-display-errors-delay 0.3
        flycheck-indication-mode 'right-fringe) ; Show indicators in fringe for all modes

  ;; Configure flycheck error list window size to show 10-15 errors
  (add-to-list 'display-buffer-alist
               `("\\*Flycheck errors\\*"
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . bottom)
                 (window-height . 25))))

;; Function to close flycheck error list from anywhere
(defun close-flycheck-error-list ()
  "Close flycheck error list window if it exists."
  (interactive)
  (let ((flycheck-window (get-buffer-window "*Flycheck errors*")))
    (when flycheck-window
      (delete-window flycheck-window))))

;; Make ESC close flycheck error list from anywhere
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "<escape>")
              'close-flycheck-error-list))

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  ;;:custom (flycheck-eglot-exclusive nil)
  :config
  (global-flycheck-eglot-mode 1))

;; Magit for Git integration
(use-package magit
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  ;; Add window operation keybindings for magit
  (evil-define-key 'normal magit-mode-map
    (kbd "SPC wh") 'evil-window-left
    (kbd "SPC wj") 'evil-window-down
    (kbd "SPC wk") 'evil-window-up
    (kbd "SPC wl") 'evil-window-right))

;; EditorConfig support
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;; Projectile for project management
(use-package projectile
  :config
  (projectile-mode +1)
  ;; Set completion system to use with projectile
  (setq projectile-completion-system 'default)
  ;; Enable caching for better performance
  (setq projectile-enable-caching nil)
  ;; Set indexing method
  (setq projectile-indexing-method 'alien)
  ;; Use ripgrep for searching when available
  (when (executable-find "rg")
    (setq projectile-generic-command "rg --files --color=never --hidden"))
  ;; Cache project files on first access
  (setq projectile-cache-file (expand-file-name "projectile.cache" user-cache-directory))
  ;; Known projects file
  (setq projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" user-data-directory)))


;; Direnv support
(use-package direnv
  :config
  (direnv-mode)
  ;; Enable direnv for all programming modes
  (add-hook 'prog-mode-hook #'direnv-update-environment))

;; Line numbers in programming modes, markdown and yaml
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'markdown-mode-hook 'display-line-numbers-mode)
(add-hook 'yaml-ts-mode-hook 'display-line-numbers-mode)

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(provide 'core)
;;; core.el ends here

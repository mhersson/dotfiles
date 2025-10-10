;;; ui.el --- User interface and visual customizations -*- lexical-binding: t -*-

;;; Commentary:
;; This module contains configuration for the user interface, including
;; modeline, themes, fonts, and other visual customizations.

;;; Code:

;; Catppuccin theme
(use-package catppuccin-theme
  :custom
  (catppuccin-cursor 'macchiato) ; 'mocha or 'latte, 'frappe, 'macchiato
  :config
  (load-theme 'catppuccin :no-confirm))

(catppuccin-set-color 'base "#222436")
(catppuccin-reload)

;; Doom themes
;; (use-package doom-themes
;;   :config
;;   (setq doom-themes-enable-bold t
;;         doom-themes-enable-italic t)
;;   (load-theme 'doom-moonlight :no-confirm))

;; Gruvbox theme
;; (use-package gruvbox-theme
;;   :config
;;   (load-theme 'gruvbox-light-hard :no-confirm))

;; Set font
(set-face-attribute 'default nil
                    :family "RobotoMono Nerd Font"
                    :height 140) ; 14pt = 140 (height is in 1/10th points)

;; Doom Modeline Configuration
(use-package doom-modeline
  :custom
  (doom-modeline-height 25)
  (doom-modeline-bar-width 3)
  (doom-modeline-buffer-file-name-style 'relative-from-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-buffer-state-icon t)
  (doom-modeline-buffer-modification-icon t)
  (doom-modeline-minor-modes nil)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-buffer-encoding t)
  (doom-modeline-indent-info nil)
  (doom-modeline-checker-simple-format nil)
  (doom-modeline-vcs-max-length 12)
  (doom-modeline-persp-name nil)
  (doom-modeline-lsp t)
  (doom-modeline-github nil)
  (doom-modeline-mu4e nil)
  (doom-modeline-irc nil)
  (doom-modeline-time nil)
  (doom-modeline-env-version t)
  (doom-modeline-checker t)
  :config
  (doom-modeline-mode 1))

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t
  :config
  (evil-define-key 'treemacs treemacs-mode-map
    (kbd "SPC tt") 'treemacs
    (kbd "SPC wh") 'evil-window-left
    (kbd "SPC wj") 'evil-window-down
    (kbd "SPC wk") 'evil-window-up
    (kbd "SPC wl") 'evil-window-right))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t
  :config
  ;; Try the built-in mode again with a simpler approach
  (treemacs-project-follow-mode 1))

(use-package treemacs-nerd-icons
  :config
  (treemacs-load-theme "nerd-icons"))

(provide 'ui)
;;; ui.el ends here

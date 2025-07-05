;;; init.el --- Emacs configuration -*- lexical-binding: t -*-

;; Author: Morten
;; Package-Requires: ((emacs "31.x"))

;;; Commentary:

;; Fast and minimal Emacs configuration with:
;; - Evil mode for vi keybindings
;; - Tree-sitter for modern syntax highlighting
;; - Eglot for LSP support
;; - Apheleia - for code formatting
;; - Corfu for completion
;; - Magit for Git integration
;; - Flycheck for syntax checking
;; - Space leader key setup

;;; Code:

;; Configure straight.el directories before loading
(setq straight-base-dir (expand-file-name "straight/" user-cache-directory))

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" straight-base-dir))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file))

;; Use-package with straight.el
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Add modules directory to load path
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/lang" user-emacs-directory))

;; Load configuration modules
(require 'core)
(require 'ui)
(require 'treesitter)
(require 'completion)
(require 'formatter)
(require 'lsp)
(require 'testing)
(require 'debug)
(require 'terminal)
(require 'keybindings)
(require 'ai)

;; Load language configuration
(require 'go)
(require 'markdown)

(provide 'init)
;;; init.el ends here

;;; debug.el --- Debug configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Debug configuration using dape (Debug Adapter Protocol for Emacs).
;; Provides debugging support for multiple languages.

;;; Code:

;; Dape - Debug Adapter Protocol for Emacs
(use-package dape
  :config
  ;; Info buffers to the right
  (setq dape-buffer-window-arrangement 'right)
  ;; (setq dape-buffer-window-arrangement 'gud)
  ;; (setq dape-info-hide-mode-line nil)

  ;; Showing inlay hints
  (setq dape-inlay-hints t)

  ;; Disable default key prefix to avoid conflicts with evil/which-key
  (setq dape-key-prefix nil)

  (setq dape-cwd-function 'projectile-project-root)

  (add-to-list 'dape-configs
               `(devspace
                 command "dlv"
                 command-args ("connect" "127.0.0.1:2345")
                 modes (go-mode go-ts-mode)
                 host "127.0.0.1"
                 port 2345
                 prefix-local ,(lambda () default-directory)
                 prefix-remote "/workspace/"
                 :name "Debug remote in devspace pod"
                 :request "attach"
                 :mode "remote"
                 :type "go"
                 ))
  )


(provide 'debug)
;;; debug.el ends here

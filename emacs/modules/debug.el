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

  (add-to-list 'dape-configs
               `(devspace
                 modes (go-mode go-ts-mode)
                 command "dlv"
                 command-args ("connect" "127.0.0.1:2345")
                 command-cwd default-directory
                 host "127.0.0.1"
                 port 2345
                 :name "Debug remote in devspace pod"
                 :request "attach"
                 :mode "remote"
                 :type "go"
                 ))

  ;; (add-to-list dape-configs
  ;;              '(
  ;;                (go-test
  ;;                 modes (go-mode go-ts-mode)
  ;;                 command "dlv"
  ;;                 command-args ("dap" "--listen" "127.0.0.1:autoport")
  ;;                 command-cwd default-directory
  ;;                 host "127.0.0.1"
  ;;                 port autoport
  ;;                 :name "Run the go tests in cwd"
  ;;                 :request "launch"
  ;;                 :mode "test"
  ;;                 :type "go"
  ;;                 :program "."
  ;;                 )))
  )

(provide 'debug)
;;; debug.el ends here

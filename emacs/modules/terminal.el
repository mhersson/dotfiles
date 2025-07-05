;;; terminal.el --- Terminal and shell configuration -*- lexical-binding: t -*-

;;; Commentary:
;; This module contains configuration for terminal emulators and shell
;; integration, including vterm, shell settings, and terminal utilities.

;;; Code:

;; Vterm - Terminal emulator
(use-package vterm
  :defer t
  :custom
  (vterm-max-scrollback 5000)
  (vterm-buffer-name-string "*vterm %s*")
  (vterm-install-buffer-name "*vterm-install*")
  :config
  ;; Auto-compile vterm module without prompting
  (when (and (fboundp 'vterm-module-compile)
             (not (featurep 'vterm-module)))
    (vterm-module-compile))

  ;; Configure vterm to open in bottom window like flycheck
  (add-to-list 'display-buffer-alist
               `("\\*vterm.*\\*"
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . bottom)
                 (window-height . 20))))


(provide 'terminal)
;;; terminal.el ends here

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Morten Hersson"
      user-mail-address "mher@stibodx.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Source Code Pro" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;;(load-theme 'gruvbox-dark-medium t)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org-files")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Always middle click paste at cursors position
(setq mouse-yank-at-point t)

;; Set cursor colors on mode change
(unless (display-graphic-p)
  (evil-terminal-cursor-changer-activate))

(when (display-graphic-p)
(setq evil-emacs-state-cursor '("red" box)
    evil-normal-state-cursor '("green" box)
    evil-visual-state-cursor '("orange" box)
    evil-insert-state-cursor '("red" bar)
    evil-replace-state-cursor '("red" bar)
    evil-operator-state-cursor '("red" hollow)))

(defun normal-mode-and-save ()
  "Enter 'evil-normal-state and 'evil-write in sequence."
  (interactive)
  (evil-normal-state)
  (evil-write nil nil))

;; Save buffers with Ctrl+S
(global-set-key (kbd "C-s") 'normal-mode-and-save)
(global-set-key (kbd "C-q") 'evil-quit)

;; Set shell indent to 2 spaces
(add-hook! sh-mode
  (setq sh-basic-offset 2)
  (setq tab-width 2))

;; Set up flycheck checkers combined with lsp
;; https://github.com/hlissner/doom-emacs/issues/1530#issuecomment-725588733
(add-hook! 'lsp-after-initialize-hook
  (run-hooks (intern (format "%s-lsp-hook" major-mode))))

(defun sh-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'sh-shellcheck))
(add-hook 'sh-mode-lsp-hook #'sh-flycheck-setup)

(defun python-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'python-pylint))
(add-hook 'python-mode-lsp-hook #'python-flycheck-setup)

(defun go-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'golangci-lint)
  (setq flycheck-golangci-lint-enable-all t)
  (setq flycheck-golangci-lint-disable-linters
     '("gochecknoinits" "gochecknoglobals" "gomnd" "gofumpt" "gci" "exhaustivestruct")))
(add-hook 'go-mode-lsp-hook #'go-flycheck-setup)

;; Disable the golang lsp formatter - it does not clean up imports
;; https://github.com/hlissner/doom-emacs/tree/develop/modules/editor/format#disabling-the-lsp-formatter
(setq-hook! 'go-mode-hook +format-with-lsp nil)

(add-hook! go-mode
  (setq gofmt-command "goreturns")
  (setq lsp-gopls-complete-unimported t))

;; Insert CLOSED property when a TODO item is marked as DONE
(setq org-log-done 'time)

;; Populates the EXPORT_FILE_NAME property in the inserted headline.
(after! org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
      "Returns `org-capture' template string for new Hugo post.
  See `org-capture-templates' for more information."
      (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
            (fname (org-hugo-slug title)))
        (mapconcat #'identity
                  `(
                    ,(concat "* TODO " title)
                    ":PROPERTIES:"
                    ,(concat ":EXPORT_FILE_NAME: " fname)
                    ":END:"
                    "%?\n")          ;Place the cursor here finally
                  "\n")))

  (add-to-list 'org-capture-templates
                '("h"                ;`org-capture' binding + h
                  "Hugo post"
                  entry
                  (file+olp buffer-file-name "Posts")
                  (function org-hugo-new-subtree-post-capture-template))))

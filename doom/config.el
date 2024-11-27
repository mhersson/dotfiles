;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(defun autobots-rules-greater ()
  (let* ((banner '(
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠠⣤⣤⣤⣤⣄⣀⣀⣀⣀⠀⠀⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⠀⠀⢀⣀⣀⣀⣀⣤⣤⣤⣤⠄"
                   "⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀"
                   "⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠸⣿⣿⣿⣿⣿⣿⣿⣯⣍⡉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⢉⣩⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀"
                   "⠀⠈⣿⣿⣿⣿⠻⢿⣿⣿⣿⡀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⢀⣼⣿⣿⣿⠟⢻⣿⣿⣿⠁⠀"
                   "⠀⠀⢹⣿⣿⣿⣄⡀⠉⠻⣿⣿⣷⣤⣀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⣀⣤⣾⣿⣿⠟⠋⢀⣠⣿⣿⣿⡏⠀⠀"
                   "⠀⠀⠘⣿⣿⣿⣿⣿⣶⣄⡀⠉⠻⣿⣿⣷⣦⣄⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⣠⣴⣾⣿⣿⠟⠋⢀⣠⣶⣿⣿⣿⣿⣿⠃⠀⠀"
                   "⠀⠀⠀⢻⣿⣿⣧⠈⠛⢿⣿⣶⣄⡀⠙⠻⣿⣿⣿⣶⣄⡈⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⢀⣠⣴⣿⣿⣿⠟⠋⠀⣠⣶⣿⡿⠛⠁⣸⣿⣿⡟⠀⠀⠀"
                   "⠀⠀⠀⠸⣿⣿⣿⣷⣦⣀⠈⠛⢿⣿⣶⣄⡀⠙⣿⣿⣿⣷⠀⠀⡈⠙⠿⣿⣿⣿⣿⠿⠋⢀⠀⠀⣾⣿⣿⣿⠋⠀⣠⣶⣿⡿⠛⠁⢀⣤⣾⣿⣿⣿⠃⠀⠀⠀"
                   "⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣷⣦⣀⠈⠛⢿⣿⣶⣼⣿⣿⣿⡀⠀⢹⣶⣄⠈⠙⠋⠁⣠⣴⡿⠀⢀⣿⣿⣿⣿⣴⣿⡿⠟⠉⢀⣤⣾⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣷⣦⣀⠈⠛⢿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣦⣴⣿⣿⣿⡇⠀⢸⣿⣿⣿⡿⠛⠉⢀⣤⣾⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⡀⠈⠙⢿⣿⣿⣿⣿⣿⣿⣷⣦⡀⣿⣿⣿⣷⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⣾⣿⣿⣿⢀⣤⣾⣿⣿⣿⣿⣿⣿⡿⠛⠁⢀⡀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⣿⣷⣤⡀⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⣿⣿⣿⣿⣿⣿⣿⣿⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠉⢀⣠⣶⣿⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣶⠀⠀⠀⠈⠉⠉⠛⠛⠛⠿⠿⢿⡇⠀⢹⣿⣿⣿⣿⣿⣿⣿⠀⢸⡿⠿⠿⠛⠛⠛⠉⠉⠁⠀⠀⠀⣶⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣷⣄⡀⠀⠀⠀⠀⢀⣠⣴⣾⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣷⣦⣄⡀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⢰⣾⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣷⡆⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡇⠀⠸⠿⠿⠿⠿⠿⠿⠿⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣇⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡟⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⢻⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⡇⠀⢸⣿⣿⣿⣿⡿⠀⠀⣶⣶⣶⣶⣶⣶⣶⣶⡀⠀⢻⣿⣿⣿⣿⡇⠀⢸⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⢸⣿⣿⣿⡿⠁⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠈⢿⣿⣿⣿⡇⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⠃⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠈⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠃⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'autobots-rules-greater)

(custom-set-faces!
  '(doom-dashboard-banner :foreground "#61afef" ))


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Morten Hersson"
      user-mail-address "mhersson@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; Don't nag about me wanting to exit
(setq confirm-kill-emacs nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org-mode/")

;; Set max length for branch name on the modeline
(setq doom-modeline-vcs-max-length 40)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Always middle click paste at cursors position
(setq mouse-yank-at-point t)

;; Set shell indent to 2 spaces
(add-hook! sh-mode
  (setq sh-basic-offset 2)
  (setq tab-width 2))

;; Override shfmt to use two spaces instead of tabs
(after! format-all
  (set-formatter! 'shfmt
    '("shfmt"
      "-i" "2" "-ci" "-bn"
      ;; Mode selection ropied from the default config
      ("-ln" "%s" (cl-case (and (boundp 'sh-shell) (symbol-value 'sh-shell))
                    (bash "bash") (mksh "mksh") (t "posix"))))
    :modes 'sh-mode))

(add-hook! go-mode
  (setq lsp-gopls-gofumpt t)
  (setq lsp-gopls-complete-unimported t)
  (setq lsp-gopls-deep-completion t)
  (setq lsp-gopls-use-placeholders t)
  (setq lsp-gopls-semantic-tokens t)
  (setq lsp-go-build-flags ["-tags=integration"]))

(after! lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\moto")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\vendor"))

;; Use yamlfmt instead of lsp to format yaml files
(after! yaml-mode
  (add-hook 'yaml-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'yamlfmt-format-buffer nil t))))

(defun yamlfmt-format-buffer ()
  "Format the current buffer using yamlfmt."
  (when (executable-find "yamlfmt")
    (let ((current-point (point)))
      (shell-command-on-region (point-min) (point-max) "yamlfmt -" nil t)
      (goto-char current-point))))

;; Plantuml
(after! plantuml-mode
  (setq plantuml-default-exec-mode 'jar
        plantuml-preview-theme "toy"))

;; Copilot
;; accept completion from copilot and fallback to company
;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)
;;               ("C-n" . 'copilot-next-completion)
;;               ("C-p" . 'copilot-previous-completion))

;;   :config
;;   (add-to-list 'copilot-indentation-alist '(prog-mode 2))
;;   (add-to-list 'copilot-indentation-alist '(org-mode 2))
;;   (add-to-list 'copilot-indentation-alist '(text-mode 2))
;;   (add-to-list 'copilot-indentation-alist '(closure-mode 2))
;;   (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

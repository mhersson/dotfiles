;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;; Performance optimizations - executed before package.el and GUI initialization

;; Increase gc threshold during startup for faster loading
(setq gc-cons-threshold (* 100 1024 1024))  ; 100MB
(setq gc-cons-percentage 0.6)

;; Restore garbage collection settings after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1024 1024))  ; 2MB
            (setq gc-cons-percentage 0.1)))

;; Disable package.el since we're using straight.el
(setq package-enable-at-startup nil)

;; Disable GUI elements early to prevent flickering
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; No startup screen
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

;; Faster startup by not loading default.el
(setq inhibit-default-init t)

;; Reduce rendering workload by not rendering cursors or regions in non-focused windows
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Disable bidirectional text rendering for performance
(setq-default bidi-display-reordering 'left-to-right)
(setq bidi-inhibit-bpa t)

;; XDG directory setup - keep config clean
(defvar user-cache-directory
  (expand-file-name "emacs/" (or (getenv "XDG_CACHE_HOME") "~/.cache"))
  "Directory for cache files.")

(defvar user-data-directory
  (expand-file-name "emacs/" (or (getenv "XDG_DATA_HOME") "~/.local/share"))
  "Directory for data files.")

(defvar user-state-directory
  (expand-file-name "emacs/" (or (getenv "XDG_STATE_HOME") "~/.local/state"))
  "Directory for state files.")

;; Create directories if they don't exist
(dolist (dir (list user-cache-directory user-data-directory user-state-directory))
  (unless (file-directory-p dir)
    (make-directory dir t)))

;; Redirect cache and data files away from config directory
(setq auto-save-list-file-prefix (expand-file-name "auto-save-list/.saves-" user-state-directory))
(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" user-cache-directory))))
(setq url-cache-directory (expand-file-name "url/" user-cache-directory))
(setq eshell-directory-name (expand-file-name "eshell/" user-data-directory))
(setq tramp-persistency-file-name (expand-file-name "tramp" user-state-directory))

;; Package manager directories
(setq package-user-dir (expand-file-name "elpa/" user-cache-directory))

;; Set PATH to match shell environment
(when (eq system-type 'darwin)
  (let* ((home (getenv "HOME"))
         (paths (list (concat home "/Development/go/bin")
                      (concat home "/.local/bin")
                      (concat home "/.cargo/bin")
                      "/opt/homebrew/bin")))
    ;; Add paths to exec-path in order
    (dolist (path (reverse paths))
      (when (file-directory-p path)
        (add-to-list 'exec-path path)))
    ;; Set PATH environment variable
    (setenv "PATH" (concat (string-join paths ":")
                           ":" (getenv "PATH"))))

  ;; Fix native compilation on macOS with Homebrew
  (setenv "LIBRARY_PATH"
          (string-join '("/opt/homebrew/Cellar/gcc/15.1.0/lib/gcc/current/gcc/aarch64-apple-darwin24/15"
                         "/opt/homebrew/lib/gcc/current"
                         "/opt/homebrew/lib"
                         "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"
                         "/usr/lib") ":"))
  (setq native-comp-driver-options '("-Wl,-w")))

;;; early-init.el ends here

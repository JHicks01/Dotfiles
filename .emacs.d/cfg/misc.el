;; Recentf
(setq recentf-exclude '("^/var/folders\\.*"
                        "COMMIT_EDITMSG\\'"
                        ".*-autoloads\\.el\\'"
                        "[/\\]\\.elpa/"
                        ))
(recentf-mode 1)
(setq recentf-max-saved-items 500)

;; Compilation
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq compilation-scroll-output 'first-error)

(define-key compilation-mode-map (kbd "g") nil)
(define-key compilation-mode-map (kbd "h") nil)

;; Style
(setq c-default-style "linux")
(setq c-basic-offset 4)

;; Help
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; Disable Bell
(setq ring-bell-function 'ignore)

;; Set Browser Application
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome-stable")

;; Scratch Buffer
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message '"")

;; Inhibit Startup Screen
(setq inhibit-startup-screen 't)

;; Disable Lockfiles/Backups
(setq create-lockfiles nil)
(setq make-backup-files nil)

;; Set Custom Variables in different file
(setq custom-file "~/.emacs.d/custom_set_variables.el")

;; Magit
(use-package magit
  :ensure t)

(use-package evil-magit
  :ensure t)

(setq auto-revert-check-vc-info t)

;; Ivy
(use-package ivy
  :ensure t
  :config

  (use-package flx
    :ensure t)

  (use-package ivy-xref
    :ensure t
    :config
    (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

  (ivy-mode)
  (setq ivy-height 12)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-use-virtual-buffers t)
  (setq ivy-virtual-abbreviate 'full)
  (setq ivy-use-selectable-prompt t)
  (setq helm-make-completion-method 'ivy)
  (setq ivy-extra-directories nil)
  (setq projectile-completion-system 'ivy)
  (setq ivy-switch-buffer-faces-alist nil)
  (setq ivy-dynamic-exhibit-delay-ms 200)
  (setq ivy-ignore-buffers '("\\` "
                             "\\`\\*magit-process"
                             "\\`\\*magit-diff"
                             "\\`\\*Flycheck"
                             "\\`\\*Shell Command Output"
                             "\\`\\*lsp")))

(use-package counsel
  :ensure t
  :config
  (setq counsel-find-file-ignore-regexp "^.cquery"))

(use-package counsel-projectile
  :ensure t)

(use-package swiper
  :ensure t)

(use-package helm-make
  :ensure t
  :defer t)

;; Avy
(use-package avy
  :ensure t
  :defer t)

;; Company
(use-package company
  :ensure t
  :config
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.1)
  (global-company-mode))

;; Flycheck
(use-package flycheck
  :ensure t
  :defer t)

;; Projectile
(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-mode)
  (add-to-list 'projectile-globally-ignored-directories "build/"))

(defvar project-notes-file ".notes.org")

(defun goto-project-notes()
  "Open the notes file associated with the current project.
Set `project-notes-file' to change the file name."
  (interactive)
  (find-file (concat (projectile-project-root) project-notes-file)))

;; LSP
(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-highlight-symbol-at-point nil)

  (use-package lsp-ui
    :ensure t
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    (setq lsp-ui-sideline-enable nil))
  
  (use-package company-lsp
    :ensure t
    :config
    (push 'company-lsp company-backends)))

;; Yasnippet
(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

;; Column Enforce Mode
(use-package column-enforce-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'column-enforce-mode))

;; Popwin
(use-package popwin
  :ensure t
  :config
  (popwin-mode)
  (setq popwin:popup-window-height 21)
  (add-to-list 'popwin:special-display-config
               '(cargo-process-mode :noselect t))
  (add-to-list 'popwin:special-display-config
               '(flycheck-error-list-mode :noselect t)))

;; Smex
(use-package smex
  :ensure t)

;; Smooth Scrolling
(use-package smooth-scrolling
  :ensure t
  :config
  (setq scroll-step 1)
  (setq scroll-conservatively 10000)
  (do-smooth-scroll))

;; Which Key
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1.5))

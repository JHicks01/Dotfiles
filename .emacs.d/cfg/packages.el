;; Magit
(use-package magit
  :ensure t)

(use-package evil-magit
  :ensure t)

(setq auto-revert-check-vc-info t)

;; Ivy
(use-package ivy
  :config
  
  (use-package flx)

  (use-package ivy-xref
    :defer t
    :config
    (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))
  (ido-mode 0)
  (ivy-mode)
  (setq ivy-height 12)
  (setq ivy-count-format "%d/%d ")
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
  :config
  (setq counsel-find-file-ignore-regexp "^.cquery")
  (counsel-mode))

(use-package counsel-projectile)

(use-package swiper)

(use-package helm-make)

;; Avy
(use-package avy)

;; Company
(use-package company
  :config
  (use-package company-posframe
    :config (company-posframe-mode 1))

  (setq company-tooltip-align-annotations t)
  (global-company-mode t))

(use-package flycheck
  :config
  (setq flycheck-check-syntax-automatically '(mode-enabled save)))

;; Projectile
(use-package projectile
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
  :config
  (setq lsp-enable-symbol-highlighting nil)

  (use-package lsp-ui
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    (setq lsp-ui-sideline-enable nil)
    (setq lsp-ui-doc-enable nil))
  
  (use-package company-lsp
    :config
    (push 'company-lsp company-backends)))

;; Yasnippet
(use-package yasnippet
  :defer t
  :config (yas-global-mode))

;; Column Enforce Mode
(use-package column-enforce-mode
  :config
  (add-hook 'prog-mode-hook 'column-enforce-mode))

;; Popwin
(use-package popwin
  :config
  (popwin-mode)
  (setq popwin:popup-window-height 21)
  (add-to-list 'popwin:special-display-config
               '(cargo-process-mode :noselect t))
  (add-to-list 'popwin:special-display-config
               '(flycheck-error-list-mode :noselect t)))

;; Smex
(use-package smex)

;; Smooth Scrolling
(use-package smooth-scrolling
  :config
  (setq scroll-step 1)
  (setq scroll-conservatively 10000)
  (do-smooth-scroll))

;; Which Key
(use-package which-key
  :config
  (which-key-mode))

;; Smartparens
(use-package smartparens
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode)
  (sp-pair "'" "'")
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  ;; (sp-pair "'" nil :actions nil)
  (setq sp-highlight-pair-overlay nil)
  (setq sp-highlight-wrap-overlay nil)
  (setq sp-highlight-wrap-tag-overlay nil)

  (defun my-create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent."
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))

  (sp-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET"))))

(use-package evil-smartparens
  :config (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))

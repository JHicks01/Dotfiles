;; Package Management
(require 'package)

(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(package-install 'use-package)
(eval-when-compile (require 'use-package))

;; Better Defaults
(use-package better-defaults
  :ensure t)

;; Theme
(load-file "~/.emacs.d/hicksy-dracula.el")

;; Mode Line
(use-package rich-minority
  :ensure t
  :config 
  (setf rm-blacklist "")
  (rich-minority-mode 1))

;; Font
(set-face-attribute 'default nil :font "Iosevka-14")
(set-frame-font "Iosevka-14" nil t)

;; Smartparens
(use-package smartparens
  :ensure t
  :defer t
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode)
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (setq sp-highlight-pair-overlay nil)
  (setq sp-highlight-wrap-overlay nil)
  (setq sp-highlight-wrap-tag-overlay nil)

  (defun my-create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))

  (sp-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET"))))

(use-package evil-smartparens
  :ensure t
  :config (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))

;; Rainbow Delimiters
(use-package rainbow-delimiters
  :ensure t
  :defer t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Line Numbers
(setq-default display-line-numbers 'relative)

;; Column Numbers
(column-number-mode)

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
  :ensure t)

;; Company
(use-package company
  :ensure t
  :config
  (setq company-tooltip-align-annotations t)
  ;; (use-package company-childframe
  ;;   :ensure t
  ;;   :config (company-childframe-mode 1))

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
   Set `project-notes-file` to change the file name."
  (interactive)
  (find-file (concat (projectile-project-root) project-notes-file)))

;; Org Mode
(use-package org
  :ensure t)

(use-package org-bullets
  :ensure t
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(setq org-agenda-files '("~/org/"))

(setq org-capture-templates
      '(("t" "Todo" entry (file"~/org/Todo.org")
         "** TODO %?  %i\n  %a")))

(add-hook 'org-capture-mode-hook 'evil-insert-state)

(setq org-src-fontify-natively t)

(setq org-src-window-setup 'current-window)

(defun my/org-mode-hook ()
  "Stop the org-level headers from increasing in
   height relative to the other text."
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5))
    (set-face-attribute face nil :weight 'semi-bold :height 1.0)))

(add-hook 'org-mode-hook 'my/org-mode-hook)

(setq org-file-apps '((auto-mode . emacs)
                      ("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . "google-chrome-stable")
                      ("\\.pdf\\'" . "zathura %s")))

(add-to-list 'org-latex-packages-alist '("" "listingsutf8"))
(add-to-list 'org-latex-packages-alist '("" "minted"))

(setq org-latex-listings 'minted) 

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode
         -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode
         -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode
         -output-directory %o %f"))

(add-to-list 'org-latex-packages-alist '("" "qtree"))
(add-to-list 'org-latex-packages-alist '("" "lmodern"))

(add-hook 'org-mode-hook (lambda() (visual-line-mode)))

(setq org-startup-with-inline-images t)

(add-hook 'org-mode-hook
          (lambda ()
            (setq-local company-backends
                        '((company-yasnippet company-dabbrev)))))

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

;; C/C++
(use-package cc-mode
  :ensure t
  :defer t)

(use-package cmake-mode
  :ensure t
  :defer t)

(use-package cquery
  :ensure t
  :config
  (add-hook 'c-mode-hook (lambda() (lsp-cquery-enable)))
  (add-hook 'c++-mode-hook (lambda() (lsp-cquery-enable))))

(use-package bison-mode
  :ensure t
  :defer t)

(add-hook 'c-mode-hook (lambda () (setq flycheck-checker 'lsp-ui)))
(add-hook 'c-mode-hook (lambda() (flycheck-mode)))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-checker 'lsp-ui)))
(add-hook 'c++-mode-hook (lambda() (flycheck-mode)))

;; Asm
(add-hook 'asm-mode-hook (lambda()
                           (local-set-key (kbd "RET")
                                          'electric-indent-just-newline)))

;; Rust
(use-package rust-mode
  :ensure t
  :defer t
  :config
  (setq rust-format-on-save t)
  (setq rust-rustfmt-bin "~/.cargo/bin/rustfmt"))

(use-package cargo
  :ensure t
  :defer t)

(use-package racer
  :ensure t
  :defer t
  :config
  (setq racer-cmd "/usr/local/bin/racer")
  (setq racer-rust-src-path "/usr/local/src/rust/src"))

(use-package company-racer
    :ensure t
    :config (add-to-list 'company-backends 'company-racer))
    
(use-package flycheck-rust
  :ensure t
  :defer t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (add-hook 'rust-mode-hook (lambda() (flycheck-mode))))

;; Haskell
(use-package haskell-mode
  :ensure t
  :defer t)

;; LaTeX
(use-package auctex
  :defer t
  :ensure t)

(use-package company-auctex
  :ensure t
  :config (company-auctex-init))

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; Markdown
(use-package markdown-mode
  :ensure t
  :defer t)

;; ERC
(setq erc-timestamp-only-if-changed-flag nil
      erc-timestamp-format "%H:%M "
      erc-fill-prefix "      "
      erc-insert-timestamp-function 'erc-insert-timestamp-left)

(setq erc-hide-list '("JOIN" "PART" "QUIT"))

(setq erc-fill-column 225)

;; Yasnippet
(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

;; Column Enforce Mode
(use-package column-enforce-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'column-enforce-mode))

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

;; Style
(setq c-default-style "linux")
(setq c-basic-offset 4)

;; Help
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

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

;; Load keybindings file
(load-file "~/.emacs.d/keys.el")

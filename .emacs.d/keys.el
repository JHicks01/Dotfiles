;; Evil
(use-package evil
  :ensure t
  :config 

  (use-package evil-surround
    :ensure t
    :config (global-evil-surround-mode 1))

  (use-package evil-escape
    :ensure t
    :config
    (evil-escape-mode)
    (setq evil-escape-key-sequence "jk"))

  (setq-default evil-shift-round 'nil)

  (use-package evil-commentary
    :ensure t
    :config (evil-commentary-mode))

  (evil-mode 1))

;; Helper Functions
(defun open-config-file()
  "Open my config file"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun open-keys-file()
  "Open my keybindings file"
  (interactive)
  (find-file "~/.emacs.d/keys.el"))

;; General.el Setup
(setq my-leader "SPC")
(setq my-major-mode-leader ",")

(define-key evil-motion-state-map (kbd ",") 'nil)

(setq space-bound-maps '(evil-motion-state-map
                         magit-status-mode-map
                         magit-revision-mode-map
                         magit-log-mode-map
                         magit-diff-mode-map
                         magit-process-mode-map
                         compilation-mode-map
                         help-mode-map))

(dolist (element space-bound-maps)
  (define-key (symbol-value element) (kbd "SPC") 'nil))

(use-package general
  :ensure t
  :config
  (setq general-default-keymaps '(evil-normal-state-map evil-motion-state-map)))

;; Global keybindings
(general-define-key :prefix my-leader
                    "!" 'shell-command
                    "g" 'magit-status
                    "fc" 'open-config-file
                    "fk" 'open-keys-file
                    "TAB" 'evil-buffer
                    "el" 'flycheck-list-errors
                    "en" 'flycheck-next-error
                    "ss" 'swiper
                    "sw" 'avy-goto-word-1)

(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
(global-set-key (kbd "M-x") 'counsel-M-x)
(define-key projectile-mode-map (kbd "C-c p s s") 'counsel-projectile-ag)
(define-key projectile-mode-map (kbd "C-c p n") 'goto-project-notes)
(define-key ivy-minibuffer-map (kbd "C-h") 'counsel-up-directory)
(define-key ivy-minibuffer-map (kbd "C-l") 'ivy-partial-or-done)
(define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)

;; Company
(define-key company-active-map (kbd "C-j") 'company-select-next)
(define-key company-active-map (kbd "C-k") 'company-select-previous)

;; Org
(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(use-package evil-org
  :ensure t)

(general-define-key :prefix my-major-mode-leader
                    :keymaps 'org-mode-map
                    :states '(normal)
                    "a" 'org-archive-subtree
                    "d" 'org-deadline
                    "s" 'org-schedule
                    "p" 'org-pomodoro
                    "e" 'org-export-dispatch)

(evil-define-key 'normal org-mode-map
  (kbd "RET") 'org-open-at-point)

;; C/C++
(general-define-key :prefix my-major-mode-leader
                    :keymaps '(c-mode-map c++-mode-map)
                    :states '(normal)
                    "cc" 'helm-make-projectile
                    "fs" 'xref-find-apropos
                    "fr" 'xref-find-references)

(evil-define-key 'normal c-mode-map
  (kbd "gd") 'xref-find-definitions)
(evil-define-key 'normal c++-mode-map
  (kbd "gd") 'xref-find-definitions)

;; Rust
(evil-define-key 'normal rust-mode-map
  (kbd "gd") 'racer-find-definition)

;; Split and Focus Windows in 1 Step
(defun evil-window-vsplit-and-focus ()
  "Split window vertically and move right to focus it"
  (interactive)
  (evil-window-vsplit)
  (other-window 1))

(defun evil-window-split-and-focus ()
  "Split window vertically and move right to focus it"
  (interactive)
  (evil-window-split)
  (other-window 1))

(define-key evil-normal-state-map (kbd "C-w C-v") 'evil-window-vsplit-and-focus)
(define-key evil-normal-state-map (kbd "C-w C-s") 'evil-window-split-and-focus)

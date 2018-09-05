;; Evil
(use-package evil
  :config 

  (use-package evil-surround
    :config (global-evil-surround-mode 1))

  (use-package evil-escape
    :config
    (evil-escape-mode)
    (setq evil-escape-key-sequence "jk"))

  (setq-default evil-shift-round 'nil)

  (use-package evil-commentary
    :config (evil-commentary-mode))

  (evil-mode 1))

;; Helper Functions
(defun open-config-file ()
  "Open my config file"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun open-keys-file ()
  "Open my keybindings file"
  (interactive)
  (find-file "~/.emacs.d/cfg/keys.el"))

(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
(global-set-key (kbd "M-x") 'counsel-M-x)
;; (define-key projectile-mode-map (kbd "C-c p s s") 'counsel-projectile-ag)
;; (define-key projectile-mode-map (kbd "C-c p n") 'goto-project-notes)
(define-key ivy-minibuffer-map (kbd "C-h") 'counsel-up-directory)
(define-key ivy-minibuffer-map (kbd "C-l") 'ivy-partial-or-done)
(define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)

;; Company
(define-key company-active-map (kbd "C-j") 'company-select-next)
(define-key company-active-map (kbd "C-k") 'company-select-previous)
(global-set-key (kbd "M-/") 'company-complete)

;; Org
(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(use-package evil-org)

(evil-define-key 'normal org-mode-map
  (kbd "RET") 'org-open-at-point)

(evil-define-key 'normal c-mode-map
  (kbd "gd") 'xref-find-definitions)
(evil-define-key 'normal c++-mode-map
  (kbd "gd") 'xref-find-definitions)

;; Rust
(evil-define-key 'normal rust-mode-map
  (kbd "gd") 'racer-find-definition)

;; Split and Focus Windows in 1 Step
(defun evil-window-vsplit-and-focus ()
  "Split window vertically and move right to focus it."
  (interactive)
  (evil-window-vsplit)
  (other-window 1))

(defun evil-window-hsplit-and-focus ()
  "Split window horizontally and move down to focus it."
  (interactive)
  (evil-window-split)
  (other-window 1))

(define-key evil-normal-state-map (kbd "C-w C-v") 'evil-window-vsplit-and-focus)
(define-key evil-normal-state-map (kbd "C-w C-s") 'evil-window-hsplit-and-focus)

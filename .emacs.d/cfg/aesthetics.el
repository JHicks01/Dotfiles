;; Better Defaults
(use-package better-defaults
  :ensure t)

;; Theme
(load-file "~/.emacs.d/custom-themes/dracula.el")

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

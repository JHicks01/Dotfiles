;; Better Defaults
(use-package better-defaults)

;; Theme
(load-file "~/.emacs.d/custom-themes/doom.el")

;; Mode Line
(use-package doom-modeline
      :hook (after-init . doom-modeline-init))

;; Font
(set-face-attribute 'default nil :font "Iosevka-12")
(set-frame-font "Iosevka-12" nil t)

;; Rainbow Delimiters
(use-package rainbow-delimiters
  :defer t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Line Numbers
(setq-default display-line-numbers-type 'relative)
(setq-default display-line-numbers-width-start t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Column Numbers
(column-number-mode)

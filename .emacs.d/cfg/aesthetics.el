;; Better Defaults
(use-package better-defaults)

;; Theme
(load-file "~/.emacs.d/custom-themes/dracula.el")

;; Mode Line
(use-package rich-minority
  :config
  (setf rm-blacklist "")
  (rich-minority-mode 1))

;; Font
(set-face-attribute 'default nil :font "Iosevka-14")
(set-frame-font "Iosevka-14" nil t)

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

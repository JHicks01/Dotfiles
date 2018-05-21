(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t)
  (custom-theme-set-faces
   'dracula

   '(region ((t(:background "#464752"))))

   '(show-paren-match ((t(:foreground "#ffb86c"))))
   '(show-paren-mismatch ((t(:foreground "purple"))))

   '(mode-line-inactive ((t(:background "#2F2F36" :box "#2F2F36"))))

   '(linum ((t(:slant normal :background "#282a36" :foreground "#565761"))))
   '(linum-relative-current-face ((t(:background "#282a36" :foreground "#f8f8f2"))))))

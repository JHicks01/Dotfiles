(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (custom-theme-set-faces
   'doom-one

   '(ivy-virtual ((t(:foreground "#5B6268"))))

   '(org-todo ((t(:background "#282c34" :foreground "#c678dd" :weight bold))))
   '(org-level-1 ((t(:background "#282c34" :foreground "#51afef" :weight semi-bold))))
   '(org-level-2 ((t(:background "#282c34" :foreground "#a9a1e1" :weight semi-bold))))
   '(org-level-3 ((t(:background "#282c34" :foreground "#98be65" :weight semi-bold))))))

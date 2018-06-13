(use-package org)

(use-package org-bullets
  :defer t
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

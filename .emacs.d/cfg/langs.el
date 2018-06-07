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

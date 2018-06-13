;; C/C++
(use-package cc-mode)

(use-package cmake-mode)

(add-hook 'c-mode-hook (lambda () (setq flycheck-checker 'lsp-ui)))
(add-hook 'c-mode-hook (lambda () (setq flycheck-check-syntax-automatically '(mode-enabled save))))
(add-hook 'c-mode-hook (lambda() (flycheck-mode)))

(add-hook 'c++-mode-hook (lambda () (setq flycheck-checker 'lsp-ui)))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-check-syntax-automatically '(mode-enabled save))))
(add-hook 'c++-mode-hook (lambda() (flycheck-mode)))

(use-package cquery
  :config
  (add-hook 'c-mode-hook (lambda() (lsp-cquery-enable)))
  (add-hook 'c++-mode-hook (lambda() (lsp-cquery-enable))))

;; Asm
(add-hook 'asm-mode-hook (lambda()
                           (local-set-key (kbd "RET")
                                          'electric-indent-just-newline)))

;; Rust
(use-package rust-mode
  :defer t
  :config
  (setq rust-format-on-save t)
  (setq rust-rustfmt-bin "~/.cargo/bin/rustfmt"))

(use-package cargo)

(use-package racer
  :defer t
  :config
  (setq racer-cmd "/usr/local/bin/racer")
  (setq racer-rust-src-path "/usr/local/src/rust/src"))

(use-package company-racer
    :config (add-to-list 'company-backends 'company-racer))
    
(use-package flycheck-rust
  :defer t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (add-hook 'rust-mode-hook (lambda() (flycheck-mode))))

;; Haskell
(use-package haskell-mode)

;;LaTeX
(use-package auctex
  :defer t)

(use-package company-auctex
  :config (company-auctex-init))

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; Markdown
(use-package markdown-mode)

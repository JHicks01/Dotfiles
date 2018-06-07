;; Package Management
(require 'package)

(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(package-install 'use-package)
(eval-when-compile (require 'use-package))

(defun load-cfg-files ()
  "Load list of config files.
Set `cfg-files-list' to specify the list of config files."
  (dolist (file cfg-files-list)
    (load-file file)))

(defvar cfg-files-list '("~/.emacs.d/cfg/aesthetics.el"
                         "~/.emacs.d/cfg/packages.el"
                         "~/.emacs.d/cfg/org.el"
                         "~/.emacs.d/cfg/langs.el"
                         "~/.emacs.d/cfg/misc.el"
                         "~/.emacs.d/cfg/keys.el"))

(load-cfg-files)

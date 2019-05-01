(require 'package)
(setq package-archives
      `(,@package-archives
        ("melpa" . "https://melpa.org/packages/")
        ;; ("marmalade" . "https://marmalade-repo.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ;; ("user42" . "https://download.tuxfamily.org/user42/elpa/packages/")
        ;; ("emacswiki" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/emacswiki/")
        ;; ("sunrise" . "http://joseito.republika.pl/sunrise-commander/")
        ))
(package-initialize)

(setq package-enable-at-startup nil)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(put 'use-package 'lisp-indent-function 1)
(setq use-package-always-ensure t)

(use-package system-packages
  :custom
  (system-packages-noconfirm t))

(use-package use-package-ensure-system-package)

;; :diminish keyword
(use-package diminish)

;; :bind keyword
(use-package bind-key)

;; :quelpa keyword
(use-package quelpa)
(use-package quelpa-use-package)

;;(use-package use-package-secrets
;;  :ensure nil
;;  :custom
;;  (use-package-secrets-default-directory "~/.emacs.d/secrets")
;;  :quelpa
;;  (use-package-secrets :repo "a13/use-package-secrets" :fetcher github :version original))

(use-package calendar
  :ensure nil
  :custom
  (calendar-week-start-day 1))

(use-package org
  ;; to be sure we have latest Org version
  :ensure org-plus-contrib
  :custom
  (org-src-tab-acts-natively t))

(use-package org-bullets
  :custom
  ;; org-bullets-bullet-list
  ;; default: "◉ ○ ✸ ✿"
  ;; large: ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
  ;; Small: ► • ★ ▸
  (org-bullets-bullet-list '("•"))
  ;; others: ▼, ↴, ⬎, ⤷,…, and ⋱.
  ;; (org-ellipsis "⤵")
  (org-ellipsis "…")
  :hook
  (org-mode . org-bullets-mode))

;;(use-package htmlize
;;  :custom
;;  (org-html-htmlize-output-type 'css)
;;  (org-html-htmlize-font-prefix "org-"))

;;(use-package org-password-manager
;;  :hook
;;  (org-mode . org-password-manager-key-bindings))

;;(use-package org-jira
;;  :custom
;;  (jiralib-url "http://jira:8080"))

(global-set-key (kbd "C-c i") 
(lambda() (interactive)(org-babel-load-file "~/.emacs.d/init.org")))

(global-set-key (kbd "M-o") 'other-window)
(windmove-default-keybindings)

(ido-mode t)
(setq ido-enable-flex-matching t)

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "/usr/local/bin/multimarkdown"))

(use-package anaconda-mode
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
)

(use-package conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "~/anaconda3"))
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode t)
)

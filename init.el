(setq-default
 ad-redefinition-action 'accept                   ; Silence warnings for redefinition
 cursor-in-non-selected-windows t                 ; Hide the cursor in inactive windows
 display-time-default-load-average nil            ; Don't display load average
 fill-column 80                                   ; Set width for automatic line breaks
 help-window-select t                             ; Focus new help windows when opened
 indent-tabs-mode nil                             ; Prefers spaces over tabs
 inhibit-startup-screen t                         ; Disable start-up screen
 initial-scratch-message ""                       ; Empty the initial *scratch* buffer
 kill-ring-max 128                                ; Maximum length of kill ring
 load-prefer-newer t                              ; Prefers the newest version of a file
 mark-ring-max 128                                ; Maximum length of mark ring
 scroll-conservatively most-positive-fixnum       ; Always scroll by one line
 select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
 tab-width 4                                      ; Set width for tabs
 use-package-always-ensure t                      ; Avoid the :ensure keyword for each package
 user-full-name "Vlad Artamonov"                  ; Set the full name of the current user
 user-mail-address "perestrelka@gmail.com"        ; Set the email address of the current user
 vc-follow-symlinks t                             ; Always follow the symlinks
 view-read-only t)                                ; Always open read-only buffers in view-mode
(cd "~/")                                         ; Move to the user directory
(column-number-mode 1)                            ; Show the column number
(display-time-mode 1)                             ; Enable time in the mode-line
(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
(global-hl-line-mode)                             ; Hightlight current line
(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding
(show-paren-mode 1)                               ; Show the parent

(set-face-attribute 'default nil :font "Source Code Pro")
(set-fontset-font t 'latin "Noto Sans")

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

(use-package all-the-icons :defer 0.5)

(use-package nord-theme
  :config
  (add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
  (load-theme 'nord t))

(use-package doom-modeline
  :defer 0.1
  :config (doom-modeline-mode))

(use-package fancy-battery
  :after doom-modeline
  :hook (after-init . fancy-battery-mode))

(when window-system
  (menu-bar-mode -1)              ; Disable the menu bar
  (scroll-bar-mode -1)            ; Disable the scroll bar
  (tool-bar-mode -1)              ; Disable the tool bar
  (tooltip-mode -1)              ; Disable the tooltips
  (set-frame-size (selected-frame) 160 80))

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
(lambda() (interactive)(org-babel-load-file "~/.emacs.d/config.org")))

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

(use-package async :ensure t)

(defvar *config-file* (expand-file-name "config.org" user-emacs-directory)
  "The configuration file.")

(defvar *config-last-change* (nth 5 (file-attributes *config-file*))
  "Last modification time of the configuration file.")

(defvar *show-async-tangle-results* nil
  "Keeps *emacs* async buffers around for later inspection.")

(defun my/config-updated ()
  "Checks if the configuration file has been updated since the last time."
  (time-less-p *config-last-change*
               (nth 5 (file-attributes *config-file*))))

(defun my/config-tangle ()
  "Tangles the org file asynchronously."
  (when (my/config-updated)
    (setq *config-last-change*
          (nth 5 (file-attributes *config-file*)))
    (my/async-babel-tangle *config-file*)))

(defun my/async-babel-tangle (org-file)
  "Tangles the org file asynchronously."
  (let ((init-tangle-start-time (current-time))
        (file (buffer-file-name))
        (async-quiet-switch "-q"))
    (async-start
     `(lambda ()
        (require 'org)
        (org-babel-tangle-file ,org-file))
     (unless *show-async-tangle-results*
       `(lambda (result)
          (if result
              (message "SUCCESS: %s successfully tangled (%.2fs)."
                       ,org-file
                       (float-time (time-subtract (current-time)
                                                  ',init-tangle-start-time)))
            (message "ERROR: %s as tangle failed." ,org-file)))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (fancy-battery doom-modeline nord-theme all-the-icons use-package-ensure-system-package quelpa-use-package org-plus-contrib org-bullets markdown-mode diminish conda async anaconda-mode)))
 '(system-packages-noconfirm t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

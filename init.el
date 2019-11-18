;;; init.el --- GNU Emacs Configuration

;;; Commentary:

;; Following lines build the configuration code out of the config.el file.

;;; Code:

;; Make startup faster by reducing the frequency of garbage
;; collection.
(setq gc-cons-threshold (* 50 1000 1000))

(require 'package)
(package-initialize)

(if (file-exists-p (expand-file-name "config.el" user-emacs-directory))
    (load-file (expand-file-name "config.el" user-emacs-directory))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-week-start-day 1)
 '(git-commit-summary-max-length 50)
 '(markdown-command "/usr/local/bin/pandoc" t)
 '(markdown-preview-javascript
   (quote
    ("https://github.com/highlightjs/highlight.js/9.15.6/highlight.min.js" "<script>
            $(document).on('mdContentChange', function() {
              $('pre code').each(function(i, block)  {
                hljs.highlightBlock(block);
              });
            });
          </script>")) t)
 '(markdown-preview-stylesheets
   (quote
    ("https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css" "https://github.com/highlightjs/highlight.js/9.15.6/styles/github.min.css" "<style>
            .markdown-body {
              box-sizing: border-box;
              min-width: 200px;
              max-width: 980px;
              margin: 0 auto;
              padding: 45px;
            }

            @media (max-width: 767px) { .markdown-body { padding: 15px; } }
          </style>")) t)
 '(org-bullets-bullet-list (quote ("•")) t)
 '(org-ellipsis "…")
 '(org-src-tab-acts-natively t)
 '(package-selected-packages
   (quote
    (direnv use-package-ensure-system-package quelpa-use-package org-plus-contrib org-bullets nord-theme nix-mode markdown-preview-mode magit git-timemachine git-gutter fancy-battery doom-modeline diminish conda anaconda-mode)))
 '(system-packages-noconfirm t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

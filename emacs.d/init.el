;;
;; Init functions
;;

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;;
;; Install & Configure el-get
;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)
;; el-get packages
(setq my-el-get-packages
      `(
        el-get
        auto-complete
        smex
        color-theme-railscasts
        color-theme-leuven
        color-theme-desert
        smartparens
        autopair
        linum-ex
        js-comint
        js2-mode
        jshint-mode
        pandoc-mode
        markdown-mode
        coffee-mode
        flymake-coffee
        quack
        scheme-complete
        highlight-parentheses
        ))
(el-get `sync my-el-get-packages)

;;
;; Basic Settings 
;;

;; Auto Complete
(require 'auto-complete-config)
(ac-config-default)
;; Ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
;; Smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex-major-mode-commands)
(global-set-key (kbd "M-x") 'smex)
;; Highlight Parentheses
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(setq hl-paren-colors
      '(;"#8f8f8f" ; this comes from Zenburn
                   ; and I guess I'll try to make the far-outer parens look like this
        "orange1" "yellow1" "greenyellow" "green1"
        "springgreen1" "cyan1" "slateblue1" "magenta1" "purple"))
;; Autopair
(require 'autopair)
(autopair-global-mode)
;; Look
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(blink-cursor-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(color-theme-desert)
(set-default-font "Hermit-12")
(require 'linum-ex)
(global-linum-mode +1)
;; Parentheses
(require 'paren)
(setq show-paren-style 'parentheses)
(show-paren-mode +1)
;; Scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)
;; Do not use tab
(setq c-basic-offset 2)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
;; Can delete selection
(delete-selection-mode t)
;; WindMove
(require 'windmove)
(windmove-default-keybindings 'meta)
;; Disable backups
(setq make-backup-files nil)
;; Highlight current line
;; (global-hl-line-mode +1)

;;
;; Programming Language
;;

;; JavaScript
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
          (lambda () (flymake-mode t)))
(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq inferior-js-program-command "node --interactive")

;; Markdown
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.pandoc\\'" . markdown-mode))

;; Pandoc
(add-hook 'markdown-mode-hook 'turn-on-pandoc)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

;; CoffeeScript
(setq coffee-tab-width 2)

;; Scheme
(require 'quack)

;;
;; Load modules
;;
(load-user-file "personal.el")

;;
;; Start Server
;;
(load "server")
(unless (server-running-p) (server-start))


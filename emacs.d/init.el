(require 'package)

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; describe packages you need

;; starter kit

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings starter-kit-eshell)
  "A list of packages to ensure are installed at launch.")
;; ipython-mode
(push 'ipython my-packages)
;; scala-mode
(push 'scala-mode my-packages)
;; auto-complete
(push 'auto-complete my-packages)
;; themes
(push 'color-theme my-packages)
(push 'color-theme-sanityinc-solarized my-packages)

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; customization

;; window movation
(windmove-default-keybindings 'meta)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key [C-tab] 'other-window)
;; auto complete customization
(require 'auto-complete-config)
(ac-config-default)
;; color theme
(color-theme-sanityinc-solarized-dark)
;; font
(set-face-attribute
 'default nil :font "Inconsolata-g 13")



;;; init.el --- My init script -*- coding: utf-8 ; lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;--+--+--+--+--+--+--+--+--+--+
;; Package Management
;;--+--+--+--+--+--+--+--+--+--+
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  (setq use-package-enable-imenu-support t)
  (require 'use-package))


;;--+--+--+--+--+--+--+--+--+--+
;; Display Settings
;;--+--+--+--+--+--+--+--+--+--+

;; No bar
(add-hook 'before-make-frame-hook
  (lambda ()
    (interactive)
    (menu-bar-mode 0)      ; No menu bar
    (tool-bar-mode 0)))      ; No tool bar
;;   (scroll-bar-mode 0)))  ; No scroll bar

;; No startup message
(setq inhibit-startup-message 1)

;; No scratch message
(setq initial-scratch-message "")

;; Show column number
(column-number-mode 1)

;; Show pairs of parentheses
(show-paren-mode 1)

;; No background color in teminal
;; https://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)


;;--+--+--+--+--+--+--+--+--+--+
;; Editor Settings
;;--+--+--+--+--+--+--+--+--+--+

;; No backup
(setq make-backup-files nil)

;; No auto save
(setq auto-save-default nil)

;; Save recent files as history
(defvar recentf-max-saved-items 25)
(defvar recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/" "/\\.emacs\\.d/bookmarks"))
(defvar recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
(recentf-mode 1)

;; No beep sound
(setq ring-bell-function 'ignore)

;; Share copied text to clipboard
(setq select-enable-clipboard t)

;; Copy with mouse
(setq mouse-drag-copy-region t)

;; Use spaces instead of tabs
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

;; Turn off wrapping
(setq-default truncate-partial-width-windows t)
(setq-default truncate-lines t)

;; Fontify code in code blocks
(defvar org-src-fontify-natively t)

;; Use on scratch buffer
(setq initial-major-mode 'org-mode)

;; Single frame to display files to be compared or merged
(defvar ediff-window-setup-function 'ediff-setup-windows-plain)

;; To be horizontally split
(defvar ediff-split-window-function 'split-window-horizontally)


;;--+--+--+--+--+--+--+--+--+--+
;; Key Settings
;;--+--+--+--+--+--+--+--+--+--+

;; C-h -> Backspace
;; C-? -> HELP
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "C-?") 'help-for-help)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-x p") 'previous-buffer)
(global-set-key (kbd "C-x n") 'next-buffer)


;;--+--+--+--+--+--+--+--+--+--+
;; Package Settings
;;--+--+--+--+--+--+--+--+--+--+

;; https://github.com/rranelli/auto-package-update.el
;; Automatically update Emacs packages.
(use-package auto-package-update
  :ensure t
  :bind ("C-x P" . auto-package-update-now)
  :custom
  (auto-package-update-delete-old-versions t))

;;------------------------------

;; https://github.com/purcell/color-theme-sanityinc-tomorrow
;; Chris Kempson's 'tomorrow' themes
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init (load-theme 'sanityinc-tomorrow-bright t))

;;------------------------------

;; https://github.com/magit/magit
;; A Git porcelain inside Emacs.
(use-package magit
  :ensure t
  :diminish auto-revert-mode
  :bind (("C-x g" . magit-status))
  :custom
  (magit-repository-directories '(("~/git/" . 1)))
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (magit-completing-read-function 'ivy-completing-read))

(use-package git-commit
  :ensure t
  :custom
  (git-commit-fill-column 120))

;;------------------------------

;; https://github.com/purcell/exec-path-from-shell
;; Make Emacs use the $PATH set up by the user's shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;;------------------------------

;; https://github.com/editorconfig/editorconfig-emacs
;; EditorConfig plugin for emacs
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;;------------------------------

;; https://github.com/abo-abo/swiper
;; A generic completion mechanism for Emacs.
(use-package ivy
  :ensure t
  :diminish ivy-mode
  :bind (("C-c C-r" . ivy-resume)
         ("C-x b" . ivy-switch-buffer))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  :config
  (ivy-mode 1))


;;------------------------------

;; https://github.com/abo-abo/swiper
;; A collection of Ivy-enhanced versions of common Emacs commands.
(use-package counsel
  :ensure t
  :bind (("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("M-y" . counsel-yank-pop)
         ("C-c e" . counsel-recentf)
         ("C-c g" . counsel-git)
         ("C-c s" . counsel-rg)))

;;------------------------------

;; https://github.com/abo-abo/avy
;; Jump to things in Emacs tree-style.
(use-package avy
  :ensure t
  :bind (("C-c ." . avy-goto-word-or-subword-1)
         ("C-c ," . avy-goto-char)
         ("M-g f" . avy-goto-line)
         ("M-g w" . avy-goto-word-or-subword-1)))

;;------------------------------

;; expand-region
;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :ensure t
  :bind (("C-t" . er/expand-region)
         ("M-t" . er/contract-region)))

;;------------------------------

;; https://github.com/EricCrosson/unkillable-scratch
;; Disallow the *scratch* buffer from being killed
(use-package unkillable-scratch
  :ensure t
  :config
  (unkillable-scratch 1))

;;------------------------------

;; https://github.com/Fanael/persistent-scratch
;; Preserve the scratch buffer across Emacs sessions
(use-package persistent-scratch
  :ensure t
  :config
  (persistent-scratch-setup-default))

;;------------------------------

;; https://github.com/emacsfodder/pbcopy.el
;; Emacs Interface to pbcopy
(use-package pbcopy
  :ensure t )

;;------------------------------

;; markdown-model.el
;; http://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown") ; C-c C-c p
  (setq markdown-open-command "~/.bin/typora")) ; C-c C-c o

;;------------------------------

;; https://github.com/joshwnj/json-mode
;; JSON major mode
(use-package json-mode
  :ensure t
  :mode ("\\.json\\'" . json-mode))

;;------------------------------

;; https://github.com/yoshiki/yaml-mode
;; Simple major mode to edit YAML file for emacs
(use-package yaml-mode
  :ensure t
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

;;------------------------------

;; https://github.com/wwwjfy/emacs-fish
;; fish-mode for emacs
(use-package fish-mode
  :ensure t
  :mode ("\\.fish\\'" . fish-mode))

;;------------------------------

;; https://github.com/flycheck/flycheck
;; On the fly syntax checking for GNU Emacs
(use-package flycheck
  :ensure t
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :hook (after-init . global-flycheck-mode))

;;------------------------------

;; https://github.com/company-mode/company-mode
;; Modular in-buffer completion framework for Emacs
(use-package company
  :diminish company-mode
  :ensure t
  :bind
  (:map company-active-map
    ("M-n" . nil)
    ("M-p" . nil)
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous)
    ("<tab>" . company-complete-common-or-cycle)
    :map company-search-map
    ("C-p" . company-select-previous)
    ("C-n" . company-select-next))
  :custom
  (company-minimum-prefix-length 1))
  ;;:hook (after-init . global-company-mode))

;;------------------------------

;;; init.el ends here

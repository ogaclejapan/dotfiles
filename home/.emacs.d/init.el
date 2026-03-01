;;; init.el --- My init script -*- coding: utf-8 ; lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;--+--+--+--+--+--+--+--+--+--+
;; Package Management
;;--+--+--+--+--+--+--+--+--+--+
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)


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
  "unsets the background color in terminal mode"
  (or frame (setq frame (selected-frame)))
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)


;;--+--+--+--+--+--+--+--+--+--+
;; Editor Settings
;;--+--+--+--+--+--+--+--+--+--+

(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p (expand-file-name custom-file))
  (load-file (expand-file-name custom-file)))

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

(which-key-mode 1)
(which-key-setup-side-window-right-bottom)

;;--+--+--+--+--+--+--+--+--+--+
;; Package Settings
;;--+--+--+--+--+--+--+--+--+--+
(use-package use-package
  :config
  (setq use-package-always-ensure t))

;; https://github.com/rranelli/auto-package-update.el
;; Automatically update Emacs packages.
(use-package auto-package-update
  :config
  (setq auto-package-update-interval 1)
  (auto-package-update-maybe))

;;------------------------------

;; https://github.com/benotn/kkp
;; Support for the Kitty Keyboard protocol in Emacs
(use-package kkp
  :ensure t
  :config
  (global-kkp-mode +1))

;;------------------------------

;; https://github.com/purcell/color-theme-sanityinc-tomorrow
;; Chris Kempson's 'tomorrow' themes
(use-package color-theme-sanityinc-tomorrow
  :init (load-theme 'sanityinc-tomorrow-bright t))

;;------------------------------

;; https://github.com/magit/magit
;; A Git porcelain inside Emacs.
(use-package magit
  :diminish auto-revert-mode
  :bind (("C-x g" . magit-status))
  :custom
  (magit-repository-directories '(("~/git/" . 1)))
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

;;------------------------------

;; http://elpa.gnu.org/packages/pinentry.html
;; GnuPG pinentry
(use-package pinentry
  :config
  ;; https://github.com/emacs-mirror/emacs/blob/master/lisp/epg-config.el
  (setq epg-pinentry-mode 'loopback)
  (pinentry-start))

;;------------------------------

;; https://github.com/purcell/exec-path-from-shell
;; Make Emacs use the $PATH set up by the user's shell
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;;------------------------------

;; https://github.com/editorconfig/editorconfig-emacs
;; EditorConfig plugin for emacs
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;;------------------------------

;; https://github.com/minad/vertico
;; VERTical Interactive COmpletion
(use-package vertico
  :custom
  (vertico-count 20)
  :init
  (vertico-mode))


;; Commands for Ido-like directory navigation.
(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;;------------------------------

;; https://github.com/oantolin/orderless
;; Emacs completion style that matches multiple regexps in any order
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;;------------------------------

;; https://github.com/minad/marginalia
;; Marginalia in the minibuffer
(use-package marginalia
  :config
  (marginalia-mode))

;;------------------------------

;; https://github.com/minad/consult
;; Consulting completing-read
(use-package consult
  :bind (("C-x b" . 'consult-buffer)
          ("M-y" . 'consult-yank-pop)
          ("M-s" . 'consult-line)
          ("C-c r" . 'consult-recent-file)
          ("C-c f" . 'consult-fd)
          ("C-c g" . 'consult-ripgrep)))

;;------------------------------

;; expand-region
;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :bind (("C-t" . er/expand-region)
         ("M-t" . er/contract-region)))

;;------------------------------

;; https://github.com/EricCrosson/unkillable-scratch
;; Disallow the *scratch* buffer from being killed
(use-package unkillable-scratch
  :config
  (unkillable-scratch 1))

;;------------------------------

;; https://github.com/Fanael/persistent-scratch
;; Preserve the scratch buffer across Emacs sessions
(use-package persistent-scratch
  :config
  (persistent-scratch-setup-default))

;;------------------------------

;; https://github.com/emacsfodder/pbcopy.el
;; Emacs Interface to pbcopy
(use-package pbcopy
  :config
  (turn-on-pbcopy))

;;------------------------------

;; markdown-model.el
;; http://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown") ; C-c C-c p
  (setq markdown-open-command "code")) ; C-c C-c o

;;------------------------------

;; https://github.com/yoshiki/yaml-mode
;; Simple major mode to edit YAML file for emacs
(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

;;------------------------------

;; https://github.com/wwwjfy/emacs-fish
;; fish-mode for emacs
(use-package fish-mode
  :mode ("\\.fish\\'" . fish-mode))

;;------------------------------

;; https://github.com/flycheck/flycheck
;; On the fly syntax checking for GNU Emacs
(use-package flycheck
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :hook (after-init . global-flycheck-mode))

;;------------------------------

;; https://github.com/karthink/gptel
;; A simple LLM client for Emacs
(use-package gptel
  :ensure t
  :pin melpa
  :config
  (setq
    gptel-model 'gpt-5-mini
    gptel-backend (gptel-make-gh-copilot "Copilot"))) ;Required gptel-gh-login

;;------------------------------

;; https://github.com/sshaw/git-link
;; Get the GitHub/Bitbucket/GitLab URL for a buffer location
(use-package git-link
  :bind (("C-c l" . git-link)))

;;------------------------------

;; Copy file reference as relative path from Git root with line numbers
(defun copy-file-line-reference ()
  "Copy selected region as git-root-relative path#line-number format."
  (interactive)
  (let* ((git-root (vc-git-root (buffer-file-name)))
         (relative-path (file-relative-name (buffer-file-name) git-root))
         (start-line (line-number-at-pos (region-beginning)))
         (end-line (line-number-at-pos (region-end)))
         (ref (if (= start-line end-line)
                  (format "%s#L%d" relative-path start-line)
                (format "%s#L%d-L%d" relative-path start-line end-line))))
    (kill-new ref)
    (message "Copied: %s" ref)))

(global-set-key (kbd "C-c L") 'copy-file-line-reference)

;;------------------------------

;;; init.el ends here

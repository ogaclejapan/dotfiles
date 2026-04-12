;;; init.el --- My init script -*- coding: utf-8 ; lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;--+--+--+--+--+--+--+--+--+--+
;; Package Management
;;--+--+--+--+--+--+--+--+--+--+
(require 'package)
(require 'subr-x)
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
  (setq markdown-open-command "mo")) ; C-c C-c o

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


;;--+--+--+--+--+--+--+--+--+--+
;; Custom functions
;;--+--+--+--+--+--+--+--+--+--+

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

;; GPG signing warmup
(defun git-global-config-value (key)
  "Return the Git global config value for KEY."
  (with-temp-buffer
    (if (zerop (process-file "git" nil t nil "config" "--global" "--get" key))
        (let ((value (string-trim (buffer-string))))
          (unless (string-empty-p value) value))
      nil)))

(defun epg-key-matches-key-id-p (key key-id)
  "Return non-nil when secret KEY matches KEY-ID."
  (let ((needle (downcase (string-trim key-id)))
        (sub-keys (epg-key-sub-key-list key))
        (matched nil))
    (while (and sub-keys (not matched))
      (let* ((sub-key (car sub-keys))
             (sub-key-id (downcase (or (epg-sub-key-id sub-key) "")))
             (fingerprint (downcase (or (epg-sub-key-fingerprint sub-key) ""))))
        (setq matched
              (or (string= needle sub-key-id)
                  (string= needle fingerprint)
                  (string-suffix-p needle sub-key-id)
                  (string-suffix-p needle fingerprint)))
        (setq sub-keys (cdr sub-keys))))
    matched))

(defun epg-secret-key-for-id (context key-id)
  "Return the secret key from CONTEXT that matches KEY-ID."
  (let ((secret-keys (epg-list-keys context nil t))
        (matched-key nil))
    (while (and secret-keys (not matched-key))
      (when (epg-key-matches-key-id-p (car secret-keys) key-id)
        (setq matched-key (car secret-keys)))
      (setq secret-keys (cdr secret-keys)))
    matched-key))

(defun gpg-signing-warmup ()
  "Warm up the GPG agent for Git commit signing."
  (interactive)
  (unless (executable-find "git")
    (user-error "git command not found"))
  (require 'epg)
  (let* ((signing-key (git-global-config-value "user.signingkey"))
         (context (epg-make-context 'OpenPGP))
         (payload (format "gpg-signing-warmup:%s"
                          (format-time-string "%Y-%m-%dT%H:%M:%S%z")))
         (secret-key nil)
         (key-suffix nil)
         (signed-text nil))
    (unless signing-key
      (user-error "Git user.signingkey is not configured"))
    (setq key-suffix
          (substring signing-key (max 0 (- (length signing-key) 8))))
    (condition-case err
        (progn
          (setq secret-key (epg-secret-key-for-id context signing-key))
          (when secret-key
            (epg-context-set-signers context (list secret-key)))
          (setq signed-text (epg-sign-string context payload 'cleartext))
          (unless (and (stringp signed-text) (> (length signed-text) 0))
            (error "Signature output is empty"))
          (message "GPG signing warmup completed: %s" key-suffix))
      (error
       (user-error "GPG signing warmup failed: %s"
                   (error-message-string err))))))

(global-set-key (kbd "C-c G") 'gpg-signing-warmup)

;;------------------------------

;;; init.el ends here

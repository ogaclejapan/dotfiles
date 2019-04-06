;;; init.el --- Init file
;;; Commentary:
;;; Code:

;;--+--+--+--+--+--+--+--+--+--+
;; Package Management
;;--+--+--+--+--+--+--+--+--+--+

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(package-initialize)
(setq package-enable-at-startup nil)

;; use-package.el
;; https://github.com/jwiegley/use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;--+--+--+--+--+--+--+--+--+--+
;; Display Settings
;;--+--+--+--+--+--+--+--+--+--+

;; Character Sets
;;(set-language-environment 'Japanese)
;;(prefer-coding-system 'utf-8)
;;(set-file-name-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(set-terminal-coding-system 'utf-8)

;; WORKAROUND: multi-byte character input
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=23412
(setq redisplay-dont-pause nil)

;; Font
(when (and (>= emacs-major-version 24) (not (null window-system)))
  (let* ((font-family "Menlo")
         (font-size 12)
         (font-height (* font-size 10))
         (jp-font-family "ヒラギノ角ゴ ProN"))
    (set-face-attribute 'default nil :family font-family :height font-height)
    (let ((name (frame-parameter nil 'font))
          (jp-font-spec (font-spec :family jp-font-family))
          (jp-characters '(katakana-jisx0201
                           cp932-2-byte
                           japanese-jisx0212
                           japanese-jisx0213-2
                           japanese-jisx0213.2004-1))
          (font-spec (font-spec :family font-family))
          (characters '((?\u00A0 . ?\u00FF)    ; Latin-1
                        (?\u0100 . ?\u017F)    ; Latin Extended-A
                        (?\u0180 . ?\u024F)    ; Latin Extended-B
                        (?\u0250 . ?\u02AF)    ; IPA Extensions
                        (?\u0370 . ?\u03FF)))) ; Greek and Coptic
      (dolist (jp-character jp-characters)
        (set-fontset-font name jp-character jp-font-spec))
      (dolist (character characters)
        (set-fontset-font name character font-spec))
      (add-to-list 'face-font-rescale-alist (cons jp-font-family 1.2)))))


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


;;--+--+--+--+--+--+--+--+--+--+
;; Editor Settings
;;--+--+--+--+--+--+--+--+--+--+

;; No backup
(setq make-backup-files nil)

;; No auto save
(setq auto-save-default nil)
;; (setq auto-save-list-file-name nil)
;; (setq auto-save-list-file-prefix nil)

;; Delete auto save files when editor finished
;; (setq delete-auto-save-files t)

;; Save recent files as history
(setq recentf-max-saved-items 25)
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/" "/\\.emacs\\.d/bookmarks"))
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
(recentf-mode 1)

;; No beep sound
(setq ring-bell-function 'ignore)

;; Share copied text to clipboard
(setq x-select-enable-clipboard t)

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
(setq org-src-fontify-natively t)

;; Use on scratch buffer
(setq initial-major-mode 'org-mode)

;; Single frame to display files to be compared or merged
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; To be horizontally split
(setq ediff-split-window-function 'split-window-horizontally)

;;--+--+--+--+--+--+--+--+--+--+
;; Server Settings
;;--+--+--+--+--+--+--+--+--+--+

;; Start server for emacs-client
;;(when window-system
;;  (require 'server)
;;  (unless (eq (server-running-p) 't)
;;    (server-start)
;;
;;    ;; Minimize window when start app
;;    ;;(defun iconify-emacs-when-server-is-done ()
;;    ;;  (unless server-clients (iconify-frame)))
;;    ;;(add-hook 'after-init-hook 'iconify-emacs-when-server-is-done)
;;
;;    ;; Don't finish app
;;    (global-set-key (kbd "C-x C-c") 'server-edit)
;;    (defalias 'exit 'save-buffers-kill-emacs)
;;
;;    ;; Show confirm message when exit app
;;    (setq confirm-kill-emacs 'yes-or-no-p)))

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

;; Insert new line below current line
(global-set-key (kbd "<S-return>") (lambda ()
   (interactive)
   (end-of-line)
   (newline-and-indent)))

;; Insert new line above current line
(global-set-key (kbd "<M-S-return>") (lambda ()
   (interactive)
   (beginning-of-line)
   (newline-and-indent)
   (backward-char)))

;; GoogleIME for Japanese Toggle Shortcuts
;;(when (eq system-type 'darwin)
;;  (setq google-ime "/Applications/GoogleJapaneseInput.localized")
;;  (when (file-exists-p google-ime)
;;    (global-set-key (kbd "C-S-j") (lambda ()
;;       (interactive)
;;       (call-process "osascript" nil t nil "-e" "tell application \"System Events\" to key code 104")))
;;    (global-set-key (kbd "C-:") (lambda ()
;;       (interactive)
;;       (call-process "osascript" nil t nil "-e" "tell application \"System Events\" to key code 102")))))

;;--+--+--+--+--+--+--+--+--+--+
;; Package Settings
;;--+--+--+--+--+--+--+--+--+--+

;; https://github.com/purcell/color-theme-sanityinc-tomorrow
;; Chris Kempson's 'tomorrow' themes
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init (load-theme 'sanityinc-tomorrow-bright t))

;;------------------------------

;; https://github.com/purcell/exec-path-from-shell
;; Make Emacs use the $PATH set up by the user's shell
(use-package exec-path-from-shell
  :ensure t
  :init (exec-path-from-shell-initialize))

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
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (bind-key "M-c" 'ivy-toggle-case-fold ivy-minibuffer-map)
  :bind ("C-c C-r" . ivy-resume))

;;------------------------------

;; https://github.com/abo-abo/swiper
;; A collection of Ivy-enhanced versions of common Emacs commands.
(use-package counsel
  :ensure t
  :bind (("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("M-y" . counsel-yank-pop)
         ("C-c e" . counsel-recentf)
         ("C-c f" . counsel-git)
         ("C-c g" . counsel-grep)
         ("C-c s" . counsel-rg)))

;;------------------------------

;; https://github.com/bbatsov/projectile
;; Project Interaction Library for Emacs.
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-mode-line
        '(:eval (format " [%s]" (projectile-project-name))))
  (setq projectile-remember-window-configs t)
  (setq projectile-completion-system 'ivy))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))

;;------------------------------

;; https://github.com/abo-abo/avy
;; Jump to things in Emacs tree-style.
(use-package avy
  :ensure t
  :bind (("C-j" . avy-goto-char-timer)
         ("C-l" . avy-goto-line)))

;;------------------------------

;; https://github.com/magit/magit
;; A Git porcelain inside Emacs.
(use-package magit
  :ensure t
  :config
  (setq magit-completing-read-function 'ivy-completing-read)
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (setq magit-repository-directories '(("~/git/" . 1)))
  :diminish auto-revert-mode
  :bind (("C-x g" . magit-status)))

;;------------------------------

;; expand-region
;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :ensure t
  :bind (("C-t" . er/expand-region)
         ("M-t" . er/contract-region)))

;;------------------------------

;; markdown-model.el
;; http://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :ensure t
  :init
  (setq markdown-command "multimarkdown") ; C-c C-c p
  (setq markdown-open-command "~/.bin/typora") ; C-c C-c o
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

;;------------------------------

;; https://github.com/EricCrosson/unkillable-scratch
;; Disallow the *scratch* buffer from being killed
(use-package unkillable-scratch
  :ensure t
  :init
  (setq unkillable-scratch-behavior 'do-nothing)
  (setq unkillable-buffers '("^\\*scratch\\*$"))
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

;; https://github.com/flycheck/flycheck
;; On the fly syntax checking for GNU Emacs
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;;------------------------------

;; https://github.com/joshwnj/json-mode
;; JSON major mode
(use-package json-mode
  :ensure t
  :mode (("\\.json\\'" . json-mode))
  :config (setq-default js-indent-level 2))

;;------------------------------

;; https://github.com/yoshiki/yaml-mode
;; Simple major mode to edit YAML file for emacs
(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'" . yaml-mode))

;;------------------------------

;; https://github.com/wwwjfy/emacs-fish
;; fish-mode for emacs
(use-package fish-mode
  :ensure t
  :mode ("\\.fish\\'" . fish-mode))

;;------------------------------

;; https://github.com/rranelli/auto-package-update.el
;; Automatically update Emacs packages.
;;(use-package auto-package-update
;;  :ensure t
;;  :config
;;  (setq auto-package-update-delete-old-versions t
;;        auto-package-update-interval 30)
;;  (auto-package-update-maybe))
;;
;;------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow-theme use-package markdown-mode ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; init.el ends here

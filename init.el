(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; hacking packages
(add-to-list 'load-path "~/.emacs.d/hacks")
(load "smart-theme")
(load "hdfb")

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq user-full-name "Xiaoyue Chen")
(setq user-mail-address "xiaoyue.chen.0484@student.uu.se")

(global-set-key (kbd "C-c v") 'view-mode)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(fringe-mode 16)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq x-underline-at-descent-line t)
(setq backup-by-copying t)
(global-auto-revert-mode)
(global-visual-line-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(delete-selection-mode)
(setq show-paren-delay 0)
(show-paren-mode)
(electric-pair-mode)
(add-hook 'ibuffer-mode-hook 'ibuffer-auto-mode)
(setq gdb-many-windows t)
(which-key-mode)

;; flymake
(setq flymake-error-bitmap '(hdfb-double-exclamation-mark compilation-error))
(setq flymake-warning-bitmap '(hdfb-exclamation-mark compilation-warning))
(setq flymake-note-bitmap '(hdfb-exclamation-mark compilation-info))
(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "C-c e n") 'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "C-c e p") 'flymake-goto-prev-error)
  (define-key flymake-mode-map (kbd "C-c e l") 'flymake-show-diagnostics-buffer))

;; eldoc
(eldoc-add-command 'c-electric-paren)

;; magit
(setq magit-section-visibility-indicator
      '(hdfb-plus . hdfb-minus))
(defun my-magit-mode-hook ()
  (setq left-fringe-width 32))
(add-hook 'magit-mode-hook 'my-magit-mode-hook)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

;; vterm
(setq vterm-buffer-name-string "vterm %s")

;; company
(setq company-minimum-prefix-length 2
      company-idle-delay 0.0)

;; yasnippet
(with-eval-after-load 'yasnippet
  (yas-reload-all))

;; eglot
(setq eglot-confirm-server-initiated-edits nil)
(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c f") 'eglot-format)
  (define-key eglot-mode-map (kbd "C-c a") 'eglot-code-actions)
  (add-to-list
   'eglot-server-programs
   '((c-mode c++mode) .
     ("clangd" "-background-index" "-clang-tidy" "-completion-style=detailed"
      "-cross-file-rename" "-header-insertion=iwyu"
      "-header-insertion-decorators")))
  (add-to-list 'eglot-server-programs '(java-mode . ("jdtls")))
  (add-to-list 'eglot-server-programs '(csharp-mode . ("omnisharp" "-lsp")))
  (add-to-list 'eglot-server-programs '(cmake-mode . ("cmake-language-server"))))

;; compilation buffer
(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(defun my-emacs-lisp-mode-hook ()
  (flymake-mode))
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

(defun my-text-mode-hook ()
  (flyspell-mode))
(add-hook 'text-mode-hook 'my-text-mode-hook)

(defun my-prog-mode-hook ()
  (flyspell-prog-mode)
  (company-mode))
(add-hook 'prog-mode-hook 'my-prog-mode-hook)

(defun my-c-mode-common-hook ()
  (c-toggle-electric-state 1)
  (c-toggle-auto-newline 1))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-c-mode-hook ()
  (yas-minor-mode)
  (eglot-ensure))
(add-hook 'c-mode-hook 'my-c-mode-hook)

(defun my-c++-mode-hook ()
  (yas-minor-mode)
  (eglot-ensure))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(defun my-java-mode-hook ()
  (yas-minor-mode)
  (eglot-ensure))
(add-hook 'java-mode-hook 'my-java-mode-hook)

(defun my-csharp-mode-hook ()
  (yas-minor-mode)
  (eglot-ensure))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

(defun my-python-mode-hook ()
  (yas-minor-mode)
  (eglot-ensure))
(add-hook 'python-mode-hook 'my-python-mode-hook)

(add-to-list 'auto-mode-alist '("\\.mzn\\'" . minizinc-mode))

(pdf-loader-install)
(defun my-pdf-view-mode-hook ()
  (pdf-view-themed-minor-mode))
(add-hook 'pdf-view-mode-hook 'my-pdf-view-mode-hook)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

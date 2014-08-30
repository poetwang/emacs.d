(desktop-save-mode 0)


;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; 不要 toolbar
(if (functionp 'tool-bar-mode) (tool-bar-mode 0))

;; tab 默认为四个空格
(setq default-tab-width 4)

;; c/c++ style
(setq c-default-style
      '((other . "stroustrup")))

(global-set-key (kbd "C-z") 'undo)

;; 用于 代码折叠
(defun toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (or column
       (unless selective-display
         (1+ (current-column))))))
(defun toggle-hiding (column)
  (interactive "P")
  (if hs-minor-mode
      (if (condition-case nil
              (hs-toggle-hiding)
            (error t))
          (hs-show-all))
    (toggle-selective-display column)))

(defun all-toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))
(defun func-toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 5)))
(global-set-key [f1] 'all-toggle-selective-display)
(global-set-key [f2] 'func-toggle-selective-display)


(global-set-key (kbd "C-+") 'toggle-hiding)
(global-set-key (kbd "C-\\") 'toggle-selective-display)

(defadvice goto-line (after expand-after-goto-line
                            activate compile)
  "hideshow-expand affected block when using goto-line in a collapsed buffer"
  (save-excursion
    (hs-show-block)))

(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'shell-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'scala-mode-hook 'hs-minor-mode)
(add-hook 'javascript-mode-hook 'hs-minor-mode)
(add-hook 'go-mode-hook 'hs-minor-mode)

(global-set-key [C-left] 'hs-hide-block)
(global-set-key [C-right] 'hs-show-block)
(global-set-key [C-S-left] 'hs-hide-all)
(global-set-key [C-S-right] 'hs-show-all)



;; winner mode 用于在多个窗口间快速切换
(winner-mode)
(windmove-default-keybindings)

;;以 y/n 替代 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(prefer-coding-system 'utf-8)
(prefer-coding-system 'chinese-gbk)
(prefer-coding-system 'gb2312)


(custom-set-variables '(show-trailing-whitespace t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(c-basic-offset 4)
 '(c-tab-always-indent t)
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(load-home-init-file t t)
 '(show-paren-mode t nil (paren))
 '(tab-width 4)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tooltip-gud-tips-p t)
 '(ido-show-dot-for-dired t)
 '(ido-enable-last-directory-history nil)
 '(ido-record-commands nil)
 '(ido-max-work-directory-list 0)
 '(ido-max-work-file-list 0)
 '(x-select-enable-clipboard t))

(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
;; 配置 color theme
(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(defun apply-color-theme (frame)
  "Apply color theme to a frame based on whether its a 'real'
   window or a console window."
  (select-frame frame)
  (color-theme-clarity))
(add-hook 'after-make-frame-functions 'apply-color-theme)
(color-theme-clarity)

(add-to-list 'load-path "~/.emacs.d/ace-jump-mode")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;; 加载 cscope mode
(defun load_cscope()
   (load "xcscope.el")
   (cscope-setup))

(add-hook 'c-mode-hook 'load_cscope)

(global-set-key (kbd "M-<left>") 'backward-word)
(global-set-key (kbd "M-<right>") 'forward-word)

;(set-fontset-font
;    (frame-parameter nil 'font)
;    'han
;    (font-spec :family "Hiragino Sans GB" ))

(if (display-graphic-p)
    (set-fontset-font
     (frame-parameter nil 'font)
     'han
     (font-spec :family "SimHei" ))
  )
;; 如果出现中文字体显示为方框的问题，介入 M-x correct-fontset 即可
(defun correct-fontset ()
  (interactive)
  (set-fontset-font (frame-parameter nil 'font)
                  'han ("WenQuanYi Bitmap Song" . "unicode-bmp")))


(when (eq window-system 'ns)
  (setq initial-frame-alist '((top .15) (left . 30)   (width . 90) (height . 45)))
  (setq default-frame-alist
        '((height . 45) (width . 90) (menu-bar-lines . 20) (tool-bar-lines . 0)))

  (defadvice ns-get-pasteboard (around hack-empty-pasteboard compile activate)
    (condition-case err
        ad-do-it
      (quit (message "%s" (cadr err))
            nil))))


(add-hook 'html-mode-hook
  (lambda () (setq truncate-lines nil)))

(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

;(setq epy-load-yasnippet-p t)
;(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
;(epy-setup-checker "pyflakes %f")
;(epy-django-snippets)


(setq initial-frame-alist '((top .20) (left . 100)   (width . 100) (height . 60)))
(setq default-frame-alist
      '((height . 60) (width . 100) (menu-bar-lines . 0) (tool-bar-lines . 0)))

(provide 'init-local)

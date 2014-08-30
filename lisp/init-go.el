(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(unless (package-installed-p 'go-mode)
  (package-refresh-contents) (package-install 'go-mode))

(unless (package-installed-p 'auto-complete)
  (package-refresh-contents) (package-install 'auto-complete))

(unless (package-installed-p 'go-autocomplete)
  (package-refresh-contents) (package-install 'go-autocomplete))

(unless (package-installed-p 'company-go)
  (package-refresh-contents) (package-install 'company-go))

(add-to-list 'load-path "~/dev/gocode/src/github.com/dougm/goflymake")

(defun load_go()
  (local-set-key (kbd "C-c s-i") 'go-goto-imports)
  (local-set-key (kbd "C-c s-g") 'godef-jump)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (local-set-key (kbd "C-c C-f") 'gofmt)
  (local-set-key (kbd "C-c C-k") 'godoc)
  (setq tab-width 8 indent-tabs-mode 1)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (require 'go-flymake)
  (require 'go-flycheck)
  (require 'go-autocomplete)
  (require 'auto-complete-config)
  )
(add-hook 'go-mode-hook 'load_go)

(provide 'init-go)

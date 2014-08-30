(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(unless (package-installed-p 'js2-mode)
  (package-refresh-contents) (package-install 'js2-mode))

(unless (package-installed-p 'ac-js2)
  (package-refresh-contents) (package-install 'ac-js2))


(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(provide 'init-js)

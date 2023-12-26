(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)

(load-library "view")
(require 'cc-mode)
(require 'ido)
(require 'compile)
(ido-mode t)

(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

(setq global-hl-line-mode nil)

(define-key global-map "\ef" 'find-file)
(define-key global-map "\eF" 'find-file-other-window)

(global-set-key (read-kbd-macro "\eb")  'ido-switch-buffer)
(global-set-key (read-kbd-macro "\eB")  'ido-switch-buffer-other-window)

(setq auto-mode-alist
      (append
       '(("\\.cpp$"    . c++-mode)
         ("\\.hin$"    . c++-mode)
         ("\\.cin$"    . c++-mode)
         ("\\.inl$"    . c++-mode)
         ("\\.rdc$"    . c++-mode)
         ("\\.h$"    . c++-mode)
         ("\\.c$"   . c++-mode)
         ("\\.cc$"   . c++-mode)
         ("\\.c8$"   . c++-mode)
         ("\\.txt$" . indented-text-mode)
         ("\\.emacs$" . emacs-lisp-mode)
         ("\\.gen$" . gen-mode)
         ("\\.ms$" . fundamental-mode)
         ("\\.m$" . objc-mode)
         ("\\.mm$" . objc-mode)
         ) auto-mode-alist))

(setq tab-width 4
      indent-tabs-mode nil)

(c-set-offset 'member-init-intro '++)

(abbrev-mode 1)

(define-key global-map [C-right] 'forward-word)
(define-key global-map [C-left] 'backward-word)
(define-key global-map [C-up] 'previous-blank-line)
(define-key global-map [C-down] 'next-blank-line)
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)
(define-key global-map [pgup] 'forward-page)
(define-key global-map [pgdown] 'backward-page)
(define-key global-map [C-next] 'scroll-other-window)
(define-key global-map [C-prior] 'scroll-other-window-down)

(setq scroll-step 3)

(display-time)

(setq next-line-add-newlines nil)
(setq-default truncate-lines t)
(setq truncate-partial-width-windows nil)
(split-window-horizontally)

(define-key global-map "\er" 'revert-buffer)
(define-key global-map "\ek" 'kill-this-buffer)
(define-key global-map "\es" 'save-buffer)

(define-key global-map "\eu" 'undo)
(define-key global-map "\e6" 'upcase-word)
(define-key global-map "\e^" 'capitalize-word)
(define-key global-map "\e." 'fill-paragraph)

(custom-set-variables
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7" default))
 '(package-selected-packages '(ace-window neotree evil gruber-darker-theme)))

(custom-set-faces
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#181818" :foreground "#e4e4ef" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 116 :width normal :foundry "outline" :family "Fira Mono")))))

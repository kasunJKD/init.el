(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

(setq global-hl-line-mode nil)
; (set-face-background 'hl-line "#072627")

(setq compilation-directory-locked nil)
(scroll-bar-mode -1)
(setq shift-select-mode nil)
(setq enable-local-variables nil)

; Turn off the toolbar
(tool-bar-mode 0)

(load-library "view")
(require 'cc-mode)
(require 'ido)
(require 'compile)
(ido-mode t)

; Setup my find-files
(define-key global-map "\ef" 'find-file)
(define-key global-map "\eF" 'find-file-other-window)

(global-set-key (read-kbd-macro "\eb")  'ido-switch-buffer)
(global-set-key (read-kbd-macro "\eB")  'ido-switch-buffer-other-window)

(defun casey-ediff-setup-windows (buffer-A buffer-B buffer-C control-buffer)
  (ediff-setup-windows-plain buffer-A buffer-B buffer-C control-buffer)
)
(setq ediff-window-setup-function 'casey-ediff-setup-windows)
(setq ediff-split-window-function 'split-window-horizontally)

; no screwing with my middle mouse button
(global-unset-key [mouse-2])

; Accepted file extensions and their appropriate modes
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

 ; 4-space tabs
  (setq tab-width 4
        indent-tabs-mode nil)

  ; Additional style stuff
  (c-set-offset 'member-init-intro '++)

  ; Newline indents, semi-colon doesn't
  (define-key c++-mode-map "\C-m" 'newline-and-indent)
  (setq c-hanging-semi&comma-criteria '((lambda () 'stop)))

  ; Handle super-tabbify (TAB completes, shift-TAB actually tabs)
  (setq dabbrev-case-replace t)
  (setq dabbrev-case-fold-search t)
  (setq dabbrev-upcase-means-case-search t)

  ; Abbrevation expansion
  (abbrev-mode 1)

(defun casey-find-corresponding-file ()
    "Find the file that corresponds to this one."
    (interactive)
    (setq CorrespondingFileName nil)
    (setq BaseFileName (file-name-sans-extension buffer-file-name))
    (if (string-match "\\.c" buffer-file-name)
       (setq CorrespondingFileName (concat BaseFileName ".h")))
    (if (string-match "\\.h" buffer-file-name)
       (if (file-exists-p (concat BaseFileName ".c")) (setq CorrespondingFileName (concat BaseFileName ".c"))
	   (setq CorrespondingFileName (concat BaseFileName ".cpp"))))
    (if (string-match "\\.hin" buffer-file-name)
       (setq CorrespondingFileName (concat BaseFileName ".cin")))
    (if (string-match "\\.cin" buffer-file-name)
       (setq CorrespondingFileName (concat BaseFileName ".hin")))
    (if (string-match "\\.cpp" buffer-file-name)
       (setq CorrespondingFileName (concat BaseFileName ".h")))
    (if CorrespondingFileName (find-file CorrespondingFileName)
       (error "Unable to find a corresponding file")))
  (defun casey-find-corresponding-file-other-window ()
    "Find the file that corresponds to this one."
    (interactive)
    (find-file-other-window buffer-file-name)
    (casey-find-corresponding-file)
    (other-window -1))
  (define-key c++-mode-map [f12] 'casey-find-corresponding-file)
  (define-key c++-mode-map [M-f12] 'casey-find-corresponding-file-other-window)

  ; Alternate bindings for F-keyless setups (ie MacOS X terminal)
  (define-key c++-mode-map "\ec" 'casey-find-corresponding-file)
  (define-key c++-mode-map "\eC" 'casey-find-corresponding-file-other-window)

(define-key c++-mode-map "\es" 'casey-save-buffer)

  (define-key c++-mode-map "\t" 'dabbrev-expand)
  (define-key c++-mode-map [S-tab] 'indent-for-tab-command)
  (define-key c++-mode-map "\C-y" 'indent-for-tab-command)
  (define-key c++-mode-map [C-tab] 'indent-region)
  (define-key c++-mode-map "	" 'indent-region)

  (define-key c++-mode-map "\ej" 'imenu)

  (define-key c++-mode-map "\e." 'c-fill-paragraph)

  (define-key c++-mode-map "\e/" 'c-mark-function)

  (define-key c++-mode-map "\e " 'set-mark-command)
  (define-key c++-mode-map "\eq" 'append-as-kill)
  (define-key c++-mode-map "\ea" 'yank)
(define-key c++-mode-map "\ez" 'kill-region)

(defun maximize-frame ()
    "Maximize the current frame"
     (interactive)
     (when casey-aquamacs (aquamacs-toggle-full-frame))
     (when casey-win32 (w32-send-sys-command 61488)))

(define-key global-map "\ep" 'maximize-frame)
(define-key global-map "\ew" 'other-window)

; Navigation
(defun previous-blank-line ()
  "Moves to the previous line containing nothing but whitespace."
  (interactive)
  (search-backward-regexp "^[ \t]*\n")
)

(defun next-blank-line ()
  "Moves to the next line containing nothing but whitespace."
  (interactive)
  (forward-line)
  (search-forward-regexp "^[ \t]*\n")
  (forward-line -1)
)

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

; ALT-alternatives
(defadvice set-mark-command (after no-bloody-t-m-m activate)
  "Prevent consecutive marks activating bloody `transient-mark-mode'."
  (if transient-mark-mode (setq transient-mark-mode nil)))

(defun append-as-kill ()
  "Performs copy-region-as-kill as an append."
  (interactive)
  (append-next-kill) 
  (copy-region-as-kill (mark) (point))
)

(define-key global-map "\e:" 'View-back-to-mark)
(define-key global-map "\e;" 'exchange-point-and-mark)

(define-key global-map [f9] 'first-error)
(define-key global-map [f10] 'previous-error)
(define-key global-map [f11] 'next-error)

(define-key global-map "\en" 'next-error)
(define-key global-map "\eN" 'previous-error)

(define-key global-map "\eg" 'goto-line)
(define-key global-map "\ej" 'imenu)

(define-key global-map "\e " 'set-mark-command)
(define-key global-map "\eq" 'append-as-kill)
(define-key global-map "\ea" 'yank)
(define-key global-map "\ez" 'kill-region)

; Editting
(define-key global-map "" 'copy-region-as-kill)
(define-key global-map "" 'yank)
(define-key global-map "" 'nil)
(define-key global-map "" 'rotate-yank-pointer)
(define-key global-map "\eu" 'undo)
(define-key global-map "\e6" 'upcase-word)
(define-key global-map "\e^" 'captilize-word)
(define-key global-map "\e." 'fill-paragraph)


(defun casey-replace-in-region (old-word new-word)
  "Perform a replace-string in the current region."
  (interactive "sReplace: \nsReplace: %s  With: ")
  (save-excursion (save-restriction
		    (narrow-to-region (mark) (point))
		    (beginning-of-buffer)
		    (replace-string old-word new-word)
		    ))
  )
(define-key global-map "\el" 'casey-replace-in-region)

(define-key global-map "\eo" 'query-replace)
(define-key global-map "\eO" 'casey-replace-string)

; \377 is alt-backspace
(define-key global-map "\377" 'backward-kill-word)
(define-key global-map [M-delete] 'kill-word)

(define-key global-map "\e[" 'start-kbd-macro)
(define-key global-map "\e]" 'end-kbd-macro)
(define-key global-map "\e'" 'call-last-kbd-macro)

; Buffers
(define-key global-map "\er" 'revert-buffer)
(define-key global-map "\ek" 'kill-this-buffer)
(define-key global-map "\es" 'save-buffer)

; Smooth scroll
(setq scroll-step 3)

; Clock
(display-time)

; Startup windowing
(setq next-line-add-newlines nil)
(setq-default truncate-lines t)
(setq truncate-partial-width-windows nil)
(split-window-horizontally)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#d3b58d" :background "#041818"))))
 '(custom-group-tag-face ((t (:underline t :foreground "lightblue"))) t)
 '(custom-variable-tag-face ((t (:underline t :foreground "lightblue"))) t)
 '(font-lock-builtin-face ((t nil)))
 ; '(font-lock-comment-face ((t (:foreground "yellow"))))
 '(font-lock-comment-face ((t (:foreground "#3fdflf"))))
 '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "white")))) 
 '(font-lock-keyword-face ((t (:foreground "white" ))))
 ; '(font-lock-string-face ((t (:foreground "gray160" :background "gray16"))))
 '(font-lock-string-face ((t (:foreground "#0fdfaf"))))
 '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#c8d4ec"))))  
; '(font-lock-warning-face ((t (:foreground "#695a46"))))
 '(font-lock-warning-face ((t (:foreground "#504038"))))
 '(highlight ((t (:foreground "navyblue" :background "darkseagreen2"))))
 '(mode-line ((t (:inverse-video t))))
 '(region ((t (:background "blue"))))
 '(widget-field-face ((t (:foreground "white"))) t)
 '(widget-single-line-field-face ((t (:background "darkgray"))) t))

(global-font-lock-mode 1)
(set-cursor-color "lightgreen")
(set-background-color "#072626")
(global-set-key [C-return] 'save-buffer)

;(set-face-attribute 'default nil :font "Anonymous Pro-14")
(set-face-attribute 'default nil :font "Consolas-14")

(set-face-foreground 'font-lock-builtin-face         "lightgreen")

(define-key global-map "\t" 'dabbrev-expand)
(define-key global-map [S-tab] 'indent-for-tab-command)
(define-key global-map [backtab] 'indent-for-tab-command)
(define-key global-map "\C-y" 'indent-for-tab-command)
(define-key global-map [C-tab] 'indent-region)
(define-key global-map "	" 'indent-region)


  (interactive)
  (menu-bar-mode -1)
  ;; (maximize-frame)
  (set-foreground-color "#A99063")
  (set-background-color "#072627")
 ;  (set-cursor-color "#9FE99A")

(setq vendor-dir (concat dotfiles-dir "/vendor/"))
(add-to-list 'load-path (concat vendor-dir))
(require 'textmate)
(textmate-mode)

(setq ns-pop-up-frames nil)

;; Font
(set-face-font 'default "-apple-menlo-medium-r-normal--11-0-72-72-m-0-iso10646-1")


;; Color Themes
(add-to-list 'load-path (concat vendor-dir "/color-theme"))
(require 'color-theme)
(color-theme-initialize)

;; Activate theme
(load (concat dotfiles-dir "vendor/color-theme-ir-black/color-theme-ir-black.el"))
(color-theme-ir-black)

;; YASnippet
(add-to-list 'load-path (concat vendor-dir "/yasnippet"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat vendor-dir "/yasnippet/snippets"))

(yas/load-directory (concat vendor-dir "yasnippets-rails"))
;;; window-numbering-mode
(require 'window-number)
(autoload 'window-number-mode "window-number"
  "A global minor mode that enables selection of windows according to
numbers with the C-x C-j prefix.  Another mode,
`window-number-meta-mode' enables the use of the M- prefix."
  t)

(autoload 'window-number-meta-mode "window-number"
  "A global minor mode that enables use of the M- prefix to select
windows, use `window-number-mode' to display the window numbers in
the mode-line."
  t)
(window-number-mode 1)
(window-number-meta-mode 1)

(add-to-list 'load-path (concat vendor-dir "feature-mode"))
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; Full screen toggle
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                         'fullboth)))
(global-set-key (kbd "M-n") 'toggle-fullscreen)

;; Use Mac OS commnd key + arrows for next, previous input
;; (add-hook 'comint-mode-hook
;;          (lambda ()
;;            (define-key comint-mode-map (kbd "s-<down>") 'comint-next-input)
;;            (define-key comint-mode-map (kbd "s-<up>") 'comint-previous-input)
;;            ))


(load (concat dotfiles-dir "vendor/rdoc-mode.el"))
(require 'rdoc-mode)


;; 2010-01-11 de add rinari
(add-to-list 'load-path (concat dotfiles-dir "/vendor/rinari"))
(require 'rinari)


(add-to-list 'load-path (concat vendor-dir "/rhtml"))
(require 'rhtml-mode)

(require 'rvm)

(rvm-use-default) ;; use rvm’s default ruby for the current Emacs session

;; Try just the arrow keys for next, previous input
(add-hook 'comint-mode-hook
         (lambda ()
           (define-key comint-mode-map (kbd "<down>") 'comint-next-input)
           (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
           ))

(global-set-key [f5] 'call-last-kbd-macro)

(require 'defshell)

;; RAILS SESSION
;; do all the stuff needed to have a rails editing session:
;; -- Get the correct dir from the user
;; -- cd to that dir
;; -- Create shells with the following names:
;;      *spec*
;;      *psql*
;;      *console*
;;      *shell*
;; -- Load the corresponding rvm
;; -- launch rinari
;; -- launch a web server instance
;;
(defun de-rails-session (directory)
  "Start a rails progrmming session in DIRECTORY."
  (interactive "D")
  (cd directory)
  (bash)
  (rename-buffer "*spec*")
  (bash)
  (rename-buffer "*psql*")
  (bash)
  (rename-buffer "*console*")
  (bash)
  (rename-buffer "*gems*")
  (bash)
  (rename-buffer "*jobs*")
  (bash)
  (rename-buffer "*shell*")
  (rvm-activate-corresponding-ruby)
  (rinari-launch)
  (rinari-web-server)
  )


(defun maximize-frame () 
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))

(global-set-key (kbd "<s-S-return>") 'maximize-frame)

;; open multiple marked files in dired
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))))

;; (eval-after-load "ispell"
;;   (progn
;;     (setq ispell-dictionary "en_US"
;;           ispell-silently-savep t)))
;; (setq-default ispell-program-name "aspell")

(setq-default ispell-program-name "aspell")

(if (eq system-type 'darwin)
    (setq exec-path
          (append 
           '("/usr/local/bin")
           exec-path)))

;; COFFEE-MODE
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)


;; ORG MODE
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
; (add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

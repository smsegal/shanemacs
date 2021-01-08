;; -*- lexical-binding: t; -*-

;;; Keybindings
;; Using ~general.el~ for easily setting up keybindings
;; ~general.el~ lets us pretty easily set up keybindings and keymaps, and
;; is used extensively throughout the rest of this configuration.

;; Here, I'm setting up the top-level keybindings and leader keys. I'll
;; bind to these keymaps in the relevant packages later.

;; Set up evil-mode ahead of general.el

(use-package undo-fu)
(use-package evil
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-ex-substitute-global t)
  (evil-respect-visual-line-mode t)
  (evil-want-Y-yank-to-eol t)
  (evil-cross-lines nil)
  (evil-split-window-below t)
  (evil-vsplit-window-right t)
  (evil-undo-system 'undo-fu)
  (evil-regexp-search t)
  (evil-move-cursor-back t)
  (evil-undo-system 'undo-fu)
  :config
  (evil-select-search-module 'evil-search-module 'evil-search)
  (evil-mode +1))

;; Apparently ~undo-tree~ has had it's performance improved, will try it again sometime
(use-package undo-tree
  :disabled
  :custom (evil-undo-system 'undo-tree)
  :config (global-undo-tree-mode +1))


(use-package general
  :after evil
  :custom
  (general-override-states
   '(insert emacs hybrid normal visual motion operator replace))
  :config
  (general-evil-setup)

  ;; text indentation stuff
  (general-add-hook (list 'prog-mode-hook 'text-mode-hook)
                    (lambda () (setq-local indent-tabs-mode nil)))

  ;; (general-add-advice #'evil-force-normal-state :after #'evil-escape)

  ;; leader key setup
  (general-create-definer +leader-def
    :prefix "SPC"
    :keymaps 'override
    :states '(normal visual))

  ;; local leader
  (general-create-definer +local-leader-def
    :prefix ","
    :keymaps 'override
    :states '(normal visual))

  (general-def :prefix-map '+file-map
    "f" #'find-file
    "s" #'save-buffer)

  (general-def :prefix-map '+code-map
    "e" #'eval-buffer)

  (general-def :prefix-map '+quit-restart-map
    "q" 'save-buffers-kill-emacs
    "r" 'restart-emacs)

  (general-def :prefix-map '+buffer-map
    :wk-full-keys nil
    "p" 'previous-buffer
    "n" 'next-buffer
    "r" 'revert-buffer
    "k" 'kill-this-buffer)

  (general-def :prefix-map '+vc-map)
  (general-def :prefix-map '+insert-map)
  (general-def :prefix-map '+open-map
    "f" 'make-frame)
  (general-def :prefix-map '+toggle-map)
  (general-def :prefix-map '+search-map)
  (general-def :prefix-map '+bookmark-map
    :wk-full-keys nil)
  (general-def :prefix-map '+narrow/notes-map)

  (+leader-def
    "SPC" '(execute-extended-command :which-key "M-x")
    "u" 'universal-argument
    "w" '(:keymap evil-window-map :which-key "windows")
    "b" '(:keymap +buffer-map :which-key "buffers")
    "B" '(:keymap +bookmark-map :which-key "bookmarks")
    "q" '(:keymap +quit-restart-map :which-key "quit/restart")
    "c" '(:keymap +code-map :which-key "code")
    "g" '(:keymap +vc-map :which-key "vc/git")
    "f" '(:keymap +file-map :which-key "files")
    "i" '(:keymap +insert-map :which-key "insert")
    "o" '(:keymap +open-map :which-key "open")
    "s" '(:keymap +search-map :which-key "search")
    "n" '(:keymap +narrow/notes-map :which-key "narrow/notes")
    "t" '(:keymap +toggle-map :which-key "toggle")
    "h" '(:keymap help-map :which-key "help")))

(provide '+core-keys)
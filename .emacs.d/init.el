;;; 文字コード
(set-default-coding-systems 'utf-8)

;;optionキーをmetaに
(setq mac-option-modifier 'meta)

;; delete key
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;;; 行番号・桁番号をモードラインに表示する・しない設定
(line-number-mode t) ; 行番号
(column-number-mode t) ; 桁番号

;;;カーソルのハイライト
(show-paren-mode 1)
;;;自動インデント
(setq indent-line-function 'indent-relative-maybe)
;; 初期フレームの設定
(setq default-frame-alist
      (append (list '(foreground-color . "white")
		    '(background-color . "black")
		    '(border-color . "white")
		    '(mouse-color . "white")
		    '(cursor-color . "white")
		    '(width . 85)
		    '(height . 50)
		    '(top . 50)
		    '(left . 50)
		    )))

;;バックアップをけす
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;;YATEX
(setq load-path 
      (cons (expand-file-name "/Applications/MacPorts/Emacs.app/Contents/Resources/site-lisp/yatex")
	    load-path))
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;(if (eq window-system 'mac)
;    (carbon-emacs-package-add-to-path '("/sw/bin")))
;; CarbonEmacsAndYatexより
;(setq tex-command "/usr/local/bin/platex")
;(setq tex-command "~/Library/TeXShop/bin/platex2pdf-sjis" 
;      dvi2-command "open -a TeXShop")
;
;; utf-8
(setq tex-command "/opt/local/bin/platex")
(setq tex-command "/Users/ishigaki/Library/TeXShop/bin/platex2pdf-utf8" 
      dvi2-command "open -a TeXShop")


(setq YaTeX-kanji-code 4)

(setenv "PATH" 
(concat "/Applications/Tools/pTeX.app/teTeX/bin:/opt/local/bin:~/bin:" (getenv "PATH")))

;; AMS math
(setq YaTeX-use-AMS-LaTeX t)

(setq yatex-mode-load-hook
'(lambda()
;; (YaTeX-define-begend-key "be" "eqnarray")
 (YaTeX-define-begend-key "be" "enumerate")
;; (YaTeX-define-begend-key "bt" "tabular")
 (YaTeX-define-begend-key "bf" "figure")
 (YaTeX-define-begend-key "ba" "align")
)
)

;;Word Count
(setq load-path (cons (expand-file-name "~/elisp") load-path))
(autoload 'word-count-mode "word-count"
          "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)


;;
;; Fortran のキーワードの設定
;;

;;(add-hook 'f90-mode-hook 'turn-on-auto-fill)
;;(add-hook 'f90-mode-hook '(lambda () (abbrev-mode 1)))

(add-hook 'fortran-mode-hook
	  '(lambda ()
	     (abbrev-mode 1)
	     (auto-fill-mode 1)
	     (setq fill-column 72)))


(setq auto-mode-alist
      (append auto-mode-alist
	      (list '("\\.F90$" . f90-mode))
	      ))

(add-hook 'f90-mode-hook
	   '(lambda () 
	      (setq indent-tabs-mode nil)
	      (setq f90-beginning-ampersand t)
;;	      (setq f90-font-lock-keywords f90-font-lock-keywords-3) 
	      (abbrev-mode 1) 
	      (setq fill-column 132) 
	      (auto-fill-mode 1) 
;;;;;;	      (turn-on-font-lock)
	      ))

;;=============================================================;;
;; C mode
;; c-mode, c++-mode
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;;; K&R のスタイルを使う
;             (c-set-style "k&r")
             ;;; インデントには tab を使う
             (setq indent-tabs-mode t)
             ;;; インデント幅
             (setq c-basic-offset 4)
             ))

(setq auto-mode-alist
      ;;; 拡張子とモードの対応
      (append
       '(("\\.c$" . c-mode))
       '(("\\.h$" . c-mode))
       '(("\\.cpp$" . c++-mode))
       auto-mode-alist))
;;=============================================================;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gnuplot
;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))


;; drag and drop
(define-key global-map [ns-drag-file] 'ns-find-file)
(setq ns-pop-up-frames nil)


;;; font 日本語
(create-fontset-from-ascii-font "monaco-13:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 13 :weight 'bold)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;(when (>= emacs-major-version 23)
; (set-face-attribute 'default nil
;                     :family "monaco"
;                     :height 120)
; (set-fontset-font
;  (frame-parameter nil 'font)
;  'japanese-jisx0208
;  '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
; (set-fontset-font
;  (frame-parameter nil 'font)
;  'japanese-jisx0212
;  '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
; (set-fontset-font
;  (frame-parameter nil 'font)
;  'mule-unicode-0100-24ff
;  '("monaco" . "iso10646-1"))
; (setq face-font-rescale-alist
;      '(("^-apple-hiragino.*" . 1.2)
;        (".*osaka-bold.*" . 1.2)
;        (".*osaka-medium.*" . 1.2)
;        (".*courier-bold-.*-mac-roman" . 1.0)
;        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;        (".*monaco-bold-.*-mac-roman" . 0.9)
;        ("-cdac$" . 1.3))))
;

;;; magit
(require 'magit)


;; compile
(setq compilation-scroll-output t)

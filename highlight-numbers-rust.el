;;; highlight-numbers-python.el --- -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2017 Yevgnen Koh
;;
;; Author: Yevgnen Koh <wherejoystarts@gmail.com>
;; Version: 0.0.1
;; Keywords:
;; Package-Requires: ((emacs "25.1") (highlight-numbers "0.2.3"))
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;;
;;

;;; Code:

(require 'highlight-numbers)

;; https://doc.rust-lang.org/reference/tokens.html#integer-literals
(defvar highlight-numbers-rust-bin-digit '(any "01"))
(defvar highlight-numbers-rust-oct-digit '(any "0-7"))
(defvar highlight-numbers-rust-dec-digit '(any "0-9"))
(defvar highlight-numbers-rust-hex-digit '(any "0-9" "a-f" "A-F"))

(defvar highlight-numbers-rust-integer-suffix
  '(and (any "ui")
        (or "8" "16" "32" "64" "128" "size")))

(defvar highlight-numbers-rust-bin-literal
  '(and "0b"
        (0+ (or "_" (eval highlight-numbers-rust-bin-digit)))
        (eval highlight-numbers-rust-bin-digit)
        (0+ (or "_" (eval highlight-numbers-rust-bin-digit)))))

(defvar highlight-numbers-rust-hex-literal
  '(and "0x"
        (0+ (or "_" (eval highlight-numbers-rust-hex-digit)))
        (eval highlight-numbers-rust-hex-digit)
        (0+ (or "_" (eval highlight-numbers-rust-hex-digit)))))

(defvar highlight-numbers-rust-oct-literal
  '(and "0o"
        (0+ (or "_" (eval highlight-numbers-rust-oct-digit)))
        (eval highlight-numbers-rust-oct-digit)
        (0+ (or "_" (eval highlight-numbers-rust-oct-digit)))))

(defvar highlight-numbers-rust-dec-literal
  '(and (eval highlight-numbers-rust-dec-digit)
        (0+ (or "_" (eval highlight-numbers-rust-dec-digit)))))

(defvar highlight-numbers-rust-integer-literal
  '(and (or (eval highlight-numbers-rust-dec-literal)
            (eval highlight-numbers-rust-bin-literal)
            (eval highlight-numbers-rust-oct-literal)
            (eval highlight-numbers-rust-hex-literal))
        (? (eval highlight-numbers-rust-integer-suffix))))

;; https://doc.rust-lang.org/reference/tokens.html#floating-point-literals
(defvar highlight-numbers-rust-float-suffix
  '(or "f32" "f64"))

(defvar highlight-numbers-rust-float-exponent
  '(and (any "eE")
        (? (any "-+"))
        (0+ (or "_" (eval highlight-numbers-rust-dec-digit)))
        (eval highlight-numbers-rust-dec-digit)
        (0+ (or "_" (eval highlight-numbers-rust-dec-digit)))))

(defvar highlight-numbers-rust-float-literal
  '(or
    (and (eval highlight-numbers-rust-dec-literal) ".")
    (and (eval highlight-numbers-rust-dec-literal)
         (eval highlight-numbers-rust-float-exponent))
    (and (eval highlight-numbers-rust-dec-literal)
         "."
         (eval highlight-numbers-rust-dec-literal)
         (? (eval highlight-numbers-rust-float-exponent)))
    (and (eval highlight-numbers-rust-dec-literal)
         (? (and "." (eval highlight-numbers-rust-dec-literal)))
         (? (eval highlight-numbers-rust-float-exponent))
         (eval highlight-numbers-rust-float-suffix))))

(defvar highlight-numbers-rust
  (eval '(rx (and symbol-start
                  (or (eval highlight-numbers-rust-integer-literal)
                      (eval highlight-numbers-rust-float-literal))
                  symbol-end))))

(dolist (mode '(rustic-mode rust-mode))
  (puthash mode highlight-numbers-rust highlight-numbers-modelist))

(provide 'highlight-numbers-rust)

;;; highlight-numbers-python.el ends here

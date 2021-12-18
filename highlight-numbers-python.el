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

;; https://docs.python.org/3/reference/lexical_analysis.html#numeric-literals
(defvar highlight-numbers-py-bindigit '(any "01"))
(defvar highlight-numbers-py-octdigit '(any "0-7"))
(defvar highlight-numbers-py-hexdigit '(any "0-9" "a-f" "A-F"))
(defvar highlight-numbers-py-nonzerodigit '(any "1-9"))
(defvar highlight-numbers-py-decinteger
  '(or (and (eval highlight-numbers-py-nonzerodigit)
            (0+ (and (? "_") digit)))
       (and (1+ "0") (0+ (and (? "_") "0")))))
(defvar highlight-numbers-py-bininteger
  '(and "0" (any "bB") (1+ (and (? "_") (eval highlight-numbers-py-bindigit)))))
(defvar highlight-numbers-py-octinteger
  '(and "0" (any "oO") (1+ (and (? "_") (eval highlight-numbers-py-octdigit)))))
(defvar highlight-numbers-py-hexinteger
  '(and "0" (any "oO") (1+ (and (? "_") (eval highlight-numbers-py-hexdigit)))))
(defvar highlight-numbers-py-integer
  '(or (eval highlight-numbers-py-decinteger)
       (eval highlight-numbers-py-bininteger)
       (eval highlight-numbers-py-octinteger)
       (eval highlight-numbers-py-hexinteger)))

(defvar highlight-numbers-py-digitpart '(and (any "0-9") (0+ (any "_" digit))))
(defvar highlight-numbers-py-fraction
  '(and "." (eval highlight-numbers-py-digitpart)))
(defvar highlight-numbers-py-pointfloat
  '(or (and (? (eval highlight-numbers-py-digitpart))
            (eval highlight-numbers-py-fraction))
       (and (eval highlight-numbers-py-digitpart) ".")))
(defvar highlight-numbers-py-exponent
  '(and (any "eE")
        (? (any "-+"))
        (eval highlight-numbers-py-digitpart)))
(defvar highlight-numbers-py-exponentfloat
  '(and (or (eval highlight-numbers-py-digitpart)
            (eval highlight-numbers-py-pointfloat))
        (eval highlight-numbers-py-exponent)))
(defvar highlight-numbers-py-floatnumber
  '(or (eval highlight-numbers-py-pointfloat)
       (eval highlight-numbers-py-exponentfloat)))

(defvar highlight-numbers-py-imagnumber
  '(and (or (eval highlight-numbers-py-floatnumber)
            (eval highlight-numbers-py-digitpart))
        (any "jJ")))

(defvar highlight-numbers-python
  (eval '(rx (and symbol-start
                  (or (eval highlight-numbers-py-imagnumber)
                      (eval highlight-numbers-py-floatnumber)
                      (eval highlight-numbers-py-integer))
                  symbol-end))))

(provide 'highlight-numbers-python)

;;; highlight-numbers-python.el ends here

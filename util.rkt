#lang racket

(provide stages)
(provide complement)
(provide remove-nulls)
(provide safe-first)
(provide translation-trace)

(define (stages . fns)
  (apply compose (reverse fns)))

(define (complement fn)
  (lambda (arg)
    (not (fn arg))))

(define (remove-nulls lst)
  (remove* (list null) lst))

(define (remove-falses lst)
  (remove* (list #f) lst))

(define (safe-first lst)
  (if (empty? lst)
      null
      (first lst)))

(define (translation-trace str res)
  (printf "- ~a: ~v.~%" str res)
  res)

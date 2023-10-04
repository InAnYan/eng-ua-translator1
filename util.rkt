#lang racket

(provide stages)
(provide complement)
(provide remove-nulls)
(provide safe-first)

(define (stages . fns)
  (apply compose (reverse fns)))

(define (complement fn)
  (lambda (arg)
    (not (fn arg))))

(define (remove-nulls lst)
  (remove* (list null) lst))

(define (safe-first lst)
  (if (empty? lst)
      null
      (first lst)))

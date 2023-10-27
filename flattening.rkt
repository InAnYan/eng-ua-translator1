#lang racket

(require racket/trace
         "util.rkt")

(define-stages flatten-stage
  decline
  flatten-tree
  string-join
  end-string)

(define (decline gt [decl null])
  gt)

(define (flatten-tree gt)
  (filter string? (flatten gt)))

(define (end-string str)
  ;; assert len(str) != 0
  ;; not a pure function, bad
  ;; why racket standard library doesn't provide string-capitalize?
  ;; TODO: Change the function!
  (string-set! str 0 (char-upcase (string-ref str 0)))
  (string-append str "."))

(trace decline
       flatten-tree
       flatten-stage)

(provide flatten-stage)

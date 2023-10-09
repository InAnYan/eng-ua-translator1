#lang racket

(require racket/trace)

(require "util.rkt")

(provide flatten-stage)

(define (flatten-stage gt)
  ((stages decline
           flatten-tree
           join-string
           end-string) gt))

(define (decline gt [decl null])
  gt)

(define (flatten-tree gt)
  (filter string? (flatten gt)))

(define (join-string lst)
  (string-join lst))

(define (end-string str)
  ;; assert len(str) != 0
  ;; not a pure function, bad
  ;; why racket standard library doesn't provide string-capitalize?
  (string-set! str 0 (char-upcase (string-ref str 0)))
  (string-append str "."))

(trace flatten-stage)
(trace decline)
(trace flatten-tree)
(trace join-string)
(trace end-string)

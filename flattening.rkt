#lang racket

(require "util.rkt")

(provide flatten-stage)

(define (flatten-stage gt)
  ((stages decline
           flatten-tree
           string-join) gt))

(define (decline gt [decl null])
  gt)

(define (flatten-tree gt)
  (filter string? (flatten gt)))

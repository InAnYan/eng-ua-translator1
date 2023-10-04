#lang racket

(require "parsing.rkt")

(provide parsing-stage)

(define-grammar english-grammar
  [S -> NP VP]
  [NP -> adjective* noun]
  [adjective* -> adjective adjective*]
  [adjective* -> ]
  [VP -> verb NP])

(define (parsing-stage tokens)
  (let ([res (parse-rule (first (first english-grammar))
              tokens
              english-grammar)])
    (if res
        (parse-result-val res)
        #f)))

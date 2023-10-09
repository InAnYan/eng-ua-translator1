#lang racket

(require racket/trace)

(require "parsing.rkt")
(require "util.rkt")

(provide parsing-stage)

(define-grammar english-grammar
  [S -> NP VP]
  [NP -> determiner? adjective* noun PreP*]
  [determiner? -> determiner]
  [determiner? -> ]
  [adjective* -> adjective adjective*]
  [adjective* -> ]
  [PreP* -> PreP PreP*]
  [PreP* -> ]
  [PreP -> preposition NP]
  [VP -> verb NP]
  [VP -> verb PreP*])

(define (parsing-stage tokens)
  (let ([res (parse-rule (first (first english-grammar))
              tokens
              english-grammar)])
    (if res
        (parse-result-val res)
        #f)))

(trace parsing-stage)

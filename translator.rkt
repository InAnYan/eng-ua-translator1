#lang racket

(require "util.rkt")
(require "lexical-analysis.rkt")
(require "parsing.rkt")
(require "english-grammar.rkt")
(require "transformer.rkt")
(require "flattening.rkt")

(provide translate-from-english-to-ukrainian)

(define (translate-from-english-to-ukrainian str)
  ((stages lexical-analysis-stage
           parsing-stage
           transform-stage
           flatten-stage) str))

(translate-from-english-to-ukrainian "My name is Anton.")

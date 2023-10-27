#lang racket

(require racket/trace
         "util.rkt"
         "parsing.rkt"
         "transformer.rkt"
         "flattening.rkt")

(define-stages translate-from-english-to-ukrainian
  parsing-stage
  (map transform)
  (map flatten-stage))

(trace translate-from-english-to-ukrainian)

(provide translate-from-english-to-ukrainian)

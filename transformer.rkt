#lang racket

(require "dictionary.rkt")

(provide transform-stage)

(define (transform-stage gt)
  (transform gt))

(define (transform gt)
  (match gt
    [(list 'S np vp)
     (list 'S (transform np) (transform vp))]

    [(list 'NP adjs noun)
     (list 'NP (transform adjs) (transform noun))]

    [(list 'VP verb np)
     (list 'VP (transform verb) (transform np))]

    [(list 'adjective* adj adjs)
     (list 'adjective* (transform adj) (transform adjs))]

    [(list 'adjective*)
     (list 'adjective*)]

    [(list (or 'noun 'verb 'adjective) word)
     (list (first gt) (translate-word-from-eng-to-ukr word (first gt)))]))

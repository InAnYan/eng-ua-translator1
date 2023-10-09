#lang racket

(require racket/trace)

(require "dictionary.rkt")
(require "util.rkt")

(provide transform-stage)

(define (transform-stage gt)
  (transform gt))

(trace transform-stage)

(define (transform gt)
  (match gt
    [(list 'S main-np (list 'VP (list 'verb (or "has" "have")) vp-np))
     `(S (PreP
          (preposition "в") ,(transform main-np))
         (VP (verb "є") ,(transform vp-np)))]

    [(list 'S np vp)
     (list 'S (transform np) (transform vp))]

    [(list 'NP det adjs noun preps)
     (list 'NP (transform det) (transform adjs) (transform noun) (transform preps))]

    [(list 'determiner determiner)
     null]

    [(list 'determiner)
     null]

    [(list 'adjective* adj adjs)
     (list 'adjective* (transform adj) (transform adjs))]

    [(list 'adjective*)
     gt]

    [(list 'PreP* prep preps)
     (list 'PreP* (transform prep) (transform preps))]

    [(list 'PreP*)
     gt]

    [(list 'PreP prep np)
     (list 'PreP (transform prep) (transform np))]

    [(list 'VP (list 'verb (or "am" "is" "are")) np)
     (list 'VP (transform np))]

    [(list 'VP verb np-or-prep)
     (list 'VP (transform verb) (transform np-or-prep))]

    [(list (or 'noun 'verb 'adjective 'determiner 'preposition) word)
     (list (first gt) (translate-word-from-eng-to-ukr word (first gt)))]

    [_ gt]))

#lang racket

(require racket/trace
         "dictionary.rkt"
         "util.rkt")

(define (transform gt)
  (match gt
    [(list 'S main-np (list 'VP (list 'verb (or "has" "have")) REST-VP ...))
     `(S (PreP
          (preposition "в") ,(transform main-np))
         (VP (verb "є") ,@(map transform REST-VP)))]

    [(list 'VP (list 'verb (or "am" "is" "are")) np pp)
     (list 'VP (transform np) (transform pp))]

    [(list 'determiner determiner)
     null]

    [(list (or 'S 'NP 'adjective* 'PP* 'PP 'VP) MEMBERS ...)
     (cons (first gt) (map transform MEMBERS))]

    [(list (or 'noun 'verb 'adjective 'determiner 'preposition) word)
     (list (first gt) (translate-word-from-eng-to-ukr word (first gt)))]

    [_ gt]))

(trace transform)

(provide transform)

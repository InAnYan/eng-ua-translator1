#lang racket

(require net/url)
(require "util.rkt")

(provide determine-parts-of-speech)
(provide translate-word-from-eng-to-ukr)

(define english-to-ukrainian-dictionary
  (read (open-input-file "english-to-ukrainian-dictionary.rkt")))

(define (determine-parts-of-speech word)
  (remove-nulls
   (map (lambda (part-entry)
          (if (assoc word (rest part-entry))
              (first part-entry)
              null))
        english-to-ukrainian-dictionary)))

(define (translate-word-from-eng-to-ukr word part)
  (second (assoc word
         (rest (assoc part english-to-ukrainian-dictionary)))))

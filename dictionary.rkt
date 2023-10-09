#lang racket

(require net/url)
(require "util.rkt")

(provide determine-parts-of-speech)
(provide translate-word-from-eng-to-ukr)

(define english-to-ukrainian-dictionary
  (read (open-input-file "english-to-ukrainian-dictionary.rkt")))

(define (determine-parts-of-speech word)
  (let ([res (determine-parts-of-speech-from-dictionary word)])
    (if (null? res)
        '(noun)
        res)))

(define (determine-parts-of-speech-from-dictionary word)
  (remove-nulls
   (map (lambda (part-entry)
          (if (assoc word (rest part-entry))
              (first part-entry)
              null))
        english-to-ukrainian-dictionary)))

(define (translate-word-from-eng-to-ukr word part)
  (let ([res (translate-word-from-eng-to-ukr-impl word part)])
    (if (equal? res word)
        (translation-trace "Unable to translate word" res)
        res)))

(define (translate-word-from-eng-to-ukr-impl word part)
  (let ([res (lookup-translation word part)])
    (if res
        (second res)
        word)))

(define (lookup-translation word part)
  (assoc word (get-part-dict part)))

(define (get-part-dict part)
  (let ([part-dict (assoc part english-to-ukrainian-dictionary)])
    (if part-dict
        (rest part-dict)
        #f)))


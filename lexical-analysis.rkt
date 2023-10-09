#lang racket

(require racket/trace)

(require "util.rkt")
(require "dictionary.rkt")

(provide lexical-analysis-stage)
(provide token)
(provide token-str)
(provide is-of-part-of-speech?)

(struct token
  (str parts-of-speech)
  #:transparent)

(define (lexical-analysis-stage str)
  ((stages delete-punctuation
           downcase-string
           split-string
           words->token) str))

(define (delete-punctuation str)
  (list->string (filter (complement char-punctuation?) (string->list str))))

(define (downcase-string str)
  (string-downcase str))

(define (split-string str)
  (string-split str))

(define (words->token words)
  (map word->token words))

(trace lexical-analysis-stage)
(trace delete-punctuation)
(trace downcase-string)
(trace split-string)
(trace words->token)

(define (word->token word)
  (token word (determine-parts-of-speech word)))

(define (is-of-part-of-speech? token part)
  (member part (token-parts-of-speech token)))

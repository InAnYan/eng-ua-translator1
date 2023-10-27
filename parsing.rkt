#lang racket

(require racket/trace
         amb-parser
         "english-grammar.rkt"
         "util.rkt"
         "dictionary.rkt")

(define-stages parsing-stage
  string-downcase
  delete-punctuation
  string-split
  (map word->token)
  (parse 'S)
  (filter (compose empty? parser-result-rest))
  (map parser-result-data))

(define (delete-punctuation str)
  (list->string (filter (complement char-punctuation?) (string->list str))))

(define (word->token word)
  (token word (determine-parts-of-speech word)))

(trace parsing-stage
       word->token)

(provide parsing-stage)

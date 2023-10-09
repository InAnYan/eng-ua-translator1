#lang racket

(require "util.rkt")
(require "lexical-analysis.rkt")

(require (for-syntax syntax/parse))

(provide define-grammar)
(provide parse-rule)
(provide parse-result)
(provide parse-result-val)
(provide parse-result-rest)
(provide production-rule)
(provide production-expansion)

(define-syntax-rule (define-grammar name prods ...)
  (define name '(prods ...)))

(struct parse-result
  (val rest)
  #:transparent)

(define (parse-rule rule tokens grammar)
  ; maybe
  ; terminal: noun, verb.
  ; non-terminal: S, NP, VP.
  ; list: '(NP VP).
  (cond [(terminal? rule grammar)
         (parse-terminal rule tokens grammar)]
        [(non-terminal? rule grammar)
         (parse-non-terminal rule tokens grammar)]
        [(pair? rule)
         (parse-list rule tokens grammar)]
        [else (parse-result null tokens)]))

(define (parse-terminal rule tokens grammar)
  (if (and (pair? tokens)
           (is-of-part-of-speech? (first tokens) rule))
      (parse-result (list rule (token-str (first tokens)))
                    (rest tokens))
      #f))

(define (parse-non-terminal rule tokens grammar)
  (ormap (lambda (prod)
           (let ([res (parse-rule (production-expansion prod) tokens grammar)])
             (if res
                 (parse-result (cons rule (parse-result-val res))
                               (parse-result-rest res))
                 #f)))
         (find-non-terminal-productions rule grammar)))

(define (parse-list rule tokens grammar)
  (let ([fst-rule (first rule)]
        [rst-rule (rest rule)])
    (let ([fst-res (parse-rule fst-rule tokens grammar)])
      (if fst-res
          (let ([rst-res (parse-rule rst-rule (parse-result-rest fst-res) grammar)])
            (if rst-res
                (parse-result (cons (parse-result-val fst-res)
                                    (parse-result-val rst-res))
                              (parse-result-rest rst-res))
                #f))
          #f))))

(define (find-non-terminal-productions rule grammar)
  (remove-nulls (map (lambda (prod)
                       (if (eq? (production-rule prod) rule)
                           prod
                           null))
                     grammar)))

(define (production-rule prod)
  (first prod))

(define (production-expansion prod)
  (rest (rest prod)))

(define (terminal? rule grammar)
  (and (symbol? rule)
       (not (ormap (lambda (prod)
                     (eq? (production-rule prod) rule))
                   grammar))))

(define (non-terminal? rule grammar)
  (and (symbol? rule) (not (terminal? rule grammar))))

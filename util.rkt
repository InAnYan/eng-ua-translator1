#lang racket

(define-syntax-rule (define-stages name FNS ...)
  (define (name arg)
    ((create-stages-fn FNS ...)
     arg)))

(define-syntax create-stages-fn
  (syntax-rules ()
    [(create-stages-fn (FNS ...))
     (lambda (arg)
       (FNS ... arg))]
    [(create-stages-fn FN)
     FN]
    [(create-stages-fn FN FNS ...)
     (compose (create-stages-fn FNS ...)
              (create-stages-fn FN))]))

(define (complement fn)
  (lambda (arg)
    (not (fn arg))))

(println "HELLO")

(define (remove-nulls lst)
  (remove* (list null) lst))

(define (remove-falses lst)
  (remove* (list #f) lst))

(define (safe-first lst)
  (if (empty? lst)
      null
      (first lst)))

(provide define-stages
         complement
         remove-nulls
         safe-first)

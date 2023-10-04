(require (for-syntax syntax/parse))
(require syntax/parse)

(define (defines-grammar stx)
  (let ([datum (syntax->datum stx)])
    (datum->syntax (append (list 'begin
                                 (list 'define (car datum) (cdr datum)))
                           (map (lambda (prod)
                                  (list 'struct (production-rule prod)
                                        (production-expansion prod)))
                                (car (cdr datum)))))))

(define-syntax-rule (define-grammar name prods ...)
  (begin (define name '(prods ...))
         (define-productions prods ...)))

(define-syntax define-productions
  (syntax-rules ()
    [(define-productions prod)
     (define-production prod)]
    [(define-productions prod prods ...)
     (begin (define-productions prod)
            (define-productions prods ...))]))

(define-syntax define-production
  (lambda (stx)
    (syntax-parse stx
      [(_define-production (name arrow expansion ...))
       (syntax (struct name (expansion ...) #:transparent))])))

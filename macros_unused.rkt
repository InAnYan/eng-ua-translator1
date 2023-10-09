







(define-syntax-rule (define-grammar name prods ...)
  (begin (define name '(prods ...))
         (define-production-rules prods ...)))

(define-for-syntax (remove-duplicates lst)
  (cond
    [(null? lst) null]
    [(member (car lst) (cdr lst))
     (remove-duplicates (cdr lst))]
    [else (cons (car lst) (remove-duplicates (cdr lst)))]))


; Why this does not work?
(define-syntax define-production-rules
  (lambda (stx)
    (syntax-parse stx
      [(_define-production-rule prods ...)
       (let ([rules (remove-duplicates (map car (syntax->datum (syntax (prods ...)))))])
         (datum->syntax stx
                        `(define-values ,rules ,(cons 'values (map (lambda (rule)
                                                                     
                                                               `(quote ,rule))
                                                             rules)))))])))
       




(define-grammar test
  [A -> ]
  [A -> ]
  [B ->])










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





(define-syntax define-production-rules-old
  (lambda (stx)
    (syntax-parse stx
      [(_define-production-rule prods ...)
       (datum->syntax stx
                      (cons 'begin (map (lambda (rule)
                                          `(define ,rule ',rule))
                                        )))])))

       #'(cons 'begin
               (map (lambda (rule)
                      `(define ,rule (quote ,rule)))
                    (remove-duplicates
                     (map car (prods ...)))))])))

                      (map (lambda (prod)
                             `(define ,prod ',prod))
                           (remove-duplicates (map car '(prods ...)))))])))
(define-syntax define-production-rules
  (syntax-rules ()
    [(define-production-rules prod)
     (define-production-rule prod)]
    [(define-production-rules prod prods ...)
     (begin (define-production-rules prod)
            (define-production-rules prods ...))]))

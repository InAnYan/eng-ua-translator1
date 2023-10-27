#lang web-server/insta

(require "translator.rkt")

(define (start request)
  (response/xexpr
   `(html
     (head (title "English to Ukrainian translator"))
     (body (h3 "Enter an English sentence:")
           (form
            (input ((name "text")))
            (input ((type "submit") (value "Translate"))))
           ,(if (exists-binding? 'text (request-bindings request))
                (let ([text (extract-binding/single 'text (request-bindings request))])
                  `(div (h3 "Result:")
                        (p ,text)
                        (ul
                         ,@(map (lambda (x) (list 'li x))
                                (translate-from-english-to-ukrainian text)))))
                '(div))))))

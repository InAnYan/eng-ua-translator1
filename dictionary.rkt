#lang racket

(require racket/trace
         net/url
         racket/runtime-path
         json)

(define-runtime-path old-dict-path "english-to-ukrainian-dictionary.rkt")
(define-runtime-path dict-path "ukrainian/words.json")

(define old-english-to-ukrainian-dictionary
  (read (open-input-file old-dict-path)))

(define english-to-ukrainian-dictionary
  (read-json (open-input-file dict-path)))

(define (determine-parts-of-speech word)
  (let ([res (determine-parts-of-speech-from-dictionary word)])
    (if (not res)
        '(noun)
        res)))

(define (determine-parts-of-speech-from-dictionary word)
  (filter identity
   (map (lambda (part-entry)
          (if (assoc word (rest part-entry))
              (first part-entry)
              #f))
        old-english-to-ukrainian-dictionary)))

(define (translate-word-from-eng-to-ukr word part)
  (let ([res (lookup-translation word part)])
    (if res
        res
        word)))

(define (lookup-translation word part)
  (sort (filter identity
          (map (lambda (obj)
                 (and (in-the-defs word obj)
                      (equal? (hash-ref obj 'pos)
                              (symbol->string part))
                      (list (hash-ref obj 'word) (meaning-specificness obj word))))
               english-to-ukrainian-dictionary))
        (lambda (a b)
          (if (or (not (second a)) (not (second b)))
              #f
              (< (second a) (second b))))))

(define (in-the-defs word obj)
  (ormap (lambda (def)
           (regexp-match? (pregexp (string-append "\\b" word "\\b"))
                          def))
         (hash-ref obj 'defs)))

(define (meaning-specificness obj word)
  (let ([res (map (lambda (def) (find-specificness word def)) (hash-ref obj 'defs))])
    (exact->inexact (/ (apply + res)
                       (length res)))))

(define (find-specificness word def)
  (/ (string-length word)
     (string-length def)))

(define (get-part-dict part)
  (let ([part-dict (assoc part old-english-to-ukrainian-dictionary)])
    (if part-dict
        (rest part-dict)
        #f)))

(trace translate-word-from-eng-to-ukr)

(provide determine-parts-of-speech
         translate-word-from-eng-to-ukr)

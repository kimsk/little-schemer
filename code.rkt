#lang scheme
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
;(atom? '())

(define l '(1 2 3))

(define lat?
  (lambda (l)
         (cond
           ((null? l) #t)
           ((atom? (car l)) (lat? (cdr l)))
           (else #f))))

;(cond
;  ((null? '()) #t)
;  (else #f))

;(or (null? '()) (null? '(1)))

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      ((eq? (car lat) a) #t)
      (else (member? a (cdr lat))))))


(member? "a" '("a" "b" 2))
(member? "c" '("a" "b" 2))
(member? '() '("a" "b" 2))
(member? '("a") '("a" "b" 2))
(member? '(2) '("a" "b" (2)))
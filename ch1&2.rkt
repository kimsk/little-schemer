(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; Chapter 2: Recursion
(define lat?
  (lambda (l)
         (cond
           ((null? l) #t)
           ((atom? (car l)) (lat? (cdr l)))
           (else #f))))

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      ((eq? (car lat) a) #t)
      (else (member? a (cdr lat))))))

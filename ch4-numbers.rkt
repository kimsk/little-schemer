#lang racket
; Chapter 4: Numbers
(define add1
  (lambda (n)
    (+ n 1)))

(define sub1
  (lambda (n)
    (- n 1)))

(define zero?
  (lambda (n)
    (eq? n 0)))

(define o++
  (lambda (n m)
    (cond
      ((zero? n) m)
      (else (o++ (sub1 n) (add1 m))))))

(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (add1 (o+ n (sub1 m)))))))

(define o-
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (sub1 (o- n (sub1 m)))))))

(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (+ (car tup) (addtup (cdr tup)))))))

(define x
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (o+ n (x n (sub1 m)))))))

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((and (null? tup1) (null? tup2)) '())
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (+ (car tup1) (car tup2))
                  (tup+ (cdr tup1) (cdr tup2)))))))

(define >
  (lambda (n m)
    (cond
      ;((and (zero? n) (zero? m) #f))
      ((zero? n) #f)
      ((zero? m) #t)
      (else (> (sub1 n) (sub1 m))))))

(define <
  (lambda (n m)
    (cond      
      ((zero? m) #f)
      ((zero? n) #t)
      (else (< (sub1 n) (sub1 m))))))

(define =
  (lambda (n m)
    (cond
      ((and (zero? n) (zero? m)) #t)
      ((or (zero? n) (zero? m)) #f)
      (else (= (sub1 n) (sub1 m))))))

(define =2
  (lambda (n m)
    (cond
      ((zero? m) (zero? n))
      ((zero? n) #f)
      (else (=2 (sub1 n) (sub1 m))))))

(define =3
  (lambda (n m)
    (cond
      ((< n m) #f)
      ((> n m) #f)
      (else #t))))

(define =4
  (lambda (n m)
    (and (not (< n m)) (not (> n m)))))

(define ^
  (lambda (n m)
    (cond
      ((zero? m) 1)
      (else (x n (^ n (sub1 m)))))))

(define /
  (lambda (n m)
    (cond
      ((< n m) 0)
      (else (add1 (/ (- n m) m))))))

(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length (cdr lat)))))))

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) lat)
      ((number? (car lat)) (no-nums (cdr lat)))
      (else (cons (car lat) (no-nums (cdr lat)))))))

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) lat)
      ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (= a1 a2))
      ((or (number? a1) (number? a2)) #f)
      (else (eq? a1 a2)))))

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eqan? a (car lat)) (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))

(define one?
  (lambda (n)
    (= n 1)))

(define rempick2
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))
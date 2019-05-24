## `atom?`

``` scheme
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
```

## `lat?`
`lat?` looks at each S-expression in a list, in
turn, and asks if each S-expression is an atom, until it runs out of S-expressions. If it runs out without encountering a list, the value is `#t` . If it finds a list, the value is `#f`-false .

> 1st commandment: Always ask null? as the first question in expressing
any function.

``` scheme
(define lat?
  (lambda (l)
         (cond
           ((null? l) #t)
           ((atom? (car l)) (lat? (cdr l)))
           (else #f))))
```

## `member?`

``` scheme
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      ((eq? (car lat) a) #t)
      (else (member? a (cdr lat))))))
```
or (from the book)
``` scheme
(define member? (lambda (a lat)
  (cond
    ((null? lat) #f)
    (else (or (eq? (car lat) a)
            (member? a (cdr lat)))))))
```

## `rember` (remove a member)

It takes an atom and a lat as its arguments, and makes a new lat with the first occurrence of the atom in the old lat removed.

> 1st commandment: Always ask null? as the first question in expressing
any function.

> 2nd commandment: Use cons to build lists.


``` scheme
(define rember
  (lambda (a lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) a) (cdr lat))
      (else (cons (car lat) (rember a (cdr lat)))))))
```

of (from the book)
``` scheme
(define rember (lambda (a lat)
  (cond
    ((n·ull? lat) (quote ()))
    (else (cond
      ((eq? (car lat) a) (cdr lat))
      (else (cons (car lat)
        (rember a
          (cdr lat)))))))))
```
> The function rember checked each atom of
the `lat`, one at a time, to see if it was the same as the atom and. If the car was not the same as the atom, we saved it to be `consed` to the final value later. When rember found the atom and, it dropped it, and `consed` the previous atoms back onto the rest of the `lat`.

## `firsts`

The function firsts takes one argument, a
list, which is either a null list or contains only non-empty lists. It builds another list composed of the first S-expression of each internal list.

> 1st commandment: Always ask null? as the first question in expressing
any function.

> 2nd commandment: Use cons to build lists.

> 3rd commandment: When building a list, describe the first **typical** ele­ment, `(car (car l))`, and then `cons` it onto the **natural recursion**, `(firsts (cdr l))`.

``` scheme
(define firsts
  (lambda (l)
    (cond
      ((null? l) l)
      (else (cons (car (car l)) (firsts (cdr l)))))))
```

## `insertR`, `insertL`, `subst`, and `subst2`

It takes three arguments: the atoms new and old, and a lat. 
- `insertR` builds a lat with `new` inserted to the right of the first occurrence of `old`.
- `insertL` builds a lat with `new` inserted to the left of the first occurrence of `old`.
- The function `subst` builds a lat with `new` replaced the first occurrence of `old`.

`(subst2 new o1 o2 lat)`
- `subst2` replaces either the first occurrence of `o1` or the first occurrence of `o2` by `new`.



``` scheme
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old) (cons old (cons new (cdr lat))))
      (else (cons (car lat) (insertR new old (cdr lat)))))))

(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old) (cons new lat))
      (else (cons (car lat) (insertL new old (cdr lat)))))))

; lat = (cons old (cdr lat))

(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old) (cons new (cdr lat)))
      (else (cons (car lat) (subst new old (cdr lat)))))))

(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) lat)
      ((or (eq? (car lat) o1) (eq? (car lat) o2)) (cons new (cdr lat)))
      (else (cons (car lat) (subst2 new o1 o2 (cdr lat)))))))

```

## `multirember`, `multiinsertR`, `multiinsertL`, and `multisubst`

> 4th commandment: Always change at least one argument while recurring. It must be changed to be closer to termination. The changing argument must be tested in the termination condition: when using `cdr`, test termination with `null?`


``` scheme
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) a) (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat)))))))

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old) (cons old (cons new (multiinsertR new old (cdr lat)))))
      (else (cons (car lat) (multiinsertR new old (cdr lat)))))))

(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old) (cons new (cons old (multiinsertL new old (cdr lat)))))
      (else (cons (car lat) (multiinsertL new old (cdr lat)))))))

(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old) (cons new (multisubst new old (cdr lat))))
      (else (cons (car lat) (multisubst new old (cdr lat)))))))
```

## `add1`, `sub1`, `zero?`, `o+`, and `o-`

> For number, use `zero?` for `null?`, and `add1` or `sub1` as `cons`

``` scheme
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
```

## `addtup`

`addtup` builds a number by totaling all the numbers in its argument.

``` scheme
(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (o+ (car tup) (addtup (cdr tup)))))))
```

## `tup+`

``` scheme
(define tup+
  (lambda (tup1 tup2)
    (cond
      ((and (null? tup1) (null? tup2)) '())
      (else (cons (+ (car tup1) (car tup2)) 
                    (tup+ (cdr tup1) (cdr tup2)))))))

; if lengths are different
(define tup+
  (lambda (tup1 tup2)
    (cond
      ((and (null? tup1) (null? tup2)) '())
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (+ (car tup1) (car tup2))
                  (tup+ (cdr tup1) (cdr tup2)))))))
```

## `>`, `<`, `=`
``` scheme
(define >
  (lambda (n m)
    (cond
      ; ((and (zero? n) (zero? m) #f))
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
```

## `^`

``` scheme
(define ^
  (lambda (n m)
    (cond
      ((zero? m) 1)
      (else (x n (^ n (sub1 m)))))))
```

## `x`

``` scheme
(x 12 3) = 12 + (x 12 2)
         = 12 + 12 + (x 12 1)
         = 12 + 12 + 12 + (x 12 0) ; ((zero? 0) 0)
         = 12 + 12 + 12 + 0
```

``` scheme
(define x
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (o+ n (x n (sub1 m)))))))
```

## `/`

``` scheme
(/ 15 4) = 1 + (/ 11 4)
         = 1 + (1 + (/ 7 4))
         = 1 + (1 + (1 + (/ 3 4))) ; ((< 3 4) 0)
         = 1 + (1 + (1 + 0))
```

``` scheme
(define /
  (lambda (n m)
    (cond
      ((< n m) 0)
      (else (add1 (/ (- n m) m))))))
```

## `length`, `pick`, `rempick`

``` scheme
(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length (cdr lat)))))))

(length '(1 2 3))
1 + (length '(2 3)) ; (cdr lat) => (2 3)
1 + 1 + (length '(3))
1 + 1 + 1 + (length '())
1 + 1 + 1 + 0
```

``` scheme
; pick nth value from a list
(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(pick 3 '(0 1 2 3 4))
(pick (sub1 3) (cdr '(0 1 2 3 4)))
(pick (sub1 2) (cdr '(1 2 3 4)))
((zero? (sub1 1)) (car '(2 3 4))) ; 2
```

``` scheme
; remove nth value from a list

(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))
```

## `no-nums`, `all-nums`

``` scheme
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
```

## `eqan?`

``` scheme
(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (= a1 a2))
      ((or (number? a1) (number? a2)) #f)
      (else (eq? a1 a2)))))
```

## `occur`, `one?`, `rempick2`

``` scheme
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
```

## Note
- S-Expression: `atom` or `list`
- empty or null list: `()`
- `pair`: 
  - `(1 . 2)` or `(cons 1 2)` is not a list
  - All lists are pairs but not all pairs are lists. 

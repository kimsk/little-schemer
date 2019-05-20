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

## Note
- S-Expression: `atom` or `list`
- empty or null list: `()`
- `pair`: 
  - `(1 . 2)` or `(cons 1 2)` is not a list
  - All lists are pairs but not all pairs are lists. 

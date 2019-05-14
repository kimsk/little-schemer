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

## `insertR`, `insertL`, and `subst`

It takes three arguments: the atoms new and old, and a lat. The function insertR builds a lat with new inserted to the right of the first occurrence of old.

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
```

## Note
- S-Expression: `atom` or `list`
- empty or null list: `()`
- `pair`: 
  - `(1 . 2)` or `(cons 1 2)` is not a list
  - All lists are pairs but not all pairs are lists. 

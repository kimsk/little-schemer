## `atom?`

``` scheme
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
```

## `lat?`
`lat?` looks at each S-expression in a list, in
turn, and asks if each S-expression is an atom, until it runs out of S-expressions. If it runs out without encountering a list, the value is `#t` . If it finds a list, the value is `#f`-false .

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
or
``` scheme
(define member? (lambda (a lat)
  (cond
    ((null? lat) #f)
    (else (or (eq? (car lat) a)
            (member? a (cdr lat)))))))
```

## Note
- S-Expression: `atom` or `list`
- empty or null list: `()`
- `pair`: 
  - `(1 . 2)` or `(cons 1 2)` is not a list
  - All lists are pairs but not all pairs are lists. 

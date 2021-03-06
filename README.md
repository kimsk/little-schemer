# [The Little Schemer](https://www.amazon.com/Little-Schemer-Daniel-P-Friedman/dp/0262560992)

# Basic
> `atom` is a string of characters
``` lisp
atom
turkey
u
1492
*abc$
```

> `list` is a collection of `S-expression(s)` enclosed with parenthesis
``` lisp
(atom)
(atom turkey or)
()
```

> `atom` and `list` are `S-expressions`

> `null` or `()` or empty list is `S-expression`

## The Law of `Car`
The primitive car is defined only for non-empty lists.

> `car` gives 1st `S-expression` of the `list`, e.g., `( car l)`

## The Law of `Cdr`
The primitive `cdr` is defined only for non-empty lists. The `cdr` of any nonempty list is always another list.

> `(cdr (a b c))` is `(b c)`
> `cdr` is pronounced **could-er.**

## The Ten Commandments

### The First Commandment

> Always ask `null?` as the first question in expressing
any function.

- When recurring on a list of `atoms`, `lat`, ask two questions about it: `(null? lat)` and `else`. 
- When recurring on a number, `n`, ask two questions about it: `(zero? n)` and `else`.
- When recurring on a list of `S-expressions`, l, ask three question about it: `(null? l)`, `(atom? (car l))`, and `else`.

### The Second Commandment
- Use `cons` to build lists.

### The Third Commandment
- When building a list, describe the first typical element, and then `cons` it onto the natu­ral recursion.

### The Fourth Commandment
- Always change at least one argument while recurring. When recurring on a list of `atoms`, `lat`, use `(cdr lat)`. 
- When recurring on a num­ber, `n`, use `(sub1 n)`.
- And when recurring on a list of S-expressions, `l`, use `(car l)` and `(cdr l)` if neither `(null? l)` nor `(atom? (car l))` are true.
It must be changed to be closer to termina­tion. The changing argument must be tested in the termination condition:
  - when using `cdr`, test termination with `null?` and
  - when using `sub1`, test termination with `zero?`.

### The Fifth Commandment
- When building a value with `+` ,always use `0` for the value of the terminating line, for adding `0` does not change the value of an addition.
- When building a value with `x`, always use `1` for the value of the terminating line, for multiplying by `1` does not change the value of a multiplication.
- When building a value with `cons`, always consider `()` for the value of the terminating line.

### The Sixth Commandment
- Simplify only after the function is correct.

### The Seventh Commandment
- Recur on the subparts that are of the same nature:
  - On the sublists of a list.
  - On the subexpressions of an arithmetic expression.

### The Eighth Commandment
- Use help functions to abstract from represen­tations.

### The Ninth Commandment
- Abstract common patterns with a new func­tion.

### The Tenth Commandment
- Build functions to collect more than one value at a time.


## The Five Rules

### The Law of **Car**
- The primitive `car` is defined only for non­ empty lists.

### The Law of **Cdr**
- The primitive `cdr` is defined only for non­ empty lists. 
- The `cdr` of any non-empty list is always another list.

### The Law of **Cons**
- The primitive `cons` takes two arguments. The second argument to `cons` must be a list. The result is a list.

### The Law of **Null?**
- The primitive `null?` is defined only for lists.

### The Law of **Eq?**
The primitive `eq?` takes two arguments. Each must be a non-numeric atom.

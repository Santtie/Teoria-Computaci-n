# Implementación de Booleanos de Church

## 1. Introducción

En este proyecto se implementan **booleanos utilizando el cálculo lambda**, específicamente mediante **Codificación de Church (Church Encoding)**.

La idea principal es representar valores lógicos (`true` y `false`) **sin usar los booleanos nativos del lenguaje**, sino únicamente **funciones**.

Este enfoque proviene del **cálculo lambda**, un sistema formal desarrollado por **Alonzo Church**, que demuestra que conceptos básicos de programación pueden representarse únicamente mediante funciones.

En este proyecto se implementan:

* `true`
* `false`
* `and` (conjunción lógica)
* `or` (disyunción lógica)
* `not` (negación lógica)

Todo utilizando únicamente **expresiones lambda en OCaml**.

---

# 2. Teoría: Booleanos en Cálculo Lambda

En el cálculo lambda, un booleano **no es un valor**, sino una **función que elige entre dos opciones**.

La idea fundamental es la siguiente:

```
true  x y → x
false x y → y
```

Esto significa:

* `true` devuelve el **primer argumento**
* `false` devuelve el **segundo argumento**

Por lo tanto, se definen así:

```
true  ≡ λx.λy.x
false ≡ λx.λy.y
```

Interpretación:

* `λx.λy.x` significa: una función que recibe `x`, luego `y`, y devuelve `x`.
* `λx.λy.y` significa: una función que recibe `x`, luego `y`, y devuelve `y`.

En otras palabras:

| Booleano | Comportamiento               |
| -------- | ---------------------------- |
| true     | selecciona la primera opción |
| false    | selecciona la segunda opción |

---

# 3. Implementación en OCaml

## 3.1 True

Definición teórica:

```
true ≡ λx.λy.x
```

Implementación:

```ocaml
let true_c =
  fun x ->
    fun y ->
      x
```

Explicación:

* recibe dos argumentos `x` y `y`
* siempre retorna `x`

Ejemplo conceptual:

```
true A B → A
```

---

## 3.2 False

Definición teórica:

```
false ≡ λx.λy.y
```

Implementación:

```ocaml
let false_c =
  fun x ->
    fun y ->
      y
```

Explicación:

* recibe dos argumentos
* siempre retorna el segundo

Ejemplo conceptual:

```
false A B → B
```

---

# 4. Operadores Booleanos

A partir de `true` y `false` se pueden construir operadores lógicos.

---

# 4.1 AND (Conjunción)

Definición lógica:

```
X AND Y es verdadero solo si ambos son verdaderos
```

Tabla de verdad:

| X | Y | Resultado |
| - | - | --------- |
| T | T | T         |
| T | F | F         |
| F | T | F         |
| F | F | F         |

Definición en cálculo lambda:

```
and ≡ λp.λq. p q false
```

Implementación en OCaml:

```ocaml
let and_c =
  fun p ->
    fun q ->
      p q false_c
```

Explicación:

* si `p` es `true`, el resultado será `q`
* si `p` es `false`, el resultado será `false`

Ejemplo de reducción:

```
and true false
= true false false
= false
```

---

# 4.2 OR (Disyunción)

Definición lógica:

```
X OR Y es verdadero si al menos uno es verdadero
```

Tabla de verdad:

| X | Y | Resultado |
| - | - | --------- |
| T | T | T         |
| T | F | T         |
| F | T | T         |
| F | F | F         |

Definición en cálculo lambda:

```
or ≡ λp.λq. p true q
```

Implementación:

```ocaml
let or_c =
  fun p ->
    fun q ->
      p true_c q
```

Explicación:

* si `p` es `true`, el resultado es `true`
* si `p` es `false`, el resultado es `q`

Ejemplo:

```
or false true
= false true true
= true
```

---

# 4.3 NOT (Negación)

Definición lógica:

```
NOT X invierte el valor lógico
```

Tabla:

| X | NOT X |
| - | ----- |
| T | F     |
| F | T     |

Definición en cálculo lambda:

```
not ≡ λp. p false true
```

Implementación:

```ocaml
let not_c =
  fun p ->
    p false_c true_c
```

Explicación:

* si `p` es `true`, se devuelve `false`
* si `p` es `false`, se devuelve `true`

Ejemplo:

```
not true
= true false true
= false
```

---

# 5. Conversión a Booleanos de OCaml

Para poder **mostrar resultados en pantalla**, se utiliza una función que convierte un booleano de Church a un booleano nativo de OCaml.

```ocaml
let to_bool b =
  b true false
```

Esto funciona porque:

```
true true false  → true
false true false → false
```

---

# 6. Ejemplos de Uso

Ejemplos usando las funciones implementadas:

```
and true true  → true
and true false → false

or false true  → true
or false false → false

not true  → false
not false → true
```

Ejemplo en OCaml:

```ocaml
to_bool (and_c true_c false_c)
```

Resultado:

```
false
```

---

# 7. Cómo ejecutar el proyecto

1. Guardar el código en un archivo llamado:

```
church_bool.ml
```

2. Compilar el programa:

```
ocamlc church_bool.ml -o church_bool
```

3. Ejecutar:

```
./church_bool
```

También se puede ejecutar directamente con:

```
ocaml church_bool.ml
```

---

# 8. Conclusión

Este proyecto demuestra cómo conceptos básicos de programación como:

* valores booleanos
* operadores lógicos
* selección condicional

pueden implementarse **únicamente mediante funciones**, utilizando los principios del **cálculo lambda**.

La codificación de Church muestra que **las funciones por sí solas son suficientes para construir estructuras de control completas**, lo cual es una idea fundamental en teoría de la computación y en el diseño de lenguajes funcionales.

---

# 9. Referencias

* Matemática discreta y lógica - Grassman
* Libro Susanna Epps
* https://ocaml.org
* Explicaciones dadas en clase

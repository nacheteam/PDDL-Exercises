(define (problem Problema2)
    (:domain Ejercicio2)
    (:objects
        bruja1 - bruja
        player1 - agente
        oscar1 - oscar
        manzana1 - manzana
        princesa1 - princesa
        z1 z7 z3 z4 z2 z5 z6 - zona
    )
    (:init
        (conectado z1 z3 sur)
        (conectado z3 z1 norte)
        (conectado z3 z6 sur)
        (conectado z6 z3 norte)
        (conectado z2 z3 este)
        (conectado z3 z2 oeste)
        (conectado z3 z4 este)
        (conectado z4 z3 oeste)
        (conectado z5 z6 este)
        (conectado z6 z5 oeste)
        (conectado z6 z7 este)
        (conectado z7 z6 oeste)
        (orientado player1 norte)
        (manovacia player1)
        (en bruja1 z1)
        (en player1 z2)
        (en oscar1 z5)
        (en manzana1 z5)
        (en princesa1 z7)
        (= (coste z3 z1) 10)
        (= (coste z1 z3) 10)
        (= (coste z6 z3) 5)
        (= (coste z3 z6) 5)
        (= (coste z3 z2) 10)
        (= (coste z2 z3) 10)
        (= (coste z4 z3) 5)
        (= (coste z3 z4) 5)
        (= (coste z6 z5) 10)
        (= (coste z5 z6) 10)
        (= (coste z7 z6) 5)
        (= (coste z6 z7) 5)
        (= (costeTotal) 0)
    )
    (:goal (AND
          (tieneobjeto  bruja1)
          (tieneobjeto  princesa1)
          (< (costeTotal) 200)
          )
    )
)

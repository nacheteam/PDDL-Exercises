(define (problem Problema6)
    (:domain Ejercicio6)
    (:objects
        bruja1 - bruja
        rosa1 - rosa
        bikini1 - bikini
        leonardo1 - leonardo
        zapatilla1 - zapatilla
        player1 - agente
        oro2 - oro
        manzana2 - manzana
        algoritmo1 - algoritmo
        oro1 - oro
        oscar1 - oscar
        manzana1 - manzana
        princesa1 - princesa
        player2 - agente
        z6 z5 z2 z7 z3 z1 z4 - zona
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
        (es piedra z4)
        (es bosque z5)
        (es arena z3)
        (es piedra z6)
        (es bosque z1)
        (es piedra z7)
        (es piedra z2)
        (orientado player1 norte)
        (manovacia player1)
        (mochilavacia player1)
        (orientado player2 norte)
        (manovacia player2)
        (mochilavacia player2)
        (en bruja1 z1)
        (en rosa1 z1)
        (en bikini1 z3)
        (en leonardo1 z3)
        (en zapatilla1 z6)
        (en player1 z2)
        (en oro2 z3)
        (en manzana2 z3)
        (en algoritmo1 z4)
        (en oro1 z4)
        (en oscar1 z5)
        (en manzana1 z5)
        (en princesa1 z7)
        (en player2 z7)
        (esbikini bikini1)
        (eszapatilla zapatilla1)
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
        (= (puntosTotales) 0)
        (= (puntosObtenidos player1) 0)
        (= (puntosObtenidos player2) 0)
        (= (puntos rosa1 bruja1) 5)
        (= (puntos oro2 bruja1) 3)
        (= (puntos manzana2 bruja1) 10)
        (= (puntos algoritmo1 bruja1) 1)
        (= (puntos oro1 bruja1) 3)
        (= (puntos oscar1 bruja1) 4)
        (= (puntos manzana1 bruja1) 10)
        (= (puntos rosa1 leonardo1) 1)
        (= (puntos oro2 leonardo1) 5)
        (= (puntos manzana2 leonardo1) 3)
        (= (puntos algoritmo1 leonardo1) 4)
        (= (puntos oro1 leonardo1) 5)
        (= (puntos oscar1 leonardo1) 10)
        (= (puntos manzana1 leonardo1) 3)
        (= (puntos rosa1 princesa1) 10)
        (= (puntos oro2 princesa1) 4)
        (= (puntos manzana2 princesa1) 1)
        (= (puntos algoritmo1 princesa1) 3)
        (= (puntos oro1 princesa1) 4)
        (= (puntos oscar1 princesa1) 5)
        (= (puntos manzana1 princesa1) 1)
        (= (numeroObjetos bruja1) 2)
        (= (numeroObjetos princesa1) 3)
        (= (numeroObjetos leonardo1) 1)
    )
    (:goal (AND
          (tieneobjeto bruja1)
          (tieneobjeto leonardo1)
          (tieneobjeto princesa1)
          (< (costeTotal) 500)
          (>= (puntosTotales) 20)
          (>= (puntosObtenidos player1) 10)
          (>= (puntosObtenidos player2) 10)
          )
    )
)

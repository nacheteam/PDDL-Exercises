(define (problem Problema4)
  (:domain Ejercicio4)
  (:objects z1 z2 z3 z4 z5 z6 z7 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19 z20 z21 z22 z23 z24 z25 - zona
            agente1 - agente
            princesa1 - princesa
            principe1 - principe
            bruja1 - bruja
            profesor1 - profesor
            leonardo1 - leonardo
            oscar1 - oscar
            manzana1 - manzana
            rosa1 - rosa
            algoritmo1 - algoritmo
            oro1 - oro
            zapatilla1 - zapatilla
            bikini1 - bikini
  )
  (:init
    ; z1  z2  z3  z4  z5
    ; z6  z7  z8  z9  z10
    ; z11 z12 z13 z14 z15         z25
    ; z16 z17 z18 z19 z20 z21 z22 z23
    ;                             z24

    ; Declaramos la conexión de las zonas
    (conectado z1 z2 este)
    (conectado z2 z1 oeste)
    (conectado z2 z3 este)
    (conectado z3 z2 oeste)
    (conectado z3 z4 este)
    (conectado z4 z3 oeste)
    (conectado z4 z5 este)
    (conectado z5 z4 oeste)
    (conectado z1 z6 sur)
    (conectado z6 z1 norte)
    (conectado z2 z7 sur)
    (conectado z7 z2 norte)
    (conectado z3 z8 sur)
    (conectado z8 z3 norte)
    (conectado z4 z9 sur)
    (conectado z9 z4 norte)
    (conectado z5 z10 sur)
    (conectado z10 z5 norte)
    (conectado z6 z7 este)
    (conectado z7 z6 oeste)
    (conectado z7 z8 este)
    (conectado z8 z7 oeste)
    (conectado z8 z9 este)
    (conectado z9 z8 oeste)
    (conectado z9 z10 este)
    (conectado z10 z9 oeste)
    (conectado z6 z11 sur)
    (conectado z11 z6 norte)
    (conectado z7 z12 sur)
    (conectado z12 z7 norte)
    (conectado z8 z13 sur)
    (conectado z13 z8 norte)
    (conectado z9 z14 sur)
    (conectado z14 z9 norte)
    (conectado z10 z15 sur)
    (conectado z15 z10 norte)
    (conectado z11 z12 este)
    (conectado z12 z11 oeste)
    (conectado z12 z13 este)
    (conectado z13 z12 oeste)
    (conectado z13 z14 este)
    (conectado z14 z13 oeste)
    (conectado z14 z15 este)
    (conectado z15 z14 oeste)
    (conectado z11 z16 sur)
    (conectado z16 z11 norte)
    (conectado z12 z17 sur)
    (conectado z17 z12 norte)
    (conectado z13 z18 sur)
    (conectado z18 z13 norte)
    (conectado z14 z19 sur)
    (conectado z19 z14 norte)
    (conectado z15 z20 sur)
    (conectado z20 z15 norte)
    (conectado z16 z17 este)
    (conectado z17 z16 oeste)
    (conectado z17 z18 este)
    (conectado z18 z17 oeste)
    (conectado z18 z19 este)
    (conectado z19 z18 oeste)
    (conectado z19 z20 este)
    (conectado z20 z19 oeste)
    (conectado z20 z21 este)
    (conectado z21 z20 oeste)
    (conectado z21 z22 este)
    (conectado z22 z21 oeste)
    (conectado z22 z23 este)
    (conectado z23 z22 oeste)
    (conectado z25 z23 sur)
    (conectado z23 z25 norte)
    (conectado z23 z24 sur)
    (conectado z24 z23 norte)

    ; Declaramos el tipo de superficie de cada zona
    (es piedra z1)
    (es piedra z2)
    (es arena z3)
    (es piedra z4)
    (es piedra z5)
    (es arena z6)
    (es arena z7)
    (es arena z8)
    (es arena z9)
    (es arena z10)
    (es arena z11)
    (es piedra z12)
    (es piedra z13)
    (es piedra z14)
    (es agua z15)
    (es arena z16)
    (es arena z17)
    (es arena z18)
    (es precipicio z19)
    (es arena z20)
    (es piedra z21)
    (es arena z22)
    (es piedra z23)
    (es piedra z24)
    (es piedra z25)

    ; Declaramos el coste de ir de una zona a otra
    (= (coste z1 z2) 5)
    (= (coste z2 z1) 5)
    (= (coste z2 z3) 4)
    (= (coste z3 z2) 4)
    (= (coste z3 z4) 3)
    (= (coste z4 z3) 3)
    (= (coste z4 z5) 8)
    (= (coste z5 z4) 8)

    (= (coste z1 z6) 2)
    (= (coste z6 z1) 2)
    (= (coste z2 z7) 5)
    (= (coste z7 z2) 5)
    (= (coste z3 z8) 6)
    (= (coste z8 z3) 6)
    (= (coste z4 z9) 5)
    (= (coste z9 z4) 5)
    (= (coste z5 z10) 2)
    (= (coste z10 z5) 2)

    (= (coste z6 z7) 3)
    (= (coste z7 z6) 3)
    (= (coste z7 z8) 6)
    (= (coste z8 z7) 6)
    (= (coste z8 z9) 5)
    (= (coste z9 z8) 5)
    (= (coste z9 z10) 1)
    (= (coste z10 z9) 1)

    (= (coste z6 z11) 1)
    (= (coste z11 z6) 1)
    (= (coste z7 z12) 1)
    (= (coste z12 z7) 1)
    (= (coste z8 z13) 1)
    (= (coste z13 z8) 1)
    (= (coste z9 z14) 1)
    (= (coste z14 z9) 1)
    (= (coste z10 z15) 1)
    (= (coste z15 z10) 1)

    (= (coste z11 z12) 7)
    (= (coste z12 z11) 7)
    (= (coste z12 z13) 2)
    (= (coste z13 z12) 2)
    (= (coste z13 z14) 6)
    (= (coste z14 z13) 6)
    (= (coste z14 z15) 2)
    (= (coste z15 z14) 2)

    (= (coste z11 z16) 4)
    (= (coste z16 z11) 4)
    (= (coste z12 z17) 3)
    (= (coste z17 z12) 3)
    (= (coste z13 z18) 2)
    (= (coste z18 z13) 2)
    (= (coste z14 z19) 6)
    (= (coste z19 z14) 6)
    (= (coste z15 z20) 8)
    (= (coste z20 z15) 8)

    (= (coste z16 z17) 8)
    (= (coste z17 z16) 8)
    (= (coste z17 z18) 9)
    (= (coste z18 z17) 9)
    (= (coste z18 z19) 2)
    (= (coste z19 z18) 2)
    (= (coste z19 z20) 5)
    (= (coste z20 z19) 5)
    (= (coste z20 z21) 2)
    (= (coste z21 z20) 2)
    (= (coste z21 z22) 1)
    (= (coste z22 z21) 1)
    (= (coste z22 z23) 4)
    (= (coste z23 z22) 4)

    (= (coste z25 z23) 8)
    (= (coste z23 z25) 8)
    (= (coste z23 z24) 6)
    (= (coste z24 z23) 6)

    ; Inicializamos el coste total a 0
    (= (costeTotal) 0)

    ; Inicializamos el número total de puntos a 0
    (= (puntosTotales) 0)

    ; Indicamos el número de puntos que da entregar cada objeto a cada personaje
    (= (puntos oscar1 leonardo1) 10)
    (= (puntos oscar1 princesa1) 5)
    (= (puntos oscar1 bruja1) 4)
    (= (puntos oscar1 profesor1) 3)
    (= (puntos oscar1 principe1) 1)

    (= (puntos rosa1 leonardo1) 1)
    (= (puntos rosa1 princesa1) 10)
    (= (puntos rosa1 bruja1) 5)
    (= (puntos rosa1 profesor1) 4)
    (= (puntos rosa1 principe1) 3)

    (= (puntos manzana1 leonardo1) 3)
    (= (puntos manzana1 princesa1) 1)
    (= (puntos manzana1 bruja1) 10)
    (= (puntos manzana1 profesor1) 5)
    (= (puntos manzana1 principe1) 4)

    (= (puntos algoritmo1 leonardo1) 4)
    (= (puntos algoritmo1 princesa1) 3)
    (= (puntos algoritmo1 bruja1) 1)
    (= (puntos algoritmo1 profesor1) 10)
    (= (puntos algoritmo1 principe1) 5)

    (= (puntos oro1 leonardo1) 5)
    (= (puntos oro1 princesa1) 4)
    (= (puntos oro1 bruja1) 3)
    (= (puntos oro1 profesor1) 1)
    (= (puntos oro1 principe1) 10)

    ; z1[ag] ==5== z2 ==4== z3[psa] =3== z4 ====8==== z5[pcpe]
    ; ==2==       =5=       ==6==       =5=           ===2===
    ; z6[oro] ==3= z7 ==6== z8[osc] =5== z9 ====1==== z10[leo]
    ; ==1===       =1=      ===1==       =1=          ===1=
    ; z11[bja] =7= z12 ==2= z13 ===6==== z14[man] =2= z15                            z25
    ; ==4===       =3=      =2=          ==6==        =8=                            =8=
    ; z16 ====8=== z17 ==9= z18[pro] =2= z19 ===5==== z20 =2= z21[rsa] =1= z22 ==4== z23[algo]
    ;                                                                                =6=
    ;                                                                                z24

    ; Declaramos la orientación del agente y que tiene la mano y la mochila vacías
    (orientado agente1 norte)
    (manovacia agente1)
    (mochilavacia agente1)

    ; Declaramos la posición de los personajes
    (en agente1 z1)
    (en princesa1 z3)
    (en principe1 z5)
    (en bruja1 z11)
    (en leonardo1 z10)
    (en profesor1 z18)

    ; Declaramos la posición de los objetos
    (en oscar1 z8)
    (en manzana1 z14)
    (en rosa1 z21)
    (en algoritmo1 z23)
    (en oro1 z6)

    ; Declaramos la posición del bikini y las zapatillas
    (en bikini1 z16)
    (en zapatilla1 z15)
    ; Indicamos que son zapatillas y bikini
    (eszapatilla zapatilla1)
    (esbikini bikini1)
  )
  (:goal (AND
            ; Requerimos que todos los personajes tengan al menos un objeto.
            (tieneobjeto princesa1)
            (tieneobjeto principe1)
            (tieneobjeto bruja1)
            (tieneobjeto profesor1)
            (tieneobjeto leonardo1)
            ; Requerimos que la longitud total sea menor que 700
            (< (costeTotal) 700)
            ; Requerimos que el número de puntos totales sea mayor que 20
            (>= (puntosTotales) 20)
          )
  )
)

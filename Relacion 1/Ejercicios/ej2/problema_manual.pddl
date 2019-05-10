(define (problem problema-ej2)
  (:domain dominio-ej2)
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
  )
  (:init
    ; z1  z2  z3  z4  z5
    ; z6  z7  z8  z9  z10
    ; z11 z12 z13 z14 z15         z25
    ; z16 z17 z18 z19 z20 z21 z22 z23
    ;                             z24

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

    (= (costeTotal) 0)

    ; z1[ag] ==5== z2 ==4== z3[psa] =3== z4 ====8==== z5[pcpe]
    ; ==2==       =5=       ==6==       =5=           ===2===
    ; z6[oro] ==3= z7 ==6== z8[osc] =5== z9 ====1==== z10[leo]
    ; ==1===       =1=      ===1==       =1=          ===1=
    ; z11[bja] =7= z12 ==2= z13 ===6==== z14[man] =2= z15                            z25
    ; ==4===       =3=      =2=          ==6==        =8=                            =8=
    ; z16 ====8=== z17 ==9= z18[pro] =2= z19 ===5==== z20 =2= z21[rsa] =1= z22 ==4== z23[algo]
    ;                                                                                =6=
    ;                                                                                z24


    (orientado agente1 norte)
    (manovacia agente1)
    (en agente1 z1)
    (en princesa1 z3)
    (en principe1 z5)
    (en bruja1 z11)
    (en leonardo1 z10)
    (en profesor1 z18)

    (en oscar1 z8)
    (en manzana1 z14)
    (en rosa1 z21)
    (en algoritmo1 z23)
    (en oro1 z6)
  )
  (:goal (AND
            (tieneobjeto princesa1)
            (tieneobjeto principe1)
            (tieneobjeto bruja1)
            (tieneobjeto profesor1)
            (tieneobjeto leonardo1)
            (< (costeTotal) 200)
          )
  )
  (:metric (costeTotal))
)

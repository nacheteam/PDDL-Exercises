(define (problem problema-ej1)
  (:domain dominio-ej1)
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


    ; z1[ag]   z2       z3[psa]  z4       z5[pcpe]
    ; z6[oro]  z7       z8[osc]  z9       z10[leo]
    ; z11[bja] z12      z13      z14[man] z15                        z25
    ; z16      z17      z18[pro] z19      z20      z21[rsa] z22      z23[algo]
    ;                                                                z24
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
          )
  )
)

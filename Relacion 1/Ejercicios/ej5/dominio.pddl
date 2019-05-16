(define (domain Ejercicio5)
  (:requirements :strips :equality :typing)
  (:types  zona
           orientacion
           agente princesa principe bruja profesor leonardo - personaje
           oscar manzana rosa algoritmo oro zapatilla bikini - objeto
           personaje objeto - posicionable
           superficie
  )

  (:constants
    norte - orientacion
    sur - orientacion
    este - orientacion
    oeste - orientacion
    bosque - superficie
    agua - superficie
    precipicio - superficie
    arena - superficie
    piedra - superficie
  )

  (:predicates
    (en ?x - posicionable ?y - zona)
    (orientado ?a - personaje ?ori - orientacion)
    (conectado ?z1 ?z2 - zona ?ori - orientacion)
    (manovacia ?a - agente)
    (enlamano ?a - agente ?obj - objeto)
    (mochilavacia ?a - agente)
    (enlamochila ?a - agente ?obj - objeto)
    (tieneobjeto ?per - personaje)
    (es ?sup - superficie ?z - zona)
    (esbikini ?obj - objeto)
    (eszapatilla ?obj - objeto)
	)

  (:functions
	    (coste ?z1 ?z2 - zona)
      (costeTotal)
      (puntosTotales)
      (puntos ?obj - objeto ?pers - personaje)
      (numeroObjetos ?per - personaje)
  )

  (:action girar-izquierda
	     :parameters (?age - agente)
	     :effect (and
                  (when (and(orientado ?age norte))
                    (and
                      (orientado ?age oeste)
                      (not (orientado ?age norte))
                    )
                  )
                  (when (and(orientado ?age oeste))
                    (and
                      (orientado ?age sur)
                      (not (orientado ?age oeste))
                    )
                  )
                  (when (and(orientado ?age sur))
                    (and
                      (orientado ?age este)
                      (not (orientado ?age sur))
                    )
                  )
                  (when (and(orientado ?age este))
                    (and
                      (orientado ?age norte)
                      (not (orientado ?age este))
                    )
                  )
	             )
  )

  (:action girar-derecha
	     :parameters (?age - agente)
	     :effect (and
                  (when (and(orientado ?age norte))
                    (and
                      (orientado ?age este)
                      (not (orientado ?age norte))
                    )
                  )
                  (when (and(orientado ?age oeste))
                    (and
                      (orientado ?age norte)
                      (not (orientado ?age oeste))
                    )
                  )
                  (when (and(orientado ?age sur))
                    (and
                      (orientado ?age oeste)
                      (not (orientado ?age sur))
                    )
                  )
                  (when (and(orientado ?age este))
                    (and
                      (orientado ?age sur)
                      (not (orientado ?age este))
                    )
                  )
	             )
  )


  (:action ir
    :parameters (?age - agente ?z1 ?z2 - zona ?ori - orientacion ?obj - objeto)
    :precondition (and
                    (en ?age ?z1)
                    (orientado ?age ?ori)
                    (conectado ?z1 ?z2 ?ori)
                    (not (es precipicio ?z2))
                    (or
                      (not (es bosque ?z2))
                      (and
                        (es bosque ?z2)
                        (eszapatilla ?obj)
                        (or
                          (enlamochila ?age ?obj)
                          (enlamano ?age ?obj)
                        )
                      )
                    )
                    (or
                      (not (es agua ?z2))
                      (and
                        (es agua ?z2)
                        (esbikini ?obj)
                        (or
                          (enlamochila ?age ?obj)
                          (enlamano ?age ?obj)
                        )
                      )
                    )
                  )
    :effect (and
              (en ?age ?z2)
              (not (en ?age ?z1))
              (increase (costeTotal) (coste ?z1 ?z2))
            )
  )

  (:action coger
    :parameters (?age - agente ?z1 - zona ?obj - objeto)
    :precondition (and
                    (en ?age ?z1)
                    (en ?obj ?z1)
                    (manovacia ?age)
                  )
    :effect (and
              (not (en ?obj ?z1))
              (not (manovacia ?age))
              (enlamano ?age ?obj)
            )
  )

  (:action dejar
    :parameters (?age - agente ?z1 - zona ?obj - objeto)
    :precondition (and
                    (en ?age ?z1)
                    (enlamano ?age ?obj)
                  )
    :effect (and
              (en ?obj ?z1)
              (manovacia ?age)
              (not (enlamano ?age ?obj))
            )
  )

  (:action entregar
    :parameters (?age - agente ?z1 - zona ?obj - objeto ?per - personaje)
    :precondition (and
                    (en ?age ?z1)
                    (en ?per ?z1)
                    (> (numeroObjetos ?per) 0)
                    (enlamano ?age ?obj)
                  )
    :effect (and
              (manovacia ?age)
              (not (enlamano ?age ?obj))
              (increase (puntosTotales) (puntos ?obj ?per))
              (tieneobjeto ?per)
              (decrease (numeroObjetos ?per) 1)
            )
  )

  (:action meter-mochila
    :parameters (?age - agente ?obj - objeto)
    :precondition (and
                    (enlamano ?age ?obj)
                    (mochilavacia ?age)
                  )
    :effect (and
              (manovacia ?age)
              (not (enlamano ?age ?obj))
              (not (mochilavacia ?age))
              (enlamochila ?age ?obj)
            )
  )

  (:action sacar-mochila
    :parameters (?age - agente ?obj - objeto)
    :precondition (and
                    (enlamochila ?age ?obj)
                    (manovacia ?age)
                  )
    :effect (and
              (mochilavacia ?age)
              (not (enlamochila ?age ?obj))
              (not (manovacia ?age))
              (enlamano ?age ?obj)
            )
  )
)

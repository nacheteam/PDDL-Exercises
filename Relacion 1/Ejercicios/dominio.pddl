(define (domain dominio-belkan)	       ; Comment: adding location caused fail
  (:requirements :strips :equality :typing)
  (:types  zona
           orientacion
           agente princesa principe bruja profesor leonardo - personaje
           oscar manzana rosa algoritmo oro - objeto
           personaje objeto - posicionable
  )

  (:constants
    norte - orientacion
    sur - orientacion
    este - orientacion
    oeste - orientacion
  )

  (:predicates
    (en ?x - posicionable ?y - zona)
    (orientado ?a - personaje ?ori - orientacion)
    (conectado ?z1 ?z2 - zona ?ori - orientacion)
    (manovacia ?a - personaje)
    (enlamano ?a - personaje ?obj - objeto)
	)

  (:action girar-izquierda
	     :parameters (?age - agente)
	     :precondition (and
	                   )
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
	     :precondition (and
	                   )
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
    :parameters (?age - agente ?z1 ?z2 - zona ?ori - orientacion)
    :precondition (and
                    (en ?age ?z1)
                    (orientado ?age ?ori)
                    (conectado ?z1 ?z2 ?ori)
                  )
    :effect (and
              (en ?age ?z2)
              (not (en ?age ?z1))
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

(define (domain belkan)	       ; Comment: adding location caused fail
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
	)

  (:action girar-izquierda
	     :parameters (?age - agente ?ori - orientacion)
	     :precondition (and
                        (orientado ?age ?ori)
	                   )
	     :effect (and
                  (when (and(orientado ?age norte))
                    (and
                      (orientado ?age oeste)
                      (not (orientado ?age ?ori))
                    )
                  )
                  (when (and(orientado ?age oeste))
                    (and
                      (orientado ?age sur)
                      (not (orientado ?age ?ori))
                    )
                  )
                  (when (and(orientado ?age sur))
                    (and
                      (orientado ?age este)
                      (not (orientado ?age ?ori))
                    )
                  )
                  (when (and(orientado ?age este))
                    (and
                      (orientado ?age norte)
                      (not (orientado ?age ?ori))
                    )
                  )
	             )
  )

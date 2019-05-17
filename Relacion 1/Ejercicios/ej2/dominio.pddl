(define (domain Ejercicio2)
  (:requirements :strips :equality :typing)
  ; Definimos los tipos
  (:types  zona
           orientacion
           agente princesa principe bruja profesor leonardo - personaje
           oscar manzana rosa algoritmo oro - objeto
           personaje objeto - posicionable
  )

  ; Defino las constantes de la orientación
  (:constants
    norte - orientacion
    sur - orientacion
    este - orientacion
    oeste - orientacion
  )

  (:predicates
    ; Indica la posición de un personaje u objeto en una zona
    (en ?x - posicionable ?y - zona)
    ; Indica la orientación de un personaje
    (orientado ?a - personaje ?ori - orientacion)
    ; Indica que dos zonas están conectadas y por qué lado mediante la orientación
    (conectado ?z1 ?z2 - zona ?ori - orientacion)
    ; Indica que el agente tiene la mano vacía
    (manovacia ?a - agente)
    ; Indica que el agente tiene un objeto en la mano
    (enlamano ?a - agente ?obj - objeto)
    ; Indica que un personaje posee un objeto
    (tieneobjeto ?per - personaje)
	)

  ; Definición de las funciones
  (:functions
      ; Indica el coste de ir de una zona a otra
	    (coste ?z1 ?z2 - zona)
      ; Almacena el coste total del camino
      (costeTotal)
  )

  ; Acción de girar hacia la izquierda
  (:action girar-izquierda
	     :parameters (?age - agente)
       ; No tiene precondiciones
       ; Cambiamos la orientación gracias al giro
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

  ; Acción de girar hacia la derecha
  (:action girar-derecha
	     :parameters (?age - agente)
       ; No tiene precondiciones
       ; Cambiamos la orientación gracias al giro
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

  ; Acción de ir de una zona a otra
  (:action ir
    :parameters (?age - agente ?z1 ?z2 - zona ?ori - orientacion)
    ; Debemos estar en una zona, la zona en la que estamos y hacia la que queremos ir deben
    ; estar conectadas y debemos estar orientados en la misma orientación que conecta
    ; las zonas
    :precondition (and
                    (en ?age ?z1)
                    (orientado ?age ?ori)
                    (conectado ?z1 ?z2 ?ori)
                  )
    ; Ahora el agente está en la segunda zona y no en la primera y se suma al coste
    ; total el coste de ir de z1 a z2
    :effect (and
              (en ?age ?z2)
              (not (en ?age ?z1))
              (increase (costeTotal) (coste ?z1 ?z2))
            )
  )

  ; Acción de coger un objeto
  (:action coger
    :parameters (?age - agente ?z1 - zona ?obj - objeto)
    ; El agente y el objeto deben estar en la misma zona y además tiene que tener
    ; el agente la mano vacía
    :precondition (and
                    (en ?age ?z1)
                    (en ?obj ?z1)
                    (manovacia ?age)
                  )
    ; El objeto deja de estar en esa zona, el agente deja de tener la mano vacía
    ; y pasa a tener el objeto en la mano
    :effect (and
              (not (en ?obj ?z1))
              (not (manovacia ?age))
              (enlamano ?age ?obj)
            )
  )

  ; Acción de dejar un objeto en el suelo
  (:action dejar
    :parameters (?age - agente ?z1 - zona ?obj - objeto)
    ; El agente debe estar en una zona y tener el objeto en la mano
    :precondition (and
                    (en ?age ?z1)
                    (enlamano ?age ?obj)
                  )
    ; Como efecto produce que el objeto esté en la misma zona que el agente, que
    ; este tenga la mano vacía y que no tenga el objeto en la mano.
    :effect (and
              (en ?obj ?z1)
              (manovacia ?age)
              (not (enlamano ?age ?obj))
            )
  )

  ; Acción de entregar un objeto a un personaje
  (:action entregar
    :parameters (?age - agente ?z1 - zona ?obj - objeto ?per - personaje)
    ; El agente y el personaje deben estar en la misma zona y el agente debe
    ; tener el objeto en la mano
    :precondition (and
                    (en ?age ?z1)
                    (en ?per ?z1)
                    (enlamano ?age ?obj)
                  )
    ; El agente pasa a tener la mano vacía y no tener el objeto en la mano y el personaje
    ; pasa a tener al menos un objeto.
    :effect (and
              (manovacia ?age)
              (not (enlamano ?age ?obj))
              (tieneobjeto ?per)
            )
  )
)

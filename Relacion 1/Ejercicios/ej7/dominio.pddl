﻿(define (domain Ejercicio7)
  (:requirements :strips :equality :typing)
  ; Definimos los tipos
  (:types  zona
           orientacion
           agente princesa principe bruja profesor leonardo - personaje
           oscar manzana rosa algoritmo oro zapatilla bikini - objeto
           personaje objeto - posicionable
           superficie
  )

  ; Defino las constantes de la orientación y las
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
    ; Indica que el agente tiene la mochila vacía
    (mochilavacia ?a - agente)
    ; Indica que el agente tiene un objeto en la mochila
    (enlamochila ?a - agente ?obj - objeto)
    ; Indica que un personaje posee un objeto
    (tieneobjeto ?per - personaje)
    ; Indica que una zona es de un tipo de superficie
    (es ?sup - superficie ?z - zona)
    ; Indica que un objeto es un bikini
    (esbikini ?obj - objeto)
    ; Indica que un objeto es una zapatilla
    (eszapatilla ?obj - objeto)
    ; Indica que el agente es de tipo picker
    (espicker ?per - agente)
    ; Indica que el agente es de tipo dealer
    (esdealer ?per - agente)
	)

  ; Definición de las funciones
  (:functions
      ; Indica el coste de ir de una zona a otra
	    (coste ?z1 ?z2 - zona)
      ; Almacena el coste total del camino
      (costeTotal)
      ; Lleva la cuenta del número de puntos totales conseguidos
      (puntosTotales)
      ; Indica el número de puntos obtenidos por el momento por el agente.
      (puntosObtenidos ?age - agente)
      ; Indica el número de puntos que da darle un objeto a un personaje
      (puntos ?obj - objeto ?pers - personaje)
      ; Indica el número de huecos libres que le quedan a un personaje
      ; para albergar objetos
      (numeroObjetos ?per - personaje)
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
    :parameters (?age - agente ?z1 ?z2 - zona ?ori - orientacion ?obj - objeto)
    ; Debemos estar en la zona 1, que la zona a la que queremos ir y en la que estamos
    ; estén conectadas y que nosotros tengamos la misma orientación que conecta a
    ; las dos zonas. Además la zona a la que queremos ir no debe ser un precipicio.
    ; Además la zona tiene que o no ser un bosque o que si es un bosque tengamos
    ; unas zapatillas en la mano o en la mochila. Además la zona tiene que o no ser
    ; agua o si es agua debemos tener un bikini en la mano o en la mochila.
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
    ; el agente la mano vacía. Además ahora el agente tiene que ser picker.
    :precondition (and
                    (espicker ?age)
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

  ; Acción para entregar un objeto de un picker a un dealer
  (:action entregar-agente
    :parameters (?age1 ?age2 - agente ?z1 - zona ?obj - objeto)
    ; El agente que da tiene que ser un picker y el que recibe el objeto tiene que
    ; ser un dealer, además deben estar en la misma zona y el agente que da el
    ; objeto lo debe de tener en la mano y el que recibe el objeto debe tener
    ; la mano vacía.
    :precondition (and
                    (espicker ?age1)
                    (esdealer ?age2)
                    (en ?age1 ?z1)
                    (en ?age2 ?z1)
                    (manovacia ?age2)
                    (enlamano ?age1 ?obj)
                  )
    ; El efecto que produce es que el agente que tenía el objeto deja de tenerlo
    ; y pasa a tener la mano vacía y el agente que recibe el objeto deja de tener
    ; la mano vacía y pasa a tener el objeto en la mano.
    :effect (and
              (manovacia ?age1)
              (not (enlamano ?age1 ?obj))
              (enlamano ?age2 ?obj)
              (not (manovacia ?age2))
            )
  )

  ; Acción de entregar un objeto a un personaje
  (:action entregar-personaje
    :parameters (?age - agente ?z1 - zona ?obj - objeto ?per - personaje)
    ; El agente y el personaje deben estar en la misma zona y el agente debe
    ; tener el objeto en la mano. Además ahora el personaje debe tener capacidad
    ; para poder coger el objeto, esto es que el número de huecos libres que tiene
    ; sea mayor que 0. Además el agente debe de ser de tipo dealer.
    :precondition (and
                    (esdealer ?age)
                    (en ?age ?z1)
                    (en ?per ?z1)
                    (> (numeroObjetos ?per) 0)
                    (enlamano ?age ?obj)
                  )
    ; El agente pasa a tener la mano vacía y no tener el objeto en la mano y el personaje
    ; pasa a tener al menos un objeto. Además se suma a la cuenta total de puntos
    ; el número de puntos que da entregar el objeto al personaje. Además se decrementa
    ; en 1 el número de huecos libres que tiene el personaje.
    :effect (and
              (manovacia ?age)
              (not (enlamano ?age ?obj))
              (increase (puntosTotales) (puntos ?obj ?per))
              (increase (puntosObtenidos ?age) (puntos ?obj ?per))
              (tieneobjeto ?per)
              (decrease (numeroObjetos ?per) 1)
            )
  )

  ; Acción de meter un objeto en la mochila
  (:action meter-mochila
    :parameters (?age - agente ?obj - objeto)
    ; Debemos tener el objeto en la mano y la mochila vacía
    :precondition (and
                    (enlamano ?age ?obj)
                    (mochilavacia ?age)
                  )
    ; Pasamos a tener la mano vacía, no tener el objeto en la mano y que la mochila
    ; no esté vacía y tenga el objeto.
    :effect (and
              (manovacia ?age)
              (not (enlamano ?age ?obj))
              (not (mochilavacia ?age))
              (enlamochila ?age ?obj)
            )
  )

  ; Acción de sacar un objeto de la mochila
  (:action sacar-mochila
    :parameters (?age - agente ?obj - objeto)
    ; Debemos tener el objeto en la mochila y la mano vacía
    :precondition (and
                    (enlamochila ?age ?obj)
                    (manovacia ?age)
                  )
    ; Pasamos a tener la mochila vacía, no tener el objeto en la mochila y
    ; no tener la mano vacía para tener el objeto en la mano.
    :effect (and
              (mochilavacia ?age)
              (not (enlamochila ?age ?obj))
              (not (manovacia ?age))
              (enlamano ?age ?obj)
            )
  )
)

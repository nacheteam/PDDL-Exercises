(define (domain zeno-travel)


(:requirements
  :typing
  :fluents
  :derived-predicates
  :negative-preconditions
  :universal-preconditions
  :disjuntive-preconditions
  :conditional-effects
  :htn-expansion

  ; Requisitos adicionales para el manejo del tiempo
  :durative-actions
  :metatags
 )

(:types aircraft person city - object)
(:constants slow fast - object)
(:predicates (at ?x - (either person aircraft) ?c - city)
             (in ?p - person ?a - aircraft)
             (different ?x ?y) (igual ?x ?y)
             (hay-fuel-lento ?a ?c1 ?c2)
             (hay-fuel-rapido ?a ?c1 ?c2)
             (destino ?x - person ?y - city)
             )
(:functions (fuel ?a - aircraft)
            (distance ?c1 - city ?c2 - city)
            (slow-speed ?a - aircraft)
            (fast-speed ?a - aircraft)
            (slow-burn ?a - aircraft)
            (fast-burn ?a - aircraft)
            (capacity ?a - aircraft)
            (refuel-rate ?a - aircraft)
            (total-fuel-used ?a - aircraft)
            (boarding-time)
            (debarking-time)
            (fuel-limit ?a - aircraft)
            (capacidad-personas ?a - aircraft)
            (personas-dentro ?a - aircraft)
            (maximo-tiempo-vuelo ?a)
            (tiempo-vuelo ?a)
            )

(:derived
  (hay-fuel-rapido ?a ?c1 ?c2)
  (and
      (>= (fuel ?a) (* (fast-burn ?a) (distance ?c1 ?c2)))
      (>= (fuel-limit ?a) (+ (total-fuel-used ?a) (* (fast-burn ?a) (distance ?c1 ?c2))))
  )
)

;; este literal derivado se utiliza para deducir, a partir de la información en el estado actual,
;; si hay fuel suficiente para que el avión ?a vuele de la ciudad ?c1 a la ?c2
;; el antecedente de este literal derivado comprueba si el fuel actual de ?a es mayor que 1.
;; En este caso es una forma de describir que no hay restricciones de fuel. Pueden introducirse una
;; restricción más copleja  si en lugar de 1 se representa una expresión más elaborada (esto es objeto de
;; los siguientes ejercicios).
(:derived

  (hay-fuel-lento ?a - aircraft ?c1 - city ?c2 - city)
  (and
      (>= (fuel ?a) (* (slow-burn ?a) (distance ?c1 ?c2)))
      (>= (fuel-limit ?a) (+ (total-fuel-used ?a) (* (slow-burn ?a) (distance ?c1 ?c2))))
  )
  )

  (:task transport-person
  	:parameters (?p - person ?c - city)

    (:method Case1 ; si la persona est� en la ciudad no se hace nada
  	 :precondition (at ?p ?c)
  	 :tasks ()
     )


     (:method Case2 ;si no est� en la ciudad destino, pero avion y persona est�n en la misma ciudad
  	  :precondition (and (at ?p - person ?c1 - city)
  			                 (at ?a - aircraft ?c1 - city))

  	  :tasks (
  	  	      (montar-persona ?a ?c1)
  		        (mover-avion ?a ?c1 ?c)
  		        (bajar-persona ?a ?c)))
    (:method Case3
      :precondition (and
                      (at ?p - person ?c1 - city)
                      (at ?a - aircraft ?c2 - city)
                    )
      :tasks (
                (mover-avion ?a ?c2 ?c1)
                (montar-persona ?a ?c1)
                (mover-avion ?a ?c1 ?c)
                (bajar-persona ?a ?c)
              )
    )
    (:method Case4
      :precondition (and
                      (in ?p - person ?a - aircraft)
                      (at ?a - aircraft ?c1 - city)
                      (not (destino ?p ?c1))
                    )
      :tasks (
          (mover-avion ?a ?c1 ?c)
          (bajar-persona ?a ?c)
        )
      )
  	)

(:task montar-persona
  :parameters (?a - aircraft ?c1 - city)
  (:method montar
    :precondition (and
                    (at ?p - person ?c1)
                    (not (destino ?p - person ?c1))
                    (at ?a - aircraft ?c1)
                  )
    :tasks (
      (board ?p ?a ?c1)
      (montar-persona ?a ?c1)
      )
    )
  (:method caso-base
    :precondition ()
    :tasks ()
    )
)

(:task bajar-persona
  :parameters (?a - aircraft ?c1 - city)
  (:method montar
    :precondition (and
                    (in ?p - person ?a)
                    (destino ?p - person ?c1)
                    (at ?a ?c1)
                  )
    :tasks (
      (debark ?p ?a ?c1)
      (bajar-persona ?a ?c1)
      )
    )
  (:method caso-base
    :precondition ()
    :tasks ()
    )
)

(:task mover-avion
 :parameters (?a - aircraft ?c1 - city ?c2 -city)
 (:method caso-base
   :precondition (at ?a ?c2)
   :tasks ()
   )
 (:method fuel-suficiente-rapido
   :precondition (hay-fuel-rapido ?a ?c1 ?c2)
   :tasks (
        (zoom ?a ?c1 ?c2)
     )
   )
 (:method fuel-suficiente-lento ;; este método se escogerá para usar la acción fly siempre que el avión tenga fuel para
                          ;; volar desde ?c1 a ?c2
			  ;; si no hay fuel suficiente el método no se aplicará y la descomposición de esta tarea
			  ;; se intentará hacer con otro método. Cuando se agotan todos los métodos posibles, la
			  ;; descomponsición de la tarea mover-avión "fallará".
			  ;; En consecuencia HTNP hará backtracking y escogerá otra posible vía para descomponer
			  ;; la tarea mover-avion (por ejemplo, escogiendo otra instanciación para la variable ?a)
  :precondition (and
                  (hay-fuel-lento ?a ?c1 ?c2)
                  (not (hay-fuel-rapido ?a ?c1 ?c2))
                  )
  :tasks (
          (fly ?a ?c1 ?c2)
         )
   )

   (:method no-fuel-suficiente
     :precondition (and
                      (not (hay-fuel-lento ?a ?c1 ?c2))
                      (not (hay-fuel-rapido ?a ?c1 ?c2))
                    )
     :tasks (
              (refuel ?a ?c1)
              (mover-avion ?a ?c1 ?c2)
            )
     )
  )

  (:durative-action board
   :parameters (?p - person ?a - aircraft ?c - city)
   :duration (= ?duration (boarding-time))
   :condition (and  (at ?p ?c)
                    (at ?a ?c)
                    (< (personas-dentro ?a) (capacidad-personas ?a))
                )
   :effect (and  (not (at ?p ?c))
                 (in ?p ?a)
                 (increase (personas-dentro ?a) 1)
            )
  )

  (:durative-action debark
   :parameters (?p - person ?a - aircraft ?c - city)
   :duration (= ?duration (debarking-time))
   :condition (and (in ?p ?a)
                   (at ?a ?c))
   :effect (and  (not (in ?p ?a))
                 (at ?p ?c)
                 (decrease (personas-dentro ?a) 1)
            )
  )

  (:durative-action fly
   :parameters (?a - aircraft ?c1 ?c2 - city)
   :duration (= ?duration (/ (distance ?c1 ?c2) (slow-speed ?a)))
   :condition (and  (at ?a ?c1)
                    (>= (fuel ?a)
                           (* (distance ?c1 ?c2) (slow-burn ?a)))
                    (< (tiempo-vuelo ?a) (maximo-tiempo-vuelo ?a))
              )
   :effect (and  (not (at ?a ?c1))
                 (at ?a ?c2)
                (increase (total-fuel-used ?a)
                           (* (distance ?c1 ?c2) (slow-burn ?a)))
                (decrease (fuel ?a)
                           (* (distance ?c1 ?c2) (slow-burn ?a)))
                (increase (tiempo-vuelo ?a) (/ (distance ?c1 ?c2) (slow-speed ?a)))
              )
  )

  (:durative-action zoom
   :parameters (?a - aircraft ?c1 ?c2 - city)
   :duration (= ?duration (/ (distance ?c1 ?c2) (fast-speed ?a)))
   :condition (and  (at ?a ?c1)
                    (>= (fuel ?a)
                           (* (distance ?c1 ?c2) (fast-burn ?a)))
                    (< (tiempo-vuelo ?a) (maximo-tiempo-vuelo ?a))
              )
   :effect (and (not (at ?a ?c1))
                 (at ?a ?c2)
                 (increase (total-fuel-used ?a)
                           (* (distance ?c1 ?c2) (fast-burn ?a)))
                (decrease (fuel ?a)
                           (* (distance ?c1 ?c2) (fast-burn ?a)))
                (increase (tiempo-vuelo ?a) (/ (distance ?c1 ?c2) (fast-speed ?a)))
            )
)

  (:durative-action refuel
   :parameters (?a - aircraft ?c - city)
   :duration (= ?duration (/ (- (capacity ?a) (fuel ?a)) (refuel-rate ?a)))
   :condition (and  (> (capacity ?a) (fuel ?a))
                   (at ?a ?c)
                   (< (total-fuel-used ?a) (fuel-limit ?a)))
   :effect (assign (fuel ?a) (capacity ?a)))


)

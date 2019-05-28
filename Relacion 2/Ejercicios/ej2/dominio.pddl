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
             (hay-fuel ?a ?c1 ?c2)
             )
(:functions (fuel ?a - aircraft)
            (distance ?c1 - city ?c2 - city)
            (slow-speed ?a - aircraft)
            (fast-speed ?a - aircraft)
            (slow-burn ?a - aircraft)
            (fast-burn ?a - aircraft)
            (capacity ?a - aircraft)
            (refuel-rate ?a - aircraft)
            (total-fuel-used)
            (boarding-time)
            (debarking-time)
            )

;; el consecuente "vac�o" se representa como "()" y significa "siempre verdad"
(:derived
  (igual ?x ?x) ())

(:derived
  (different ?x ?y) (not (igual ?x ?y)))



;; este literal derivado se utiliza para deducir, a partir de la información en el estado actual,
;; si hay fuel suficiente para que el avión ?a vuele de la ciudad ?c1 a la ?c2
;; el antecedente de este literal derivado comprueba si el fuel actual de ?a es mayor que 1.
;; En este caso es una forma de describir que no hay restricciones de fuel. Pueden introducirse una
;; restricción más copleja  si en lugar de 1 se representa una expresión más elaborada (esto es objeto de
;; los siguientes ejercicios).
(:derived

  (hay-fuel ?a - aircraft ?c1 - city ?c2 - city)
  (> (fuel ?a) 1))

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
	  	      (board ?p ?a ?c1)
		        (mover-avion ?a ?c1 ?c)
		        (debark ?p ?a ?c )))
  (:method Case3
    :precondition (and
                    (at ?p - person ?c1 - city)
                    (at ?a - aircraft ?c2 - city)
                  )
    :tasks (
              (mover-avion ?a ?c2 ?c1)
              (board ?p ?a ?c1)
              (mover-avion ?a ?c1 ?c)
              (debark ?p ?a ?c)
            )
  )
	)

(:task mover-avion
 :parameters (?a - aircraft ?c1 - city ?c2 -city)
 (:method fuel-suficiente ;; este método se escogerá para usar la acción fly siempre que el avión tenga fuel para
                          ;; volar desde ?c1 a ?c2
			  ;; si no hay fuel suficiente el método no se aplicará y la descomposición de esta tarea
			  ;; se intentará hacer con otro método. Cuando se agotan todos los métodos posibles, la
			  ;; descomponsición de la tarea mover-avión "fallará".
			  ;; En consecuencia HTNP hará backtracking y escogerá otra posible vía para descomponer
			  ;; la tarea mover-avion (por ejemplo, escogiendo otra instanciación para la variable ?a)
  :precondition (hay-fuel ?a ?c1 ?c2)
  :tasks (
          (fly ?a ?c1 ?c2)
         )
   )

   (:method no-fuel-suficiente
     :precondition (not (hay-fuel ?a ?c1 ?c2))
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
                    (at ?a ?c))
   :effect (and  (not (at ?p ?c))
                 (in ?p ?a)))

  (:durative-action debark
   :parameters (?p - person ?a - aircraft ?c - city)
   :duration (= ?duration (debarking-time))
   :condition (and (in ?p ?a)
                   (at ?a ?c))
   :effect (and  (not (in ?p ?a))
                 (at ?p ?c)))

  (:durative-action fly
   :parameters (?a - aircraft ?c1 ?c2 - city)
   :duration (= ?duration (/ (distance ?c1 ?c2) (slow-speed ?a)))
   :condition (and  (at ?a ?c1)
                    (>= (fuel ?a)
                           (* (distance ?c1 ?c2) (slow-burn ?a))))
   :effect (and  (not (at ?a ?c1))
                 (at ?a ?c2)
                (increase (total-fuel-used)
                           (* (distance ?c1 ?c2) (slow-burn ?a)))
                (decrease (fuel ?a)
                           (* (distance ?c1 ?c2) (slow-burn ?a)))))

  (:durative-action zoom
   :parameters (?a - aircraft ?c1 ?c2 - city)
   :duration (= ?duration (/ (distance ?c1 ?c2) (fast-speed ?a)))
   :condition (and  (at ?a ?c1)
                    (>= (fuel ?a)
                           (* (distance ?c1 ?c2) (fast-burn ?a))))
   :effect (and (not (at ?a ?c1))
                 (at ?a ?c2)
                 (increase (total-fuel-used)
                           (* (distance ?c1 ?c2) (fast-burn ?a)))
                (decrease (fuel ?a)
                           (* (distance ?c1 ?c2) (fast-burn ?a)))))

  (:durative-action refuel
   :parameters (?a - aircraft ?c - city)
   :duration (= ?duration (/ (- (capacity ?a) (fuel ?a)) (refuel-rate ?a)))
   :condition (and  (> (capacity ?a) (fuel ?a))
                   (at ?a ?c))
   :effect (assign (fuel ?a) (capacity ?a)))


)

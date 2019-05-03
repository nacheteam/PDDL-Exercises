(define (domain monkey-domain)	       ; Comment: adding location caused fail
  (:requirements :strips :equality :typing)
  (:types  monkey banana box - locatable
          location)
 
  (:predicates 
	       (on-floor ?x - monkey )
	       (at ?m - locatable ?x - location)
	       (onbox ?x - monkey ?y - location)
	       (hasbananas ?x - monkey)
	       
	       )
	       
  (:functions
         (distanciaTotal)
  )
  (:action GRAB-BANANAS
	     :parameters (?m - monkey ?y - location ?ban - banana)
	     ; Las precondiciones van relacionadas con un and
	     :precondition (and 
	                     (onbox ?m  ?y)
	                     (at ?ban ?y)
	                   )
	     ; Añade este predicado
	     :effect (and
	                   (hasbananas ?m)
	                   (not (at ?ban ?y))
	               )
  )
  (:action GO-OVER-BOX
      :parameters (?m - monkey ?y - location ?b - box)
      :precondition (and 
                        (on-floor ?m)
                        (at ?m ?y)
                        (at ?b ?y)
                    )
      :effect (and
          (onbox ?m ?y)
          (not (on-floor ?m))
      )
  )
  (:action MOVE
      :parameters (?x - monkey ?y1 ?y2 - location)
      :precondition (and (at ?x ?y1))
      :effect (and
          (at ?x ?y2)
          (not (at ?x ?y1))
          )
  )
  (:action PUSH
      :parameters (?x - monkey ?y - location ?b - box ?end - location)
      :precondition (and 
                        (at ?x ?y)
                        (at ?b ?y)
                        (on-floor ?x)
                    )
      :effect (and
          (at ?x ?end)
          (at ?b ?end)
          (not (at ?x ?y))
          (not (at ?b ?y))
          )
  )
)
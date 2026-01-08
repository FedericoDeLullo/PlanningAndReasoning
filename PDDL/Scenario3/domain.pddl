(define (domain aero-scenario-3)
  (:requirements :adl :typing :fluents)

  (:types location sensor)

  (:predicates
    (at ?l - location)
    (connected ?l1 ?l2 - location)
    (sensor_at ?s - sensor ?l - location)
    (active ?s - sensor)
    (is_charger ?l - location)
    (exited)
  )

  (:functions
    (battery) - number
    (time_left) - number 
  )

  (:action move
    :parameters (?from ?to - location)
    :precondition (and 
        (at ?from) 
        (connected ?from ?to)
        (>= (battery) 10)    
        (>= (time_left) 5)
    )
    :effect (and 
        (not (at ?from)) (at ?to)
        (decrease (battery) 10)
        (decrease (time_left) 5)
    )
  )

  (:action activate
    :parameters (?s - sensor ?l - location)
    :precondition (and 
        (at ?l)
        (sensor_at ?s ?l)
        (not (active ?s))
        (>= (battery) 15)
        (>= (time_left) 10)
    )
    :effect (and 
        (active ?s)
        (decrease (battery) 15)
        (decrease (time_left) 10)
    )
  )

  (:action recharge
    :parameters (?l - location)
    :precondition (and 
        (at ?l)
        (is_charger ?l)
        (>= (time_left) 20) 
        (< (battery) 90)    
    )
    :effect (and 
        (assign (battery) 100)
        (decrease (time_left) 20)
    )
  )

  (:action exit
    :parameters (?l - location)
    :precondition (and 
        (at ?l)
        (is_charger ?l) 
        (> (time_left) 0) 
        (forall (?s - sensor) (active ?s)) 
        (not (exited))
    )
    :effect (exited)
  )
)
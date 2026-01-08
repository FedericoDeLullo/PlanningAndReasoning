(define (domain aero-scenario-2)
  (:requirements :adl :typing :fluents)

  (:types cell item)

  (:predicates
    (at ?c - cell)
    (adjacent ?c1 ?c2 - cell)
    (wall_between ?c1 ?c2 - cell) 
    (item_at ?i - item ?c - cell)
    (holding ?i - item)
    (is_exit ?c - cell)
    (exited)
  )

  (:functions
    (battery) - number
  )

  (:action move
    :parameters (?from ?to - cell)
    :precondition (and
      (at ?from)
      (adjacent ?from ?to)
      (not (wall_between ?from ?to))
      (>= (battery) 1)
    )
    :effect (and
      (not (at ?from)) (at ?to)
      (decrease (battery) 1)
    )
  )

  (:action jump
    :parameters (?from ?to - cell)
    :precondition (and
      (at ?from)
      (adjacent ?from ?to)
      (wall_between ?from ?to)
      (>= (battery) 20)
    )
    :effect (and
      (not (at ?from)) (at ?to)
      (decrease (battery) 20)
    )
  )

  (:action pick
    :parameters (?i - item ?c - cell)
    :precondition (and
      (at ?c)
      (item_at ?i ?c)
      (>= (battery) 1)
    )
    :effect (and
      (not (item_at ?i ?c))
      (holding ?i)
      (decrease (battery) 1)
    )
  )

  (:action exit
    :parameters (?c - cell ?i - item)
    :precondition (and
      (at ?c)
      (is_exit ?c)
      (holding ?i) 
      (>= (battery) 5)
      (not (exited))
    )
    :effect (exited)
  )
)
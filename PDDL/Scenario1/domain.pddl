(define (domain aero-scenario1)
  (:requirements :adl :typing)
  (:types key container switch - object)

  (:predicates
    (has ?k - key)
    (open ?c - container)
    (locked ?c - container)
    (in ?k - key ?c - container)
    (on ?s - switch)
    (fits ?k - key ?c - container)
    (is-master-key ?k - key)
    (escaped)
  )

  (:action take-key
    :parameters (?k - key ?c - container)
    :precondition (and (open ?c) (in ?k ?c))
    :effect (and (not (in ?k ?c)) (has ?k))
  )

  (:action pick-up-free
    :parameters (?k - key)
    :precondition (not (exists (?c - container) (in ?k ?c)))
    :effect (has ?k)
  )

  (:action unlock
    :parameters (?k - key ?c - container)
    :precondition (and (has ?k) (fits ?k ?c) (locked ?c))
    :effect (and (not (locked ?c)) (open ?c))
  )

  (:action toggle-switch
    :parameters (?s - switch)
    :precondition (not (on ?s))
    :effect (on ?s)
  )

  (:action escape
    :parameters (?k - key)
    :precondition (and 
        (has ?k) 
        (is-master-key ?k)
        (forall (?s - switch) (on ?s))
    )
    :effect (escaped)
  )
)
(define (problem aero-prob-2)
  (:domain aero-scenario-2)

  (:objects
    c1_1 c1_2 c1_3 c1_4 c1_5 c1_6
    c2_1 c2_2 c2_3 c2_4 c2_5 c2_6
    c3_1 c3_2 c3_3 c3_4 c3_5 c3_6
    c4_1 c4_2 c4_3 c4_4 c4_5 c4_6
    c5_1 c5_2 c5_3 c5_4 c5_5 c5_6
    c6_1 c6_2 c6_3 c6_4 c6_5 c6_6 - cell

    key_card - item
  )

  (:init
    (= (battery) 60) 
    (at c1_1)
    (is_exit c1_2)
    (item_at key_card c6_6) 

    (adjacent c1_1 c1_2) (adjacent c1_2 c1_1)
    (wall_between c1_1 c1_2) (wall_between c1_2 c1_1)

    (adjacent c1_1 c2_1) (adjacent c2_1 c1_1)
    (adjacent c2_1 c3_1) (adjacent c3_1 c2_1)
    (adjacent c3_1 c4_1) (adjacent c4_1 c3_1)
    (adjacent c4_1 c5_1) (adjacent c5_1 c4_1)
    (adjacent c5_1 c6_1) (adjacent c6_1 c5_1)

    (adjacent c6_1 c6_2) (adjacent c6_2 c6_1)

    (adjacent c6_2 c5_2) (adjacent c5_2 c6_2)
    (adjacent c5_2 c4_2) (adjacent c4_2 c5_2)
    (adjacent c4_2 c3_2) (adjacent c3_2 c4_2)
    (adjacent c3_2 c2_2) (adjacent c2_2 c3_2)
    (adjacent c2_2 c1_2) (adjacent c1_2 c2_2)

    (adjacent c1_2 c1_3) (adjacent c1_3 c1_2)

    (adjacent c1_3 c2_3) (adjacent c2_3 c1_3)
    (adjacent c2_3 c3_3) (adjacent c3_3 c2_3)
    (adjacent c3_3 c4_3) (adjacent c4_3 c3_3)
    (adjacent c4_3 c5_3) (adjacent c5_3 c4_3)
    (adjacent c5_3 c6_3) (adjacent c6_3 c5_3)

    (adjacent c6_3 c6_4) (adjacent c6_4 c6_3)

    (adjacent c6_4 c5_4) (adjacent c5_4 c6_4)
    (adjacent c5_4 c4_4) (adjacent c4_4 c5_4)
    (adjacent c4_4 c3_4) (adjacent c3_4 c4_4)
    (adjacent c3_4 c2_4) (adjacent c2_4 c3_4)
    (adjacent c2_4 c1_4) (adjacent c1_4 c2_4)

    (adjacent c1_4 c1_5) (adjacent c1_5 c1_4)

    (adjacent c1_5 c2_5) (adjacent c2_5 c1_5)
    (adjacent c2_5 c3_5) (adjacent c3_5 c2_5)
    (adjacent c3_5 c4_5) (adjacent c4_5 c3_5)
    (adjacent c4_5 c5_5) (adjacent c5_5 c4_5)
    (adjacent c5_5 c6_5) (adjacent c6_5 c5_5)

    (adjacent c6_5 c6_6) (adjacent c6_6 c6_5)

    (adjacent c3_3 c3_4) (adjacent c3_4 c3_3) 
    (adjacent c2_4 c2_5) (adjacent c2_5 c2_4)
  )

  (:goal
    (exited)
  )
)
(define (problem aero-scenario1)
  (:domain aero-scenario1)
  (:objects
    k-start k-inter k-master - key
    
    box1 box2 - container
    
    sw1 sw2 sw3 sw4 - switch
  )

  (:init
    (locked box1)
    (locked box2)
    
    (fits k-start box1)
    (fits k-inter box2)
    
    (is-master-key k-master)

    (in k-inter box1)
    (in k-master box2)

  )

  (:goal 
    (escaped)
  )
)
(define (problem aero-scenario-3)
  (:domain aero-scenario-3)

  (:objects 
    hub mod1 mod2 mod3 mod4 mod5 mod6 - location
    s1 s2 s3 s4 s5 s6 - sensor
  )

  (:init
    (= (battery) 60)   
    (= (time_left) 300) 
    
    (at hub)
    (is_charger hub)
    
    
    (connected hub mod1) (connected mod1 hub)
    (connected hub mod2) (connected mod2 hub)
    (connected hub mod3) (connected mod3 hub)
    (connected hub mod4) (connected mod4 hub)
    (connected hub mod5) (connected mod5 hub)
    (connected hub mod6) (connected mod6 hub)

    (connected mod1 mod2) (connected mod2 mod1)
    (connected mod2 mod3) (connected mod3 mod2)
    (connected mod3 mod4) (connected mod4 mod3)
    (connected mod4 mod5) (connected mod5 mod4)
    (connected mod5 mod6) (connected mod6 mod5)
    (connected mod6 mod1) (connected mod1 mod6)
    
    (sensor_at s1 mod1)
    (sensor_at s2 mod2)
    (sensor_at s3 mod3)
    (sensor_at s4 mod4)
    (sensor_at s5 mod5)
    (sensor_at s6 mod6)
    
    (not (active s1)) (not (active s2)) (not (active s3))
    (not (active s4)) (not (active s5)) (not (active s6))
  )

  (:goal (exited))
)
(define (problem world1)
	(:domain shakey_world)
	(:objects room1 room2 room3 door1 door2 door3 shakey small_object1 gripper1 gripper2 box1) ;;; osäker hur vi initialiserar klorna
	(:init (room room1)(room room2) (room room3) (adjacent room1 room 2) (adjacent room2 room 1) (adjacent room2 room 3) (adjacent room3 room2) (at shakey room1)
			(gripper1 left)(gripper2 right)(wide_door door1) (door door2)(wide_door door3) (light_on room3))
			
	(:goal (not(light_on room3) )
	)

)
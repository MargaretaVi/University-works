(define (problem world3)
	(:domain shakeys_world)
	(:objects room1 room2 room3 door1 door2 door3 shakey small_object1 small_object2 box1 left right)
	(:init (room room1)(room room2)(room room3)(adjacent room1 room2)(adjacent room2 room1)(adjacent room2 room3)(adjacent room3 room2)(in_room shakey room1)
		(wide_door door1)(door door2)(wide_door door3) (not (light_on room1)) (not (light_on room2)) (is_box room1 box1) (small_object_in_room room1 small_object1) 
		(small_object_in_room room1 small_object2) (gripper right) (gripper left) (empty left) (empty right) (light_on room3)
	)
			
	(:goal (and  (small_object_in_room room3 small_object1) (small_object_in_room room3 small_object2)(in_room shakey room3) )
	)
	

)

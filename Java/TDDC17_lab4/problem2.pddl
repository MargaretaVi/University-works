(define (problem world2)
	(:domain shakeys_world)
	(:objects room1 room2 room3 door1 door2 door3 shakey box1 left right)
	(:init (room room1) (room room2) (room room3) (adjacent room1 room2) (adjacent room2 room1) (adjacent room2 room3) (adjacent room3 room2) (connected room1 room2 door1)
		(connected room2 room3 door2) (connected room2 room3 door3) (wide_door door1) (door door2) (wide_door door3) (robot shakey) (in_room shakey room1) (box box1) (is_box room1 box1)
	)  
			
	(:goal (and (in_room shakey room3) (is_box room3 box1) (light_on room3))
	)
	

)

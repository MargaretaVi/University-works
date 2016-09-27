(define (domain shakeys_world)
  (:requirements [:strips])

  (:predicates 
			(room ?r)					;;; room	
			(robot ?s)					;;; robot shakey
			(box ?b)					;;; box
			(gripper ?g)					;;; gripper
			(small_object ?so)				;;; small object
			(door ?d)					;;; door
			(walkable ?s)					;;; robot can walk
			
			(small_object_in_room ?r ?so) 			;;; there is small object in the room
			(light_on ?r)					;;; light is turned on in the room
			(adjacent ?r1 ?r2)				;;; two rooms are adjacent to each other
			(is_box ?r ?b)					;;; there is a box in the room
			
			(wide_door ?d)					;;; the door is wide     
			(on_box ?s)					;;; the robot is on the box
			(in_room ?s ?r)					;;; the robot is in the room
			(empty ?g)  					;;; the gripper is empty (only check one hand at a time)
			(connected ?r1 ?r2 ?d)				;;; rooms connected via door

)

 

  (:action pick_up_object
  	   :parameters (?g ?r ?so ) 
	   :precondition(and (light_on ?r) 
			     (empty ?g)
			     (small_object_in_room ?r ?so))
	   :effect (not(empty ?g))
)

 (:action drop_objects
  	   :parameters (?g ?g2 ?r ?so ?s) 
	   :precondition (and (or (not (empty ?g)) (not (empty ?g2))) (walkable ?s))
	   :effect (and (empty ?g) (empty ?g2) (small_object_in_room ?r ?so))
)
  
  (:action move_box
  	   :parameters(?b ?d ?r1 ?r2 ?s)
	   :precondition(and (in_room ?s ?r1)
			(is_box ?r1 ?b)
			(wide_door ?d)
			(connected ?r1 ?r2 ?d)
			(not (on_box ?s)) )
	   :effect(and (in_room ?s ?r2) (not (in_room ?s ?r1)) 
	   	       (is_box ?r2 ?b) (not (is_box ?r1 ?b)))
	   	       	   			  
)

   (:action climb
		:parameters (?r ?b  ?s )
		:precondition(and (is_box ?r ?b) (in_room ?s ?r) (not (on_box ?s)))
		:effect (and (on_box ?s) (not(walkable ?s)))
)
  
  (:action climb_down
		:parameters (?s ?r)
	   	:precondition (and (on_box ?s) (not (walkable ?s)))
	   	:effect (and (not (on_box ?s)) (walkable ?s))
) 

  (:action turn_on_light
  	   :parameters(?r ?s ?b)
	   :precondition(and(on_box ?s) (in_room ?s ?r) (is_box ?r ?b) (not (light_on ?r)))
	   :effect (and (light_on ?r) (on_box ?s))	   
)

  (:action turn_off_light
  	   :parameters(?r ?s)
	   :precondition(and(on_box ?s) (in_room ?s ?r) (light_on ?r))
	   :effect (and (not (light_on ?r)) (not (on_box ?s)))
)

  (:action change_room_no_item
  	   :parameters (?from ?to ?s ?g ?g2 ?so)
	   :precondition(and (in_room ?s ?from) (or (adjacent ?from ?to) (adjacent ?to ?from)) 
	   		     (and (empty ?g ) (empty ?g2))
			     )
	   :effect(and (in_room ?s ?to)  (not (in_room ?s ?from)))  	   
)

(:action change_room_both_hands
  	   :parameters (?from ?to ?s ?g ?g2 ?so1 ?so2 )
	   :precondition(and (in_room ?s ?from) (small_object_in_room ?from ?so1) (small_object_in_room ?from ?so2)  
	   		     (or (adjacent ?from ?to) (adjacent ?to ?from)) (and (not (empty ?g)) (not (empty ?g2)))
			     )
	   :effect(and (in_room ?s ?to) (small_object_in_room ?to ?so1) (small_object_in_room ?to ?so2)
	   	       (not (in_room ?s ?from)) (not (small_object_in_room ?from ?so1)) (not (small_object_in_room ?from ?so2))
		       (and (not (empty ?g)) (not (empty ?g2))))
)

(:action change_room_one_hand
  	   :parameters (?from ?to ?s ?g ?g2 ?so)
	   :precondition(and (in_room ?s ?from) (or (adjacent ?from ?to) (adjacent ?to ?from))
	   		(or (empty ?g2) (empty ?g)) (small_object_in_room ?from ?so))

	   :effect(and (in_room ?s ?to) (not (empty ?g)) (small_object_in_room ?to ?so)
	   	        (not (in_room ?s ?from)) (not (small_object_in_room ?from ?so))(empty ?g2))
)


)
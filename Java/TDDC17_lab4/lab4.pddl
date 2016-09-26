(define (domain shakeys_world)
  (:requirements [:strips])

  (:predicates 
			(room ?r)					;;; room	
			(robot ?s)					;;; robot shakey
			(box ?b)					;;; box
			(gripper ?g)					;;; gripper
			(small_object ?so)				;;; small object
			(door ?d)					;;; door
			
			(small_object_in_room ?r ?so) 			;;; there is small object in the room
			(light_on ?r)					;;; light is turned on in the room
			(adjacent ?r1 ?r2)				;;; two rooms are adjacent to each other
			(is_box ?r ?b)					;;; there is a box in the room
			
			(wide_door ?d)					;;; the door is wide     
			(on_box ?s)					;;; the robot is on the box
			(in_room ?s ?r)					;;; the robot is in the room
			(empty ?gripper )				;;; the gripper is empty (only check one hand at a time)
			(connected ?r1 ?r2 ?d)				;;; rooms connected via door

)

 

  (:action pick_up_object_right
  	   :parameters (?righthand ?so ?r ) 
	   :precondition(and (light_on ?r) 
					(empty ?righthand)
					(small_object_in_room ?r ?so))
	   :effect (not(empty ?righthand))
)

  (:action pick_up_object_left
  	   :parameters (?lefthand ?so ?r) 
	   :precondition (and (light_on ?r) 
	   		      (empty ?lefthand)
			      (small_object_in_room ?r ?so))
	   :effect (not(empty ?lefthand))
)
  
  (:action move_box
  	   :parameters(?b ?d ?r1 ?r2 ?s )
	   :precondition(and (in_room ?s ?r1)
			(is_box ?r1 ?b)
			(wide_door ?d)
			(connected ?r1 ?r2 ?d)
			(not (on_box ?s)))
	   :effect(and (in_room ?s ?r2) (not (in_room ?s ?r1)) 
	   	       (is_box ?r2 ?b) (not (is_box ?r1 ?b)))
	   	       	   			  
)
  
 (:action drop_object_right
  	   :parameters (?righthand ?r ?so) 
	   :precondition (not( empty ?righthand)) 
	   :effect (and (empty ?righthand) (small_object_in_room ?r ?so) )
)

 (:action drop_object_left
  	   :parameters (?lefthand) 
	   :precondition (not (empty ?lefthand)) 
	   :effect (and (empty ?lefthand) (small_object_in_room ?r ?so))
)

  (:action turn_on_light
  	   :parameters(?r ?s)
	   :precondition(and(on_box ?s) (in_room ?s ?r) (not (light_on ?r)))
	   :effect (light_on ?r)	   
)

  (:action turn_off_light
  	   :parameters(?r ?s)
	   :precondition(and(on_box ?s) (in_room ?s ?r) (light_on ?r))
	   :effect (light_on ?r)
)

  (:action change_room_no_item
  	   :parameters (?from ?to ?s ?lefthand ?righthand ?so)
	   :precondition(and (not(small_object_in_room ?from ?so)) (or (adjacent ?from ?to) (adjacent ?to ?from)) (and (empty ?righthand ) (empty ?lefthand)) 
					(not (on_box ?s)))
	   :effect(and (in_room ?s ?to)  (not (in_room ?s ?from)))  	   
)

(:action change_room_both_hands
  	   :parameters (?from ?to ?s ?lefthand ?righthand ?so1 ?so2)
	   :precondition(and (small_object_in_room ?from ?so1) (small_object_in_room ?from ?so2)  (or (adjacent ?from ?to) (adjacent ?to ?from))  (empty ?righthand ) (empty ?lefthand)
					(not (on_box ?s)))
	   :effect(and (in_room ?s ?to) (small_object_in_room ?to ?so1) (small_object_in_room ?to ?so2) (not (in_room ?s ?from)) (not (small_object_in_room ?from ?so1)) (not (small_object_in_room ?from ?so2 )))  	   
)

(:action change_room_left_hand
  	   :parameters (?from ?to ?s ?lefthand ?so)
	   :precondition(and (or (adjacent ?from ?to)  (adjacent ?to ?from)) (empty ?lefthand)
					(not (on_box ?s)))
	   :effect(and (in_room ?s ?to) (not (empty ?lefthand)) (small_object_in_room ?to ?so) (not (in_room ?s ?from)) (not (small_object_in_room ?from ?so)))  	   
)

  (:action change_room_right_hand
  	   :parameters (?from ?to ?s ?righthand ?so)
	   :precondition(and (or (adjacent ?from ?to)  (adjacent ?to ?from))  (empty ?righthand)
					(not (on_box ?s)))
	   :effect(and (in_room ?s ?to)(not (empty ?righthand)) (small_object_in_room ?to ?so) (not (in_room ?s ?from)) (not (small_object_in_room ?from ?so)))  	   
)

   (:action climb
		:parameters (?r ?b  ?s)
		:precondition(and (is_box ?r ?b)
				(in_room ?r ?s)
				(not (on_box ?s)))
		:effect (on_box ?s)
)
  
  (:action climb_down
	:parameters (?s)
	   :precondition (on_box ?s)
	   :effect (not (on_box ?s))
)

)


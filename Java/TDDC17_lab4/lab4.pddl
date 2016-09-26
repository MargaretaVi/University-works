(define (domain shakeys_world)
  (:requirements [:strips] [:equality] [:typing] [:adl])

  (:predicates 
			(room ?r)											;;; room	
			(shakey ?s)											;;; robot shakey
			(box ?b)											;;; box
			(gripper ?g)										;;; gripper
			(small_object ?so)									;;; small object
			(door ?d)											;;; door
			
			(adjacent ?r1 ?r2)									;;; two rooms are adjacent to each other
			(light_on ?r )										;;; light is turned on in the room
			(is_box ?r ?b)										;;; there is a box in the room
			(small_object_in_room ?r ?so ) 								;;; there is small object in the room
			(wide_door ?d)										;;; the door is wide     
			(on_box ?s)											;;; the robot is on the box
			(in_room ?s ?r)										;;; the robot is in the room
			(empty ?gripper )									;;; the gripper is empty (only check one hand at a time)
			(position ?s ?r)									;;; the robot is located in this room
	       )

  (:action climb
			:parameters (?r ?b  ?s )
			:precondition(and (is_box ?r ?b)
							(in_room ?r ?s))
			:effect (on_box ?s)
)
  
  (:action climb_down
  	   :parameters (?s)
	   :precondition (on_box ?s)
	   :effect (not (on_box ?s))
)

  (:action change_room_no_item
  	   :parameters (?from ?to ?s ?lefthand ?righthand)
	   :precondition(and (or (adjacent ?from ?to)  (adjacent ?to ?from)) (and (empty ?righthand ) (empty ?lefthand))
					(not (on_box ?s)))
	   :effect(and (in_room ?s ?to)  (not (in_room ?s ?from)))  	   
)

  (:action change_room_right_hand
  	   :parameters (?from ?to ?s ?lefthand ?righthand ?so)
	   :precondition(and (or (adjacent ?from ?to)  (adjacent ?to ?from)) (not (empty ?righthand))
					(not (on_box ?s)))
	   :effect(and (in_room ?s ?to) (small_object_in_room ?to ?so) (not (in_room ?s ?from)))  	   
)

  (:action change_room_left_hand
  	   :parameters (?from ?to ?s ?lefthand ?righthand ?so)
	   :precondition(and (or (adjacent ?from ?to)  (adjacent ?to ?from)) (not (empty ?lefthand))
					(not (on_box ?s)))
	   :effect(and (in_room ?s ?to)  (small_object_in_room ?to ?so) (not (in_room ?s ?from)))  	   
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
	   :precondition(and (in_room (?s ?r1))
					(is_box ?r1 ?b)
					(wide_door ?d)
					(adjacent ?r1 ?r2))
	   :effect(and (in_room ?s ?r2) (not (in_room ?s ?r1)) 
	   	       (is_box ?r2 ?b) (not (is_box ?r1 ?b)))
	   	       	   			  
)
  
 (:action drop_object_right
  	   :parameters (?righthand ?r) 
	   :precondition (not( empty ?righthand)) 
	   :effect (empty ?righthand)
)

 (:action drop_object_left
  	   :parameters (?lefthand ?r) 
	   :precondition (not (empty ?lefthand)) 
	   :effect (empty ?lefthand)
)

  (:action turn_on_light
  	   :parameters(?r ?s)
	   :precondition(and(on_box ?s) (in_room ?s ?r) not(light_on ?r))
	   :effect (and((light_on ?r) not(on_box ?s))) 	   
)


  
  (:action
  	   :parameters()
	   :precondition()
	   :effect()
  )


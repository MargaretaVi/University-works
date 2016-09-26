(define (domain shakeys_world)
  (:requirements [:strips] [:equality] [:typing] [:adl])
  (:types
	 box;
	 door;
	 shakey;
	 small_object;
	 gripper;
	 room )

  (:predicates 
  	       (adjacent ?r1 ?r2 - room )
               (light_on ?r - room)
	       (is_box ?r - room ?b - box)
	       (is_small_object ?r - room ?so - small_object)
	       (wide_door ?d door)
	       (box_under ?b - box ?ls - light_switch)
	       (on_box ?s - shakey ?b - box)
	       (in_room ?s - shakey ?r - room)
	       (empty ?hand - gripper)	
	       )

  (:action climb
    	   :parameters (?r - room ?b - box ?s - shakey)
   	   :precondition (and (is_box ?r ?b)
	   		      (in_room ?r ?s))
    	   :effect (on_box ?s ?b)
   )

  (:action change_room
  	   :parameters (?from ?to - room ?s - shakey)
	   :precodition  (and (or (adjacent ?from ?to)  (adjacent ?to ?from))
	   		 (not (on_box ?s ?b)))
	   :effect (and (in_room ?s ?to) (not (in_room ?s ?from)))  	   
  )
  
  (:action climb_down
  	   :parameters (?b - box ?s - shakey)
	   :precondition (on_box ?s ?b)
	   :effect (not (on_box ?s ?b))
  )

  (:action pick_up_object_right
  	   :parameters (?righthand - gripper ?so - small_object ?r - room ?l - light) 
	   :precondition (and (light_on ?r ?l) 
	   		      (empty ?righthand)
			      (is_small_object ?r ?so))
	   :effect (not(empty ?righthand))
  )

  (:action pick_up_object_left
  	   :parameters (?lefthand - gripper ?so - small_object ?r - room ?l - light) 
	   :precondition (and (light_on ?r ?l) 
	   		      (empty ?lefthand)
			      (is_small_object ?r ?so))
	   :effect (not(empty ?lefthand))
  )
  
  (:action move_box
  	   :parameters(?b - box ?d - door ?r1 ?r2 - room ?s - shakey)
	   :precondition(and (in_room (?s ?r1))
			     (is_box ?r1 ?b)
			     (wide_door ?d)
			     (adjacent ?r1 ?r2))
	   :effect(and (in_room ?s ?r2) (not (in_room ?s ?r1)) 
	   	       (is_box ?r2 ?b) (not (is_box ?r1 ?b)))
	   	       	   			  
  )
  
 (:action drop_object_right
  	   :parameters (?righthand - gripper ?r - room) 
	   :precondition (not( empty ?righthand)) 
	   :effect (empty ?righthand)
 )

 (:action drop_object_left
  	   :parameters (?lefthand - gripper ?r - room) 
	   :precondition (not (empty ?lefthand)) 
	   :effect (empty ?lefthand)
 )

  (:action turn_on_light
  	   :parameters(?r - room ?l - light ?b -box ?s - shakey)
	   :precondition(and(on_box ?s ?b) not(light_on ?r ?l))
	
	   :effect(and (lig) )
  )


  
  (:action
  	   :parameters()
	   :precondition()
	   :effect()
  )


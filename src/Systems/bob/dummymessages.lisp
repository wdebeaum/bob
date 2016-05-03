;;;;
;;;; messages.lisp for DUMMY
;;;;
;;;;

(in-package :dummy)

(in-component :dummy)

;;  Here we pick up messages for all modules that don't exist yet, to
;;    allow developers to run the system as they add functionality
;;   As functionality is added, messages should be commented out


;;=================
;;  BA interaction: eval/commit cycle -- this one rule picks up any evaluate and sends back an acceptance
;;=================

(defcomponent-handler
  '(request &key :content (evaluate  . *))
     #'(lambda (msg args)
	 (process-evaluate msg args))

  :subscribe t)

(defcomponent-handler
  '(request &key :content (what-next  . *))
     #'(lambda (msg args)
	 (what-next msg args))

  :subscribe t)



#||

FAKE-SEND-AND-WAIT from November demo

(defun fake-send-and-wait (msg)
  "allows us to fake certain interactions until the BA can handle them. For debugging, you can just comment out the
       message that you want to go through"
  (cond
    ((equal msg '(ONT::EVALUATE :content (ONT::PROPOSE :PS-OBJECT ONT::GOAL :CONTENT
					     (ONT::FIND-TREATMENT :DISEASE (W::CANCER W::PANCREATIC)))))
     '(((ONT::ACCEPT :PS-OBJECT GOAL :ID G11 :CONTENT (ONT::FIND-TREATMENT :DISEASE (W::CANCER W::PANCREATIC))))))
    ((equal msg '(ONT::EVALUATE :content (ONT::PROPOSE :PS-OBJECT ONT::GOAL :CONTENT
					     (ONT::FIND-TREATMENT :DISEASE (W::PANCREATIC-CANCER -)))))
     '(((ONT::ACCEPT :PS-OBJECT GOAL :ID G11 :CONTENT (ONT::FIND-TREATMENT :DISEASE (W::PANCREATIC-CANCER -))))))

    ((equal msg '(ONT::PERFORM :ID G11 :CONTENT (ONT::FIND-TREATMENT :DISEASE (W::CANCER W::PANCREATIC))))
     '(((ONT::TELL :content (ONT::PROPORTION :REFSET (ONT::CANCER-PATIENT) :QUAN (ONT::PERCENT 25) :CONTENT (MUTATION :AFFECTED ONT::KRAS))))
       ((ONT::TELL :content (ONT::DONT-KNOW :content (ONT::A X1 :instance-of ONT::DRUG))))))

    ((equal msg '(ONT::EVALUATE :content (ONT::PROPOSE :PS-OBJECT ONT::SUBGOAL :CONTENT
		 (ONT::BUILD-MODEL :INVOLVING (:* ONT::GENE W::KRAS)) :SUBGOAL-OF G11)))
     '(((ONT::ACCEPT :PS-OBJECT ONT::SUBGOAL :ID SG1 :CONTENT (ONT::BUILD-MODEL :INVOLVING (:* ONT::GENE W::KRAS))))))
     
    ((equal msg '(ONT::PROPOSE :PS-OBJECT ONT::SUBGOAL :CONTENT
                      (ONT::BUILD-MODEL :INVOLVING (:* ONT::GENE W::KRAS))
                      :SUBGOAL-OF G11))
     '(((ONT::ACCEPT :PS-OBJECT ONT::SUBGOAL :ID SG1 :CONTENT (ONT::BUILD-MODEL :INVOLVING (:* ONT::GENE W::KRAS))))))
     
    (t
     (send-and-wait `(REQUEST :content ,msg)))
    ))
||#

#||
;;  stuff copied from CABOT hat might be useful

(defcomponent-handler
    '(request &key :content (SET-SHARED-GOAL . *))
    #'(lambda (msg args)
	(process-reply  msg args
				  '(BA (ONT::OK))))
  :subscribe t)

(defcomponent-handler
    '(request &key :content (what-next . *))
    #'(lambda (msg args)
	(let ((active-goal (find-arg args :active-goal)))
	  (format t "~%~%args = ~S; active-goal = ~S" args active-goal)
	  (process-reply msg args 
			 (when (consp active-goal)
			   (case (fourth active-goal)
			     (ont::BUILD
			      '(BA (ONT::PERFORM :agent *USER*
				:action (A A1 :instance-of ONT::PUT :agent *USER* :affected b1 :result on1
					 :suchthat
					 ((RELN on1 :instance-of ont::ON :of b1 :val t1)
					  (A b1 :instance-of ont::BLOCK)
					  (THE t1 :instance-of ont::TABLE))))))
			     ;;  there are now two blocks on the table, say b1 and b2
			     ;;   this is something like "move b1 until it touches b2" (a simpler version of "push them together")
			     (ont::PUT
			      '(BA (ONT::PERFORM :agent *USER*
				:action (A A2 :instance-of ONT::PUSH :agent *USER* :affected b1 :result to1
					 :suchthat
					 ((RELN to1 :instance-of ont::TOUCH :neutral b1 :neutral1 b2)
					  )))))
			     (ont::PUSH
 			      '(BA (ONT::PERFORM :agent *USER*
				:action (A A3 :instance-of ONT::MAKE-IT-SO :agent *USER*  :result on2
					 :suchthat
					 ((RELN on2 :instance-of ont::ON :of b3 :val b2 :suchthat
						((A b3 :instance-of ONT::BLOCK)))))
					  )))
			     (ont::MAKE-IT-SO
			      '(BA (ONT::DONE)))
			     ;;  just to give some reply - we didn't anticipate the call
			     (otherwise
			      '(BA (ONT::ACT)))
			     )))))
			 
  :subscribe t)

(defcomponent-handler
  '(request &key :content (accepted . *))
     #'(lambda (msg args)
	 (process-reply msg args
				 '(BA (ONT::OK))))

  :subscribe t)

(defcomponent-handler
  '(request &key :content (notify-completed . *))
     #'(lambda (msg args)
	 (process-reply msg args
				 '(BA (ONT::OK))))
  :subscribe t)

(defcomponent-handler
    '(tell &key :content (scene-description . *))
    #'(lambda (msg args)
	(let ((time (find-arg args :timestamp))
	      )
	  (process-reply msg args
			 (cond ((equal time "2015-08-17T01:45:33.134001")
				'(BA (EXECUTION-STATUS :action A2 :status ont::INCOMPLETE)))
			       ((equal test "next one")
				'(BA (EXECUTION-STATUS :action A2 :status ont::DONE)))
			       
			       ((equal time "another")
				'(BA (EXECUTION-STATUS :action A3 :status ont::DONE)))
			       ))
	  ))
  
  
  :subscribe t)

||#

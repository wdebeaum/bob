;;;;
;;;; W::talk
;;;;

(define-words :pos W::n :templ COUNT-PRED-TEMPL
 :tags (:base500)
 :words (
;   )
   (W::talk
   (SENSES
    ((LF-PARENT ONT::presentation)
     (meta-data :origin calo :entry-date 20041130 :change-date nil :wn ("talk%1:10:02") :comment caloy2)
     (example "I need an lcd projector for my talk")
     )
    )
   )
))

(define-words :pos W::v :TEMPL AGENT-FORMAL-XP-TEMPL
 :tags (:base500)
 :words (
  (W::talk
   (SENSES
    (;;(LF-PARENT ONT::talk)
     (LF-PARENT  ONT::talk)
     (example "We talked")
     (SEM (F::Aspect F::unbounded) (F::Time-span F::extended))
     (TEMPL AGENT-TEMPL)
     )
    (;;(LF-PARENT ONT::TALK)
     (LF-PARENT  ONT::talk)
     (example "he talked with her [about it]")
     (TEMPL AGENT-AGENT1-FORMAL-2-XP1-3-XP-OPTIONAL-TEMPL 
	    (xp1 (% w::pp (w::ptype (? ptp w::to w::with)))))
     )
    (;;(LF-PARENT ONT::TALK)
     (LF-PARENT  ONT::talk)
     (example "he talked about it [to/with her]")
     (TEMPL AGENT-FORMAL-AGENT1-2-XP1-PP-3-XP2-PP-WITH-OPTIONAL-TEMPL)
     )
    ))
))


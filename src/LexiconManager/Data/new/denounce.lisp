;;;;
;;;; W::denounce
;;;;

(define-words :pos W::v :TEMPL AGENT-FORMAL-XP-TEMPL
 :words (
  (W::denounce
   (SENSES
    ((meta-data :origin "verbnet-2.0" :entry-date 20060315 :change-date 20090506 :comments nil :vn ("judgement-33") :wn ("denounce%2:32:00" "denounce%2:41:00"))
     (LF-PARENT ONT::criticize)
     (TEMPL AGENT-AGENT1-NP-TEMPL) ; like thank
     )
    ((meta-data :origin cardiac :entry-date 20090121 :change-date 20090506 :comments nil :vn ("judgement-33"))
     (LF-PARENT ONT::criticize)
     (example "he denounced it")
     (TEMPL AGENT-FORMAL-XP-TEMPL) 
     )
    )
   )
))


;;;;
;;;; W::titter
;;;;

(define-words :pos W::v :TEMPL AGENT-FORMAL-XP-TEMPL
 :words (
  (W::titter
   (wordfeats (W::morph (:forms (-vb) :past W::tittered :ing W::tittering)))
   (SENSES
    ((meta-data :origin "verbnet-2.0" :entry-date 20060315 :change-date nil :comments nil :vn ("nonverbal_expression-40.2") :wn ("titter%2:29:00"))
     (LF-PARENT ont::sound-expression)
     (EXAMPLE "She tittered gleefully.")
     (TEMPL agent-templ) ; like laugh
     )
    )
   )
))


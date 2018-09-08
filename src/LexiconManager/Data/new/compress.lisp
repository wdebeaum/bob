;;;;
;;;; w::compress
;;;;

(define-words :pos W::v :templ AGENT-THEME-XP-TEMPL
 :words (
(w::compress
  (wordfeats (W::morph (:forms (-vb) :nom w::compression)))
 (senses
  ;((meta-data :origin calo :entry-date 20050811 :change-date nil :comments nil)
  ; (LF-PARENT ONT::shrink)
  ; (example "compress the data")
  ; (SEM (F::Cause F::Agentive) (F::Aspect F::bounded) (F::Time-span F::atomic))   
  ;  )
  ((meta-data :origin step :entry-date 20080626 :change-date nil :comments nil)
   (LF-PARENT ONT::shrink)
   (example "it compressed in size")
   (templ affected-theme-xp-optional-templ  (xp (% W::PP (W::ptype (? pt w::in)))))
   (SEM (F::Aspect F::bounded) (F::Time-span F::extended) (F::scale ont::size-scale))
   )
  )
 )

))


(define-words :pos W::v :templ AGENT-affected-XP-TEMPL
 :words (
  (W::compress
     (wordfeats (W::morph (:forms (-vb) :nom w::compression)))
   (SENSES
    ((EXAMPLE "compress the files/data")
     (meta-data :origin task-learning :entry-date 20050823 :change-date 20090504 :comments nil)
     (LF-PARENT ONT::shrink)
     (SEM (F::Cause F::agentive) (F::Aspect F::bounded) (F::Time-span F::extended) (F::scale ont::size-scale))
     )
    )
   )
))


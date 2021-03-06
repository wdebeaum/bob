;;;;
;;;; W::PRIOR
;;;;

(define-words :pos W::adj :templ CENTRAL-ADJ-TEMPL
 :words (
  (W::PRIOR
   (SENSES
    ((meta-data :origin calo :entry-date 20040414 :change-date nil :wn ("prior%5:00:00:antecedent:00") :comments caloy1v6)
     (lf-parent ont::previous-val)
     (TEMPL attributive-only-adj-templ)
     )
    )
   )
))

(define-words :pos W::ADV
  :words (
	  ((W::PRIOR w::to)
	   (SENSES
	    ((LF-PARENT ONT::before)
	     (TEMPL binary-constraint-S-ing-TEMPL)
	     (example "prior to leaving she checked her watch")
	     )
	    ((LF-PARENT ONT::before)
	     (TEMPL binary-constraint-S-TEMPL)
	     (example "prior to the meeting she checked her watch")
	     )
	    ((LF-PARENT ONT::before)
	     (meta-data :origin cernl :entry-date 20110223 :change-date nil :comments bionlp)
	     (example "show me departures prior to 5 pm / the meeting")
	     (TEMPL binary-constraint-np-TEMPL)
	     )
	    )
	   )
	  ))


(define-words :pos W::adj
  :words (
	  (w::prior
	   (senses
	    ((LF-PARENT ONT::in-past)
	     (TEMPL central-adj-templ)
	     )
	    )
	   )
	  ))

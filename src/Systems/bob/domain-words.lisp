(in-package :lxm)

(define-words :pos W::adj  
:words (
 (w::WT
   (SENSES
    ((LF-PARENT ONT::NATURAL)
     (LF-FORM W::WILDTYPE)
     (TEMPL central-adj-templ)
     )
    )
   )
))

(define-words :pos W::n 
:words (
 (w::WT
   (SENSES
    ((LF-PARENT ONT::WILDTYPE-OBJ)
     (LF-FORM W::WILDTYPE)
     (TEMPL count-pred-templ)
     )
    )
   )
))

(define-words :pos W::v 
 :words (
  (W::target
   (wordfeats (W::morph (:forms (-vb) :past w::targeted :ing w::targeting)))
   (SENSES
    ((lf-parent ont::TRANSPORT)
     (EXAMPLE "protein targeting")
     ;(TEMPL agent-affected-GOAL-templ (xp (% W::ADVBL (w::lf (% w::prop (w::class (? x ont::goal-reln ont::source-reln)))))))
     (TEMPL AGENT-AFFECTED-RESULT-ADVBL-OBJCONTROL-TEMPL (xp (% W::ADVBL (w::lf (% w::prop (w::class (? x ont::goal-reln ont::source-reln)))))))
     )
    )
   )
))

(define-words :pos W::v 
 :words (
  (W::sort
   (SENSES
    ((lf-parent ont::TRANSPORT)
     (example "protein sorting")
     ;(TEMPL agent-affected-xp-templ)
     ;(TEMPL agent-affected-GOAL-templ (xp (% W::ADVBL (w::lf (% w::prop (w::class (? x ont::goal-reln ont::source-reln)))))))
     (TEMPL AGENT-AFFECTED-RESULT-ADVBL-OBJCONTROL-TEMPL (xp (% W::ADVBL (w::lf (% w::prop (w::class (? x ont::goal-reln ont::source-reln)))))))
     )

    )
   )
))

#|
(define-words :pos W::N
  :words (
	  ((W::TRANSCRIPTION W::PUNC-MINUS W::FACTOR)
	   (SENSES
	    ((lf-parent ONT::PROTEIN)
	     (LF-FORM W::transcription-factor)
	     (TEMPL count-pred-templ)
	     )))
	  )
  )
|#
	     
;;;;;;;;;;;;;;;;;;;;;;;;
; TFTA
;;;;;;;;;;;;;;;;;;;;;;;;

(define-words :pos W::name
:words (
 (w::Reactome
   (SENSES
    ((LF-PARENT ONT::DATABASE)
     (TEMPL name-templ)
     )
    )
   )
))

(define-words :pos W::name
:words (
 (w::KEGG
   (SENSES
    ((LF-PARENT ONT::DATABASE)
     (TEMPL name-templ)
     )
    )
   )
))

;;;;;;;;;;;;;;;;;;;;;;;;
; BOB 
;;;;;;;;;;;;;;;;;;;;;;;;

; Are there common upstreams of MAPK1 and AKT1?
(define-words :pos W::n
:words (
 (w::upstream
   (SENSES
    ((LF-PARENT ONT::predecessor)
     (TEMPL other-reln-templ)
     )
    )
   )
))

(define-words :pos W::n
:words (
 (w::downstream
   (SENSES
    ((LF-PARENT ONT::successor)
     (TEMPL other-reln-templ)
     )
    )
   )
))

(define-words :pos W::n
:words (
 (w::PMID
   (SENSES
    ((LF-PARENT ONT::identification)
     (TEMPL other-reln-templ)
     )
    )
   )
))

(define-words :pos W::n
:words (
 (w::PMCID
   (SENSES
    ((LF-PARENT ONT::identification)
     (TEMPL other-reln-templ)
     )
    )
   )
 ))

;;;;;;;;;;;;;;;;;;;
; in common to
;;;;;;;;;;;;;;;;;;;
(define-words :pos W::adj
 :tags (:base500)
 :words (
  ((w::in w::common)
  (senses
   ((lf-parent ont::typical-val)
    (TEMPL  adj-co-theme-templ (xp (% w::pp (w::PTYPE (? pt w::to)))))
    (sem (f::gradability +) (f::intensity ont::med) (f::orientation ont::more))
    (meta-data :origin bob :entry-date 20181228 :change-date 20181229 :comments nil)
    )
   )
)
))




;;;;;;;;;;;;;;;;;;;;;;;;
; for paper 1
;;;;;;;;;;;;;;;;;;;;;;;;

#|
(define-words :pos W::n 
:words (
 (w::RTK
   (SENSES
    ((LF-PARENT ONT::PROTEIN)
     (TEMPL count-pred-templ)
     )
    )
   )
))

; put here because there should be a more principled way to handle adjectives
(define-words :pos W::adj 
:words (
 ((w::short w::lived)
   (SENSES
    ((LF-PARENT ONT::SHORT)
     (TEMPL CENTRAL-ADJ-TEMPL)
     )
    )
   )
))

; copied from "resulting"
(define-words :pos W::adj 
 :words (
   (W::ensuing
   (SENSES
    (
     (LF-PARENT ONT::outcome-val)
     (TEMPL CENTRAL-ADJ-TEMPL)
     (example "the ensuing chaos")  
     )
    )
   )
))

|#

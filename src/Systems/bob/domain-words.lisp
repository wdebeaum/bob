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

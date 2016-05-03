(in-package "IM")

(setq *term-extraction-rules* '(drumtermsAdd))
(reset-im-rules 'drumtermsAdd)

(mapcar #'(lambda (x) (add-im-rule x 'drumtermsAdd))  ;; sets of rules are tagged so they can be managed independently 
	'(


#|
	  ;; basic terms (not conjunctions) with selected mod (e.g., prefixes auto-, mono-, trans-)
	  (((? reln ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?!obj 
	    (:* (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) ?w) :SEQUENCE - :MOD ?!modA)
            (ONT::F ?!modA (? tmp ONT::MANNER-REFL ONT::SAME ONT::DIFFERENT ONT::CARDINALITY-VAL ONT::TRAJECTORY))
	   -simple-ref-modA1>
	   100
	   (term ?!obj ?t1
	    :name ?w
	    :modA ?!modA
	    :rule -simple-ref-modA1
	    ))
|#
	  ;; basic terms (not conjunctions) with selected mod (e.g., prefixes auto-, mono-, trans-)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) :SEQUENCE - :MODS (?!modA) )
	   ; leave out ONT::INCLUSIVE (for co-)  (by the way, co- is now :MANNER, but it does not need to be returned)
            (ONT::F ?!modA (? tmp ONT::MANNER-REFL ONT::SAME ONT::DIFFERENT ONT::CARDINALITY-VAL ONT::TRAJECTORY))  
	   -simple-ref-modA2>
	   100
	   (ONT::TERM ?!obj ?t1
	    :modA ?tmp ;?!modA
	    :rule -simple-ref-modA2
	    ))
#|
	  ;; basic terms (not conjunctions) with selected mods that negates/reverses the meaning
	  ;; (e.g., prefixes de-, non-, un-)
	  (((? reln ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?!obj 
	    (:* (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) ?w) :SEQUENCE - :MOD ?!modN)
            (ONT::F ?!modN (? tmp ONT::MANNER-UNDO ONT::NEG))
	   -simple-ref-modN1>
	   100
	   (term ?!obj ?t1
	    :name ?w
	    :modN ?!modN
	    :rule -simple-ref-modN1
	    ))
|#

	  ;; basic terms (not conjunctions) with selected mods that negates/reverses the meaning
	  ;; (e.g., prefixes de-, non-, un-)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) :SEQUENCE - :MODS (?!modN) )
            (ONT::F ?!modN (? tmp ONT::MANNER-UNDO ONT::NEG))
	   -simple-ref-modN2>
	   100
	   (ONT::TERM ?!obj ?t1
	    :modN ?tmp ;?!modN
	    :rule -simple-ref-modN2
	    ))


;; this will return for example ONT::AT-LOC as a MODL for MEK (not good)
;; don't need this for now because extra- etc are not fixed yet.
#||
	  ;; basic terms (not conjunctions) with selected LOC (e.g., extra-)
	  (((? reln ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?!obj 
	    (:* (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) ?w) :SEQUENCE - :LOC ?!modL)
            (ONT::F ?!modL (? tmp ONT::position-as-point-reln))
	   -simple-ref-modL1>
	   100
	   (term ?!obj ?t1
	    :name ?w
	    :modL ?!modL
	    :rule -simple-ref-modL1
	    ))
||#

	  ;; basic terms (not conjunctions) with selected mod (only ONT::ACTIVE)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) :SEQUENCE - :MODS (?!modActive) )
            (ONT::F ?!modActive (? tmp ONT::ACTIVE))
	   -simple-ref-modActive1>
	   100
	   (ONT::TERM ?!obj ?t1
	    :active ONT::TRUE
	    :rule -simple-ref-modActive1
	    ))

	  ;; basic terms (not conjunctions) with selected mod (only ONT::INACTIVE)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) :SEQUENCE - :MODS (?!modActive))
            (ONT::F ?!modActive (? tmp ONT::INACTIVE))
	   -simple-ref-modActive2>
	   100
	   (ONT::TERM ?!obj ?t1
	    :active ONT::FALSE
	    :rule -simple-ref-modActive2
	    ))

#|
	  ; merged into simple-ref-modEvent
	  ;; basic terms (not conjunctions) with :mod pointing to ACTIVATE events
	  (((? reln ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?!obj 
	    (:* (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) ?w) :SEQUENCE - :MODS (?!ev))
            (ONT::F ?!ev (? tmp ONT::START ONT::START-OBJECT))
	   -simple-ref-modActive3>
	   100
	   (term ?!obj ?t1
	    :name ?w
	    :active +
	    :rule -simple-ref-modActive3
	    ))
|#



	  ;; basic terms (not conjunctions) with selected mods that indicate degree
	  ;; (e.g., hyper-)
	  ;; :degree is automatically extracted but for terms it is :MOD, not :DEGREE
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) :SEQUENCE - :MODS (?!modD) )
            (ONT::F ?!modD (? tmp ONT::DEGREE-MODIFIER))
	   -simple-ref-modD2>
	   100
	   (ONT::TERM ?!obj ?t1
	    :degree ?!modD
	    :rule -simple-ref-modD2
	    ))


; INEVENT has moved to ruleFileTop_mod	  
#|
	  ; need to straighten this out!
	  ; also need to fix: it is possible that ?!ev is not extracted as an EVENT (e.g., if the arguments don't match)
	  ;; basic terms (not conjunctions) with :mod pointing to events (BIND, UNBIND, PTM, ACTIVATE, DEACTIVATE, INCREASE, DECREASE, STIMULATE, INHIBIT)
	  (((? reln ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?!obj 
	    (:* (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::PHYS-OBJECT ONT::MENTAL-CONSTRUCTION ONT::AWARENESS ONT::INFORMATION-FUNCTION-OBJECT) ?!w) :SEQUENCE - :MODS (?!ev) :DRUM ?code)
            (ONT::F ?!ev (? tmp ONT::JOINING ONT::ATTRACT 
ONT::BREAK-OBJECT ONT::SEPARATION 
ONT::POST-TRANSLATIONAL-MODIFICATION 
ONT::START ONT::START-OBJECT 
ONT::STOP 
ONT::INCREASE ONT::ADD-INCLUDE ONT::ACQUIRE ONT::FILLING ONT::START ONT::START-OBJECT
ONT::DECREASE ONT::EXTINGUISH
ONT::ENCOURAGE ONT::CAUSE-STIMULATE ONT::HELP ONT::ENABLE ONT::ALLOW ONT::IMPROVE
ONT::INHIBIT-EFFECT ONT::CAUSE-COME-FROM ONT::REMOVE-FROM ONT::RENDER-INEFFECTIVE
))
	   -simple-ref-modEvent>
	   100
	   (?reln ?!obj ?t1
	    :name ?!w
	    :inevent ?!ev
	    :drum ?code
	    :rule -simple-ref-modEvent
	    ))

|#
	  
	  ;; basic terms (not conjunctions) with mutation (:ASSOC-WITH)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :ASSOC-WITHS (?!m))
            (ONT::TERM ?!m (? tmp ONT::MUTATION))
	   -simple-ref-mutation1>
	   100
	   (ONT::TERM ?!obj ?t1
	    :mutation ?!m
	    :rule -simple-ref-mutation1
	    ))

	  ;; basic terms (not conjunctions) with mutation (in parentheses)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :PARENTHETICAL ?!m )
            (ONT::TERM ?!m (? tmp ONT::MUTATION))
	   -simple-ref-mutation2>
	   100
	   (ONT::TERM ?!obj ?t1
	    :mutation ?!m
	    :rule -simple-ref-mutation2
	    ))

	  ;; basic terms (not conjunctions) with wild type (:MOD)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :MODS (?!m) )
            (ONT::F ?!m (:* (? tmp ONT::NATURAL) ?!m2))
	   -simple-ref-mutation3>
	   100
	   (ONT::TERM ?!obj ?t1
	    :mutation ONT::FALSE
	    :rule -simple-ref-mutation3
	    ))

	  ;; basic terms (not conjunctions) with wild type (in parentheses)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :PARENTHETICAL ?!m )
            ((? spec ONT::F ONT::BARE) ?!m (:* (? tmp ONT::NATURAL ONT::WILDTYPE-OBJ) ?!m2))  ; "WILDTYPE-OBJ" added for good measure (see -simple-ref-mutation6)
	   -simple-ref-mutation4>
	   100
	   (ONT::TERM ?!obj ?t1
	    :mutation ONT::FALSE
	    :rule -simple-ref-mutation4
	    ))

	  ;; TERM substitution: WT is extracted as a TERM
	  ;; basic terms (not conjunctions) with wild type (in parentheses)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :PARENTHETICAL ?!m )
            (ONT::TERM ?!m (? tmp ONT::NATURAL ONT::WILDTYPE-OBJ))  ; "WILDTYPE-OBJ" added for good measure (see -simple-ref-mutation6)
	   -simple-ref-mutation4b>
	   100
	   (ONT::TERM ?!obj ?t1
	    :mutation ONT::FALSE
	    :rule -simple-ref-mutation4b
	    ))

	  ;; basic terms (not conjunctions) with mutant (:MOD)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :MODS (?!m) )
            (ONT::F ?!m (:* (? tmp ONT::MUTANT) ?!m2))
	   -simple-ref-mutation5>
	   100
	   (ONT::TERM ?!obj ?t1
	    :mutation ONT::TRUE
	    :rule -simple-ref-mutation5
	    ))

	  ;; basic terms (not conjunctions) with mutant (in parentheses)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :PARENTHETICAL ?!m )
            ((? spec ONT::F ONT::BARE) ?!m (:* (? tmp ONT::MUTANT ONT::MUTANT-OBJ) ?!m2))  ; "mutant" sometimes come out as a noun, which then needs ONT::BARE
	   -simple-ref-mutation6>
	   100
	   (ONT::TERM ?!obj ?t1
	    :mutation ONT::TRUE
	    :rule -simple-ref-mutation6
	    ))

	  ;; basic terms (not conjunctions) with mutant (in parentheses)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :PARENTHETICAL ?!m )
            (ONT::TERM ?!m (? tmp ONT::MUTANT ONT::MUTANT-OBJ))  ; "mutant" sometimes come out as a noun, which then needs ONT::BARE
	   -simple-ref-mutation6b>
	   100
	   (ONT::TERM ?!obj ?t1
	    :mutation ONT::TRUE
	    :rule -simple-ref-mutation6b
	    ))
	  
	  ;; basic terms (not conjunctions) for BODY-PART-VAL (e.g., cytoplasmic)
	  ;; *** cytoplasmic doesn't work now because it has been removed from the lexicon (waiting for pertainyms to work)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :MODS (?!modBP) )
            (ONT::F ?!modBP (? tmp ONT::BODY-PART-VAL))
	   -simple-ref-modBP>
	   100
	   (ONT::TERM ?!obj ?t1
	    :LOC ?!modBP
	    :rule -simple-ref-modBP
	    ))

	  ;; basic terms (not conjunctions) for BODY-PART (e.g., in the nucleus)  *maybe this parse doesn't come out any more
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :ASSOC-WITHS (?!modBP) )
            (ONT::TERM ?!modBP (? tmp ONT::BODY-PART))
	   -simple-ref-modBP2>
	   100
	   (ONT::TERM ?!obj ?t1
	    :LOC ?!modBP
	    :rule -simple-ref-modBP2
	    ))

	  ;; basic terms (not conjunctions) for BODY-PART (e.g., in the nucleus) 
	  ;; *maybe this doesn't work any more either* :LOC has changed to :LOCATION (see -simple-ref-modBP4)  *** seem to have changed back to :LOC! ***
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :LOC ?!modL )
	   (ONT::F ?!modL (? tmp ONT::IN-LOC ONT::AT-LOC ONT::ON) :VAL ?!modBP)	   
            (ONT::TERM ?!modBP (? tmp2 ONT::BODY-PART))
	   -simple-ref-modBP3>
	   100
	   (ONT::TERM ?!obj ?t1
	    :LOC ?!modBP
	    :rule -simple-ref-modBP3
	    ))

	  ;; basic terms (not conjunctions) for BODY-PART (e.g., in the nucleus)
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :LOCATION ?!modL )
	   (ONT::F ?!modL (? tmp ONT::IN-LOC ONT::AT-LOC ONT::ON) :VAL ?!modBP)	   
            (ONT::TERM ?!modBP (? tmp2 ONT::BODY-PART))
	   -simple-ref-modBP4>
	   100
	   (ONT::TERM ?!obj ?t1
	    :LOC ?!modBP
	    :rule -simple-ref-modBP4
	    ))

	  ;; basic terms (not conjunctions) for cell lines
	  ((ONT::TERM ?!obj 
	    (? t1 ONT::MUTATION ONT::BIOLOGICAL-PROCESS ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY) :SEQUENCE - :LOC ?!modL )
	   (ONT::F ?!modL (? tmp ONT::IN-LOC ONT::AT-LOC ONT::ON) :VAL ?!modBP)	   
            (ONT::TERM ?!modBP (? tmp2 ONT::CELL-LINE))
	   -simple-ref-modCL>
	   100
	   (ONT::TERM ?!obj ?t1
	    :CELL-LINE ?!modBP
	    :rule -simple-ref-modCL
	    ))


	  )
	)
	  

(in-package "IM")

(setq *extractor-oblig-features* '(:tense :negation
; :modality
; :degree :frequency 
:progr :perf :passive 
; :coref 
:while :until :purpose 
;:drum    ; we don't automatically pass :drum on because we are constructing logical sequences explicitly in, e.g., -explicit-ref-seq3 (Drumterms)
:ASSOC-WITH  ; for PTM arguments and sites (whcih are chained by :ASSOC-WITH and :MOD)
:MOD
:METHOD ; by-means-of
:REASON ; because
:MANNER ; as a result of

;;;;;; commented this out just for BOB (Let's build a model of the KRAS neighborhood.)
;:OF     ; as a result of
;;;;;;

;:LOCATION ; molecular-site
:PARENTHETICAL ; in-event (NRAS, bound to GTP, binds BRAF.), also mutation, e.g., -simple-ref-mutation2
:LOC       ; Ras in the nucleus/cell line
:LOCATION  ; Ras in the nucleus/cell line
:CONDITION ; if

;;;;; for BOB
:suchthat ; What proteins might lead to the development of pancreatic cancer?
))


(setq *extraction-rules* '(bobRules))

(reset-im-rules 'bobRules)  ;; this allows you to edit this file and reload it without having to reload the entire system

(mapcar #'(lambda (x) (add-im-rule x 'bobRules))  ;; sets of rules are tagged so they can be managed independently 
	'(

	  ; find 
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* (? type ONT::DETERMINE) ?!w) :AGENT ?!ag :NEUTRAL ?!obj :DRUM ?code)
           (?reln1 ?!ag  (? t1 ONT::PERSON))
           -rule1>
           60
           (ONT::EVENT ?ev ?type
            :rule -rule1
            :NEUTRAL ?!obj
            :DRUM ?code
            )
           )

	  ; use 
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* (? type ONT::USE) ?!w) :AGENT ?!ag :AFFECTED ?!obj :DRUM ?code)
           (?reln1 ?!ag  (? t1 ONT::PERSON))
           -rule1b>
           60
           (ONT::EVENT ?ev ?type
            :rule -rule1b
            :AFFECTED ?!obj
            :DRUM ?code
            )
           )
	  
	  ; build
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* (? type ONT::CREATE) ?!w) :AGENT ?!ag :AFFECTED-RESULT ?!obj :DRUM ?code)
           (?reln1 ?!ag  (? t1 ONT::PERSON))
           -rule1c>
           60
           (ONT::EVENT ?ev ?type
            :rule -rule1c
            :AFFECTED-RESULT ?!obj
            :DRUM ?code
            )
           )

	  ; treatment
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* ONT::CONTROL-MANAGE W::TREATMENT) :AFFECTED ?!obj :DRUM ?code)
           ((? reln2 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!obj (? t2 ONT::medical-disorders-and-conditions))
           -rule2>
           60
           (ONT::EVENT ?ev ONT::TREATMENT
            :rule -rule2
            :DISEASE ?!obj
            :DRUM ?code
            )
           )

	  ; pancreatic cancer
	  (((? reln ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?!obj 
	    (:* (? t1 ONT::medical-disorders-and-conditions) ?!w) :SEQUENCE - :DRUM ?code)
           (ONT::EVAL (symbolmap (:* ?t1 ?!w) ?!t1_new))
	   -rule3>
	   90
	   (ONT::TERM ?!obj ?!t1_new
	    :drum ?code
	    :rule -rule3
	    ))

	  ; model
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* ONT::REPRESENTATION W::MODEL) :OF ?!obj :DRUM ?code)
           ((? reln2 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!obj (? t2 ONT::DISTRICT W::NEIGHBORHOOD) :ASSOC-WITHS (?!v3))
	   (ONT::TERM ?!v3 ?t3)
           -rule2b>
           60
           (ONT::TERM ?ev ONT::MODEL
            :rule -rule2b
            :OF ?!v3
	    :EXTENT ONT::SMALL
            :DRUM ?code
            )
           )
	  
          ;; growth
          (((? reln0  ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* (? type ONT::INCREASE ONT::ADD-INCLUDE ONT::ACQUIRE ONT::FILLING ONT::GROW ONT::PROGRESS ONT::DECREASE ONT::PARTS-REMOVED ONT::REMOVE-PARTS ) ?!w) :AFFECTED ?!obj :DRUM ?code )
;           ((? reln1 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET TERM) ?!ag  (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           ((? reln2 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!obj (? t2 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE ONT::medical-disorders-and-conditions))
           (ONT::EVAL (symbolmap ?type ?!eventName -rule20_AGENT_AFFECTED))
           -rule20_AGENT_AFFECTED-AFFECTED>
           20
           (ONT::event ?ev ?!eventName
            :rule -rule20_AGENT_AFFECTED-AFFECTED
;            :AGENT ?!ag
            :AFFECTED ?!obj
            :DRUM ?code
            )
           )

          ;; target
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* (? type ONT::DIRECT-AT ) ?!w) :NEUTRAL ?!ag :NEUTRAL1 ?!obj :DRUM ?code )
           ((? reln1 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!ag  (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           ((? reln2 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!obj (? t2 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           (ONT::EVAL (symbolmap ?type ?!eventName -rule10_NEUTRAL_NEUTRAL1))
           -rule10_NEUTRAL_NEUTRAL1>
           10
           (ONT::event ?ev ?!eventName
            :rule -rule10_NEUTRAL_NEUTRAL1
            :NEUTRAL ?!ag
            :NEUTRAL1 ?!obj
            :DRUM ?code
            )
           )

          ;; activate
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* (? type ONT::START ONT::START-OBJECT ONT::CREATE ONT::CAUSE-MAKE ONT::CAUSE-PRODUCE-REPRODUCE ) ?!w) :AGENT ?!ag :AFFECTED ?!obj :DRUM ?code )
           ((? reln1 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!ag  (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           ((? reln2 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!obj (? t2 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           (ONT::EVAL (symbolmap ?type ?!eventName -rule40a_AGENT_AFFECTED))
           -rule40a_AGENT_AFFECTED>
           40
           (ONT::event ?ev ?!eventName
            :rule -rule40a_AGENT_AFFECTED
            :AGENT ?!ag
            :AFFECTED ?!obj
            :DRUM ?code
            )
           )
 
          ;; activate
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* (? type ONT::START ONT::START-OBJECT ONT::CREATE ONT::CAUSE-MAKE ONT::CAUSE-PRODUCE-REPRODUCE ) ?!w) :AFFECTED ?!obj :DRUM ?code )
;           ((? reln1 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!ag  (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           ((? reln2 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!obj (? t2 ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           (ONT::EVAL (symbolmap ?type ?!eventName -rule40a_AGENT_AFFECTED))
           -rule40a_AGENT_AFFECTED-AFFECTED>
           40
           (ONT::event ?ev ?!eventName
            :rule -rule40a_AGENT_AFFECTED-AFFECTED
;            :AGENT ?!ag
            :AFFECTED ?!obj
            :DRUM ?code
            )
           )

          ;; inactivate
          (((? reln0 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET) ?ev
            (:* (? type ONT::STOP ONT::EXTINGUISH ONT::CONSUME ONT::TAKE-IN ONT::DETERIORATE ONT::DESTROY ) ?!w) :AFFECTED ?!obj :DRUM ?code )
;           ((? reln1 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!ag  (? t1 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           ((? reln2 ONT::F ONT::QUANTIFIER ONT::KIND ONT::A ONT::INDEF-PLURAL ONT::THE ONT::THE-SET ONT::INDEF-SET ONT::BARE ONT::SM ONT::PRO ONT::PRO-SET ONT::TERM) ?!obj (? t2 ONT::EVENT-OF-CHANGE ONT::CHEMICAL ONT::MOLECULAR-PART ONT::CELL-PART ONT::BODY-PART ONT::SIGNALING-PATHWAY ONT::MUTANT-OBJ ONT::WILDTYPE-OBJ ONT::SEQUENCE))
           (ONT::EVAL (symbolmap ?type ?!eventName -rule40_AGENT_AFFECTED))
           -rule40_AGENT_AFFECTED>
           40
           (ONT::event ?ev ?!eventName
            :rule -rule40_AGENT_AFFECTED
;            :AGENT ?!ag
            :AFFECTED ?!obj
            :DRUM ?code
            )
           )

	  
;;;;;;;;;;;;;;;
	  
	  )
	)

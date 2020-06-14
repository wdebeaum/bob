(in-package "IM")

(reset-im-rules 'preprocessRules)

(mapcar #'(lambda (x) (add-im-rule x 'preprocessRules))  ;; sets of rules are tagged so they can be managed independently 
	'(
	  ((?reln ?!obj ?t
	    )
	   -add-spec>
	   100
	   (?reln ?!obj ?t
	    :spec ?reln
	    :ONT ?t  ; TRIPS type
	    :rule -add-spec
	    ))

	  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	  ; bypass STATE-RESULTING-FROM
	  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	  ((?reln ?!obj ?t :MODS (?!mod ?mod2))
	   (?reln1 ?mod ONT::STATE-RESULTING-FROM :FIGURE ?!obj :GROUND ?!ev)
	   (?reln1b ?!ev ?t1b)
	   -state-resulting-from>
	   100
	   (?reln ?!obj ?t
	    :MOD ?!ev
	    :MOD ?mod2
	    :ONT ?t
	    :spec ?reln ; since -add-spec> wouldn't be used
	    :rule -state-resulting-from
	    ))

	  ; copy LOCATION to "find out" from "want" in "I want to find out how X does Y"
	  ; because the "want" clause is skipped by -want-to-proposal>
          (
	   (ONT::F ?!v2 (? type2 ONT::WANT) :EXPERIENCER ?!v1 :formal ?ev 
		   :force (? f ONT::TRUE ONT::ALLOWED ONT::FUTURE ONT::POSSIBLE)
		   :LOCATION ?!loc)
	   (?reln1 ?!v1 ?type1 :PROFORM (? xx W::I W::WE))
	   (?reln ?ev (? type ONT::DETERMINE) :AGENT ?!v1 :FORMAL ?!obj :DRUM ?code)
	   (?reln3 ?!loc ?type3 :FIGURE ?!v2)
           -rule-want>
           100
           (?reln ?ev ?type
	    :LOCATION ?!loc
	    :spec ?reln  ; add-spec is not used, so add :spec here
            :DRUM ?code
            :rule -rule-want
            )
	   (ONT::F ?!v2 ?type2
            :LOCATION - ; in case this clause matches something else downstream (even though this clause would be skipped in the final output)
	    :spec ONT::F  ; add-spec is not used, so add :spec here
            :rule -rule-want-b 
	    )
           (?reln1 ?!v1 ?type1
	    :spec ?reln1  ; add-spec is not used, so add :spec here
            :rule -rule-want-c 
            )
           (?reln3 ?!loc ?type3
	    :FIGURE ?ev
	    :spec ?reln3  ; add-spec is actually also used, but I don't know why
            :rule -rule-want-d
            )
            )
	  
	  
))

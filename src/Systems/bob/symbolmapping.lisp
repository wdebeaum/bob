(in-package :im)

;;  e.g. (setq *symbol-map* '((ONT::DOG CANINE) (ONT::CAT FELINE)))
;;      would bind the variable ?y to IM::CANINE in a extraction rule term of form  (ONT::EVAL (symbolmap ONT::DOG ?y))

(setq *symbol-map*
      '(
	
;	((:* ONT::ILLNESS W::PANCREATIC-CANCER) ONT::PANCREATIC-CANCER)	
;	((:* ONT::CANCER W::PANCREATIC) ONT::PANCREATIC-CANCER)	
	(ONT::GROW ONT::INCREASE -rule20_AGENT_AFFECTED)
	(ONT::PROGRESS ONT::INCREASE -rule20_AGENT_AFFECTED)
	(ONT::DIRECT-AT ONT::MODULATE -rule10_NEUTRAL_NEUTRAL1)
        (ONT::START ONT::ACTIVATE -rule40a_AGENT_AFFECTED)
	(ONT::ADD-INCLUDE ONT::INCREASE -rule20_AGENT_AFFECTED)
	(ONT::STOP ONT::DEACTIVATE -rule40_AGENT_AFFECTED)

	)
      )

;;  the domain specific sense preferences


(setf lxm::*domain-sense-preferences*
      '((W::EXPRESSION ONT::GENE-EXPRESSION)
	(W::EXPRESS ONT::GENE-EXPRESSION)
	(W::TRANSCRIPT ONT::RNA)
	(W::SITE ONT::MOLECULAR-SITE)
	(W::POSITION ONT::MOLECULAR-SITE)
	(W::complex ONT::MACROMOLECULAR-COMPLEX)
	;;(W::RAS ONT::PROTEIN-FAMILY )
	(W::ASSOCIATE ONT::ATTACH)
	(W::ASSOCIATION ONT::ATTACH)
	(W::INTERACT ONT::BIND-INTERACT)
	(W::interaction ONT::BIND-INTERACT)
	(W::FDA ONT::PROFESSIONAL-ORGANIZATION) ; as opposed to PROTEIN
	(W::MODEL ONT::REPRESENTATION)
	(W::CELL ONT::CELL)
	(W::CLEAR ONT::EMPTY) ;; "clear the model"
	(W::HGF ONT::GENE-PROTEIN)
	;((W::NF 1) ONT::GENE-PROTEIN) ; "NF1"
	(W::NF-1 ONT::GENE-PROTEIN) ; "NF1"
	(W::GO ONT::DATABASE)
	(w::high ont::high-val)
	(w::highly ont::high-val)
	(w::higher ont::high-val)
	(w::low ont::low-val)
	))

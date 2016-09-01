package states;

import TRIPS.KQML.KQMLList;

public class Action extends Goal {

	Goal contributesTo;
	
	public Action(KQMLList term) {
		super(term);
		// TODO Auto-generated constructor stub
	}

	public Action(KQMLList term, Goal parent) {
		super(term, parent);
		// TODO Auto-generated constructor stub
	}

	public Action(String variableName, KQMLList context, Goal parent) {
		super(variableName, context, parent);
		// TODO Auto-generated constructor stub
	}

	public Action(String variableName, KQMLList context) {
		super(variableName, context);
		// TODO Auto-generated constructor stub
	}

	public Goal getContributesTo() {
		return contributesTo;
	}

	public void setContributesTo(Goal contributesTo) {
		this.contributesTo = contributesTo;
	}


	
	
	
}

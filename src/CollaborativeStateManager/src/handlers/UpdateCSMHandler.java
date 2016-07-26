package handlers;

import java.util.List;

import plans.GoalPlanner;
import states.Goal;
import TRIPS.KQML.KQMLList;
import TRIPS.KQML.KQMLObject;
import TRIPS.KQML.KQMLPerformative;
import TRIPS.KQML.KQMLString;

public class UpdateCSMHandler extends MessageHandler {

	KQMLList innerContent = null;
	KQMLObject context;
	String updateType;
	GoalPlanner goalPlanner;
	String activeGoal = null;
	
	public UpdateCSMHandler(KQMLPerformative msg, KQMLList content, GoalPlanner goalPlanner) {
		super(msg, content);
		this.goalPlanner = goalPlanner;
		// TODO Auto-generated constructor stub
	}

	@Override
	public KQMLList process() {
		KQMLObject innerContentObj = content.getKeywordArg(":content");
		innerContent = null;
		
		if (innerContentObj instanceof KQMLList)
			innerContent = (KQMLList)innerContentObj;
		
		updateType = innerContent.get(0).stringValue();
		context = innerContent.getKeywordArg(":context");	
		
		KQMLObject activeGoalObject = innerContent.getKeywordArg(":active-goal");
		
		if ((activeGoalObject != null) &&
		    !activeGoalObject.stringValue().equalsIgnoreCase("nil") &&
		    !activeGoalObject.stringValue().equals("-"))
		    {
			activeGoal = activeGoalObject.stringValue();
		    }

		
		switch (updateType.toLowerCase())
		{
		case "proposed":
			return handleProposed();
		case "accepted-solution":
			return handleAcceptedSolution();
		case "accepted":
			return handleAccepted();
		case "no-initiative-taken":
			return handleNoInitiativeTaken();
		case "initiative-taken-on-goal":
			return handleInitiativeTakenOnGoal();
		case "failed-on":
			return handleFailedOn();
			
		}
		
		return failureMessage("NIL",context, 
				new KQMLString("UNKNOWN-UPDATE-TYPE"), new KQMLList());
		
	}
	
	private KQMLList handleProposed()
	{
		return null;
	}
	
	private KQMLList handleFailedOn()
	{
		
		KQMLObject goalNameObject = innerContent.getKeywordArg(":WHAT");
		String goalName = null;
		if (goalNameObject != null)
			goalName = goalNameObject.stringValue();
		// This was a specific goal that failed
		if (goalName != null && goalPlanner.hasGoal(goalName))
		{
			goalPlanner.getGoal(goalName).setFailed(true);
			System.out.println("Set goal + " + goalName + " as failed");
			return null;
		}
		
		// ... or, this was a new goal that was part of an existing goal
		
		KQMLObject failedAsObject = innerContent.getKeywordArg(":AS");
		
		if (failedAsObject != null && failedAsObject instanceof KQMLList)
		{
			KQMLList failedAsList = (KQMLList)failedAsObject;
			String parentGoalName = failedAsList.getKeywordArg(":OF").stringValue();
			if (goalPlanner.hasGoal(parentGoalName))
			{
				goalPlanner.getGoal(parentGoalName).setFailed(true);
				System.out.println("Set goal + " + parentGoalName + " as failed");
				return null;
			}
			
		}
					
		System.out.println("No such goal to set as failed");
		return null;
	}
	
	private KQMLList handleAcceptedSolution()
	{
		return null;
	}
	
	private KQMLList handleAccepted()
	{
		KQMLList acceptContent = (KQMLList)(innerContent.getKeywordArg(":CONTENT"));
		String goalName = acceptContent.getKeywordArg(":WHAT").stringValue();
		
		//TODO: Give better error message
		
		if (goalPlanner.hasGoal(goalName))
		{
			goalPlanner.setActiveGoal(goalName);
			System.out.println("Active goal now: " + goalName);
		}
		else
		{
			System.out.println("No such goal in system.");
			return missingGoal(goalName);
		}
		
		return null;
	}
	
	private KQMLList handleNoInitiativeTaken()
	{
		return null;
	}

	private KQMLList handleInitiativeTakenOnGoal()
	{
		return null;
	}
	
	private KQMLList missingGoal(String goalName)
	{
		KQMLList failureReason = new KQMLList();
		failureReason.add("MISSING-GOAL");
		
		return failureMessage(goalName, context,failureReason);
	}
}

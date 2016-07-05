package handlers;

import TRIPS.KQML.KQMLList;
import TRIPS.KQML.KQMLObject;
import TRIPS.KQML.KQMLPerformative;

public abstract class MessageHandler {

	KQMLPerformative msg;
	KQMLList content;
	
	public MessageHandler(KQMLPerformative msg, KQMLList content)
	{
		this.msg = msg;
		this.content = content;
	}
	
	public abstract KQMLList process();
	
	public KQMLList failureMessage(String what)
	{
		KQMLList context = new KQMLList();
		KQMLObject contextObject = content.getKeywordArg(":CONTEXT");
		if (contextObject != null && contextObject instanceof KQMLList)
			context = (KQMLList)contextObject;
		
		KQMLList failureContent = new KQMLList();
		failureContent.add("FAILED-TO-INTERPRET");
		failureContent.add(":WHAT");
		failureContent.add(what);
		failureContent.add(":REASON");
		failureContent.add("NIL");
		return reportContent(failureContent, context);
	}
	
	public KQMLList failureMessage()
	{
		return failureMessage("NIL");
	}
	
    protected KQMLList reportContent(KQMLObject content, KQMLObject context)
    {
    	KQMLList reportContent = new KQMLList();
    	reportContent.add("REPORT");
    	reportContent.add(":content");
    	reportContent.add(content);
    	reportContent.add(":context");
    	reportContent.add(context);
    	
    	return reportContent;
    }
}

package states;

public class Action {
	String name;
	Goal contributesTo;
	
	public Action(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}

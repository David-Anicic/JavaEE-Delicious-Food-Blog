package bean;

public class Prijava 
{
	String userName;
	
	public Prijava()
	{
		
	}

	public Prijava(String userName) {
		super();
		this.userName = userName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}

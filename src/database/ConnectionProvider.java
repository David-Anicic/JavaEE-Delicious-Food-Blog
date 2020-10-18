package database;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class ConnectionProvider 
{
	static EntityManagerFactory konekcija = Persistence.createEntityManagerFactory("David_Anicic_57_2015");
	static EntityManager em = konekcija.createEntityManager();
	
	private ConnectionProvider() { }
	
	public static EntityManager getConnection()
	{
		return em;
	}
}

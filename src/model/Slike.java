package model;

import javax.persistence.*;

@Entity
public class Slike 
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) private int id;
	private int idRecepta;
	private String nazivSlike;
	
	public Slike() { }
	
	public Slike(int idRecepta, String nazivSlike)
	{
		super();
		this.idRecepta = idRecepta;
		this.nazivSlike = nazivSlike;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getIdRecepta() {
		return idRecepta;
	}
	
	public void setIdRecepta(int idRecepta) {
		this.idRecepta = idRecepta;
	}
	
	public String getNazivSlike() {
		return nazivSlike;
	}
	
	public void setNazivSlike(String nazivSlike) {
		this.nazivSlike = nazivSlike;
	}
}

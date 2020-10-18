package model;

import javax.persistence.*;

@Entity
public class ReceptSastojci
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) private int id;
	private int idRecepta;
	private String sastojak;
	private int kolicina;
	private int idMere;
	
	public ReceptSastojci() { }

	public ReceptSastojci(int idRecepta, String sastojak, int kolicina, int idMere) 
	{
		super();
		this.idRecepta = idRecepta;
		this.sastojak = sastojak;
		this.kolicina = kolicina;
		this.idMere = idMere;
	}
	
	
	public String getSastojak() {
		return sastojak;
	}

	public void setSastojak(String sastojak) {
		this.sastojak = sastojak;
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

	public int getKolicina() {
		return kolicina;
	}

	public void setKolicina(int kolicina) {
		this.kolicina = kolicina;
	}

	public int getIdMere() {
		return idMere;
	}
	
	public void setIdMere(int idMere) {
		this.idMere = idMere;
	}
}

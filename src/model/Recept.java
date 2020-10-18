package model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Recept
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) private int id;
	private int idKorisnika;
	private String naziv;
	private String opis;
	private int idKategorije;
	
	public Recept() { }
	
	public Recept(String naziv, String opis, int idKategorije, int idKorisnika)
	{
		super();
		this.naziv = naziv;
		this.opis = opis;
		this.idKategorije = idKategorije;
		this.idKorisnika = idKorisnika;
	}
	
	public int getIdKorisnika()
	{
		return idKorisnika;
	}
	
	public void setIdKorisnik(int id)
	{
		idKorisnika = id;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNaziv() {
		return naziv;
	}
	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}
	public String getOpis() {
		return opis;
	}
	public void setOpis(String opis) {
		this.opis = opis;
	}
	public int getIdKategorije() {
		return idKategorije;
	}
	public void setIdKategorije(int idKategorije) {
		this.idKategorije = idKategorije;
	}
}

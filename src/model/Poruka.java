package model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * Entity implementation class for Entity: Poruka
 *
 */
@Entity

public class Poruka implements Serializable {

	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private int idPrimaoca;
	private int idPosiljaoca;
	String tekst;

	public Poruka(int id, int idPrimaoca, int idPosiljaoca, String tekst) {
		super();
		this.id = id;
		this.idPrimaoca = idPrimaoca;
		this.idPosiljaoca = idPosiljaoca;
		this.tekst = tekst;
	}
	
	

	public Poruka(int idPrimaoca, int idPosiljaoca, String tekst) {
		super();
		this.idPrimaoca = idPrimaoca;
		this.idPosiljaoca = idPosiljaoca;
		this.tekst = tekst;
	}



	public Poruka() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdPrimaoca() {
		return idPrimaoca;
	}

	public void setIdPrimaoca(int idPrimaoca) {
		this.idPrimaoca = idPrimaoca;
	}

	public int getIdPosiljaoca() {
		return idPosiljaoca;
	}

	public void setIdPosiljaoca(int idPosiljaoca) {
		this.idPosiljaoca = idPosiljaoca;
	}

	public String getTekst() {
		return tekst;
	}

	public void setTekst(String tekst) {
		this.tekst = tekst;
	}
   
}

package bean;

public class Poruka 
{
	String tekstPoruke;
	String primalac;
	String posiljalac;
	
	public Poruka()
	{
		
	}
	
	public Poruka(String tekstPoruke, String primalac, String posiljalac) {
		super();
		this.tekstPoruke = tekstPoruke;
		this.primalac = primalac;
		this.posiljalac = posiljalac;
	}
	public String getTekstPoruke() {
		return tekstPoruke;
	}
	public void setTekstPoruke(String tekstPoruke) {
		this.tekstPoruke = tekstPoruke;
	}
	public String getPrimalac() {
		return primalac;
	}
	public void setPrimalac(String primalac) {
		this.primalac = primalac;
	}
	public String getPosiljalac() {
		return posiljalac;
	}
	public void setPosiljalac(String posiljalac) {
		this.posiljalac = posiljalac;
	}
	
}

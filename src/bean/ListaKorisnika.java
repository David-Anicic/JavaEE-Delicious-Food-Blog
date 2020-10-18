package bean;

import java.util.ArrayList;
import java.util.List;

public class ListaKorisnika 
{
	List<String> onlineKorisnici;

	public ListaKorisnika(List<String> onlineKorisnici) {
		super();
		this.onlineKorisnici = onlineKorisnici;
	}

	public ListaKorisnika() {
		super();
	}

	public List<String> getOnlineKorisnici() {
		return onlineKorisnici;
	}

	public void setOnlineKorisnici(List<String> onlineKorisnici) {
		this.onlineKorisnici = onlineKorisnici;
	}
	
}

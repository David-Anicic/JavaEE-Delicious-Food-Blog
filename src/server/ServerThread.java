package server;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;

import bean.ListaKorisnika;
import bean.Odjava;
import bean.Poruka;
import model.Korisnik;
import util.Util;

public class ServerThread extends Thread 
{
	public static Map<String, BufferedWriter> mapaKorisnika = new HashMap<>();
	BufferedReader br;
	String uname;
	
	public ServerThread(String uname, BufferedWriter bw, BufferedReader br)
	{
		this.uname=uname;
		this.br=br;
		synchronized (mapaKorisnika) {
			mapaKorisnika.put(uname, bw);
			try {
				List<String> lista = new ArrayList<>();
				for(String un: mapaKorisnika.keySet()) {
					lista.add(un);
				}
				ListaKorisnika lk = new ListaKorisnika(lista);
				if(mapaKorisnika.containsKey("admin"))
				{
					mapaKorisnika.get("admin").write(Util.getXmlFromObject(lk));
					mapaKorisnika.get("admin").flush();
					System.out.println("poslata lista korisnika sa ServerThread-a");
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	
	public void run()
	{
		while(true) {
			try {
				System.out.println("Server: pre citanja poruke");
				Object o = Util.getObjectFromString(br.readLine());
				//System.out.println("Server: procitao poruku:"+((Poruka)o).getTekstPoruke());
				if(o instanceof Poruka) {
					Poruka p = (Poruka)o;
					synchronized (mapaKorisnika) {
						if(mapaKorisnika.containsKey(p.getPrimalac()))
						{
							System.out.println("mapa sadrzi primaoca:"+p.getPrimalac());
							mapaKorisnika.get(p.getPrimalac()).write(Util.getXmlFromObject(p));
							mapaKorisnika.get(p.getPrimalac()).flush();
						}
						EntityManager em = database.ConnectionProvider.getConnection();
						
						String sql = "select * from korisnik where korisnickoIme like '"+p.getPrimalac()+"'";
						@SuppressWarnings("unchecked")
						List<Korisnik> primalac = em.createNativeQuery(sql, Korisnik.class).getResultList();
						
						sql = "select * from korisnik where korisnickoIme like '"+p.getPosiljalac()+"'";
						@SuppressWarnings("unchecked")
						List<Korisnik> posiljalac = em.createNativeQuery(sql, Korisnik.class).getResultList();
						
						model.Poruka por = new model.Poruka(primalac.get(0).getId(), posiljalac.get(0).getId(), p.getTekstPoruke());
						em.getTransaction().begin();
						em.persist(por);
						em.getTransaction().commit();
					}
				}else if(o instanceof Odjava) {
					Odjava od=(Odjava)o;
					String korisnickoIme=od.getKorisnickoIme();
					System.out.println("Korisnik: "+korisnickoIme+" se odjavljuje");
					if(mapaKorisnika.containsKey(korisnickoIme))
						mapaKorisnika.remove(korisnickoIme);
					
					List<String> lista = new ArrayList<>();
					for(String un: mapaKorisnika.keySet()) {
						lista.add(un);
					}
					ListaKorisnika lk = new ListaKorisnika(lista);
					if(mapaKorisnika.containsKey("admin"))
					{
						mapaKorisnika.get("admin").write(Util.getXmlFromObject(lk));
						mapaKorisnika.get("admin").flush();
						System.out.println("poslata lista korisnika sa ServerThread-a");
					}
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}

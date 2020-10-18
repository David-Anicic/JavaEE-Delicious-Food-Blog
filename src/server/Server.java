package server;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

import bean.Prijava;
import util.Util;

public class Server 
{
	public static void main(String[] args) {
		
		try {
			ServerSocket server = new ServerSocket(9090);
			
			while(true)
			{
				Socket klijent = server.accept();
				BufferedReader br = Util.getBuffredReader(klijent);
				BufferedWriter bw = Util.getBuffredWriter(klijent);
				System.out.println("konektovan korisnik");
				Object o = Util.getObjectFromString(br.readLine());
				if(o instanceof Prijava)
				{
					String uname = ((Prijava)o).getUserName();
					(new ServerThread(uname,bw,br)).start();
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
}

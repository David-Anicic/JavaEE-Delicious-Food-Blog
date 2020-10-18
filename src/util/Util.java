package util;

import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;

public class Util {
	
	public static BufferedReader getBuffredReader(Socket socket) throws IOException
	{
		InputStreamReader isr = new InputStreamReader(socket.getInputStream());
		
		return new BufferedReader(isr);
	}
	
	public static BufferedWriter getBuffredWriter(Socket socket) throws IOException
	{
		OutputStreamWriter osw = new OutputStreamWriter(socket.getOutputStream());
		
		return new BufferedWriter(osw);
	}
	
	public static String getXmlFromObject(Object o)
	{
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		XMLEncoder xmlEncoder = new XMLEncoder(baos);
		xmlEncoder.writeObject(o);
		xmlEncoder.close();
		
		return new String(baos.toByteArray()).replace("\n", "") + "\n";
	}
	
	public static Object getObjectFromString(String xml)
	{
		ByteArrayInputStream bais = new ByteArrayInputStream(xml.getBytes());
		XMLDecoder xmlDecoder = new XMLDecoder(bais);
		Object o = xmlDecoder.readObject();
		xmlDecoder.close();
		
		return o;
	}
}
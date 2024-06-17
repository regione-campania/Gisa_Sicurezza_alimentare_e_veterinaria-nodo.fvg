package org.aspcfs.modules.suap.base;

import java.util.ArrayList;
import java.util.HashMap;

public class BeanPerXmlRichiesta {
	String campo1;
	String campo2;
	ArrayList<HashMap<String,String>> listaEntries;
	
	public String getCampo1() {
		return campo1;
	}
	public void setCampo1(String campo1) {
		this.campo1 = campo1;
	}
	public String getCampo2() {
		return campo2;
	}
	public void setCampo2(String campo2) {
		this.campo2 = campo2;
	}
	public void setListaEntries(ArrayList<HashMap<String, String>> entries) {
		listaEntries = entries;
		
	}
	
	public ArrayList<HashMap<String,String>> getListaEntries()
	{
		return listaEntries;
	}
	
	
	
}

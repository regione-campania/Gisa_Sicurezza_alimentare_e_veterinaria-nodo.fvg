package org.aspcfs.modules.suap.campiestesiv2;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

public class Attr {
	private String attr;
	private String value;
	
	public String getAttr() {
		return attr;
	}
	public void setAttr(String attr) {
		this.attr = attr;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	
	
	public Attr(String attr, String value)
	{
		this.attr = attr;
		this.value = value;
	}
	public String getHtml()
	{
		return (this.attr+"=\""+this.value)+"\" ";
	}
	
	public static  ArrayList<Attr> buildList(JSONArray ja)
	{
		
		ArrayList<Attr> toRet = new ArrayList<Attr>();
		if(ja != null)
		{
			for(int i = 0; i< ja.length();i++)
			{
				JSONObject jo = (JSONObject) ja.get(i);
				/* per hp deve essere un {attr name : attrvalue} */
				String nomeAttr = (String)jo.keys().next();
				String valueAttr = (String)jo.getString(nomeAttr);
			
				toRet.add(new Attr(nomeAttr,valueAttr));
			}
		}
		return toRet;
	}
	
}

package org.aspcfs.modules.suap.campiestesiv2;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

public class Prop {
	private String prop;
	private Boolean value;
	
	public Prop(String prop, Boolean value)
	{
		this.prop = prop;
		this.value = value;
	}
	
	public String getHtml()
	{
		if(value == true)
		{
			return this.prop+" ";
		}
		return " ";
	}
	
	public static  ArrayList<Prop> buildList(JSONArray ja)
	{
		ArrayList<Prop> toRet = new ArrayList<Prop>();
		
		if(ja != null)
		{
			for(int i = 0; i< ja.length();i++)
			{
				JSONObject jo = (JSONObject) ja.get(i);
				/* per hp deve essere un {attr name : attrvalue} */
				String nomeAttr = (String)jo.keys().next();
				Boolean valueAttr = Boolean.parseBoolean((String)jo.getString(nomeAttr));
			
				toRet.add(new Prop(nomeAttr,valueAttr));
			}
		}
		return toRet;
	}
}

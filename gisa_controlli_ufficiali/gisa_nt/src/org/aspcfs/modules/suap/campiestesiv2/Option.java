package org.aspcfs.modules.suap.campiestesiv2;

import java.sql.Connection;

import org.json.JSONArray;
import org.json.JSONObject;

public class Option extends HtmlTag {
	
	public boolean isDefault;
	 
	
	public static Option build(JSONObject jo, int idRelStabLp, int idIstanzaValore, Connection conn) /*non mi servono in realtx idrelstablp e idistanza valore in questo caso */
	{
		Option op = new Option();
		 op.ordine = Integer.parseInt(getSafe(jo,"ordine") != null ? (String)getSafe(jo,"ordine") : "0");
		 op.isDefault = Boolean.parseBoolean(  getSafe(jo,"default") != null ? (String) getSafe(jo,"default") : "false");
		 op.valoreAssunto = (String) getSafe(jo,"valore");
		 op.label = (String)getSafe(jo,"label");
		 op.type = "option";
		 JSONArray arrayAttrs =  (JSONArray) getSafe(jo,"attrs");
		 JSONArray arrayProps =(JSONArray) getSafe(jo,"props");
		 op.attrs = Attr.buildList(arrayAttrs);
		 op.props = Prop.buildList(arrayProps);
		 
		 return op;
	}
	
	
	@Override
	public String apriTag() {

		StringBuffer toRet = new StringBuffer("<option ");
		 
		toRet.append("value = "+this.valoreAssunto);
		for(Attr attr : attrs)
		{
			toRet.append(attr.getHtml());
		}
		for(Prop prop : props)
		{
			toRet.append(prop.getHtml());
		}
		if(isDefault)
		{
			toRet.append(" selected");
		}
		toRet.append(" >");
		return toRet.toString();
	}

	@Override
	public String chiudiTag() {
		 
		return "</option>";
	}

	
	@Override
	public String generaHtml() {
		 

		String toRet = apriTag();
		toRet += (this.label);
		toRet += chiudiTag();
		return toRet;
	}
	
}

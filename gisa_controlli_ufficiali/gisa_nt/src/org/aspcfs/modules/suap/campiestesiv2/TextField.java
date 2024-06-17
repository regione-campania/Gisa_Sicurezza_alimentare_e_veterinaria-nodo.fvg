package org.aspcfs.modules.suap.campiestesiv2;

import java.sql.Connection;

import org.json.JSONArray;
import org.json.JSONObject;

public class TextField extends HtmlTag {

	
	
	
	@Override
	public String apriTag() {

		StringBuffer toRet = new StringBuffer("<input ");
		toRet.append("type = \""+this.type+"\" ");
		toRet.append("name = \""+this.name+"\" ");
		toRet.append("value = \""+this.valoreAssunto+"\" ");

		toRet.append("class = \"ordine-"+this.ordine+"\" ");
		
		for(Attr attr : attrs)
		{
			toRet.append(attr.getHtml());
		}
		for(Prop prop : props)
		{
			toRet.append(prop.getHtml());
		}
		toRet.append(" >");
		return toRet.toString();
	}

	
	@Override
	public String chiudiTag() {
		
		return "</input>";
	}
	
	
	public static TextField build(JSONObject jo, int idRelStabLp, int idIstanzaValore, Connection db ) throws Exception /*se idRelStabLp e' != -1 cerca di agganciargli il valore */
	{
		 TextField tf = new TextField();
		 tf.ordine = Integer.parseInt(getSafe(jo,"ordine") != null ? (String)getSafe(jo,"ordine") : "0");
		 tf.type = (String) getSafe(jo,"type");
		 tf.name = (String) getSafe(jo,"name");
		 tf.label = (String) getSafe(jo,"label");
//		 tf.injectHtml = (String) getSafe(jo,"label");
		 JSONArray arrayAttrs = (JSONArray) getSafe(jo,"attrs");
		 JSONArray arrayProps = (JSONArray) getSafe(jo,"props");
		 tf.attrs = Attr.buildList(arrayAttrs);
		 tf.props = Prop.buildList(arrayProps);
		 if(idRelStabLp > 0 && idIstanzaValore > 0)
		 {
			 tf.searchAndSetValue(db, idRelStabLp,idIstanzaValore);
		 }
		 
		 return tf;
		
	}
	 
	

}

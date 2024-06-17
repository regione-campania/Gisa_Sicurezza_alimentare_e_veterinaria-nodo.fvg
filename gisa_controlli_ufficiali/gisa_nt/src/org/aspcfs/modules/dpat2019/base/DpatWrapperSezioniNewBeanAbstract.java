package org.aspcfs.modules.dpat2019.base;

import java.sql.Connection;
import java.util.ArrayList;

import org.json.JSONArray;

public abstract class DpatWrapperSezioniNewBeanAbstract<T extends DpatSezioneNewBeanInterface>
{
	public int anno;
	public int getAnno(){return this.anno;}
	public ArrayList<T> sezioni = new ArrayList<T>();

	public ArrayList<T> getSezioni(){return this.sezioni;}
	public void setSezioni(ArrayList<T> sezioni) {this.sezioni = sezioni;}

	public JSONArray getJsonArray()
	{
		JSONArray toRet = new JSONArray();
		for(T bean : sezioni)
		{
			toRet.put(bean.getJsonObj());
		}
		return toRet;
	}
	
	public abstract int  getStatoDopoModifica(Connection db,int anno) throws Exception;
	
}

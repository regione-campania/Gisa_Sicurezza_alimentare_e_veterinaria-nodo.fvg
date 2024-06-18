package org.aspcfs.modules.gestioneDocumenti.base;

import com.darkhorseventures.framework.beans.GenericBean;

public class DocumentaleDocumento  extends GenericBean {
	
	private static final long serialVersionUID = 4320567602597719160L;
	
	private String tipo = null; //tipo certificato
	private String dataCreazione = null;
	private int userId = -1;
	private String userIp = null;
	private boolean glifo = false;
	private String idHeader = null;
	private int idDocumento = -1;
	private boolean statico = false;
	private String nomeDocumento = null;
	
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
		public boolean isGlifo() {
		return glifo;
	}
	public void setGlifo(boolean glifo) {
		this.glifo = glifo;
	}
	public void setGlifo(String glifo) {
		if (glifo!=null && !glifo.equals(""))
		this.glifo = true;
	}
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public void setUserId(String userId) {
		if (userId!=null && !userId.equals("null") && !userId.equals(""))
			this.userId = Integer.parseInt(userId);
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public String getIdHeader() {
		return idHeader;
	}
	public void setIdHeader(String idHeader) {
		this.idHeader = idHeader;
	}
	public int getIdDocumento() {
		return idDocumento;
	}
	public void setIdDocumento(int idDocumento) {
		this.idDocumento = idDocumento;
	}
	public void setIdDocumento(String idDocumento) {
		if (idDocumento!=null && !idDocumento.equals("null") && !idDocumento.equals(""))
			this.idDocumento = Integer.parseInt(idDocumento);
	}
	public String getDataCreazione() {
		return dataCreazione;
	}
	public void setDataCreazione(String dataCreazione) {
		this.dataCreazione = dataCreazione;
	}
	public String getNomeDocumento() {
		return nomeDocumento;
	}
	public void setNomeDocumento(String nomeDocumento) {
		this.nomeDocumento = nomeDocumento;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
		
	public DocumentaleDocumento(String riga) {
		
		String[] split;
		split = riga.split(";;");
				
		this.setDataCreazione(split[0]); 	
		this.setNomeDocumento(split[1]);
		this.setUserId(split[2]);
		this.setUserIp(split[3]);
		this.setGlifo(split[4]);
		this.setIdHeader(split[5]);
		this.setIdDocumento(split[6]);
		this.setTipo(split[7]);
		this.setStatico(split[8]);
		
		
		
	
		
		}
	public boolean isStatico() {
		return statico;
	}
	public void setStatico(boolean statico) {
		this.statico = statico;
	}
	public void setStatico(String statico) {
		if (statico!=null && !statico.equals(""))
		this.glifo = true;
	}
	

}

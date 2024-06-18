package it.us.web.bean.vam;

import it.us.web.bean.BUtente;

import java.util.Date;

public interface EsameInterface
{
	public int				getId();
	public Date				getDataRichiesta();
	public Date				getDataEsito();
	public CartellaClinica	getCartellaClinica();
	public BUtente			getEnteredBy();
	public Date				getEntered();
	public String			getNomeEsame();
	public String			getHtml();
}

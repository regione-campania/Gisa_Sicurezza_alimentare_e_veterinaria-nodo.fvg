package org.aspcfs.modules.opu.actions;

public class BeanMappingLinea {
	
	private int idLineaV;
	private int idLineaN;
	
	private String macroV;
	private String macroN;
	private String aggrV;
	private String aggrN;
	private String attV;
	private String attN;
	private int ranking;
	
	public int getRanking() {
		return ranking;
	}
	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
	public BeanMappingLinea(int idv, String macroV, String aggrV, String attV, int idN, String macroN, String aggrN, String attN,int ranking)
	{
		idLineaV = idv;
		this.ranking = ranking;
		this.macroV = macroV;
		this.aggrV = aggrV;
		this.attV = attV;
		this.idLineaN = idN;
		this.macroN = macroN;
		this.aggrN = aggrN;
		this.attN = attN;
	}
	public int getIdLineaV() {
		return idLineaV;
	}
	public void setIdLineaV(int idLineaV) {
		this.idLineaV = idLineaV;
	}
	public int getIdLineaN() {
		return idLineaN;
	}
	public void setIdLineaN(int idLineaN) {
		this.idLineaN = idLineaN;
	}
	public String getMacroV() {
		return macroV;
	}
	public void setMacroV(String macroV) {
		this.macroV = macroV;
	}
	public String getMacroN() {
		return macroN;
	}
	public void setMacroN(String macroN) {
		this.macroN = macroN;
	}
	public String getAggrV() {
		return aggrV;
	}
	public void setAggrV(String aggrV) {
		this.aggrV = aggrV;
	}
	public String getAggrN() {
		return aggrN;
	}
	public void setAggrN(String aggrN) {
		this.aggrN = aggrN;
	}
	public String getAttV() {
		return attV;
	}
	public void setAttV(String attV) {
		this.attV = attV;
	}
	public String getAttN() {
		return attN;
	}
	public void setAttN(String attN) {
		this.attN = attN;
	}
	
	
}

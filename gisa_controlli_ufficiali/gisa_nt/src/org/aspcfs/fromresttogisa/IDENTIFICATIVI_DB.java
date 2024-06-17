package org.aspcfs.fromresttogisa;

public enum IDENTIFICATIVI_DB {
	
	ATT_FISSA(1)
	,ATT_MOBILE(2)
	,ATT_APICOLTURA(3)
	,IMPRESA_INDIVIDUALE(1)
	,TIPO_REG_RIC_REGISTRABILI(1)
	,CATEGORIA_INSERIMENTO_CAT4(4);
	
	public int getData(){return this.data;}
	private IDENTIFICATIVI_DB(int i){this.data = i;}
	private int data;
}

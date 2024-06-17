package org.aspcfs.modules.checklistdocumenti.base;

import java.util.HashMap;

import com.darkhorseventures.framework.beans.GenericBean;

public class Checklist extends GenericBean {
	
	private int orgId = -1;
	private int idAsl = -1;
	private int tipoChecklist = -1;

	private HashMap <Integer, Integer[]> questionario = new HashMap<Integer, Integer[]>();
	
	

}

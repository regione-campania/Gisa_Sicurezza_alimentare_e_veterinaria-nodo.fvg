package org.aspcfs.modules.registrazioniAnimali.base;

import java.util.ArrayList;

import org.aspcfs.utils.web.PagedListInfo;


public class SchedaDecessoList extends ArrayList<SchedaDecesso> {

	private PagedListInfo pagedListInfo = null;
	


	
	public void setPagedListInfo(PagedListInfo tmp) {
		this.pagedListInfo = tmp;
	}
	public PagedListInfo getPagedListInfo() {
		return pagedListInfo;
	}
	
	
}

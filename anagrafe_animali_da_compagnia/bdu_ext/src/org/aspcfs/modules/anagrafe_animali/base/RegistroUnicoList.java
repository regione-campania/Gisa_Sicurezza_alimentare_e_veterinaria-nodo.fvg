package org.aspcfs.modules.anagrafe_animali.base;

import java.util.ArrayList;

import org.aspcfs.utils.web.PagedListInfo;


public class RegistroUnicoList extends ArrayList<RegistroUnico> {

	private PagedListInfo pagedListInfo = null;
	


	
	public void setPagedListInfo(PagedListInfo tmp) {
		this.pagedListInfo = tmp;
	}
	public PagedListInfo getPagedListInfo() {
		return pagedListInfo;
	}
	
	
}

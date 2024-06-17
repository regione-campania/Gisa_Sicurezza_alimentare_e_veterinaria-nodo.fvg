package org.aspcfs.utils;

import com.darkhorseventures.framework.actions.ActionContext;

public class PrefissoWrapper {
	
	public static String valutaPrefissoWrapper(ActionContext context){
	    if(context.getRequest().getParameter("fromWrapper") != null && context.getRequest().getParameter("fromWrapper").equals("si") ){
	    	return"W_";
	    }
	    return "";
	}

}

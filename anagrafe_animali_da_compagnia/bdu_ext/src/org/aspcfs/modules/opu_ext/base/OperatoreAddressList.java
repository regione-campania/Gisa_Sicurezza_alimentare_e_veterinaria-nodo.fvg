package org.aspcfs.modules.opu_ext.base;

import javax.servlet.http.HttpServletRequest;

import org.aspcfs.modules.base.AddressList;

public class OperatoreAddressList extends AddressList{

	
	  public OperatoreAddressList() {
	  }
	  
	  
	  
	  public OperatoreAddressList(HttpServletRequest request) {
		    int i = 1;
		    int primaryAddress = -1;
		    if (request.getParameter("primaryAddress") != null) {
		      primaryAddress = Integer.parseInt(
		          (String) request.getParameter("primaryAddress"));
		    }
		    
		    while (request.getParameter("address" + (i) + "type") != null) {
		    	org.aspcfs.modules.opu_ext.base.OperatoreAddress thisAddress = new  org.aspcfs.modules.opu_ext.base.OperatoreAddress();
		    	thisAddress.buildRecord(request, i);
		      if (primaryAddress == i) {
		        thisAddress.setPrimaryAddress(true);
		      }
		      if (thisAddress.isValid()) {
		        this.addElement(thisAddress);
		      }
		      i++;
		    }
		  
		    i=1;
		    while (request.getParameter("address4"  + "type"+(i)) != null) {
		    	
		    	// org.aspcfs.modules.requestor.base.OrganizationAddress thisAddress = new  org.aspcfs.modules.requestor.base.OrganizationAddress();
		        /*thisAddress.buildRecord2(request, i);
		       
		        if (thisAddress.isValid()) {
		          this.addElement(thisAddress);
		        }
		        i++;*/
		      }
		    
		  }
	  
	  
}

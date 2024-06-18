package org.aspcfs.utils;

import java.lang.reflect.Method;

import org.directwebremoting.AjaxFilter;
import org.directwebremoting.AjaxFilterChain;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.extend.LoginRequiredException;
  
public class DwrSessionFilter implements AjaxFilter {
    public Object doFilter(Object obj, Method method, Object[] params, AjaxFilterChain chain) throws Exception {
 
        //Check if session has timedout/invalidated
        if( WebContextFactory.get().getSession( false ) == null ) {
            //Throw an exception
            throw new LoginRequiredException( "Sessione di Lavoro Scaduta." );
        }
 
        return chain.doFilter( obj, method, params );
    }
}

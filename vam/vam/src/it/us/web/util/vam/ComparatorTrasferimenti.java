package it.us.web.util.vam;

import it.us.web.bean.vam.Trasferimento;
import java.util.Comparator;

public class ComparatorTrasferimenti implements Comparator<Trasferimento>{
 
    @Override
    public int compare(Trasferimento t1, Trasferimento t2) 
    {
    	int toReturn = 0;
    	
    	if(t1.getStato().getStatoOrder()>t2.getStato().getStatoOrder())
    		toReturn = -1;
    	else if(t1.getStato().getStatoOrder()==t2.getStato().getStatoOrder())
    	{
    		if(t1.getDataRichiesta().after(t2.getDataRichiesta()))
    			toReturn =  -1;
    		else if(!t1.getDataRichiesta().after(t2.getDataRichiesta()) && !t1.getDataRichiesta().before(t2.getDataRichiesta()))
    			toReturn =  0;
    		else if(t1.getDataRichiesta().before(t2.getDataRichiesta()))
    			toReturn =  1;
    			
    	}
    	else
    		toReturn =  1;
    	
    	return toReturn;
    }
}

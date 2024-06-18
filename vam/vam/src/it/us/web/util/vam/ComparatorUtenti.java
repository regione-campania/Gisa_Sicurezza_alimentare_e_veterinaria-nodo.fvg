package it.us.web.util.vam;

import it.us.web.bean.BUtente;
import java.util.Comparator;

public class ComparatorUtenti implements Comparator<BUtente>{
 
    @Override
    public int compare(BUtente u1, BUtente u2) 
    {
    	return u1.toString().toLowerCase().compareTo(u2.toString().toLowerCase());
    }
}

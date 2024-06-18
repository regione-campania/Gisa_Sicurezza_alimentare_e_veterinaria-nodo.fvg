package it.us.web.util.vam;

import it.us.web.bean.SuperUtente;

import java.util.Comparator;

public class ComparatorSuperUtenti implements Comparator<SuperUtente>{
 
    @Override
    public int compare(SuperUtente u1, SuperUtente u2) 
    {
    	return u1.toString().toLowerCase().compareTo(u2.toString().toLowerCase());
    }
}

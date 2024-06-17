package org.aspcfs.modules.opu.actions;

import java.util.regex.Pattern;

public class EccezioneCodiceL30GiaInUso extends Exception {

	public EccezioneCodiceL30GiaInUso()
	{
		
	}
	public EccezioneCodiceL30GiaInUso(String msg)
	{
		super(msg);
	}
	
	public static void main(String[] args)
	{
		String t = "cc00234asd";
		Pattern p = Pattern.compile("[0-9]{4}");
		 
		int i = 0; 
		int parsed = -1;
		t = t.replaceAll("[^0-9]","");
		parsed = Integer.parseInt(t);
	}
}

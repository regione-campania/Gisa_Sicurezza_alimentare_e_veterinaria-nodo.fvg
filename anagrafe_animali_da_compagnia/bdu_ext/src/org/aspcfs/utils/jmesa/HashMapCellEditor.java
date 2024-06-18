package org.aspcfs.utils.jmesa;


import java.util.HashMap;

import org.jmesa.view.editor.CellEditor;
import org.jmesa.view.html.HtmlBuilder;

public class HashMapCellEditor implements CellEditor
{
	public Object getValue(Object item, String property, int rowcount) 
	{
		
		HashMap h = (HashMap)item;
	//	Animale u = (Animale)h.get("u");
		
		//String ruolo = u.getMicrochip();
        
        HtmlBuilder html = new HtmlBuilder();
//        html.append(ruolo);
        return html.toString();
    }
}

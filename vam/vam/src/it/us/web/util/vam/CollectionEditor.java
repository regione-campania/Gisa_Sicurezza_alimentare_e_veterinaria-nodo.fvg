package it.us.web.util.vam;

import it.us.web.bean.vam.CartellaClinica;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.jmesa.util.ItemUtils;
import org.jmesa.view.editor.CellEditor;
import org.jmesa.view.html.HtmlBuilder;

public class CollectionEditor implements CellEditor
{
	public Object getValue(Object item, String property, int rowcount) 
	{
		HtmlBuilder html = new HtmlBuilder();
		Set<CartellaClinica> items = (Set<CartellaClinica>)item;
		
		Iterator<CartellaClinica> iter = items.iterator();
		
		
		while(iter.hasNext())
		{
			html.append(iter.next().getDiagnosis());
		}
        return html.toString();
    }
}
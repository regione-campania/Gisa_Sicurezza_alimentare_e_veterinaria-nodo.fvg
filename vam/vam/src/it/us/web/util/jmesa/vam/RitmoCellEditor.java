package it.us.web.util.jmesa.vam;

import org.jmesa.util.ItemUtils;
import org.jmesa.view.editor.CellEditor;
import org.jmesa.view.html.HtmlBuilder;

public class RitmoCellEditor implements CellEditor
{
	public Object getValue(Object item, String property, int rowcount) 
	{
		Object value = ItemUtils.getItemValue(item, property);
        
		String tipo = "";
        if(value.equals("S"))
        {
        	tipo = "Sinusale";
        }
        if(value.equals("A"))
        {
        	tipo = "Aritmico";
        }
        
        HtmlBuilder html = new HtmlBuilder();
        html.append(tipo);
        return html.toString();
    }
}
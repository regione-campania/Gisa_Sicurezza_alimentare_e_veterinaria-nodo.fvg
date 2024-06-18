package it.us.web.util.jmesa.vam;

import org.jmesa.util.ItemUtils;
import org.jmesa.view.editor.CellEditor;
import org.jmesa.view.html.HtmlBuilder;

public class EsitoLeishmaniosiCellEditor implements CellEditor
{
	public Object getValue(Object item, String property, int rowcount) 
	{
		Object value = ItemUtils.getItemValue(item, property);
        
		String esito = value.toString();
        
        HtmlBuilder html = new HtmlBuilder();
        html.append(esito);
        return html.toString();
    }
}
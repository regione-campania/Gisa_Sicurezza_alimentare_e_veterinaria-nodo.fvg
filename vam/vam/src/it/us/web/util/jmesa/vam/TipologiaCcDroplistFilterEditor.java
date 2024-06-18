package it.us.web.util.jmesa.vam;

import java.util.ArrayList;

import org.jmesa.view.html.editor.DroplistFilterEditor;

public class TipologiaCcDroplistFilterEditor extends DroplistFilterEditor {
   @Override
   protected ArrayList<Option> getOptions()  {
	   ArrayList<Option> options = new ArrayList<Option>();
      options.add(new Option("Degenza","Degenza"));
      options.add(new Option("Day Hospital", "Day Hospital"));
      options.add(new Option("Necroscopica", "Necroscopica"));
      return options;
   }
}
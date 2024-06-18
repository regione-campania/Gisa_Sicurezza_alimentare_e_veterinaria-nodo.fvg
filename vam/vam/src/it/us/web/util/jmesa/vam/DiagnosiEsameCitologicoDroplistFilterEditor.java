package it.us.web.util.jmesa.vam;

import java.util.ArrayList;

import org.jmesa.view.html.editor.DroplistFilterEditor;

public class DiagnosiEsameCitologicoDroplistFilterEditor extends DroplistFilterEditor {
   @Override
   protected ArrayList<Option> getOptions()  {
	   ArrayList<Option> options = new ArrayList<Option>();
      options.add(new Option("1","Diagnosi 1"));
      options.add(new Option("2", "Diagnosi 2"));
      options.add(new Option("3", "Diagnosi 3"));
      return options;
   }
}
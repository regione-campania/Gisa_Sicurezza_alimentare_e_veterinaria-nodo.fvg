package it.us.web.util.jmesa.vam;

import java.util.ArrayList;

import org.jmesa.view.html.editor.DroplistFilterEditor;

public class EsitoLeishmaniosiDroplistFilterEditor extends DroplistFilterEditor {
   @Override
   protected ArrayList<Option> getOptions()  {
	   ArrayList<Option> options = new ArrayList<Option>();
      options.add(new Option("1 : 160","1 : 160"));
      options.add(new Option("1 : 320", "1 : 320"));
      options.add(new Option("1 : 640","1 : 640"));
      options.add(new Option("1 : 1280", "1 : 1280"));
      options.add(new Option("> 1 : 1280","> 1 : 1280"));
      options.add(new Option("1 : 40", "1 : 40"));
      options.add(new Option("1 : 80","1 : 80"));
      options.add(new Option("< 1 : 40", "< 1 : 40"));
      return options;
   }
}
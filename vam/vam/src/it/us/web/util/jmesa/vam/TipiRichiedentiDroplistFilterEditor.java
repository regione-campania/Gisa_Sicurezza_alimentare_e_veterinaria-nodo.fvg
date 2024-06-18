package it.us.web.util.jmesa.vam;

import java.util.ArrayList;

import org.jmesa.view.html.editor.DroplistFilterEditor;

public class TipiRichiedentiDroplistFilterEditor extends DroplistFilterEditor {
   @Override
   protected ArrayList<Option> getOptions()  {
	   ArrayList<Option> options = new ArrayList<Option>();
      options.add(new Option("Privato","Privato"));
      options.add(new Option("Altro", "Altro"));
      options.add(new Option("Associazione", "Associazione"));
      options.add(new Option("Personale ASL", "Personale ASL"));
      options.add(new Option("Questura", "Questura"));
      options.add(new Option("Polizia", "Polizia"));
      options.add(new Option("Carabinieri", "Carabinieri"));
      options.add(new Option("Vigili del fuoco", "Vigili del fuoco"));
      options.add(new Option("Polizia Municipale", "Polizia Municipale"));
      options.add(new Option("Corpo forestale", "Corpo forestale"));
      options.add(new Option("Polizia provinciale", "Polizia provinciale"));
      options.add(new Option("Polizia di Stato", "Polizia di Stato"));
      options.add(new Option("Guardia di Finanza", "Guardia di Finanza"));
      return options;
   }
}
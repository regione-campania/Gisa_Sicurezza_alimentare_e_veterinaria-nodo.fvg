function popupAggiunta() {
  var stili = "top=30, left=30, width=600, height=150, status=no, menubar=no, toolbar=no scrollbars=no";
  var testo = window.open("", "", stili);
    
  testo.document.write("<html>\n");
  testo.document.write(" <head>\n");
  testo.document.write("  <title>G.I.S.A.</title>\n");
  testo.document.write("  <basefont size=2 face=Tahoma>\n");
  testo.document.write(" </head>\n");
  testo.document.write("<body>");
  testo.document.write("<center><b><font color=\"red\">Attenzione!</font></b><br/>");
  testo.document.write("In questa fase di transizione verso la gestione Operatore Unico, per le operazioni di inserimento contattare ORSA. <br/><br/>");
  testo.document.write("<b>Mail</b>: b.napolitano@usmail.it <br/>");
  testo.document.write("Scheda da scaricare e compilare: <a href='operatorinonaltrove/AggiungiOperatoreNonAltrove.pdf' target='_blank'><font color='red'>clicca qui</font></a></center>\n");
  testo.document.write("</body>");
  testo.document.write("</html>");
 }
 
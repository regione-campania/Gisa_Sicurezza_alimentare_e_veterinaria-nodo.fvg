
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Apistopro", propOrder = {
    "propIdFiscale",
    "dtInizioAttivita",
    "apiattAziendaCodice"
})
public class Apistopro
    extends Entity
{

    protected String propIdFiscale;
    protected XMLGregorianCalendar dtInizioAttivita;
    protected String apiattAziendaCodice;

    public String getPropIdFiscale() {
        return propIdFiscale;
    }

    public void setPropIdFiscale(String value) {
        this.propIdFiscale = value;
    }

    public String getApiattAziendaCodice() {
        return apiattAziendaCodice;
    }

    public void setApiattAziendaCodice(String value) {
        this.apiattAziendaCodice = value;
    }
    
    public XMLGregorianCalendar getDtInizioAttivita() {
        return dtInizioAttivita;
    }

    public void setDtInizioAttivita(XMLGregorianCalendar value) {
        this.dtInizioAttivita = value;
    }

   

}

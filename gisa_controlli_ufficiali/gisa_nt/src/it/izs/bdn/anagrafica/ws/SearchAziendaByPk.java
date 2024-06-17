
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchAziendaByPk complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchAziendaByPk">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="aziendaId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchAziendaByPk", propOrder = {
    "aziendaId"
})
public class SearchAziendaByPk {

    protected long aziendaId;

    /**
     * Recupera il valore della proprieta aziendaId.
     * 
     */
    public long getAziendaId() {
        return aziendaId;
    }

    /**
     * Imposta il valore della proprieta aziendaId.
     * 
     */
    public void setAziendaId(long value) {
        this.aziendaId = value;
    }

}

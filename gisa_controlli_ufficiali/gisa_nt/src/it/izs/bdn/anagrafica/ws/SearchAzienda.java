
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchAzienda complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchAzienda">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="AziendaSearchTO" type="{http://ws.anagrafica.bdn.izs.it/}azienda"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchAzienda", propOrder = {
    "aziendaSearchTO"
})
public class SearchAzienda {

    @XmlElement(name = "AziendaSearchTO", required = true)
    protected Azienda aziendaSearchTO;

    /**
     * Recupera il valore della proprieta aziendaSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link Azienda }
     *     
     */
    public Azienda getAziendaSearchTO() {
        return aziendaSearchTO;
    }

    /**
     * Imposta il valore della proprieta aziendaSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Azienda }
     *     
     */
    public void setAziendaSearchTO(Azienda value) {
        this.aziendaSearchTO = value;
    }

}

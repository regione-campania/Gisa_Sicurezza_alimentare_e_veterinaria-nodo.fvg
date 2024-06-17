
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchDettaglioAttivita complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchDettaglioAttivita">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="DettaglioAttivitaSearchTO" type="{http://ws.anagrafica.bdn.izs.it/}avidetatt"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchDettaglioAttivita", propOrder = {
    "dettaglioAttivitaSearchTO"
})
public class SearchDettaglioAttivita {

    @XmlElement(name = "DettaglioAttivitaSearchTO", required = true)
    protected Avidetatt dettaglioAttivitaSearchTO;

    /**
     * Recupera il valore della proprieta dettaglioAttivitaSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link Avidetatt }
     *     
     */
    public Avidetatt getDettaglioAttivitaSearchTO() {
        return dettaglioAttivitaSearchTO;
    }

    /**
     * Imposta il valore della proprieta dettaglioAttivitaSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Avidetatt }
     *     
     */
    public void setDettaglioAttivitaSearchTO(Avidetatt value) {
        this.dettaglioAttivitaSearchTO = value;
    }

}

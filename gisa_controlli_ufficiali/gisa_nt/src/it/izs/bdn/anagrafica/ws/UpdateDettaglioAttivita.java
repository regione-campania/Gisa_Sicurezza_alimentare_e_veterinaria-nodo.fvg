
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per updateDettaglioAttivita complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="updateDettaglioAttivita">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="DettaglioAttivitaTO" type="{http://ws.anagrafica.bdn.izs.it/}avidetatt"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "updateDettaglioAttivita", propOrder = {
    "dettaglioAttivitaTO"
})
public class UpdateDettaglioAttivita {

    @XmlElement(name = "DettaglioAttivitaTO", required = true)
    protected Avidetatt dettaglioAttivitaTO;

    /**
     * Recupera il valore della proprieta dettaglioAttivitaTO.
     * 
     * @return
     *     possible object is
     *     {@link Avidetatt }
     *     
     */
    public Avidetatt getDettaglioAttivitaTO() {
        return dettaglioAttivitaTO;
    }

    /**
     * Imposta il valore della proprieta dettaglioAttivitaTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Avidetatt }
     *     
     */
    public void setDettaglioAttivitaTO(Avidetatt value) {
        this.dettaglioAttivitaTO = value;
    }

}


package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchDettaglioAttivitaByAziendaCodice complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchDettaglioAttivitaByAziendaCodice">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="DettaglioAttivitaUkSearchTO" type="{http://ws.anagrafica.bdn.izs.it/}avidetattUk"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchDettaglioAttivitaByAziendaCodice", propOrder = {
    "dettaglioAttivitaUkSearchTO"
})
public class SearchDettaglioAttivitaByAziendaCodice {

    @XmlElement(name = "DettaglioAttivitaUkSearchTO", required = true)
    protected AvidetattUk dettaglioAttivitaUkSearchTO;

    /**
     * Recupera il valore della proprieta dettaglioAttivitaUkSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link AvidetattUk }
     *     
     */
    public AvidetattUk getDettaglioAttivitaUkSearchTO() {
        return dettaglioAttivitaUkSearchTO;
    }

    /**
     * Imposta il valore della proprieta dettaglioAttivitaUkSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link AvidetattUk }
     *     
     */
    public void setDettaglioAttivitaUkSearchTO(AvidetattUk value) {
        this.dettaglioAttivitaUkSearchTO = value;
    }

}

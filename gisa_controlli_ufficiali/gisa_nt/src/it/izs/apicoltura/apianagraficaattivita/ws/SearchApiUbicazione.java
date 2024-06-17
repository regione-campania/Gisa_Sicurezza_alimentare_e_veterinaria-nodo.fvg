
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiUbicazione complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiUbicazione">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiUbicazioneSearchTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apiubi"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiUbicazione", propOrder = {
    "apiUbicazioneSearchTO"
})
public class SearchApiUbicazione {

    @XmlElement(name = "ApiUbicazioneSearchTO", required = true)
    protected Apiubi apiUbicazioneSearchTO;

    /**
     * Recupera il valore della proprieta apiUbicazioneSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link Apiubi }
     *     
     */
    public Apiubi getApiUbicazioneSearchTO() {
        return apiUbicazioneSearchTO;
    }

    /**
     * Imposta il valore della proprieta apiUbicazioneSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apiubi }
     *     
     */
    public void setApiUbicazioneSearchTO(Apiubi value) {
        this.apiUbicazioneSearchTO = value;
    }

}

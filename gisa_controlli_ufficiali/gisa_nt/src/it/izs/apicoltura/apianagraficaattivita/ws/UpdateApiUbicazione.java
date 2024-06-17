
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per updateApiUbicazione complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="updateApiUbicazione">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiUbicazioneTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apiubi"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "updateApiUbicazione", propOrder = {
    "apiUbicazioneTO"
})
public class UpdateApiUbicazione {

    @XmlElement(name = "ApiUbicazioneTO", required = true)
    protected Apiubi apiUbicazioneTO;

    /**
     * Recupera il valore della proprieta apiUbicazioneTO.
     * 
     * @return
     *     possible object is
     *     {@link Apiubi }
     *     
     */
    public Apiubi getApiUbicazioneTO() {
        return apiUbicazioneTO;
    }

    /**
     * Imposta il valore della proprieta apiUbicazioneTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apiubi }
     *     
     */
    public void setApiUbicazioneTO(Apiubi value) {
        this.apiUbicazioneTO = value;
    }

}

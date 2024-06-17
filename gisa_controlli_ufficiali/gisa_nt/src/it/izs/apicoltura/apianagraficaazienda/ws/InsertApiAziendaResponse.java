
package it.izs.apicoltura.apianagraficaazienda.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per insertApiAziendaResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="insertApiAziendaResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiAziendaTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apiazienda" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "insertApiAziendaResponse", propOrder = {
    "apiAziendaTO"
})
public class InsertApiAziendaResponse {

    @XmlElement(name = "ApiAziendaTO")
    protected Apiazienda apiAziendaTO;

    /**
     * Recupera il valore della proprieta apiAziendaTO.
     * 
     * @return
     *     possible object is
     *     {@link Apiazienda }
     *     
     */
    public Apiazienda getApiAziendaTO() {
        return apiAziendaTO;
    }

    /**
     * Imposta il valore della proprieta apiAziendaTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apiazienda }
     *     
     */
    public void setApiAziendaTO(Apiazienda value) {
        this.apiAziendaTO = value;
    }

}

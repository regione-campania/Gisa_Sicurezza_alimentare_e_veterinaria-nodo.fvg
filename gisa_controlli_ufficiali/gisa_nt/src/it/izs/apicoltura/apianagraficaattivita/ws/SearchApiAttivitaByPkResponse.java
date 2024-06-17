
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiAttivitaByPkResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiAttivitaByPkResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiAttivitaTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apiatt" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiAttivitaByPkResponse", propOrder = {
    "apiAttivitaTO"
})
public class SearchApiAttivitaByPkResponse {

    @XmlElement(name = "ApiAttivitaTO")
    protected Apiatt apiAttivitaTO;

    /**
     * Recupera il valore della proprieta apiAttivitaTO.
     * 
     * @return
     *     possible object is
     *     {@link Apiatt }
     *     
     */
    public Apiatt getApiAttivitaTO() {
        return apiAttivitaTO;
    }

    /**
     * Imposta il valore della proprieta apiAttivitaTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apiatt }
     *     
     */
    public void setApiAttivitaTO(Apiatt value) {
        this.apiAttivitaTO = value;
    }

}

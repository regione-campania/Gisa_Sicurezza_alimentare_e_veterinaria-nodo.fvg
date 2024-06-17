
package it.izs.apicoltura.apimovimentazione.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per updateApidetmodResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="updateApidetmodResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApidetmodTO" type="{http://ws.apimovimentazione.apicoltura.izs.it/}apidetmod" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "updateApidetmodResponse", propOrder = {
    "apidetmodTO"
})
public class UpdateApidetmodResponse {

    @XmlElement(name = "ApidetmodTO")
    protected Apidetmod apidetmodTO;

    /**
     * Recupera il valore della proprieta apidetmodTO.
     * 
     * @return
     *     possible object is
     *     {@link Apidetmod }
     *     
     */
    public Apidetmod getApidetmodTO() {
        return apidetmodTO;
    }

    /**
     * Imposta il valore della proprieta apidetmodTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apidetmod }
     *     
     */
    public void setApidetmodTO(Apidetmod value) {
        this.apidetmodTO = value;
    }

}

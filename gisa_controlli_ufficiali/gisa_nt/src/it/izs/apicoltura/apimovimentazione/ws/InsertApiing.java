
package it.izs.apicoltura.apimovimentazione.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per insertApiing complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="insertApiing">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiingTO" type="{http://ws.apimovimentazione.apicoltura.izs.it/}apiing"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "insertApiing", propOrder = {
    "apiingTO"
})
public class InsertApiing {

    @XmlElement(name = "ApiingTO", required = true)
    protected Apiing apiingTO;

    /**
     * Recupera il valore della proprieta apiingTO.
     * 
     * @return
     *     possible object is
     *     {@link Apiing }
     *     
     */
    public Apiing getApiingTO() {
        return apiingTO;
    }

    /**
     * Imposta il valore della proprieta apiingTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apiing }
     *     
     */
    public void setApiingTO(Apiing value) {
        this.apiingTO = value;
    }

}

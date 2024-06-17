
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per deletePersoneResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="deletePersoneResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="PersoneTO" type="{http://ws.anagrafica.bdn.izs.it/}persone" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "deletePersoneResponse", propOrder = {
    "personeTO"
})
public class DeletePersoneResponse {

    @XmlElement(name = "PersoneTO")
    protected Persone personeTO;

    /**
     * Recupera il valore della proprieta personeTO.
     * 
     * @return
     *     possible object is
     *     {@link Persone }
     *     
     */
    public Persone getPersoneTO() {
        return personeTO;
    }

    /**
     * Imposta il valore della proprieta personeTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Persone }
     *     
     */
    public void setPersoneTO(Persone value) {
        this.personeTO = value;
    }

}

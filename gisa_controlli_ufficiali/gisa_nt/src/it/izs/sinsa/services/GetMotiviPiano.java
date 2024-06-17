
package it.izs.sinsa.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per getMotiviPiano complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="getMotiviPiano">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="codicePiano" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getMotiviPiano", propOrder = {
    "codicePiano"
})
public class GetMotiviPiano {

    protected String codicePiano;

    /**
     * Recupera il valore della proprieta codicePiano.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCodicePiano() {
        return codicePiano;
    }

    /**
     * Imposta il valore della proprieta codicePiano.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCodicePiano(String value) {
        this.codicePiano = value;
    }

}

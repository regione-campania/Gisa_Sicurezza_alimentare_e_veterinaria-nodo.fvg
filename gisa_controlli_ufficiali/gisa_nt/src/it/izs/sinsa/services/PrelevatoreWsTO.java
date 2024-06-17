
package it.izs.sinsa.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per prelevatoreWsTO complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="prelevatoreWsTO">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="prelCodFiscale" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "prelevatoreWsTO", propOrder = {
    "prelCodFiscale"
})
public class PrelevatoreWsTO {

    protected String prelCodFiscale;

    /**
     * Recupera il valore della proprieta prelCodFiscale.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPrelCodFiscale() {
        return prelCodFiscale;
    }

    /**
     * Imposta il valore della proprieta prelCodFiscale.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPrelCodFiscale(String value) {
        this.prelCodFiscale = value;
    }

}

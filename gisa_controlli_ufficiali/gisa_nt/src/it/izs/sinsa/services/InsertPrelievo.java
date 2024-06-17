
package it.izs.sinsa.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per insertPrelievo complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="insertPrelievo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="prelievo" type="{http://sinsa.izs.it/services}prelievoWsTO" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "insertPrelievo", propOrder = {
    "prelievo"
})
public class InsertPrelievo {

    protected PrelievoWsTO prelievo;

    /**
     * Recupera il valore della proprieta prelievo.
     * 
     * @return
     *     possible object is
     *     {@link PrelievoWsTO }
     *     
     */
    public PrelievoWsTO getPrelievo() {
        return prelievo;
    }

    /**
     * Imposta il valore della proprieta prelievo.
     * 
     * @param value
     *     allowed object is
     *     {@link PrelievoWsTO }
     *     
     */
    public void setPrelievo(PrelievoWsTO value) {
        this.prelievo = value;
    }

}

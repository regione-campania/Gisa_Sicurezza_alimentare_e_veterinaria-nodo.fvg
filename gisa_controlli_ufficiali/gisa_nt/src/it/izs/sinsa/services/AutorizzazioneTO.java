
package it.izs.sinsa.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per autorizzazioneTO complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="autorizzazioneTO">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ruoloCodice" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ruoloValoreCodice" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "autorizzazioneTO", propOrder = {
    "ruoloCodice",
    "ruoloValoreCodice"
})
public class AutorizzazioneTO {

    protected String ruoloCodice;
    protected String ruoloValoreCodice;

    /**
     * Recupera il valore della proprieta ruoloCodice.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRuoloCodice() {
        return ruoloCodice;
    }

    /**
     * Imposta il valore della proprieta ruoloCodice.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRuoloCodice(String value) {
        this.ruoloCodice = value;
    }

    /**
     * Recupera il valore della proprieta ruoloValoreCodice.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRuoloValoreCodice() {
        return ruoloValoreCodice;
    }

    /**
     * Imposta il valore della proprieta ruoloValoreCodice.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRuoloValoreCodice(String value) {
        this.ruoloValoreCodice = value;
    }

}

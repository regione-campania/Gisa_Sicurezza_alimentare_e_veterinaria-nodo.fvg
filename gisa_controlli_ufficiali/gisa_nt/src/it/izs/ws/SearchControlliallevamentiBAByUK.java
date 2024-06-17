
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchControlliallevamentiBAByUK complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchControlliallevamentiBAByUK">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="chiave" type="{http://ws.izs.it}controlliallevamentiWsSearchTO" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchControlliallevamentiBAByUK", propOrder = {
    "chiave"
})
public class SearchControlliallevamentiBAByUK {

    protected ControlliallevamentiWsSearchTO chiave;

    /**
     * Recupera il valore della proprieta chiave.
     * 
     * @return
     *     possible object is
     *     {@link ControlliallevamentiWsSearchTO }
     *     
     */
    public ControlliallevamentiWsSearchTO getChiave() {
        return chiave;
    }

    /**
     * Imposta il valore della proprieta chiave.
     * 
     * @param value
     *     allowed object is
     *     {@link ControlliallevamentiWsSearchTO }
     *     
     */
    public void setChiave(ControlliallevamentiWsSearchTO value) {
        this.chiave = value;
    }

}

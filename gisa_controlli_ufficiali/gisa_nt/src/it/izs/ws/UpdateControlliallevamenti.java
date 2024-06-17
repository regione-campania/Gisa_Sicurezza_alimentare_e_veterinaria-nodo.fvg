
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per updateControlliallevamenti complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="updateControlliallevamenti">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="dettagliochecklist" type="{http://ws.izs.it}checklistallevamentiWsTO" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "updateControlliallevamenti", propOrder = {
    "dettagliochecklist"
})
public class UpdateControlliallevamenti {

    protected ChecklistallevamentiWsTO dettagliochecklist;

    /**
     * Recupera il valore della proprieta dettagliochecklist.
     * 
     * @return
     *     possible object is
     *     {@link ChecklistallevamentiWsTO }
     *     
     */
    public ChecklistallevamentiWsTO getDettagliochecklist() {
        return dettagliochecklist;
    }

    /**
     * Imposta il valore della proprieta dettagliochecklist.
     * 
     * @param value
     *     allowed object is
     *     {@link ChecklistallevamentiWsTO }
     *     
     */
    public void setDettagliochecklist(ChecklistallevamentiWsTO value) {
        this.dettagliochecklist = value;
    }

}

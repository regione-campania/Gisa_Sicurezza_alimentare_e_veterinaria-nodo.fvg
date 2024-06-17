
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per updateControlliallevamentiSV complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="updateControlliallevamentiSV">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="controlliallevamenti" type="{http://ws.izs.it}controlliallevamentiWS" minOccurs="0"/>
 *         &lt;element name="dettagliochecklist" type="{http://ws.izs.it}checklistsostanzevietateWsTO" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "updateControlliallevamentiSV", propOrder = {
    "controlliallevamenti",
    "dettagliochecklist"
})
public class UpdateControlliallevamentiSV {

    protected ControlliallevamentiWS controlliallevamenti;
    protected ChecklistsostanzevietateWsTO dettagliochecklist;

    /**
     * Recupera il valore della proprieta controlliallevamenti.
     * 
     * @return
     *     possible object is
     *     {@link ControlliallevamentiWS }
     *     
     */
    public ControlliallevamentiWS getControlliallevamenti() {
        return controlliallevamenti;
    }

    /**
     * Imposta il valore della proprieta controlliallevamenti.
     * 
     * @param value
     *     allowed object is
     *     {@link ControlliallevamentiWS }
     *     
     */
    public void setControlliallevamenti(ControlliallevamentiWS value) {
        this.controlliallevamenti = value;
    }

    /**
     * Recupera il valore della proprieta dettagliochecklist.
     * 
     * @return
     *     possible object is
     *     {@link ChecklistsostanzevietateWsTO }
     *     
     */
    public ChecklistsostanzevietateWsTO getDettagliochecklist() {
        return dettagliochecklist;
    }

    /**
     * Imposta il valore della proprieta dettagliochecklist.
     * 
     * @param value
     *     allowed object is
     *     {@link ChecklistsostanzevietateWsTO }
     *     
     */
    public void setDettagliochecklist(ChecklistsostanzevietateWsTO value) {
        this.dettagliochecklist = value;
    }

}

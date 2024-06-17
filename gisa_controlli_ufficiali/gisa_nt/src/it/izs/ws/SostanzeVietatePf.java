
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per sostanzeVietatePf complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="sostanzeVietatePf">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="checklistsostanzevietate" type="{http://ws.izs.it}checklistsostanzevietateWsTO" minOccurs="0"/>
 *         &lt;element name="controlloAllevamento" type="{http://ws.izs.it}controlliallevamentiWS" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "sostanzeVietatePf", propOrder = {
    "checklistsostanzevietate",
    "controlloAllevamento"
})
public class SostanzeVietatePf {

    protected ChecklistsostanzevietateWsTO checklistsostanzevietate;
    protected ControlliallevamentiWS controlloAllevamento;

    /**
     * Recupera il valore della proprieta checklistsostanzevietate.
     * 
     * @return
     *     possible object is
     *     {@link ChecklistsostanzevietateWsTO }
     *     
     */
    public ChecklistsostanzevietateWsTO getChecklistsostanzevietate() {
        return checklistsostanzevietate;
    }

    /**
     * Imposta il valore della proprieta checklistsostanzevietate.
     * 
     * @param value
     *     allowed object is
     *     {@link ChecklistsostanzevietateWsTO }
     *     
     */
    public void setChecklistsostanzevietate(ChecklistsostanzevietateWsTO value) {
        this.checklistsostanzevietate = value;
    }

    /**
     * Recupera il valore della proprieta controlloAllevamento.
     * 
     * @return
     *     possible object is
     *     {@link ControlliallevamentiWS }
     *     
     */
    public ControlliallevamentiWS getControlloAllevamento() {
        return controlloAllevamento;
    }

    /**
     * Imposta il valore della proprieta controlloAllevamento.
     * 
     * @param value
     *     allowed object is
     *     {@link ControlliallevamentiWS }
     *     
     */
    public void setControlloAllevamento(ControlliallevamentiWS value) {
        this.controlloAllevamento = value;
    }

}


package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per controlliAllevamentiPf complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="controlliAllevamentiPf">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="checklistAllevamento" type="{http://ws.izs.it}checklistallevamentiWsTO" minOccurs="0"/>
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
@XmlType(name = "controlliAllevamentiPf", propOrder = {
    "checklistAllevamento",
    "controlloAllevamento"
})
public class ControlliAllevamentiPf {

    protected ChecklistallevamentiWsTO checklistAllevamento;
    protected ControlliallevamentiWS controlloAllevamento;

    /**
     * Recupera il valore della proprieta checklistAllevamento.
     * 
     * @return
     *     possible object is
     *     {@link ChecklistallevamentiWsTO }
     *     
     */
    public ChecklistallevamentiWsTO getChecklistAllevamento() {
        return checklistAllevamento;
    }

    /**
     * Imposta il valore della proprieta checklistAllevamento.
     * 
     * @param value
     *     allowed object is
     *     {@link ChecklistallevamentiWsTO }
     *     
     */
    public void setChecklistAllevamento(ChecklistallevamentiWsTO value) {
        this.checklistAllevamento = value;
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

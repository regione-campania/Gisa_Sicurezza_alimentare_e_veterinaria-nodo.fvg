
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per benessereAnimalePf complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="benessereAnimalePf">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="checklistAllevamento" type="{http://ws.izs.it}checklistbenessereWsTO" minOccurs="0"/>
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
@XmlType(name = "benessereAnimalePf", propOrder = {
    "checklistAllevamento",
    "controlloAllevamento"
})
public class BenessereAnimalePf {

    protected ChecklistbenessereWsTO checklistAllevamento;
    protected ControlliallevamentiWS controlloAllevamento;

    /**
     * Recupera il valore della proprieta checklistAllevamento.
     * 
     * @return
     *     possible object is
     *     {@link ChecklistbenessereWsTO }
     *     
     */
    public ChecklistbenessereWsTO getChecklistAllevamento() {
        return checklistAllevamento;
    }

    /**
     * Imposta il valore della proprieta checklistAllevamento.
     * 
     * @param value
     *     allowed object is
     *     {@link ChecklistbenessereWsTO }
     *     
     */
    public void setChecklistAllevamento(ChecklistbenessereWsTO value) {
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

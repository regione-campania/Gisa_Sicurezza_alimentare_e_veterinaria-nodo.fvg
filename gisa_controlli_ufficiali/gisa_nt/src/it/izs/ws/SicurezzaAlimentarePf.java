
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per sicurezzaAlimentarePf complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="sicurezzaAlimentarePf">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="checklistsicurezzaalimentare" type="{http://ws.izs.it}checklistsicurezzaalimentareWsTO" minOccurs="0"/>
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
@XmlType(name = "sicurezzaAlimentarePf", propOrder = {
    "checklistsicurezzaalimentare",
    "controlloAllevamento"
})
public class SicurezzaAlimentarePf {

    protected ChecklistsicurezzaalimentareWsTO checklistsicurezzaalimentare;
    protected ControlliallevamentiWS controlloAllevamento;

    /**
     * Recupera il valore della proprieta checklistsicurezzaalimentare.
     * 
     * @return
     *     possible object is
     *     {@link ChecklistsicurezzaalimentareWsTO }
     *     
     */
    public ChecklistsicurezzaalimentareWsTO getChecklistsicurezzaalimentare() {
        return checklistsicurezzaalimentare;
    }

    /**
     * Imposta il valore della proprieta checklistsicurezzaalimentare.
     * 
     * @param value
     *     allowed object is
     *     {@link ChecklistsicurezzaalimentareWsTO }
     *     
     */
    public void setChecklistsicurezzaalimentare(ChecklistsicurezzaalimentareWsTO value) {
        this.checklistsicurezzaalimentare = value;
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

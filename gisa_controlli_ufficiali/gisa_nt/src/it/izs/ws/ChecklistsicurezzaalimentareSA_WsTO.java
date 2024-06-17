
package it.izs.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per checklistsicurezzaalimentareWsTO complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="checklistsicurezzaalimentareWsTO">
 *   &lt;complexContent>
 *     &lt;extension base="{http://ws.izs.it}checklistsicurezzaalimentareTO">
 *       &lt;sequence>
 *         &lt;element name="requisiti" type="{http://ws.izs.it}requisitiSaWsTO" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "checklistsicurezzaalimentareSA_WsTO", propOrder = {
    "requisiti"
})
public class ChecklistsicurezzaalimentareSA_WsTO
    extends ChecklistsicurezzaalimentareSA_TO
{

    @XmlElement(nillable = true)
    protected List<RequisitiSaWsTO> requisiti;

    /**
     * Gets the value of the requisiti property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the requisiti property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRequisiti().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link RequisitiSaWsTO }
     * 
     * 
     */
    public List<RequisitiSaWsTO> getRequisiti() {
        if (requisiti == null) {
            requisiti = new ArrayList<RequisitiSaWsTO>();
        }
        return this.requisiti;
    }

}

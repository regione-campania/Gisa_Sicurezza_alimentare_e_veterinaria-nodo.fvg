
package it.izs.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per checkliststalledisostaWsTO complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="checkliststalledisostaWsTO">
 *   &lt;complexContent>
 *     &lt;extension base="{http://ws.izs.it}checkliststalledisostaTO">
 *       &lt;sequence>
 *         &lt;element name="requisiti" type="{http://ws.izs.it}requisitiSsWsTO" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "checkliststalledisostaWsTO", propOrder = {
    "requisiti"
})
public class CheckliststalledisostaWsTO
    extends CheckliststalledisostaTO
{

    @XmlElement(nillable = true)
    protected List<RequisitiSsWsTO> requisiti;

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
     * {@link RequisitiSsWsTO }
     * 
     * 
     */
    public List<RequisitiSsWsTO> getRequisiti() {
        if (requisiti == null) {
            requisiti = new ArrayList<RequisitiSsWsTO>();
        }
        return this.requisiti;
    }

}

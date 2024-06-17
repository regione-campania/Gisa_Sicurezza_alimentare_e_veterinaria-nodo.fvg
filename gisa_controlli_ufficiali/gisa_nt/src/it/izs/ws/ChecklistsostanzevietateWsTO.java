
package it.izs.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per checklistsostanzevietateWsTO complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="checklistsostanzevietateWsTO">
 *   &lt;complexContent>
 *     &lt;extension base="{http://ws.izs.it}checklistsostanzevietateTO">
 *       &lt;sequence>
 *         &lt;element name="requisiti" type="{http://ws.izs.it}requisitiSvWsTO" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "checklistsostanzevietateWsTO", propOrder = {
    "requisiti"
})
public class ChecklistsostanzevietateWsTO
    extends ChecklistsostanzevietateTO
{

    @XmlElement(nillable = true)
    protected List<RequisitiSvWsTO> requisiti;

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
     * {@link RequisitiSvWsTO }
     * 
     * 
     */
    public List<RequisitiSvWsTO> getRequisiti() {
        if (requisiti == null) {
            requisiti = new ArrayList<RequisitiSvWsTO>();
        }
        return this.requisiti;
    }

}


package it.izs.bdn.anagrafica.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchPersoneResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchPersoneResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="PersoneTO" type="{http://ws.anagrafica.bdn.izs.it/}persone" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchPersoneResponse", propOrder = {
    "personeTO"
})
public class SearchPersoneResponse {

    @XmlElement(name = "PersoneTO")
    protected List<Persone> personeTO;

    /**
     * Gets the value of the personeTO property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the personeTO property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPersoneTO().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Persone }
     * 
     * 
     */
    public List<Persone> getPersoneTO() {
        if (personeTO == null) {
            personeTO = new ArrayList<Persone>();
        }
        return this.personeTO;
    }

}

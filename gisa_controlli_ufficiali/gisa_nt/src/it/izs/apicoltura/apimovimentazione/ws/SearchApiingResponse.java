
package it.izs.apicoltura.apimovimentazione.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiingResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiingResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiingTO" type="{http://ws.apimovimentazione.apicoltura.izs.it/}apiing" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiingResponse", propOrder = {
    "apiingTO"
})
public class SearchApiingResponse {

    @XmlElement(name = "ApiingTO")
    protected List<Apiing> apiingTO;

    /**
     * Gets the value of the apiingTO property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the apiingTO property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getApiingTO().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Apiing }
     * 
     * 
     */
    public List<Apiing> getApiingTO() {
        if (apiingTO == null) {
            apiingTO = new ArrayList<Apiing>();
        }
        return this.apiingTO;
    }

}

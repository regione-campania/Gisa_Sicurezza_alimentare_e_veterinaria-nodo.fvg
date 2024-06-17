
package it.izs.apicoltura.apianagraficaattivita.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiarioTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}api" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiResponse", propOrder = {
    "apiarioTO"
})
public class SearchApiResponse {

    @XmlElement(name = "ApiarioTO")
    protected List<Api> apiarioTO;

    /**
     * Gets the value of the apiarioTO property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the apiarioTO property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getApiarioTO().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Api }
     * 
     * 
     */
    public List<Api> getApiarioTO() {
        if (apiarioTO == null) {
            apiarioTO = new ArrayList<Api>();
        }
        return this.apiarioTO;
    }

}

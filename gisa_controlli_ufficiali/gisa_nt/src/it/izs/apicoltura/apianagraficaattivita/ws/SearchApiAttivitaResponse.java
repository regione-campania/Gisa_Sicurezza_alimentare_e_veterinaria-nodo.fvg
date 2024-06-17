
package it.izs.apicoltura.apianagraficaattivita.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiAttivitaResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiAttivitaResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiAttivitaTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apiatt" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiAttivitaResponse", propOrder = {
    "apiAttivitaTO"
})
public class SearchApiAttivitaResponse {

    @XmlElement(name = "ApiAttivitaTO")
    protected List<Apiatt> apiAttivitaTO;

    /**
     * Gets the value of the apiAttivitaTO property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the apiAttivitaTO property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getApiAttivitaTO().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Apiatt }
     * 
     * 
     */
    public List<Apiatt> getApiAttivitaTO() {
        if (apiAttivitaTO == null) {
            apiAttivitaTO = new ArrayList<Apiatt>();
        }
        return this.apiAttivitaTO;
    }

}

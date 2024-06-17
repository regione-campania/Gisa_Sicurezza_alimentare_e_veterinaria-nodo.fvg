
package it.izs.apicoltura.apimovimentazione.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiing complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiing">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiingSearch" type="{http://ws.apimovimentazione.apicoltura.izs.it/}apiing"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiing", propOrder = {
    "apiingSearch"
})
public class SearchApiing {

    @XmlElement(name = "ApiingSearch", required = true)
    protected Apiing apiingSearch;

    /**
     * Recupera il valore della proprieta apiingSearch.
     * 
     * @return
     *     possible object is
     *     {@link Apiing }
     *     
     */
    public Apiing getApiingSearch() {
        return apiingSearch;
    }

    /**
     * Imposta il valore della proprieta apiingSearch.
     * 
     * @param value
     *     allowed object is
     *     {@link Apiing }
     *     
     */
    public void setApiingSearch(Apiing value) {
        this.apiingSearch = value;
    }

}

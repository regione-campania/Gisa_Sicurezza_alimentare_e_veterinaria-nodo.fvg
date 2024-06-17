
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiAttivita complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiAttivita">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiAttivitaSearch" type="{http://ws.apianagrafica.apicoltura.izs.it/}apiatt"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiAttivita", propOrder = {
    "apiAttivitaSearch"
})
public class SearchApiAttivita {

    @XmlElement(name = "ApiAttivitaSearch", required = true)
    protected Apiatt apiAttivitaSearch;

    /**
     * Recupera il valore della proprieta apiAttivitaSearch.
     * 
     * @return
     *     possible object is
     *     {@link Apiatt }
     *     
     */
    public Apiatt getApiAttivitaSearch() {
        return apiAttivitaSearch;
    }

    /**
     * Imposta il valore della proprieta apiAttivitaSearch.
     * 
     * @param value
     *     allowed object is
     *     {@link Apiatt }
     *     
     */
    public void setApiAttivitaSearch(Apiatt value) {
        this.apiAttivitaSearch = value;
    }

}

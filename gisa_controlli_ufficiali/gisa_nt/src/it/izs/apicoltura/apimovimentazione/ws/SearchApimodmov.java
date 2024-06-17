
package it.izs.apicoltura.apimovimentazione.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApimodmov complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApimodmov">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApimodmovSearch" type="{http://ws.apimovimentazione.apicoltura.izs.it/}apimodmov"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApimodmov", propOrder = {
    "apimodmovSearch"
})
public class SearchApimodmov {

    @XmlElement(name = "ApimodmovSearch", required = true)
    protected Apimodmov apimodmovSearch;

    /**
     * Recupera il valore della proprieta apimodmovSearch.
     * 
     * @return
     *     possible object is
     *     {@link Apimodmov }
     *     
     */
    public Apimodmov getApimodmovSearch() {
        return apimodmovSearch;
    }

    /**
     * Imposta il valore della proprieta apimodmovSearch.
     * 
     * @param value
     *     allowed object is
     *     {@link Apimodmov }
     *     
     */
    public void setApimodmovSearch(Apimodmov value) {
        this.apimodmovSearch = value;
    }

}

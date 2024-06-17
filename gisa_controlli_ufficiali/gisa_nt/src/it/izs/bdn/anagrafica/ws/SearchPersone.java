
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchPersone complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchPersone">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="PersoneSearchTO" type="{http://ws.anagrafica.bdn.izs.it/}persone"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchPersone", propOrder = {
    "personeSearchTO"
})
public class SearchPersone {

    @XmlElement(name = "PersoneSearchTO", required = true)
    protected Persone personeSearchTO;

    /**
     * Recupera il valore della proprieta personeSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link Persone }
     *     
     */
    public Persone getPersoneSearchTO() {
        return personeSearchTO;
    }

    /**
     * Imposta il valore della proprieta personeSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Persone }
     *     
     */
    public void setPersoneSearchTO(Persone value) {
        this.personeSearchTO = value;
    }

}

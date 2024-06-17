
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiCensimento complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiCensimento">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiCensimentoSearchTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apicen"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiCensimento", propOrder = {
    "apiCensimentoSearchTO"
})
public class SearchApiCensimento {

    @XmlElement(name = "ApiCensimentoSearchTO", required = true)
    protected Apicen apiCensimentoSearchTO;

    /**
     * Recupera il valore della proprieta apiCensimentoSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link Apicen }
     *     
     */
    public Apicen getApiCensimentoSearchTO() {
        return apiCensimentoSearchTO;
    }

    /**
     * Imposta il valore della proprieta apiCensimentoSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apicen }
     *     
     */
    public void setApiCensimentoSearchTO(Apicen value) {
        this.apiCensimentoSearchTO = value;
    }

}

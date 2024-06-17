
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per updateApiCensimento complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="updateApiCensimento">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiCensimentoTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apicen"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "updateApiCensimento", propOrder = {
    "apiCensimentoTO"
})
public class UpdateApiCensimento {

    @XmlElement(name = "ApiCensimentoTO", required = true)
    protected Apicen apiCensimentoTO;

    /**
     * Recupera il valore della proprieta apiCensimentoTO.
     * 
     * @return
     *     possible object is
     *     {@link Apicen }
     *     
     */
    public Apicen getApiCensimentoTO() {
        return apiCensimentoTO;
    }

    /**
     * Imposta il valore della proprieta apiCensimentoTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apicen }
     *     
     */
    public void setApiCensimentoTO(Apicen value) {
        this.apiCensimentoTO = value;
    }

}

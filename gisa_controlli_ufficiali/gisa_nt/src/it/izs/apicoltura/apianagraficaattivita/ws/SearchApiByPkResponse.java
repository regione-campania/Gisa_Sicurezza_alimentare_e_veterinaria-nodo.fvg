
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiByPkResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiByPkResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiarioTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}api" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiByPkResponse", propOrder = {
    "apiarioTO"
})
public class SearchApiByPkResponse {

    @XmlElement(name = "ApiarioTO")
    protected Api apiarioTO;

    /**
     * Recupera il valore della proprieta apiarioTO.
     * 
     * @return
     *     possible object is
     *     {@link Api }
     *     
     */
    public Api getApiarioTO() {
        return apiarioTO;
    }

    /**
     * Imposta il valore della proprieta apiarioTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Api }
     *     
     */
    public void setApiarioTO(Api value) {
        this.apiarioTO = value;
    }

}

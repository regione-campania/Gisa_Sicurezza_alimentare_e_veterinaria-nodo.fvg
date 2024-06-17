
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApi complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApi">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiarioSearchTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}api"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApi", propOrder = {
    "apiarioSearchTO"
})
public class SearchApi {

    @XmlElement(name = "ApiarioSearchTO", required = true)
    protected Api apiarioSearchTO;

    /**
     * Recupera il valore della proprieta apiarioSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link Api }
     *     
     */
    public Api getApiarioSearchTO() {
        return apiarioSearchTO;
    }

    /**
     * Imposta il valore della proprieta apiarioSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Api }
     *     
     */
    public void setApiarioSearchTO(Api value) {
        this.apiarioSearchTO = value;
    }

}

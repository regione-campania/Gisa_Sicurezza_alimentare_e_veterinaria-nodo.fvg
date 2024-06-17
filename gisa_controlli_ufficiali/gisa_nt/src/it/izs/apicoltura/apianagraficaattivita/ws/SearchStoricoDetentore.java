
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchStoricoDetentore complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchStoricoDetentore">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="StoricoDetentoreSearchTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apistodet"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchStoricoDetentore", propOrder = {
    "storicoDetentoreSearchTO"
})
public class SearchStoricoDetentore {

    @XmlElement(name = "StoricoDetentoreSearchTO", required = true)
    protected Apistodet storicoDetentoreSearchTO;

    /**
     * Recupera il valore della proprieta storicoDetentoreSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link Apistodet }
     *     
     */
    public Apistodet getStoricoDetentoreSearchTO() {
        return storicoDetentoreSearchTO;
    }

    /**
     * Imposta il valore della proprieta storicoDetentoreSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apistodet }
     *     
     */
    public void setStoricoDetentoreSearchTO(Apistodet value) {
        this.storicoDetentoreSearchTO = value;
    }

}

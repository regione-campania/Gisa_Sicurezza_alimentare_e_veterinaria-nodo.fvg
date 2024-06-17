
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchAziendaByPkResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchAziendaByPkResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="AziendaTO" type="{http://ws.anagrafica.bdn.izs.it/}azienda" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchAziendaByPkResponse", propOrder = {
    "aziendaTO"
})
public class SearchAziendaByPkResponse {

    @XmlElement(name = "AziendaTO")
    protected Azienda aziendaTO;

    /**
     * Recupera il valore della proprieta aziendaTO.
     * 
     * @return
     *     possible object is
     *     {@link Azienda }
     *     
     */
    public Azienda getAziendaTO() {
        return aziendaTO;
    }

    /**
     * Imposta il valore della proprieta aziendaTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Azienda }
     *     
     */
    public void setAziendaTO(Azienda value) {
        this.aziendaTO = value;
    }

}

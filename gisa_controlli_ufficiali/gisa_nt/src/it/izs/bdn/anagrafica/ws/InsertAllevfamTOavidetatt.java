
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per insertAllevfamTOavidetatt complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="insertAllevfamTOavidetatt">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="AvidetattFromAllevfamTO" type="{http://ws.anagrafica.bdn.izs.it/}avidetattFromAllevfam"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "insertAllevfamTOavidetatt", propOrder = {
    "avidetattFromAllevfamTO"
})
public class InsertAllevfamTOavidetatt {

    @XmlElement(name = "AvidetattFromAllevfamTO", required = true)
    protected AvidetattFromAllevfam avidetattFromAllevfamTO;

    /**
     * Recupera il valore della proprieta avidetattFromAllevfamTO.
     * 
     * @return
     *     possible object is
     *     {@link AvidetattFromAllevfam }
     *     
     */
    public AvidetattFromAllevfam getAvidetattFromAllevfamTO() {
        return avidetattFromAllevfamTO;
    }

    /**
     * Imposta il valore della proprieta avidetattFromAllevfamTO.
     * 
     * @param value
     *     allowed object is
     *     {@link AvidetattFromAllevfam }
     *     
     */
    public void setAvidetattFromAllevfamTO(AvidetattFromAllevfam value) {
        this.avidetattFromAllevfamTO = value;
    }

}

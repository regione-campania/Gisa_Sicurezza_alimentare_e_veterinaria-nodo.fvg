
package it.izs.apicoltura.apimovimentazione.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per deleteApimodmov complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="deleteApimodmov">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApimodmovTO" type="{http://ws.apimovimentazione.apicoltura.izs.it/}apimodmov"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "deleteApimodmov", propOrder = {
    "apimodmovTO"
})
public class DeleteApimodmov {

    @XmlElement(name = "ApimodmovTO", required = true)
    protected Apimodmov apimodmovTO;

    /**
     * Recupera il valore della proprieta apimodmovTO.
     * 
     * @return
     *     possible object is
     *     {@link Apimodmov }
     *     
     */
    public Apimodmov getApimodmovTO() {
        return apimodmovTO;
    }

    /**
     * Imposta il valore della proprieta apimodmovTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Apimodmov }
     *     
     */
    public void setApimodmovTO(Apimodmov value) {
        this.apimodmovTO = value;
    }

}

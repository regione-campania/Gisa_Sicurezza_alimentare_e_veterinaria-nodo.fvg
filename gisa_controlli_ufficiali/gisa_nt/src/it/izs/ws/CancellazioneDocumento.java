
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per cancellazioneDocumento complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="cancellazioneDocumento">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="documento" type="{http://ws.izs.it}controlliallevfileTO" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "cancellazioneDocumento", propOrder = {
    "documento"
})
public class CancellazioneDocumento {

    protected ControlliallevfileTO documento;

    /**
     * Recupera il valore della proprieta documento.
     * 
     * @return
     *     possible object is
     *     {@link ControlliallevfileTO }
     *     
     */
    public ControlliallevfileTO getDocumento() {
        return documento;
    }

    /**
     * Imposta il valore della proprieta documento.
     * 
     * @param value
     *     allowed object is
     *     {@link ControlliallevfileTO }
     *     
     */
    public void setDocumento(ControlliallevfileTO value) {
        this.documento = value;
    }

}

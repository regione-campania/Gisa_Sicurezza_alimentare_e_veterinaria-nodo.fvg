
package it.izs.sinsa.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per getAltreInformazioniXsd complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="getAltreInformazioniXsd">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="codiceModulo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getAltreInformazioniXsd", propOrder = {
    "codiceModulo"
})
public class GetAltreInformazioniXsd {

    protected String codiceModulo;

    /**
     * Recupera il valore della proprieta codiceModulo.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCodiceModulo() {
        return codiceModulo;
    }

    /**
     * Imposta il valore della proprieta codiceModulo.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCodiceModulo(String value) {
        this.codiceModulo = value;
    }

}


package it.izs.sinsa.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per contaminanteWsTO complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="contaminanteWsTO">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="contaminanteCodice" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="note" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "contaminanteWsTO", propOrder = {
    "contaminanteCodice",
    "note"
})
public class ContaminanteWsTO {

    protected String contaminanteCodice;
    protected String note;

    /**
     * Recupera il valore della proprieta contaminanteCodice.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getContaminanteCodice() {
        return contaminanteCodice;
    }

    /**
     * Imposta il valore della proprieta contaminanteCodice.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setContaminanteCodice(String value) {
        this.contaminanteCodice = value;
    }

    /**
     * Recupera il valore della proprieta note.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNote() {
        return note;
    }

    /**
     * Imposta il valore della proprieta note.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNote(String value) {
        this.note = value;
    }

}

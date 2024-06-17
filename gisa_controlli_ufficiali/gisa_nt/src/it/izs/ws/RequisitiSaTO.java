
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per requisitiSaTO complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="requisitiSaTO">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="clsadettId" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="descrizione" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="flagSN" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ordine" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="sairrdettId" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="tipo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "requisitiSaTO", propOrder = {
    "clsadettId",
    "descrizione",
    "flagSN",
    "ordine",
    "sairrdettId",
    "tipo"
})
@XmlSeeAlso({
    RequisitiSaWsTO.class
})
public class RequisitiSaTO {

    protected Integer clsadettId;
    protected String descrizione;
    protected String flagSN;
    protected Integer ordine;
    protected Integer sairrdettId;
    protected String tipo;

    /**
     * Recupera il valore della proprieta clsadettId.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getClsadettId() {
        return clsadettId;
    }

    /**
     * Imposta il valore della proprieta clsadettId.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setClsadettId(Integer value) {
        this.clsadettId = value;
    }

    /**
     * Recupera il valore della proprieta descrizione.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDescrizione() {
        return descrizione;
    }

    /**
     * Imposta il valore della proprieta descrizione.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDescrizione(String value) {
        this.descrizione = value;
    }

    /**
     * Recupera il valore della proprieta flagSN.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFlagSN() {
        return flagSN;
    }

    /**
     * Imposta il valore della proprieta flagSN.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFlagSN(String value) {
        this.flagSN = value;
    }

    /**
     * Recupera il valore della proprieta ordine.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getOrdine() {
        return ordine;
    }

    /**
     * Imposta il valore della proprieta ordine.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setOrdine(Integer value) {
        this.ordine = value;
    }

    /**
     * Recupera il valore della proprieta sairrdettId.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getSairrdettId() {
        return sairrdettId;
    }

    /**
     * Imposta il valore della proprieta sairrdettId.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setSairrdettId(Integer value) {
        this.sairrdettId = value;
    }

    /**
     * Recupera il valore della proprieta tipo.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTipo() {
        return tipo;
    }

    /**
     * Imposta il valore della proprieta tipo.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTipo(String value) {
        this.tipo = value;
    }

}

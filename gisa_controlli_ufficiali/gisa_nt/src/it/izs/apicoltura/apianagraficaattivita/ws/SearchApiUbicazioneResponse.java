
package it.izs.apicoltura.apianagraficaattivita.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiUbicazioneResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiUbicazioneResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ApiUbicazioneTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apiubi" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiUbicazioneResponse", propOrder = {
    "apiUbicazioneTO"
})
public class SearchApiUbicazioneResponse {

    @XmlElement(name = "ApiUbicazioneTO")
    protected List<Apiubi> apiUbicazioneTO;

    /**
     * Gets the value of the apiUbicazioneTO property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the apiUbicazioneTO property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getApiUbicazioneTO().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Apiubi }
     * 
     * 
     */
    public List<Apiubi> getApiUbicazioneTO() {
        if (apiUbicazioneTO == null) {
            apiUbicazioneTO = new ArrayList<Apiubi>();
        }
        return this.apiUbicazioneTO;
    }

}


package it.izs.apicoltura.apianagraficaattivita.ws;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchStoricoDetentoreResponse complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchStoricoDetentoreResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="StoricoDetentoreTO" type="{http://ws.apianagrafica.apicoltura.izs.it/}apistodet" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchStoricoDetentoreResponse", propOrder = {
    "storicoDetentoreTO"
})
public class SearchStoricoDetentoreResponse {

    @XmlElement(name = "StoricoDetentoreTO")
    protected List<Apistodet> storicoDetentoreTO;

    /**
     * Gets the value of the storicoDetentoreTO property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the storicoDetentoreTO property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getStoricoDetentoreTO().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Apistodet }
     * 
     * 
     */
    public List<Apistodet> getStoricoDetentoreTO() {
        if (storicoDetentoreTO == null) {
            storicoDetentoreTO = new ArrayList<Apistodet>();
        }
        return this.storicoDetentoreTO;
    }

}

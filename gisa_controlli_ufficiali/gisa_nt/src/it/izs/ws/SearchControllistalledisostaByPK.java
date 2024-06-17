
package it.izs.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchControllistalledisostaByPK complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchControllistalledisostaByPK">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="id" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchControllistalledisostaByPK", propOrder = {
    "id"
})
public class SearchControllistalledisostaByPK {

    protected int id;

    /**
     * Recupera il valore della proprieta id.
     * 
     */
    public int getId() {
        return id;
    }

    /**
     * Imposta il valore della proprieta id.
     * 
     */
    public void setId(int value) {
        this.id = value;
    }

}

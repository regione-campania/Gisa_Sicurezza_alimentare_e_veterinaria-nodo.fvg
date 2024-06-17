
package it.izs.apicoltura.apimovimentazione.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApimodmovByPk complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApimodmovByPk">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="apimodmovId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApimodmovByPk", propOrder = {
    "apimodmovId"
})
public class SearchApimodmovByPk {

    protected long apimodmovId;

    /**
     * Recupera il valore della proprieta apimodmovId.
     * 
     */
    public long getApimodmovId() {
        return apimodmovId;
    }

    /**
     * Imposta il valore della proprieta apimodmovId.
     * 
     */
    public void setApimodmovId(long value) {
        this.apimodmovId = value;
    }

}

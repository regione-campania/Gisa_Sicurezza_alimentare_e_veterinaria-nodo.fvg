
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiAttivitaByPk complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiAttivitaByPk">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="apiattId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiAttivitaByPk", propOrder = {
    "apiattId"
})
public class SearchApiAttivitaByPk {

    protected long apiattId;

    /**
     * Recupera il valore della proprieta apiattId.
     * 
     */
    public long getApiattId() {
        return apiattId;
    }

    /**
     * Imposta il valore della proprieta apiattId.
     * 
     */
    public void setApiattId(long value) {
        this.apiattId = value;
    }

}

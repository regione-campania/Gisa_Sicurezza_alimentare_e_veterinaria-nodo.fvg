
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchStoricoDetentoreByPk complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchStoricoDetentoreByPk">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="apistodetId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchStoricoDetentoreByPk", propOrder = {
    "apistodetId"
})
public class SearchStoricoDetentoreByPk {

    protected long apistodetId;

    /**
     * Recupera il valore della proprieta apistodetId.
     * 
     */
    public long getApistodetId() {
        return apistodetId;
    }

    /**
     * Imposta il valore della proprieta apistodetId.
     * 
     */
    public void setApistodetId(long value) {
        this.apistodetId = value;
    }

}

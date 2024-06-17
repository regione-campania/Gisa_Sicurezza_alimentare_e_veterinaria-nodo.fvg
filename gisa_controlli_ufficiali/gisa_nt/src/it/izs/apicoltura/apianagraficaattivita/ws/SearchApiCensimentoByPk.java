
package it.izs.apicoltura.apianagraficaattivita.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchApiCensimentoByPk complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchApiCensimentoByPk">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="apicenId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchApiCensimentoByPk", propOrder = {
    "apicenId"
})
public class SearchApiCensimentoByPk {

    protected long apicenId;

    /**
     * Recupera il valore della proprieta apicenId.
     * 
     */
    public long getApicenId() {
        return apicenId;
    }

    /**
     * Imposta il valore della proprieta apicenId.
     * 
     */
    public void setApicenId(long value) {
        this.apicenId = value;
    }

}

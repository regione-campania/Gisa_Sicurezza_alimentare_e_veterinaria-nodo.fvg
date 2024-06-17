
package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchUnitaProduttivaByPK complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchUnitaProduttivaByPK">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="uniproId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchUnitaProduttivaByPK", propOrder = {
    "uniproId"
})
public class SearchUnitaProduttivaByPK {

    protected long uniproId;

    /**
     * Recupera il valore della proprieta uniproId.
     * 
     */
    public long getUniproId() {
        return uniproId;
    }

    /**
     * Imposta il valore della proprieta uniproId.
     * 
     */
    public void setUniproId(long value) {
        this.uniproId = value;
    }

}


package it.izs.bdn.anagrafica.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per searchUnitaProduttiva complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="searchUnitaProduttiva">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="UnitaProduttivaSearchTO" type="{http://ws.anagrafica.bdn.izs.it/}unipro"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "searchUnitaProduttiva", propOrder = {
    "unitaProduttivaSearchTO"
})
public class SearchUnitaProduttiva {

    @XmlElement(name = "UnitaProduttivaSearchTO", required = true)
    protected Unipro unitaProduttivaSearchTO;

    /**
     * Recupera il valore della proprieta unitaProduttivaSearchTO.
     * 
     * @return
     *     possible object is
     *     {@link Unipro }
     *     
     */
    public Unipro getUnitaProduttivaSearchTO() {
        return unitaProduttivaSearchTO;
    }

    /**
     * Imposta il valore della proprieta unitaProduttivaSearchTO.
     * 
     * @param value
     *     allowed object is
     *     {@link Unipro }
     *     
     */
    public void setUnitaProduttivaSearchTO(Unipro value) {
        this.unitaProduttivaSearchTO = value;
    }

}

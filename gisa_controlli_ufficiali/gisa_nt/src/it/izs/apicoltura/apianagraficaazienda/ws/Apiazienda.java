
package it.izs.apicoltura.apianagraficaazienda.ws;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per apiazienda complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="apiazienda">
 *   &lt;complexContent>
 *     &lt;extension base="{http://ws.apianagrafica.apicoltura.izs.it/}azienda">
 *       &lt;sequence>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "apiazienda")
public class Apiazienda
    extends Azienda
{
	
	public boolean verificaEsistenzaGisa(Connection db) throws SQLException
	{
		boolean toRet = false ; 
		PreparedStatement pst = null ;
		ResultSet rs = null ;
		String sql="select * from apicoltura_imprese where codice_azienda ilike ? and stato!=4";
		pst = db.prepareStatement(sql);
		pst.setString(1, this.codice);
		rs = pst.executeQuery();
		if (rs.next())
			toRet=true ;
		
		return toRet;
		
	}


}

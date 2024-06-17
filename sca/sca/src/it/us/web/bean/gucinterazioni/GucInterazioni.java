package it.us.web.bean.gucinterazioni;

import it.us.web.action.endpointconnector.ConfigAction;
import it.us.web.bean.endpointconnector.EndPoint;
import it.us.web.bean.endpointconnector.EndPointConnector;
import it.us.web.bean.endpointconnector.EndPointConnectorList;
import it.us.web.bean.endpointconnector.Operazione;


import it.us.web.util.guc.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class GucInterazioni{
	
private EndPointConnectorList listaEndPointConnector = null;

public EndPointConnectorList getListaEndPointConnector(){
	return listaEndPointConnector;
}
	
	public GucInterazioni(){
		System.out.println("SCA *** Costruisco EndPointConnector.");
		listaEndPointConnector = inizializzaEndPointConnector();
		System.out.println("SCA *** Costruito EndPointConnector *** size: "+listaEndPointConnector.size());
		
	}
	
	public EndPointConnectorList inizializzaEndPointConnector(){
		//Da mettere in session all'avvio?
			  ConfigAction ac = new ConfigAction();
			  EndPointConnectorList listaEndPointConnector = ac.getEndPointConnector();
			  return listaEndPointConnector;
		}

	

	
public boolean verificaVecchiaPassword(String username, String passwordOld) throws SQLException{
	boolean esito = false;
	
	EndPointConnector epc = listaEndPointConnector.getByIdOperazioneIdEndPoint(Operazione.VERIFICAPASSWORDPRECEDENTE, EndPoint.GUC);
	Connection dbGuc = null;
	try {
		dbGuc = DbUtil.ottieniConnessioneJDBC(epc.getEndPoint().getDataSourceSlave());
	
	String sql = epc.getSql();
	PreparedStatement pst = dbGuc.prepareStatement(sql);
	pst.setString(1, username);
	pst.setString(2, passwordOld);
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		esito = rs.getBoolean(1);
	}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		DbUtil.chiudiConnessioneJDBC(null, dbGuc);
	}
	return esito;
}

public boolean verificaCambioPasswordRecente(String username) throws SQLException{
	boolean esito = false;
	
	EndPointConnector epc = listaEndPointConnector.getByIdOperazioneIdEndPoint(Operazione.VERIFICACAMBIOPASSWORDRECENTE, EndPoint.GUC);
	Connection dbGuc = null;
	try {
		dbGuc = DbUtil.ottieniConnessioneJDBC(epc.getEndPoint().getDataSourceSlave());
	
	String sql = epc.getSql();
	PreparedStatement pst = dbGuc.prepareStatement(sql);
	pst.setString(1, username);
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		esito = rs.getBoolean(1);
	}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		DbUtil.chiudiConnessioneJDBC(null, dbGuc);
	}
	return esito;
}


public boolean verificaEsistenzaUsername(String username) throws SQLException{
	boolean esito = false;
	
	EndPointConnector epc = listaEndPointConnector.getByIdOperazioneIdEndPoint(Operazione.CHECKESISTENZAUTENTE, EndPoint.GUC);
	Connection dbGuc = null;
	try {
		dbGuc = DbUtil.ottieniConnessioneJDBC(epc.getEndPoint().getDataSourceSlave());
	
	String sql = epc.getSql();
	PreparedStatement pst = dbGuc.prepareStatement(sql);
	pst.setString(1, username);
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		esito = rs.getBoolean(1);
	}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		DbUtil.chiudiConnessioneJDBC(null, dbGuc);
	}
	return esito;
}

}

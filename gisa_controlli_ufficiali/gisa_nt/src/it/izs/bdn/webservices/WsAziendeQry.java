/**
 * WsAziendeQry.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public interface WsAziendeQry extends javax.xml.rpc.Service {

/**
 * Estrazione dati relativi alle aziende.
 */
    public java.lang.String getwsAziendeQrySoapAddress();

    public it.izs.bdn.webservices.WsAziendeQrySoap getwsAziendeQrySoap() throws javax.xml.rpc.ServiceException;

    public it.izs.bdn.webservices.WsAziendeQrySoap getwsAziendeQrySoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}

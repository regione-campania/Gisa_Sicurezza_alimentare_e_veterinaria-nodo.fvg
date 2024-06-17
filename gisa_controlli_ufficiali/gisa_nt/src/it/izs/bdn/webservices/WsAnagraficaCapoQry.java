/**
 * WsAnagraficaCapoQry.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public interface WsAnagraficaCapoQry extends javax.xml.rpc.Service {

/**
 * Estrazione dati anagrafici dei capi.
 */
    public java.lang.String getwsAnagraficaCapoQrySoapAddress();

    public it.izs.bdn.webservices.WsAnagraficaCapoQrySoap getwsAnagraficaCapoQrySoap() throws javax.xml.rpc.ServiceException;

    public it.izs.bdn.webservices.WsAnagraficaCapoQrySoap getwsAnagraficaCapoQrySoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}

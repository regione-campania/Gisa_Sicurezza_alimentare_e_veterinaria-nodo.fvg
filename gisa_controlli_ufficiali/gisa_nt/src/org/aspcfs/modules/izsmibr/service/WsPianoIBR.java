/**
 * WsPianoIBR.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.aspcfs.modules.izsmibr.service;

public interface WsPianoIBR extends javax.xml.rpc.Service {

/**
 * Registraziopne e gestione degli esiti dei campionamenti per i controlli
 * IBR sui capi bovini
 */
    public java.lang.String getwsPianoIBRSoapAddress();

    public org.aspcfs.modules.izsmibr.service.WsPianoIBRSoap getwsPianoIBRSoap() throws javax.xml.rpc.ServiceException;

    public org.aspcfs.modules.izsmibr.service.WsPianoIBRSoap getwsPianoIBRSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}

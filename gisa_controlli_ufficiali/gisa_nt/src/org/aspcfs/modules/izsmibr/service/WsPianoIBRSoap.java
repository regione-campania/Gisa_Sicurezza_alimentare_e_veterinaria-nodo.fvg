/**
 * WsPianoIBRSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.aspcfs.modules.izsmibr.service;

public interface WsPianoIBRSoap extends java.rmi.Remote {

    /**
     * Inserisce l'esito di un esame per IBR. restituisce una stringa
     */
    public java.lang.String insertEsitoPrelievoIBR_STR(java.lang.String strRecord) throws java.rmi.RemoteException;

    /**
     * Inserisce l'esito di un esame per IBR.
     */
    public org.aspcfs.modules.izsmibr.service.InsertEsitoPrelievoIBRResponseInsertEsitoPrelievoIBRResult insertEsitoPrelievoIBR(java.lang.String strRecord) throws java.rmi.RemoteException;
}

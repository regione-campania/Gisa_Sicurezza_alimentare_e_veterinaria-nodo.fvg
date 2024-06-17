
package it.izs.bdn.anagrafica.ws;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.Action;
import javax.xml.ws.FaultAction;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.9-b130926.1035
 * Generated source version: 2.2
 * 
 */
@WebService(name = "AziendaEndpoint", targetNamespace = "http://ws.anagrafica.bdn.izs.it/")
@SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
@XmlSeeAlso({
    ObjectFactory.class
})
public interface AziendaEndpoint {


    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.bdn.anagrafica.ws.SearchAziendaByPkResponse
     */
    @WebMethod
    @WebResult(name = "searchAziendaByPkResponse", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "result")
    @Action(input = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/searchAziendaByPkRequest", output = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/searchAziendaByPkResponse")
    public SearchAziendaByPkResponse searchAziendaByPk(
        @WebParam(name = "searchAziendaByPk", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "parameters")
        SearchAziendaByPk parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS);

    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.bdn.anagrafica.ws.UpdateAziendaResponse
     * @throws BusinessWsException_Exception
     */
    @WebMethod
    @WebResult(name = "updateAziendaResponse", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "result")
    @Action(input = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/updateAziendaRequest", output = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/updateAziendaResponse", fault = {
        @FaultAction(className = BusinessWsException_Exception.class, value = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/updateAzienda/Fault/BusinessWsException")
    })
    public UpdateAziendaResponse updateAzienda(
        @WebParam(name = "updateAzienda", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "parameters")
        UpdateAzienda parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS)
        throws BusinessWsException_Exception
    ;

    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.bdn.anagrafica.ws.InsertAziendaResponse
     * @throws BusinessWsException_Exception
     */
    @WebMethod
    @WebResult(name = "insertAziendaResponse", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "result")
    @Action(input = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/insertAziendaRequest", output = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/insertAziendaResponse", fault = {
        @FaultAction(className = BusinessWsException_Exception.class, value = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/insertAzienda/Fault/BusinessWsException")
    })
    public InsertAziendaResponse insertAzienda(
        @WebParam(name = "insertAzienda", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "parameters")
        InsertAzienda parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS)
        throws BusinessWsException_Exception
    ;

    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.bdn.anagrafica.ws.SearchAziendaResponse
     * @throws BusinessWsException_Exception
     */
    @WebMethod
    @WebResult(name = "searchAziendaResponse", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "result")
    @Action(input = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/searchAziendaRequest", output = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/searchAziendaResponse", fault = {
        @FaultAction(className = BusinessWsException_Exception.class, value = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/searchAzienda/Fault/BusinessWsException")
    })
    public SearchAziendaResponse searchAzienda(
        @WebParam(name = "searchAzienda", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "parameters")
        SearchAzienda parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS)
        throws BusinessWsException_Exception
    ;

    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.bdn.anagrafica.ws.DeleteAziendaResponse
     * @throws BusinessWsException_Exception
     */
    @WebMethod
    @WebResult(name = "deleteAziendaResponse", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "result")
    @Action(input = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/deleteAziendaRequest", output = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/deleteAziendaResponse", fault = {
        @FaultAction(className = BusinessWsException_Exception.class, value = "http://ws.anagrafica.bdn.izs.it/AziendaEndpoint/deleteAzienda/Fault/BusinessWsException")
    })
    public DeleteAziendaResponse deleteAzienda(
        @WebParam(name = "deleteAzienda", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", partName = "parameters")
        DeleteAzienda parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.anagrafica.bdn.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS)
        throws BusinessWsException_Exception
    ;

}
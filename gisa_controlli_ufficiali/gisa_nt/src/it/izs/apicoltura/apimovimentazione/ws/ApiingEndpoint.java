
package it.izs.apicoltura.apimovimentazione.ws;

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
@WebService(name = "ApiingEndpoint", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/")
@SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
@XmlSeeAlso({
    ObjectFactory.class
})
public interface ApiingEndpoint {


    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.apicoltura.apimovimentazione.ws.SearchApiingByPkResponse
     */
    @WebMethod
    @WebResult(name = "searchApiingByPkResponse", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "result")
    @Action(input = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/searchApiingByPkRequest", output = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/searchApiingByPkResponse")
    public SearchApiingByPkResponse searchApiingByPk(
        @WebParam(name = "searchApiingByPk", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "parameters")
        SearchApiingByPk parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS);

    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.apicoltura.apimovimentazione.ws.InsertApiingResponse
     * @throws BusinessWsException_Exception
     */
    @WebMethod
    @WebResult(name = "insertApiingResponse", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "result")
    @Action(input = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/insertApiingRequest", output = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/insertApiingResponse", fault = {
        @FaultAction(className = BusinessWsException_Exception.class, value = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/insertApiing/Fault/BusinessWsException")
    })
    public InsertApiingResponse insertApiing(
        @WebParam(name = "insertApiing", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "parameters")
        InsertApiing parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS)
        throws BusinessWsException_Exception
    ;

    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.apicoltura.apimovimentazione.ws.UpdateApiingResponse
     * @throws BusinessWsException_Exception
     */
    @WebMethod
    @WebResult(name = "updateApiingResponse", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "result")
    @Action(input = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/updateApiingRequest", output = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/updateApiingResponse", fault = {
        @FaultAction(className = BusinessWsException_Exception.class, value = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/updateApiing/Fault/BusinessWsException")
    })
    public UpdateApiingResponse updateApiing(
        @WebParam(name = "updateApiing", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "parameters")
        UpdateApiing parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS)
        throws BusinessWsException_Exception
    ;

    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.apicoltura.apimovimentazione.ws.DeleteApiingResponse
     * @throws BusinessWsException_Exception
     */
    @WebMethod
    @WebResult(name = "deleteApiingResponse", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "result")
    @Action(input = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/deleteApiingRequest", output = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/deleteApiingResponse", fault = {
        @FaultAction(className = BusinessWsException_Exception.class, value = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/deleteApiing/Fault/BusinessWsException")
    })
    public DeleteApiingResponse deleteApiing(
        @WebParam(name = "deleteApiing", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "parameters")
        DeleteApiing parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS)
        throws BusinessWsException_Exception
    ;

    /**
     * 
     * @param soapAutenticazioneWS
     * @param parameters
     * @return
     *     returns it.izs.apicoltura.apimovimentazione.ws.SearchApiingResponse
     * @throws BusinessWsException_Exception
     */
    @WebMethod
    @WebResult(name = "searchApiingResponse", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "result")
    @Action(input = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/searchApiingRequest", output = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/searchApiingResponse", fault = {
        @FaultAction(className = BusinessWsException_Exception.class, value = "http://ws.apimovimentazione.apicoltura.izs.it/ApiingEndpoint/searchApiing/Fault/BusinessWsException")
    })
    public SearchApiingResponse searchApiing(
        @WebParam(name = "searchApiing", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", partName = "parameters")
        SearchApiing parameters,
        @WebParam(name = "SOAPAutenticazioneWS", targetNamespace = "http://ws.apimovimentazione.apicoltura.izs.it/", header = true, partName = "SOAPAutenticazioneWS")
        SOAPAutenticazioneWS soapAutenticazioneWS)
        throws BusinessWsException_Exception
    ;

}
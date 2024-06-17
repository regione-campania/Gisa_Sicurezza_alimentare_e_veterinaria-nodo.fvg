/**
 * GetPersona_STR.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package it.izs.bdn.webservices;

public class GetPersona_STR  implements java.io.Serializable {
    private java.lang.String p_persona_idfiscale;

    public GetPersona_STR() {
    }

    public GetPersona_STR(
           java.lang.String p_persona_idfiscale) {
           this.p_persona_idfiscale = p_persona_idfiscale;
    }


    /**
     * Gets the p_persona_idfiscale value for this GetPersona_STR.
     * 
     * @return p_persona_idfiscale
     */
    public java.lang.String getP_persona_idfiscale() {
        return p_persona_idfiscale;
    }


    /**
     * Sets the p_persona_idfiscale value for this GetPersona_STR.
     * 
     * @param p_persona_idfiscale
     */
    public void setP_persona_idfiscale(java.lang.String p_persona_idfiscale) {
        this.p_persona_idfiscale = p_persona_idfiscale;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof GetPersona_STR)) return false;
        GetPersona_STR other = (GetPersona_STR) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.p_persona_idfiscale==null && other.getP_persona_idfiscale()==null) || 
             (this.p_persona_idfiscale!=null &&
              this.p_persona_idfiscale.equals(other.getP_persona_idfiscale())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getP_persona_idfiscale() != null) {
            _hashCode += getP_persona_idfiscale().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(GetPersona_STR.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", ">getPersona_STR"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("p_persona_idfiscale");
        elemField.setXmlName(new javax.xml.namespace.QName("http://bdr.izs.it/webservices", "p_persona_idfiscale"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}

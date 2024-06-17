package org.aspcfs.modules.noscia.dao;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import org.aspcfs.modules.gestioneanagrafica.base.LookupTemplateNoScia;
import org.aspcfs.modules.gestioneanagrafica.base.MetadatoTemplate;
import org.aspcfs.utils.Bean;


public class MetadatoDAO extends GenericDAO{
    
    private MetadatoTemplate metadato;

    public MetadatoDAO()
    {
        this.metadato=new MetadatoTemplate();
    }
    

    public MetadatoDAO(MetadatoTemplate metadato)
    {
        this.metadato=metadato;
    }
    
    public MetadatoDAO(Map<String, String[]> properties) throws IllegalAccessException, InvocationTargetException, SQLException, IllegalArgumentException, ParseException
    {
        Bean.populate(this, properties);
    }
    
    public MetadatoDAO(Map<String, String[]> properties,String prefix, boolean isPrefix) throws IllegalAccessException, InvocationTargetException, SQLException, IllegalArgumentException, ParseException
    {
        Bean.populate(this, properties, prefix, isPrefix);
    }
    
    public MetadatoDAO(ResultSet rs) throws SQLException 
    {
        Bean.populate(this, rs);
    }
    
  
    public ArrayList<MetadatoTemplate> getItems(Connection conn) throws SQLException 
    {
        String sql = " select * from public.cerca_metadato (?) "  ;
        
        PreparedStatement st = conn.prepareStatement(sql);
        st.setObject(1, metadato.getLookupGruppoTemplateNoScia().getId());
        
        
        ResultSet rs = st.executeQuery();
        ArrayList<MetadatoTemplate> metadati = new ArrayList<MetadatoTemplate>();
        
        while(rs.next())
        {
            MetadatoTemplate metadato = new MetadatoTemplate(rs);
            LookupTemplateNoScia tipo = new LookupTemplateNoScia(metadato.getLookupGruppoTemplateNoScia().getId());
            LookupTemplateNoSciaDAO tipoDao = new LookupTemplateNoSciaDAO(tipo);
            metadato.setLookupTemplateNoScia((LookupTemplateNoScia) tipoDao.getItem(conn));
          //  metadato.setId_oggetto(this.metadato.getId_oggetto());
        
            metadati.add(metadato);
        }
        
        return metadati;
    }


    @Override
    public Object getItem(Connection connection) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }
}

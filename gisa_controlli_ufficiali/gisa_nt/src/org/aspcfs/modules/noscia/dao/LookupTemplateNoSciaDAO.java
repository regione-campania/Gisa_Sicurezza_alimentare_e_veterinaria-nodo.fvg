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
import org.aspcfs.utils.Bean;


public class LookupTemplateNoSciaDAO extends GenericDAO{
    
    
    public LookupTemplateNoScia lookupTemplateNoScia;

    
    public LookupTemplateNoSciaDAO() throws SQLException
    {
        this.lookupTemplateNoScia = new LookupTemplateNoScia();
    }
    
    
    public LookupTemplateNoSciaDAO(Map<String, String[]> properties) throws IllegalAccessException, InvocationTargetException, SQLException, IllegalArgumentException, ParseException
    {
        Bean.populate(this, properties);
    }
    
    public LookupTemplateNoSciaDAO(LookupTemplateNoScia configuraLookupTemplateNoScia)
    {
        this.lookupTemplateNoScia=configuraLookupTemplateNoScia;
    }
    
    public LookupTemplateNoSciaDAO(ResultSet rs) throws SQLException
    {
        Bean.populate(this, rs);
    }
    
    public ArrayList<LookupTemplateNoScia> getItems(Connection conn) throws SQLException {
        
        
        String sql= "select * from  public.lookup_template_no_scia";
        PreparedStatement st = conn.prepareStatement(sql);
        
        ResultSet rs = st.executeQuery();
        
        ArrayList<LookupTemplateNoScia>  listGruppo = new ArrayList<LookupTemplateNoScia>();
        
        while (rs.next())
        {
            listGruppo.add(new LookupTemplateNoScia(rs));
        }
        
        return listGruppo;
    }


    @Override
    public Object getItem(Connection connection) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }

}

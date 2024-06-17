package org.aspcfs.modules.noscia.dao;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import org.aspcfs.modules.gestioneanagrafica.base.LookupGruppoTemplateNoScia;
import org.aspcfs.utils.Bean;

public class LookupGruppoTemplateNoSciaDAO extends GenericDAO{
    
public LookupGruppoTemplateNoScia lookupGruppoTemplateNoScia;
    
    public LookupGruppoTemplateNoSciaDAO() throws SQLException
    {
        this.lookupGruppoTemplateNoScia = new LookupGruppoTemplateNoScia();
    }
    
    
    public LookupGruppoTemplateNoSciaDAO(Map<String, String[]> properties) throws IllegalAccessException, InvocationTargetException, SQLException, IllegalArgumentException, ParseException
    {
        Bean.populate(this, properties);
    }
    
    public LookupGruppoTemplateNoSciaDAO(LookupGruppoTemplateNoScia lookupGruppoTemplateNoScia)
    {
        this.lookupGruppoTemplateNoScia=lookupGruppoTemplateNoScia;
    }
    
    public LookupGruppoTemplateNoSciaDAO(ResultSet rs) throws SQLException
    {
        Bean.populate(this, rs);
    }

    @Override
    public ArrayList<LookupGruppoTemplateNoScia> getItems(Connection conn) throws SQLException {
      
        String sql= "select * from  public.lookup_gruppo_template_no_scia where id_lookup_template_no_scia = ?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, lookupGruppoTemplateNoScia.getId_lookup_template_no_scia());
        ResultSet rs = st.executeQuery();
        
        ArrayList<LookupGruppoTemplateNoScia>  listRichieste = new ArrayList<LookupGruppoTemplateNoScia>();
        
        while (rs.next())
        {
            listRichieste.add(new LookupGruppoTemplateNoScia(rs));
        }
        
        return listRichieste;
    }

}

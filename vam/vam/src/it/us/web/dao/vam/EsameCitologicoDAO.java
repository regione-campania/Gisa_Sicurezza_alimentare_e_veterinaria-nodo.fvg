package it.us.web.dao.vam;

import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameCitologico;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoDiagnosi;
import it.us.web.dao.GenericDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.lookup.LookupCMIDAO;
import it.us.web.dao.lookup.LookupComuniDAO;
import it.us.web.dao.lookup.LookupEsameObiettivoTipoDAO;
import it.us.web.dao.lookup.LookupSpecieDAO;
import it.us.web.dao.sinantropi.lookup.LookupSinantropiEtaDAO;
import it.us.web.util.bean.Bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cacheonix.util.array.HashSet;

public class EsameCitologicoDAO extends GenericDAO {
	public static final Logger logger = LoggerFactory.getLogger(EsameCitologicoDAO.class);

	public static ArrayList<EsameCitologico> getByDiagnosi(int tipoDiagnosi, Connection connection) throws SQLException 
	{
		ArrayList<EsameCitologico> esami = new ArrayList<EsameCitologico>();
		String sql = " select e.id_diagnosi_padre, e.id,  e.data_esito, e.data_richiesta, e.outsideCC,  " + 
				"				 d.id as diagnosi_id, d.description as diagnosi_description, d.enabled as diagnosi_enabled, d.level as diagnosi_level,  " + 
				"				 an.identificativo, an.sesso, an.specie,  " + 
				"				 cc.id as id_cc,  " + 
				"				 acc.id as id_acc,  " + 
				"				 an2.id as id_animale, an2.identificativo as identificativo2, an2.sesso as sesso2, an2.specie as specie2,  " + 
				"                                 an2.deceduto_non_anagrafe as deceduto_non_anagrafe2  " + 
				"				 from esame_citologico e  " + 
				"				 left join utenti_ u on u.id = e.entered_by  " + 
				"				 left join animale an on an.id = e.animale and an.trashed_date is null  " + 
				"				 left join cartella_clinica cc on cc.id = e.cartella_clinica and cc.trashed_date is null  " + 
				"				 left join accettazione acc on cc.accettazione = acc.id and acc.trashed_date is null  " + 
				"				 left join animale an2 on an2.id = acc.animale and an2.trashed_date is null  " + 
				"				 left join lookup_esame_citologico_diagnosi d on d.id = e.diagnosi and d.enabled  " + 
				"				 where e.entered_by = u.id and e.trashed_date is null and e.id_diagnosi_padre in (1,2) " + 
				"				 order by e.data_richiesta desc  " ;
		PreparedStatement st = connection.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			EsameCitologico esame = new EsameCitologico();
			
			
			if(rs.getString("identificativo")!=null)
			{
				Animale animale = new Animale();
				animale.setIdentificativo(rs.getString("identificativo"));
				animale.setSesso(rs.getString("sesso"));
				animale.setLookupSpecie(LookupSpecieDAO.getSpecie(rs.getInt("specie"), connection));
				esame.setAnimale(animale);
			}
			
			if(rs.getString("identificativo2")!=null)
			{
				Animale an = new Animale();
				an.setId(rs.getInt("id_animale"));
				an.setIdentificativo(rs.getString("identificativo2"));
				an.setSesso(rs.getString("sesso2"));
				an.setDecedutoNonAnagrafe(rs.getBoolean("deceduto_non_anagrafe2"));
				an.setLookupSpecie(LookupSpecieDAO.getSpecie(rs.getInt("specie2"), connection));
				CartellaClinica cc = new CartellaClinica();
				cc.setId(rs.getInt("id_cc"));
				Accettazione acc = new Accettazione();
				acc.setId(rs.getInt("id_acc"));
				acc.setAnimale(an);
				cc.setAccettazione(acc);
				esame.setCartellaClinica(cc);
			}
			
			if(rs.getInt("diagnosi_id")>0)
			{
				LookupEsameCitologicoDiagnosi d = new LookupEsameCitologicoDiagnosi();
				d.setId(rs.getInt("diagnosi_id"));
				d.setDescription(rs.getString("diagnosi_description"));
				d.setEnabled(rs.getBoolean("diagnosi_enabled"));
				d.setLevel(rs.getInt("diagnosi_level"));
				esame.setDiagnosi(d);
			}
			
			esame.setOutsideCC(rs.getBoolean("outsideCC"));
			esame.setDataEsito(rs.getDate("data_esito"));
			esame.setDataRichiesta(rs.getDate("data_richiesta"));
			esame.setId(rs.getInt("id"));
			esame.setIdDiagnosiPadre(rs.getInt("id_diagnosi_padre"));
			esami.add(esame);
		}
		return esami;
	}
	
	
	public static ArrayList<EsameCitologico> getByUtente(int idUtente, Connection connection) throws SQLException 
	{
		ArrayList<EsameCitologico> esami = new ArrayList<EsameCitologico>();
		String sql = " select  d_padre.enabled as enabled_diagnosi_padre1, d_padre.level as level_diagnosi_padre1, d_padre.id as id_diagnosi_padre1, d_padre.description as description_diagnosi_padre1, e.id_diagnosi_padre, e.id,  e.data_esito, e.data_richiesta, e.outsideCC,  " + 
				"				 d.id as diagnosi_id, d.description as diagnosi_description, d.enabled as diagnosi_enabled, d.level as diagnosi_level,  " + 
				"				 an.identificativo, an.sesso, an.specie,  " + 
				"				 cc.id as id_cc,  " + 
				"				 acc.id as id_acc,  " + 
				"				 an2.id as id_animale, an2.identificativo as identificativo2, an2.sesso as sesso2, an2.specie as specie2,  " + 
				"                                 an2.deceduto_non_anagrafe as deceduto_non_anagrafe2  " + 
				"				 from esame_citologico e  " + 
				"				 left join utenti_ u on u.id = e.entered_by  " + 
				"				 left join animale an on an.id = e.animale and an.trashed_date is null  " + 
				"				 left join cartella_clinica cc on cc.id = e.cartella_clinica and cc.trashed_date is null  " + 
				"				 left join accettazione acc on cc.accettazione = acc.id and acc.trashed_date is null  " + 
				"				 left join animale an2 on an2.id = acc.animale and an2.trashed_date is null  " + 
				"				 left join lookup_esame_citologico_diagnosi d on d.id = e.diagnosi and d.enabled  " + 
				"				 left join lookup_esame_citologico_diagnosi d_padre on d_padre.id = d.padre and d_padre.enabled  " + 
				"				 where e.entered_by = ? and e.entered_by = u.id and e.trashed_date is null" + 
				"				 order by e.data_richiesta desc  " ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, idUtente);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			EsameCitologico esame = new EsameCitologico();
			
			
			if(rs.getString("identificativo")!=null)
			{
				Animale animale = new Animale();
				animale.setIdentificativo(rs.getString("identificativo"));
				animale.setSesso(rs.getString("sesso"));
				animale.setLookupSpecie(LookupSpecieDAO.getSpecie(rs.getInt("specie"), connection));
				esame.setAnimale(animale);
			}
			
			if(rs.getString("identificativo2")!=null)
			{
				Animale an = new Animale();
				an.setId(rs.getInt("id_animale"));
				an.setIdentificativo(rs.getString("identificativo2"));
				an.setSesso(rs.getString("sesso2"));
				an.setDecedutoNonAnagrafe(rs.getBoolean("deceduto_non_anagrafe2"));
				an.setLookupSpecie(LookupSpecieDAO.getSpecie(rs.getInt("specie2"), connection));
				CartellaClinica cc = new CartellaClinica();
				cc.setId(rs.getInt("id_cc"));
				Accettazione acc = new Accettazione();
				acc.setId(rs.getInt("id_acc"));
				acc.setAnimale(an);
				cc.setAccettazione(acc);
				esame.setCartellaClinica(cc);
			}
			
			if(rs.getInt("diagnosi_id")>0)
			{
				LookupEsameCitologicoDiagnosi d = new LookupEsameCitologicoDiagnosi();
				d.setId(rs.getInt("diagnosi_id"));
				d.setDescription(rs.getString("diagnosi_description"));
				d.setEnabled(rs.getBoolean("diagnosi_enabled"));
				d.setLevel(rs.getInt("diagnosi_level"));
				LookupEsameCitologicoDiagnosi dPadre = new LookupEsameCitologicoDiagnosi();
				dPadre.setId(rs.getInt("id_diagnosi_padre1"));
				dPadre.setDescription(rs.getString("description_diagnosi_padre1"));
				dPadre.setEnabled(rs.getBoolean("enabled_diagnosi_padre1"));
				dPadre.setLevel(rs.getInt("level_diagnosi_padre1"));
				d.setPadre(dPadre);
				esame.setDiagnosi(d);
			}
			
			esame.setOutsideCC(rs.getBoolean("outsideCC"));
			esame.setDataEsito(rs.getDate("data_esito"));
			esame.setDataRichiesta(rs.getDate("data_richiesta"));
			esame.setId(rs.getInt("id"));
			esame.setIdDiagnosiPadre(rs.getInt("id_diagnosi_padre"));
			esami.add(esame);
		}
		return esami;
	}
	
	
}

package it.us.web.dao.vam;

import it.us.web.bean.BRuolo;
import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.CartellaClinicaNoH;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.EsameObiettivo;
import it.us.web.bean.vam.EsameObiettivoEsito;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupCMI;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoEsito;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoTipo;
import it.us.web.constants.Sql;
import it.us.web.dao.GenericDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.lookup.LookupCMIDAO;
import it.us.web.dao.lookup.LookupComuniDAO;
import it.us.web.dao.lookup.LookupEsameIstopatologicoSedeLesioneDAO;
import it.us.web.dao.lookup.LookupEsameObiettivoTipoDAO;
import it.us.web.dao.lookup.LookupSpecieDAO;
import it.us.web.dao.sinantropi.lookup.LookupSinantropiEtaDAO;
import it.us.web.util.bean.Bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cacheonix.util.array.HashSet;

public class EsameIstopatologicoDAO extends GenericDAO {
	public static final Logger logger = LoggerFactory.getLogger(EsameIstopatologicoDAO.class);

	
	
	
	
	public static String getProgressivoIstopatologico(int idUtente, Connection connection) throws SQLException 
	{
		DecimalFormat decimalFormat = new DecimalFormat( "000" );
		int progressivo = 1;
		String sql = " select count(*) + 1 from esame_istopatologico where entered_by = ?" ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, idUtente);
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			progressivo = rs.getInt(1);
		}
		return decimalFormat.format(progressivo);
	}
	
	
	public static ArrayList<EsameIstopatologico> getByDiagnosi(int tipoDiagnosi, Connection connection) throws SQLException 
	{
		ArrayList<EsameIstopatologico> esami = new ArrayList<EsameIstopatologico>();
		String sql = " select e.sede_lesione, e.numero, e.id, e.diagnosi_non_tumorale, e.data_esito, e.data_richiesta, e.outsideCC, "
				+    " wu.id as wu_id, wu.description as wu_description, wu.enabled as wu_enabled, wu.codice as wu_codice, wu.level as wu_level, "
				+    " an.identificativo, an.sesso, an.specie, "
				+    " cc.id as id_cc, "
				+    " acc.id as id_acc, "
				+    " an2.id as id_animale, an2.identificativo as identificativo2, an2.sesso as sesso2, an2.specie as specie2, an2.deceduto_non_anagrafe as deceduto_non_anagrafe2 "
				+    " from esame_istopatologico e "
				+    " left join utenti_ u on u.id = e.entered_by "
				+    " left join animale an on an.id = e.animale and an.trashed_date is null "
				+    " left join cartella_clinica cc on cc.id = e.cartella_clinica and cc.trashed_date is null "
				+    " left join accettazione acc on cc.accettazione = acc.id and acc.trashed_date is null "
				+    " left join animale an2 on an2.id = acc.animale and an2.trashed_date is null "
				+    " left join lookup_esame_istopatologico_who_umana wu on wu.id = e.who_umana and wu.enabled "
				+    " where e.entered_by = u.id and e.trashed_date is null and e.tipo_diagnosi = ?"
				+    " order by e.data_richiesta desc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, tipoDiagnosi);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			EsameIstopatologico esame = new EsameIstopatologico();
			
			
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
			
			if(rs.getInt("wu_id")>0)
			{
				LookupEsameIstopatologicoWhoUmana wu = new LookupEsameIstopatologicoWhoUmana();
				wu.setId(rs.getInt("wu_id"));
				wu.setCodice(rs.getString("wu_codice"));
				wu.setDescription(rs.getString("wu_description"));
				wu.setEnabled(rs.getBoolean("wu_enabled"));
				wu.setLevel(rs.getInt("wu_level"));
				esame.setWhoUmana(wu);
			}
			
			esame.setOutsideCC(rs.getBoolean("outsideCC"));
			esame.setDataEsito(rs.getDate("data_esito"));
			esame.setDataRichiesta(rs.getDate("data_richiesta"));
			esame.setDiagnosiNonTumorale(rs.getString("diagnosi_non_tumorale"));
			esame.setId(rs.getInt("id"));
			esame.setNumero(rs.getString("numero"));
			esame.setSedeLesione(LookupEsameIstopatologicoSedeLesioneDAO.getSede(rs.getInt("sede_lesione"),connection));
			esami.add(esame);
		}
		return esami;
	}
	
	
	
	public static EsameIstopatologico get(int id, Connection connection) throws SQLException 
	{
		EsameIstopatologico esame =null;
		String sql = " select e.entered_by, e.modified_by,e.sede_lesione, e.numero, e.id, e.diagnosi_non_tumorale, e.data_esito, e.data_richiesta, e.outsideCC, "
				+    " wu.id as wu_id, wu.description as wu_description, wu.enabled as wu_enabled, wu.codice as wu_codice, wu.level as wu_level, "
				+    " an.identificativo, an.sesso, an.specie, "
				+    " cc.id as id_cc, "
				+    " acc.id as id_acc, "
				+    " an2.id as id_animale, an2.identificativo as identificativo2, an2.sesso as sesso2, an2.specie as specie2, an2.deceduto_non_anagrafe as deceduto_non_anagrafe2 "
				+    " from esame_istopatologico e "
				+    " left join utenti_ u on u.id = e.entered_by "
				+    " left join animale an on an.id = e.animale and an.trashed_date is null "
				+    " left join cartella_clinica cc on cc.id = e.cartella_clinica and cc.trashed_date is null "
				+    " left join accettazione acc on cc.accettazione = acc.id and acc.trashed_date is null "
				+    " left join animale an2 on an2.id = acc.animale and an2.trashed_date is null "
				+    " left join lookup_esame_istopatologico_who_umana wu on wu.id = e.who_umana and wu.enabled "
				+    " where e.entered_by = u.id and e.trashed_date is null and e.id = ?"
				+    " order by e.data_richiesta desc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			esame = new EsameIstopatologico();
			
			
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
			
			if(rs.getInt("wu_id")>0)
			{
				LookupEsameIstopatologicoWhoUmana wu = new LookupEsameIstopatologicoWhoUmana();
				wu.setId(rs.getInt("wu_id"));
				wu.setCodice(rs.getString("wu_codice"));
				wu.setDescription(rs.getString("wu_description"));
				wu.setEnabled(rs.getBoolean("wu_enabled"));
				wu.setLevel(rs.getInt("wu_level"));
				esame.setWhoUmana(wu);
			}
			
			esame.setOutsideCC(rs.getBoolean("outsideCC"));
			esame.setDataEsito(rs.getDate("data_esito"));
			esame.setDataRichiesta(rs.getDate("data_richiesta"));
			esame.setDiagnosiNonTumorale(rs.getString("diagnosi_non_tumorale"));
			esame.setId(rs.getInt("id"));
			esame.setNumero(rs.getString("numero"));
			esame.setSedeLesione(LookupEsameIstopatologicoSedeLesioneDAO.getSede(rs.getInt("sede_lesione"),connection));
			esame.setEnteredBy(UtenteDAO.getUtenteAll(rs.getInt("entered_by"), connection));
			esame.setModifiedBy(UtenteDAO.getUtenteAll(rs.getInt("modified_by"), connection));
		}
		return esame;
	}
	
	
	public static void update(String dataEsito, String diagnosiNonTumorale, String descrizioneMorfologica, int id, Connection connection, int tipoDiagnosi, int idWhoUmana, int userId) throws SQLException, ParseException 
	{

		String sql = "update esame_istopatologico set descrizione_morfologica = ?,who_umana = ?,tipo_diagnosi = ?, modified = current_timestamp, modified_by = ?, diagnosi_non_tumorale = ?, data_esito= ? where id = ? ";
		PreparedStatement st = connection.prepareStatement(sql);
		st.setString	( 1, descrizioneMorfologica);
		if(tipoDiagnosi!=1)
			st.setObject		( 2, null);
		else if(tipoDiagnosi==1)
			st.setInt		( 2, idWhoUmana);
		st.setInt		( 3, tipoDiagnosi);
		st.setInt		( 4, userId);
		st.setString	( 5, diagnosiNonTumorale);
		
		if(dataEsito!=null)
		{
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			java.sql.Date data = new java.sql.Date(sdf.parse(dataEsito).getTime());
			st.setDate	( 6, data);
		}
		else
			st.setObject		( 6, null);
		
		st.setInt	( 7, id);
		st.executeUpdate();
		st.close();
	}
	
	
	
	
	
	
	private static LookupEsameObiettivoEsito getLookupEsameObiettivoEsito( ResultSet rs ) throws SQLException
	{
		LookupEsameObiettivoEsito esito = new LookupEsameObiettivoEsito();
		esito.setId(rs.getInt("id_eo_esito"));
		esito.setDescription(rs.getString("description_eo_esito"));
		esito.setEnabled(rs.getBoolean("enabled_eo_esito"));
		esito.setLevel(rs.getInt("level_eo_esito"));
		return esito;
	}
	
	
}

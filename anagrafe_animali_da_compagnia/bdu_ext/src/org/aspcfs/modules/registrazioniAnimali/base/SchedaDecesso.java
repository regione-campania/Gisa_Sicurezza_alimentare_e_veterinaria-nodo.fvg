package org.aspcfs.modules.registrazioniAnimali.base;

import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.GestoreConnessioni;
import org.aspcfs.utils.web.PagedListInfo;

import com.darkhorseventures.framework.beans.GenericBean;

public class SchedaDecesso extends GenericBean 
{

	private static Logger log = Logger.getLogger(SchedaDecesso.class);
	static 
	{
		if (System.getProperty("DEBUG") != null) 
		{
			log.setLevel(Level.DEBUG);
		}
	}
	
	private int id;
	private int idAnimale;
	private Animale animale;
	private java.sql.Timestamp entered;
	private java.sql.Timestamp modified;
	private int enteredBy;
	private User userEnteredBy;
	private int modifiedBy;
	private User userModifiedBy;
	private java.sql.Timestamp trashedDate;
	private java.sql.Timestamp dataDecesso;
	private java.sql.Timestamp dataEsitoIstologico;
	private int idCausa;
	private int idNeoplasia;
	private int idTipoDiagnosiIstologica;
	private int idDiagnosiCitologica;
	private int idDiagnosiIstologica;
	private String noteCausaDecesso;
	private String noteNeoplasia;
	private String descMorfologicaIstologico;
	private String noteDiagnosiIstologicaTumorali;
	private PagedListInfo pagedListInfo = null;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public int getIdAnimale() {
		return idAnimale;
	}

	public void setIdAnimale(int idAnimale) {
		this.idAnimale = idAnimale;
	}
	
	public Animale getAnimale() {
		return animale;
	}

	public void setAnimale(Animale animale) {
		this.animale = animale;
	}

	public void setIdAnimale(String idAnimale) {
		this.idAnimale = new Integer(idAnimale).intValue();
	}
	
	public java.sql.Timestamp getEntered() {
		return entered;
	}

	public void setEntered(Timestamp entered) 
	{
		this.entered = entered;
	}
	
	public java.sql.Timestamp getModified() {
		return modified;
	}

	public void setModified(Timestamp modified) 
	{
		this.modified = modified;
	}

	public void setEnteredBy(int enteredBy) 
	{
		this.enteredBy = enteredBy;
	};
	
	public int getEnteredBy() {
		return enteredBy;
	}
	
	public void setUserEnteredBy(User userEnteredBy) 
	{
		this.userEnteredBy = userEnteredBy;
	};
	
	public User getUserEnteredBy() {
		return userEnteredBy;
	}

	
	public int getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) 
	{
		this.modifiedBy = modifiedBy;
	}
	
	public User getUserModifiedBy() {
		return userModifiedBy;
	}

	public void setUserModifiedBy(User userModifiedBy) 
	{
		this.userModifiedBy = userModifiedBy;
	}
	
	public java.sql.Timestamp getTrashedDate() {
		return trashedDate;
	}

	public void setTrashedDate(String trashedDate) 
	{
		this.trashedDate = DateUtils.parseDateStringNew(trashedDate, "dd/MM/yyyy");
	}
	

	public java.sql.Timestamp getDataDecesso() {
		return dataDecesso;
	}

	public void setDataDecesso(java.sql.Timestamp dataDecesso) {
		this.dataDecesso = dataDecesso;
	}

	public void setDataDecesso(String data) {
		this.dataDecesso = DateUtils.parseDateStringNew(data, "dd/MM/yyyy");
	}
	
	public java.sql.Timestamp getDataEsitoIstologico() {
		return dataEsitoIstologico;
	}

	public void setDataEsitoIstologico(java.sql.Timestamp dataEsitoIstologico) {
		this.dataEsitoIstologico = dataEsitoIstologico;
	}

	public void setDataEsitoIstologico(String data) {
		this.dataEsitoIstologico = DateUtils.parseDateStringNew(data, "dd/MM/yyyy");
	}
	public String getDescMorfologicaIstologico() {
		return descMorfologicaIstologico;
	}

	public void setDescMorfologicaIstologico(String descMorfologicaIstologico) {
		this.descMorfologicaIstologico = descMorfologicaIstologico;
	}
	public int getIdTipoDiagnosiIstologica() {
		return idTipoDiagnosiIstologica;
	}

	public void setIdTipoDiagnosiIstologica(int idTipoDiagnosiIstologica) {
		this.idTipoDiagnosiIstologica = idTipoDiagnosiIstologica;
	}
	public String getNoteDiagnosiIstologicaTumorali() {
		return noteDiagnosiIstologicaTumorali;
	}

	public void setNoteDiagnosiIstologicaTumorali(String noteDiagnosiIstologicaTumorali) {
		this.noteDiagnosiIstologicaTumorali = noteDiagnosiIstologicaTumorali;
	}
	
	
	public int getIdCausa() {
		return idCausa;
	}

	public void setIdCausa(int idCausa) {
		this.idCausa = idCausa;
	}
	
	public int getIdNeoplasia() {
		return idNeoplasia;
	}

	public void setIdNeoplasia(int idNeoplasia) {
		this.idNeoplasia = idNeoplasia;
	}
	
	public int getIdDiagnosiCitologica() {
		return idDiagnosiCitologica;
	}

	public void setIdDiagnosiCitologica(int idDiagnosiCitologica) {
		this.idDiagnosiCitologica = idDiagnosiCitologica;
	}
	
	public int getIdDiagnosiIstologica() {
		return idDiagnosiIstologica;
	}

	public void setIdDiagnosiIstologica(int idDiagnosiIstologica) {
		this.idDiagnosiIstologica = idDiagnosiIstologica;
	}
	
	public String getNoteNeoplasia() {
		return noteNeoplasia;
	}

	public void setNoteNeoplasia(String noteNeoplasia) {
		this.noteNeoplasia = noteNeoplasia;
	}
	
	public String getNoteCausaDecesso() {
		return noteCausaDecesso;
	}

	public void setNoteCausaDecesso(String noteCausaDecesso) {
		this.noteCausaDecesso = noteCausaDecesso;
	}
	
	public boolean insert(Connection db) throws SQLIntegrityConstraintViolationException, SQLException 
	{

		StringBuffer sql = new StringBuffer();

		
		id = DatabaseUtils.getNextSeqPostgres(db, "scheda_decesso_id_seq");

		sql.append("INSERT INTO scheda_decesso( ");

		if (id > -1) 
		{
			sql.append("id, ");
		}

		
		sql.append("id_animale,entered,modified,entered_by,modified_by, id_causa, data_decesso, id_neoplasia,note_neoplasia, note_causa_decesso, id_diagnosi_citologica, id_diagnosi_istologica, data_esito_istologico,desc_morfologica_stologico, id_tipo_dagnosi_istologica, note_diagnosi_istologica_tumorali ) VALUES (");

		if (id > -1) 
		{
			sql.append("?, ");
		}

		sql.append("?,now(),now(),?,? , ?,?,?,?,?,?,?,?,?,?,?)");
		
		int i = 0;
		PreparedStatement pst = db.prepareStatement(sql.toString());

		if (id > 0) 
		{
			pst.setInt(++i, id);
		}

		pst.setInt(++i, idAnimale);
		pst.setInt(++i, enteredBy);
		pst.setInt(++i, modifiedBy);
		if(idCausa>0)
			pst.setInt(++i, idCausa);
		else
			pst.setObject(++i, null);
		pst.setTimestamp(++i, dataDecesso);
		pst.setInt(++i, idNeoplasia);
		pst.setString(++i, noteNeoplasia);
		pst.setString(++i, noteCausaDecesso);
		pst.setInt(++i, idDiagnosiCitologica);
		pst.setInt(++i, idDiagnosiIstologica);
		pst.setTimestamp(++i, dataEsitoIstologico);
		pst.setString(++i, descMorfologicaIstologico);
		pst.setInt(++i, idTipoDiagnosiIstologica);
		pst.setString(++i, noteDiagnosiIstologicaTumorali);

		pst.execute();
		pst.close();

		this.id = DatabaseUtils.getCurrVal(db, "scheda_decesso_id_seq", id);

		return true;

	}

	public SchedaDecesso() throws SQLException 
	{}
	
	public SchedaDecesso getById(Connection db, int id) throws SQLException 
	{
		SchedaDecesso scheda = null;
		if (id == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement("Select * from get_schede_decesso(?,-1,-1,-1)");
		pst.setInt(1, id);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) 
		{
			scheda = new SchedaDecesso();
			scheda.buildRecord(db, rs);
		}

		rs.close();
		pst.close();
		
		return scheda;
	}
	
	public SchedaDecesso getByIdAnimale(Connection db, int idAnimale) throws SQLException 
	{
		SchedaDecesso scheda = null;
		
		if (idAnimale == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement(" Select * from get_schede_decesso(-1,?,-1,-1) " );
		pst.setInt(1, idAnimale);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if(rs.next()) 
		{
			scheda = new SchedaDecesso();
			scheda.buildRecord(db, rs);
		}

		rs.close();
		pst.close();
		
		return scheda;
	}
	
	
	public SchedaDecessoList getSchede(Connection db, int idAnimale, int idUtente,int idAsl) throws SQLException 
	{
		SchedaDecessoList schede = new SchedaDecessoList();
		
		PreparedStatement pst = db.prepareStatement("  Select * from get_schede_decesso(-1,?,?,?) " );
		pst.setInt(1, idAnimale);
		pst.setInt(2, idUtente);
		pst.setInt(3, idAsl);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);

		while (rs.next())
		{
			SchedaDecesso scheda = new SchedaDecesso();
			scheda.buildRecord(db, rs);
			schede.add(scheda);
		}
		
		rs.close();
		pst.close();
		
		
		return schede;
	}
	
	
	public SchedaDecessoList getSchede(Connection db, int idAnimale, int idUtente,int idAsl, String microchip, Timestamp dataDa, Timestamp dataA, Boolean flagDecesso) throws SQLException 
	{
		SchedaDecessoList schede = new SchedaDecessoList();
		
		PreparedStatement pst = db.prepareStatement("  Select * from get_schede_decesso(-1,?,?,?,?,?,?,?) " );
		pst.setInt(1, idAnimale);
		pst.setInt(2, idUtente);
		pst.setInt(3, idAsl);
		pst.setString(4, microchip);
		if(dataDa==null)
			pst.setObject(5, null);
		else
			pst.setTimestamp(5, dataDa);
		
		if(dataA==null)
			pst.setObject(6, null);
		else
			pst.setTimestamp(6, dataA);
		
		if(flagDecesso==null)
			pst.setObject(7, null);
		else
			pst.setBoolean(7, flagDecesso);
		
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);

		while (rs.next())
		{
			SchedaDecesso scheda = new SchedaDecesso();
			scheda.buildRecord(db, rs);
			schede.add(scheda);
		}
		
		rs.close();
		pst.close();
		
		
		return schede;
	}
	
	
	
	public SchedaDecesso(Connection db, ResultSet rs) throws SQLException 
	{
		this.buildRecord(db, rs);
	}

	private void buildRecord(Connection db, ResultSet rs) throws SQLException 
	{
		if (rs.getInt("id_animale") > 0) 
		{
			Animale animale = new Animale();
			animale.setMicrochip(rs.getString("microchip"));
			animale.setIdSpecie(rs.getInt("id_specie"));
			animale.setIdRazza(rs.getInt("id_razza"));
			animale.setDataNascita(rs.getTimestamp("data_nascita"));
			animale.setSesso(rs.getString("sesso"));
			animale.setIdTipoMantello(rs.getInt("id_tipo_mantello"));
			animale.setIdTaglia(rs.getInt("id_taglia"));
			animale.setFlagSterilizzazione(rs.getBoolean("flag_sterilizzazione"));
			animale.setDataSterilizzazione(rs.getTimestamp("data_sterilizzazione"));
			animale.setUbicazione(rs.getString("ubicazione"));
			animale.setIdAnimale(rs.getInt("id_animale"));
			this.setAnimale(animale);
	
	
		}
		if (rs.getInt("entered_by") > 0) 
		{
			this.userEnteredBy = new User(db, rs.getInt("entered_by"));
		}
		if (rs.getInt("modified_by") > 0) 
		{
			this.userModifiedBy = new User(db, rs.getInt("modified_by"));
		}

		
		this.setUserEnteredBy(userEnteredBy);
		this.setUserModifiedBy(userModifiedBy);
		this.setId(rs.getInt("id"));
		this.setIdAnimale(rs.getInt("id_animale"));
		this.setEntered(rs.getTimestamp("entered"));
		this.setModified(rs.getTimestamp("modified"));
		this.setEnteredBy(rs.getInt("entered_by"));
		this.setModifiedBy(rs.getInt("modified_by"));
		this.setIdCausa(rs.getInt("id_causa"));
		this.setIdNeoplasia(rs.getInt("id_neoplasia"));
		this.setIdDiagnosiCitologica(rs.getInt("id_diagnosi_citologica"));
		this.setIdDiagnosiIstologica(rs.getInt("id_diagnosi_istologica"));
		this.setNoteCausaDecesso(rs.getString("note_causa_decesso"));
		this.setNoteNeoplasia(rs.getString("note_neoplasia"));
		this.setDataDecesso(rs.getTimestamp("data_decesso"));
		this.setDataEsitoIstologico(rs.getTimestamp("data_esito_istologico"));
		this.setDescMorfologicaIstologico(rs.getString("desc_morfologica_stologico"));
		this.setIdTipoDiagnosiIstologica(rs.getInt("id_tipo_dagnosi_istologica"));
		this.setNoteDiagnosiIstologicaTumorali(rs.getString("note_diagnosi_istologica_tumorali"));
	}
	
	
	public void setPagedListInfo(PagedListInfo tmp) {
		this.pagedListInfo = tmp;
	}
	public PagedListInfo getPagedListInfo() {
		return pagedListInfo;
	}
	
	
	
	public String getInformazioniInserimentoRecord() throws UnknownHostException 
	{
		String toReturn = "";
		Connection db = null;
		try {

			db = GestoreConnessioni.getConnection();
			User user = new User();
			user.setBuildContact(true);
			if (this.getEnteredBy() > 0)
			{
				user.buildRecord(db, this.getEnteredBy());
				toReturn = user.getContact().getNameFull() + " " + new SimpleDateFormat("dd/MM/yyyy").format(this.getEntered());
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		} finally 
		{
			GestoreConnessioni.freeConnection(db);
		}

		return toReturn;

	}
	
	
	public String getNomeCognome() throws UnknownHostException 
	{
		String toReturn = "";
		Connection db = null;
		try {

			db = GestoreConnessioni.getConnection();
			User user = new User();
			user.setBuildContact(true);
			if (this.getEnteredBy() > 0)
			{
				user.buildRecord(db, this.getEnteredBy());
				toReturn = user.getContact().getNameFull();
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		} finally 
		{
			GestoreConnessioni.freeConnection(db);
		}

		return toReturn;

	}
	
	public String getCodiceFiscale() throws UnknownHostException 
	{
		String toReturn = "";
		Connection db = null;
		try {

			db = GestoreConnessioni.getConnection();
			User user = new User();
			user.setBuildContact(true);
			if (this.getEnteredBy() > 0)
			{
				user.buildRecord(db, this.getEnteredBy());
				toReturn = user.getContact().getCodiceFiscale();
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		} finally 
		{
			GestoreConnessioni.freeConnection(db);
		}

		return toReturn;

	}
	
}

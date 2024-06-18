package org.aspcfs.modules.registrazioniAnimali.base;

import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.modules.anagrafe_animali.base.Cane;
import org.aspcfs.modules.anagrafe_animali.base.Furetto;
import org.aspcfs.modules.anagrafe_animali.base.Gatto;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.opu.base.LineaProduttiva;
import org.aspcfs.modules.opu.base.Operatore;
import org.aspcfs.modules.opu.base.Stabilimento;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.GestoreConnessioni;

public class EventoAdozioneAffido extends Evento {

	public static final int idTipologiaDB = 70;

	private int id = -1;
	private int idEvento = -1;
	private java.sql.Timestamp dataAdozione;
	private int idAssociazione = -1;
	private int idDetentore = -1;
	private int idVecchioDetentore = -1; // canile
	private int idAslDestinatariaAdozione = -1;

	public EventoAdozioneAffido() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdEvento() {
		return idEvento;
	}

	public void setIdEvento(int idEvento) {
		this.idEvento = idEvento;
	}
	
	public int getIdAslDestinatariaAdozione() {
		return idAslDestinatariaAdozione;
	}

	public void setIdAslDestinatariaAdozione(int idAsl) {
		this.idAslDestinatariaAdozione = idAsl;
	}

	public void setIdAslDestinatariaAdozione(String idAsl) {
		this.idAslDestinatariaAdozione = new Integer(idAsl).intValue();
	}

	public java.sql.Timestamp getDataAdozione() {
		return dataAdozione;
	}

	public void setDataAdozione(java.sql.Timestamp dataAdozione) {
		this.dataAdozione = dataAdozione;
	}

	public void setDataAdozione(String dataAdozione) {
		this.dataAdozione = DateUtils.parseDateStringNew(dataAdozione,
				"dd/MM/yyyy");
	}


	public int getIdDetentore() {
		return idDetentore;
	}

	public void setIdDetentore(int idDetentore) {
		this.idDetentore = idDetentore;
	}

	public void setIdDetentore(String idDetentore) {
		this.idDetentore = new Integer(idDetentore).intValue();
	}

	public int getIdVecchioDetentore() {
		return idVecchioDetentore;
	}

	public void setIdVecchioDetentore(int idVecchioDetentore) {
		this.idVecchioDetentore = idVecchioDetentore;
	}

	public void setIdVecchioProprietario(String idVecchioDetentore) {
		this.idVecchioDetentore = new Integer(idVecchioDetentore).intValue();
	}
	
	public int getIdAssociazione() {
		return idAssociazione;
	}

	public void setIdAssociazione(int idAssociazione) {
		this.idAssociazione = idAssociazione;
	}

	public boolean insert(Connection db) throws SQLException {

		StringBuffer sql = new StringBuffer();
	
		try {

			super.insert(db);
			idEvento = super.getIdEvento();

			

			id = DatabaseUtils.getNextSeq(db,
					"evento_adozione_affido_id_seq");
			// sql.append("INSERT INTO animale (");

			sql.append(" INSERT INTO evento_adozione_affido("
					+ "id_evento, data_adozione");

			
			if (idAslDestinatariaAdozione > -1) {
				sql.append(",id_asl_destinataria_adozione");
			}

			if (idDetentore > -1) {
				sql.append(",id_detentore");
			}

			if (idVecchioDetentore > -1) {
				sql.append(", id_vecchio_detentore");
			}
			
			if (idDetentore > -1) {
				sql.append(", id_associazione");
			}

			sql.append(")VALUES(?,?");
			

			if (idAslDestinatariaAdozione > -1) {
				sql.append(",?");
			}

			if (idDetentore > -1) {
				sql.append(",?");
			}

			if (idVecchioDetentore > -1) {
				sql.append(", ?");
			}
				
			if (idDetentore > -1) {
				sql.append(", (select id_associazione from opu_informazioni_privato where id_privato = ? and id_associazione > 0)");	
			}
			
			sql.append(")");

			int i = 0;
			PreparedStatement pst = db.prepareStatement(sql.toString());

			pst.setInt(++i, idEvento);

			pst.setTimestamp(++i, dataAdozione);

			if (idAslDestinatariaAdozione > -1) {
				pst.setInt(++i, idAslDestinatariaAdozione);
			}
			
			if (idDetentore > -1) {
				pst.setInt(++i, idDetentore);
			}

			if (idVecchioDetentore > -1) {
				pst.setInt(++i, idVecchioDetentore);
			}

			
			if (idDetentore > -1) {
				pst.setInt(++i, idDetentore);
			}
			pst.execute();
			pst.close();

			this.id = DatabaseUtils.getCurrVal(db,
					"evento_adozione_affido_id_seq", id);


		} catch (SQLException e) {
		
			throw new SQLException(e.getMessage());
		} finally {
		
		}
		return true;

	}

	public EventoAdozioneAffido(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}

	protected void buildRecord(ResultSet rs) throws SQLException {

		super.buildRecord(rs);
		this.idEvento = rs.getInt("idevento");
		this.dataAdozione = rs.getTimestamp("data_adozione");
		this.idDetentore = rs.getInt("id_detentore");
		this.idVecchioDetentore = rs.getInt("id_vecchio_detentore");
		this.idAssociazione = rs.getInt("id_associazione");
		this.idAslDestinatariaAdozione = rs.getInt("id_asl_destinataria_adozione");
	}
	
	public EventoAdozioneAffido(Connection db, int idEventoPadre) throws SQLException {

		PreparedStatement pst = db.prepareStatement("Select *, e.id_evento as idevento, e.id_asl as idaslinserimentoevento from evento e left join evento_adozione_affido f on (e.id_evento = f.id_evento) where e.id_evento = ?");
		pst.setInt(1, idEventoPadre);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) {
			buildRecord(rs);
		}

		if (idEventoPadre == -1) {
			throw new SQLException(Constants.NOT_FOUND_ERROR);
		}

		rs.close();
		pst.close();
	}

	
	public Operatore getCanileProvenienza() throws UnknownHostException {
		
		Connection conn = null;
		int idOperatore = -1;
		Operatore operatore = null;
		try {
			//Thread t = Thread.currentThread();
			conn = GestoreConnessioni.getConnection();
//			String dbName = ApplicationProperties.getProperty("dbnameBdu");
//			String username = ApplicationProperties
//					.getProperty("usernameDbbdu");
//			String pwd = ApplicationProperties.getProperty("passwordDbbdu");
//			String host = InetAddress.getByName("hostDbBdu").getHostAddress();
//
//			conn = DbUtil.getConnection(dbName, username, pwd, host);



		
				idOperatore = this.getIdVecchioDetentore();
				

			

			if (idOperatore != -1 && idOperatore != 0) {
			//	
				operatore = new Operatore();
				operatore
						.queryRecordOperatorebyIdLineaProduttiva(conn,
								idOperatore);
			}

			//GestoreConnessioni.freeConnection(conn);
			//DbUtil.chiudiConnessioneJDBC(null, null, conn);
			//conn = null;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			GestoreConnessioni.freeConnection(conn);
		}

		return operatore;
	}
	
	
	public Operatore getSindacoProvenienza() throws UnknownHostException {
		
		Connection conn = null;
		int idOperatore = -1;
		Operatore operatore = null;
		try {
			//Thread t = Thread.currentThread();
			conn = GestoreConnessioni.getConnection();
//			String dbName = ApplicationProperties.getProperty("dbnameBdu");
//			String username = ApplicationProperties
//					.getProperty("usernameDbbdu");
//			String pwd = ApplicationProperties.getProperty("passwordDbbdu");
//			String host = InetAddress.getByName("hostDbBdu").getHostAddress();
//
//			conn = DbUtil.getConnection(dbName, username, pwd, host);



		
				idOperatore = this.getIdProprietarioCorrente();
				

			

			if (idOperatore != -1 && idOperatore != 0) {
			//	
				operatore = new Operatore();
				operatore
						.queryRecordOperatorebyIdLineaProduttiva(conn,
								idOperatore);
			}

			//GestoreConnessioni.freeConnection(conn);
			//DbUtil.chiudiConnessioneJDBC(null, null, conn);
		//	conn = null;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			GestoreConnessioni.freeConnection(conn);
		}

		return operatore;
	}
	
	
	public Operatore getNuovoProprietario() throws UnknownHostException {
		
		Connection conn = null;
		int idOperatore = -1;
		Operatore operatore = null;
		try {
			//Thread t = Thread.currentThread();
			conn = GestoreConnessioni.getConnection();
//			String dbName = ApplicationProperties.getProperty("dbnameBdu");
//			String username = ApplicationProperties
//					.getProperty("usernameDbbdu");
//			String pwd = ApplicationProperties.getProperty("passwordDbbdu");
//			String host = InetAddress.getByName("hostDbBdu").getHostAddress();
//
//			conn = DbUtil.getConnection(dbName, username, pwd, host);



		
				idOperatore = this.getIdProprietarioCorrente();
				

			

			if (idOperatore != -1 && idOperatore != 0) {
			//	
				operatore = new Operatore();
				operatore.queryRecordOperatorebyIdLineaProduttiva(conn,idOperatore);
			}

			//GestoreConnessioni.freeConnection(conn);
			//DbUtil.chiudiConnessioneJDBC(null, null, conn);
			//conn = null;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			GestoreConnessioni.freeConnection(conn);
		}

		return operatore;
	}
	
	
	
public Operatore getNuovoDetentore() throws UnknownHostException {
		
		Connection conn = null;
		int idOperatore = -1;
		Operatore operatore = null;
		try {
			//Thread t = Thread.currentThread();
			conn = GestoreConnessioni.getConnection();
		
				idOperatore = this.getIdDetentore();
				
			if (idOperatore != -1 && idOperatore != 0) 
			{
				operatore = new Operatore();
				operatore.queryRecordOperatorebyIdLineaProduttiva(conn,idOperatore);
			}

		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			GestoreConnessioni.freeConnection(conn);
		}

		return operatore;
	}


	
	public void getEventoAdozione(Connection db, int idAnimale) throws SQLException {

		//	super(db, idEventoPadre);

			PreparedStatement pst = db
					.prepareStatement("Select f.*, e.*, e.id_evento as idevento,  e.id_asl as idaslinserimentoevento  from animale a left join  evento e on  (a.id = e.id_animale) left join evento_adozione_affido f on (e.id_evento = f.id_evento) where a.id = ? and e.id_tipologia_evento = ?");
			pst.setInt(1, idAnimale);
			pst.setInt(2, idTipologiaDB);
			ResultSet rs = DatabaseUtils.executeQuery(db, pst);
			if (rs.next()) {
				buildRecord(rs);
			}


			if (idAnimale == -1) {
				throw new SQLException(Constants.NOT_FOUND_ERROR);
			}

			rs.close();
			pst.close();
		}
	
	public EventoAdozioneAffido salvaRegistrazione(int userId,
			int userRole, int userAsl, Animale thisAnimale, Connection db)
			throws Exception {
		try {

			super.salvaRegistrazione(userId, userRole, userAsl, thisAnimale, db);
		//	
			Animale oldAnimale = new Animale(db, this.getIdAnimale());

			switch (this.getSpecieAnimaleId()) {
			case Cane.idSpecie:
				thisAnimale = new Cane(db, this.getIdAnimale());
				break;
			case Gatto.idSpecie:
				thisAnimale = new Gatto(db, this.getIdAnimale());
				break;
			case Furetto.idSpecie:
				thisAnimale = new Furetto(db, this.getIdAnimale());
				break;
			default:
				break;
			}


			if (oldAnimale.getDetentore() != null
					&& oldAnimale.getDetentore()
							.getListaStabilimenti().size() > 0) {
				Stabilimento stab = (Stabilimento) oldAnimale
						.getDetentore().getListaStabilimenti().get(0);
				LineaProduttiva lineaP = (LineaProduttiva) stab
						.getListaLineeProduttive().get(0);
				this.setIdVecchioDetentore(lineaP.getId());

			
			}
			Operatore newDet = new Operatore();
			newDet.queryRecordOperatorebyIdLineaProduttiva(db,this.getIdDetentore());
			Stabilimento stabDet = (Stabilimento) newDet.getListaStabilimenti().get(0);
			int idAsl = stabDet.getIdAsl();
			this.setIdAslDestinatariaAdozione(idAsl);
			thisAnimale.setIdDetentore(this.getIdDetentore());
			this.insert(db);
			
			aggiornaFlagFuoriDominioAsl(db, thisAnimale,  userAsl,  oldAnimale);
			aggiornaStatoAnimale(db, thisAnimale);

		} catch (Exception e) {
			throw e;
		}

		return this;

	}
	
	public EventoAdozioneAffido build(ResultSet rs) throws Exception{
		try{	
			
			super.build(rs);
			buildRecord(rs);
		
		}catch (Exception e){
			throw e;
		}
	return this;
		}
	
	
	public String getAssociazioneSocio(Connection db, Operatore op) throws SQLException {

		//	super(db, idEventoPadre);

			PreparedStatement pst = db
					.prepareStatement("select * from lookup_associazioni_animaliste laa join opu_informazioni_privato o on laa.code = o.id_associazione where o.id_privato =? ;");
			pst.setInt(1, op.getIdOperatore());
			ResultSet rs = DatabaseUtils.executeQuery(db, pst);
			if (rs.next()) {
				return rs.getString("description");
			}
			

			rs.close();
			pst.close();
			return "";
		}
	
	
	
	
}

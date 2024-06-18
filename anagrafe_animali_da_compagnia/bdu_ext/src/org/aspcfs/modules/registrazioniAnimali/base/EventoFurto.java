package org.aspcfs.modules.registrazioniAnimali.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.modules.anagrafe_animali.base.Cane;
import org.aspcfs.modules.anagrafe_animali.base.Furetto;
import org.aspcfs.modules.anagrafe_animali.base.Gatto;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;

public class EventoFurto extends Evento {
	
	public static final int idTipologiaDB = 4;
	
	
	private int id = -1;
	private java.sql.Timestamp dataFurto;
	private String luogoFurto; 
	private String datiDenuncia;
	private int idEvento;
		
	private int idComuneFurto;


	public int getIdComuneFurto() {
		return idComuneFurto;
	}

	public void setIdComuneFurto(int idComuneFurto) {
		this.idComuneFurto = idComuneFurto;
	}

	public void setIdComuneFurto(String idComuneFurto) {
		this.idComuneFurto = new Integer(idComuneFurto).intValue();
	}

		
		
		public EventoFurto() {
		super();
		// TODO Auto-generated constructor stub
	}
		public java.sql.Timestamp getDataFurto() {
			return dataFurto;
		}
		public void setDataFurto(java.sql.Timestamp dataFurto) {
			this.dataFurto = dataFurto;
		}
		
		public void setDataFurto(String dataFurto){
			this.dataFurto = DateUtils.parseDateStringNew(dataFurto, "dd/MM/yyyy");
		}
		public String getLuogoFurto() {
			return luogoFurto;
		}
		public void setLuogoFurto(String luogoFurto) {
			this.luogoFurto = luogoFurto;
		}
		public String getDatiDenuncia() {
			return datiDenuncia;
		}
		public void setDatiDenuncia(String datiDenuncia) {
			this.datiDenuncia = datiDenuncia;
		}
		public int getIdEvento() {
			return idEvento;
		}
		public void setIdEvento(int idEvento) {
			this.idEvento = idEvento;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public boolean insert(Connection db) throws SQLException {
			 
			 StringBuffer sql = new StringBuffer();
		    try {
		    
		    	super.insert(db);
		    	idEvento = super.getIdEvento();
		    	
		    	
			      
			      id = DatabaseUtils.getNextSeq(db, "evento_furto_id_seq");
			     // sql.append("INSERT INTO animale (");
			      

			      
			      
			      
			      sql.append("INSERT INTO evento_furto(id_evento, data_furto ");
			    		 
			      if ( luogoFurto != null && !"".equals(luogoFurto)){
			    	  sql.append(", luogo_furto");
			      }
			      
			      if (datiDenuncia != null && !"".equals(datiDenuncia)){
			    	  sql.append(", dati_denuncia");
			      }
			 
			    
			      /*SINAAF ADEGUAMENTO   */
					sql.append(", id_comune_furto");
			      
		
	          
	          sql.append(")VALUES(?,?");
	          
	          if ( luogoFurto != null && !"".equals(luogoFurto)){
	        	  sql.append(",?");
	          }
	          
	          if (datiDenuncia != null && !"".equals(datiDenuncia)){
	        	  sql.append(",?");
	          }
	          
	          /*SINAAF ADEGUAMENTO   */
			  sql.append(",?");
	          
	          sql.append(")");

			      int i = 0;
			      PreparedStatement pst = db.prepareStatement(sql.toString());
			      
			    
			      
			  
			    	  pst.setInt(++i, idEvento);
			      
			      
			      
			    	  pst.setTimestamp(++i, dataFurto);
			    	  
			          if ( luogoFurto != null && !"".equals(luogoFurto)){
			        	  pst.setString(++i, luogoFurto);
			          }
			          
			          if (datiDenuncia != null && !"".equals(datiDenuncia)){
			        	  pst.setString(++i, datiDenuncia);
			          }
			  		
						/*SINAAF ADEGUAMENTO   */
					pst.setInt(++i, idComuneFurto);
			      
			      pst.execute();
			      pst.close();

			      this.id = DatabaseUtils.getCurrVal(db, "evento_furto_id_seq", id);
			    
			    	   
			   	    } catch (SQLException e) {
			   	    
			   	      throw new SQLException(e.getMessage());
			   	    } finally {
			   	    	
			   	    }
			   	    return true;
			   	  
			   	 }
		


		
		  public EventoFurto(ResultSet rs) throws SQLException {
			    buildRecord(rs);
			  }
		  
		  protected void buildRecord(ResultSet rs) throws SQLException {
			  
			  super.buildRecord(rs);
			  this.idEvento = rs.getInt("idevento");
			  this.dataFurto = rs.getTimestamp("data_furto");
			  this.luogoFurto = rs.getString("luogo_furto");
			  this.datiDenuncia = rs.getString("dati_denuncia");
			  this.idComuneFurto = rs.getInt("id_comune_furto");
			  
			//  buildSede(rs);
			//  buildRappresentanteLegale(rs);

			  
			  
		  }
		  
/*		 public static ArrayList getFields(Connection db){
			 
			 ArrayList fields = new ArrayList();
			 HashMap fields1 = new HashMap();
			 fields1.put("name", "dataFurto");
			 fields1.put("type", "data");
			 fields1.put("label", "Data furto");
			 fields.add(fields1);
			 
			 
			 
			 fields1 = new HashMap();
			 fields1.put("name", "luogoFurto");
			 fields1.put("type", "text");
			 fields1.put("label", "Luogo del furto");			 
			 fields.add(fields1);
			 
			 
			 fields1 = new HashMap();
			 fields1.put("name", "datiDenuncia");
			 fields1.put("type", "text");
			 fields1.put("label", "Dati della denuncia");			 
			 fields.add(fields1);
			 
			 
			

			 
			
			 
			 
			 return fields;
		 }*/
		  
		  
			public EventoFurto(Connection db, int idEventoPadre) throws SQLException {

				//super(db, idEventoPadre);

				PreparedStatement pst = db
						.prepareStatement("Select *, e.id_evento as idevento, e.id_asl as idaslinserimentoevento from evento e left join evento_furto f on (e.id_evento = f.id_evento) where e.id_evento = ?");
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
			
			public EventoFurto salvaRegistrazione(int userId, int userRole, int userAsl, Animale thisAnimale, Connection db) throws Exception{
				try{	
					
					super.salvaRegistrazione(userId, userRole, userAsl, thisAnimale, db);
					 
					Animale oldAnimale = new Animale(db, this.getIdAnimale());
					
					switch (this.getSpecieAnimaleId()) {
					case Cane.idSpecie:
						thisAnimale = new Cane(db,
								this.getIdAnimale());
						break;
					case Gatto.idSpecie:
						thisAnimale = new Gatto(db,
								this.getIdAnimale());
						break;
					case Furetto.idSpecie:
						thisAnimale = new Furetto(db,
								this.getIdAnimale());
						break;
					default:
						break;
					}
					
					this.insert(db);

					thisAnimale.setFlagFurto(true);
					


										
					aggiornaFlagFuoriDominioAsl(db, thisAnimale,  userAsl,  oldAnimale);
					aggiornaStatoAnimale(db, thisAnimale);
				
				}catch (Exception e){
					throw e;
				}
			return this;
				}

			
			public EventoFurto build(ResultSet rs) throws Exception{
				try{	
					
					super.build(rs);
					buildRecord(rs);
				
				}catch (Exception e){
					throw e;
				}
			return this;
				}
			
			
			public void getEventoFurto(Connection db, int idAnimale) throws SQLException {

				// super(db, idEventoPadre);

				PreparedStatement pst = db
						.prepareStatement("Select f.*, e.*, e.id_evento as idevento,  e.id_asl as idaslinserimentoevento  from animale a left join  evento e on  (a.id = e.id_animale) left join evento_furto f on (e.id_evento = f.id_evento) where a.id = ? and e.id_tipologia_evento = ?");
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

}

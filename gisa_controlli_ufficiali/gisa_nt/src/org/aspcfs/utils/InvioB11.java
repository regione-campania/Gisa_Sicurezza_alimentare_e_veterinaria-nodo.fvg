package org.aspcfs.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.darkhorseventures.framework.actions.ActionContext;

public class InvioB11 {

	private int id = -1;
	private java.sql.Timestamp dataOp = null;
	private String inviato_da = null;
	private int tot_cu = 0;
	
	public InvioB11() {}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public java.sql.Timestamp getDataOp() {
		return dataOp;
	}
	public void setDataOp(java.sql.Timestamp dataOp) {
		this.dataOp = dataOp;
	}
	public String getInviato_da() {
		return inviato_da;
	}
	public void setInviato_da(String inviato_da) {
		this.inviato_da = inviato_da;
	}
	public int getTot_cu() {
		return tot_cu;
	}
	public void setTot_cu(int tot_cu) {
		this.tot_cu = tot_cu;
	}
	

	public boolean insertB11(Connection db,ActionContext context) throws SQLException {
		
		PreparedStatement pst = null;
		pst = db.prepareStatement(
				"INSERT INTO invio_massivo_b11 " +
				"( id, data," +
				"  tot_cu, " +
				"  inviato_da) " +
				"  VALUES ( ?, ?, ?, ?);" );

		int i = 0;
		id = DatabaseUtils.getNextSeqInt(db,context, "invio_massivo_b11","id");
		pst.setInt(++i, id);
		pst.setTimestamp(++i, this.getDataOp());
		pst.setInt(++i, tot_cu);
		pst.setString(++i, inviato_da);	
		pst.execute();
		System.out.println("Query insert in invio_massivo_B11: "+pst.toString());
		pst.close();

		return true;
	}
	
	
}

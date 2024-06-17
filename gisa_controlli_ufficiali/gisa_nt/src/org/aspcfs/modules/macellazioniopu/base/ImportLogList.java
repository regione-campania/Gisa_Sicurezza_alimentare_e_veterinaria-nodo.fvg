package org.aspcfs.modules.macellazioniopu.base;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class ImportLogList extends Vector  {

	
	public void creaElenco(ResultSet rs) throws SQLException{
		
		 while (rs.next()){
			    ImportLog log = new ImportLog(rs);
			    this.add(log);
		 }
			    }

}

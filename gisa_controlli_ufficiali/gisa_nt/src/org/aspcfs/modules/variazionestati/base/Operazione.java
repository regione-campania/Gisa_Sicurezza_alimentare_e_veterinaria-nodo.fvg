package org.aspcfs.modules.variazionestati.base;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Operazione {

private int code;
private String description;


public Operazione(ResultSet rs) throws SQLException {
setCode(rs.getInt("code"));
description = rs.getString("description");

}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}
public int getCode() {
	return code;
}
public void setCode(int code) {
	this.code = code;
}


	
	
	
	
	
	
	
	
}

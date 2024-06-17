package org.aspcfs.utils;

public class DataVolturaException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public DataVolturaException(String msg) {
		super(msg);
	}

	@Override
	public String toString() {
		return super.getMessage();
	}
	
	
	
}

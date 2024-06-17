package org.aspcfs.modules.molluschibivalvi.base;

import java.io.Serializable;

public class Coordinate implements Serializable{

	public Coordinate() {
		// TODO Auto-generated constructor stub
	}
	private double latitudine ;
	private double longitudine ;
	public double getLatitudine() {
		return latitudine;
	}
	public void setLatitudine(double latitudine) {
		this.latitudine = latitudine;
	}
	public double getLongitudine() {
		return longitudine;
	}
	public void setLongitudine(double longitudine) {
		this.longitudine = longitudine;
	}
	
	

}

package it.us.web.bean.test;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

@Entity
@Table( name = "passwordeseeee" )
@Where( clause = "trashed_date is null" )
public class Password implements Serializable
{
	private static final long serialVersionUID = 6669556117729788677L;
	
	private int		id;
	private String	username;
	private Utente	utente;
	private Timestamp trashed_date;

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	@ManyToOne( fetch = FetchType.LAZY )
	public Utente getUtente() {
		return utente;
	}
	public void setUtente(Utente utente) {
		this.utente = utente;
	}
	protected Timestamp getTrashed_date() {
		return trashed_date;
	}
	protected void setTrashed_date(Timestamp trashed_date) {
		this.trashed_date = trashed_date;
	}
	
	
}

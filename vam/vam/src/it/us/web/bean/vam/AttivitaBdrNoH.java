package it.us.web.bean.vam;

import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

public class AttivitaBdrNoH implements java.io.Serializable
{
	private static final long serialVersionUID = 4218602302365729127L;
	
	private int id;
	private LookupOperazioniAccettazione operazioneBdr;
	private AccettazioneNoH accettazione;
	private CartellaClinicaNoH cc;
	private String descrizione;
	private String note;
	private Date entered;
	private Date modified;
	private Date trashedDate;
	private Integer idRegistrazioneBdr;
	private Integer enteredBy;
	private Integer modifiedBy;

	public AttivitaBdrNoH()
	{
		
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LookupOperazioniAccettazione getOperazioneBdr() {
		return this.operazioneBdr;
	}

	public void setOperazioneBdr(LookupOperazioniAccettazione operazioneBdr) {
		this.operazioneBdr = operazioneBdr;
	}

	public AccettazioneNoH getAccettazione() {
		return this.accettazione;
	}

	public void setAccettazione(AccettazioneNoH accettazione) {
		this.accettazione = accettazione;
	}
	
	public CartellaClinicaNoH getCc() {
		return this.cc;
	}

	public void setCc(CartellaClinicaNoH cc) {
		this.cc = cc;
	}

	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Date getEntered() {
		return this.entered;
	}

	public void setEntered(Date entered) {
		this.entered = entered;
	}

	public Date getModified() {
		return this.modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	public Date getTrashedDate() {
		return this.trashedDate;
	}

	public void setTrashedDate(Date trashedDate) {
		this.trashedDate = trashedDate;
	}

	public Integer getEnteredBy() {
		return this.enteredBy;
	}

	public void setEnteredBy(Integer enteredBy) {
		this.enteredBy = enteredBy;
	}

	public Integer getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(Integer modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	
	public Integer getIdRegistrazioneBdr() {
		return idRegistrazioneBdr;
	}

	public void setIdRegistrazioneBdr(Integer idRegistrazioneBdr) {
		this.idRegistrazioneBdr = idRegistrazioneBdr;
	}

}

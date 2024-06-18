package it.us.web.bean.vam;

import it.us.web.bean.BUtente;
import it.us.web.bean.BUtenteAll;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.lookup.LookupSpecieDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Type;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "esame_citologico", schema = "public")
@Where( clause = "trashed_date is null" )
public class EsameCitologico implements java.io.Serializable, EsameInterface
{
	private static final long serialVersionUID = -7105270997715736712L;

	private int id;
	private Animale animale;
	private LookupEsameCitologicoTipoPrelievo tipoPrelievo = new LookupEsameCitologicoTipoPrelievo();
	private String tipoPrelievoAltro;
	private String aspettoLesione;
	private LookupEsameCitologicoDiagnosi diagnosi = new LookupEsameCitologicoDiagnosi();
	private LookupEsameCitologicoDiagnosi diagnosiPadre = new LookupEsameCitologicoDiagnosi();
	private CartellaClinica cartellaClinica;
	private Date dataRichiesta;
	private Date dataEsito;
	private Date entered;
	private Date modified;
	private Date trashedDate;
//	private BUtente enteredBy;
//	private BUtente modifiedBy;
	
	private LookupStatoGenerale statoGeneraleLookup;
	
	
	private String peso;
	private Set<LookupAlimentazioni> lookupAlimentazionis = new HashSet<LookupAlimentazioni>(0);
	private Set<LookupAlimentazioniQualita> lookupAlimentazioniQualitas = new HashSet<LookupAlimentazioniQualita>(0);
	private Set<LookupHabitat> lookupHabitats = new HashSet<LookupHabitat>(0);
	
	private BUtenteAll enteredBy;
	private BUtenteAll modifiedBy;
	private boolean outsideCC;
	private Integer idDiagnosiPadre;


	public EsameCitologico()
	{
		
	}
	
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_alimentazioni_outside_esame_citologico", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "alimentazione", nullable = false, updatable = false) })
	public Set<LookupAlimentazioni> getLookupAlimentazionis() {
		return lookupAlimentazionis;
	}

	public void setLookupAlimentazionis(
			Set<LookupAlimentazioni> lookupAlimentazionis) {
		this.lookupAlimentazionis = lookupAlimentazionis;
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_alimentazioni_qualita_outside_esame_citologico", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "alimentazione", nullable = false, updatable = false) })
	public Set<LookupAlimentazioniQualita> getLookupAlimentazioniQualitas() {
		return lookupAlimentazioniQualitas;
	}

	public void setLookupAlimentazioniQualitas(
			Set<LookupAlimentazioniQualita> lookupAlimentazioniQualitas) {
		this.lookupAlimentazioniQualitas = lookupAlimentazioniQualitas;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_habitat_outside_esame_citologico", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "habitat", nullable = false, updatable = false) })
	public Set<LookupHabitat> getLookupHabitats() {
		return lookupHabitats;
	}

	public void setLookupHabitats(Set<LookupHabitat> lookupHabitats) {
		this.lookupHabitats = lookupHabitats;
	}
	
	

	@Override
	public String toString()
	{
		return getNumero();
	}
	
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	@Column(name = "id", unique = true, nullable = false)
	@NotNull
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "id_diagnosi_padre", unique = true, nullable = false)
	public Integer getIdDiagnosiPadre() {
		return this.idDiagnosiPadre;
	}

	public void setIdDiagnosiPadre(Integer idDiagnosiPadre) {
		this.idDiagnosiPadre = idDiagnosiPadre;
	}
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "cartella_clinica")
	public CartellaClinica getCartellaClinica() {
		return this.cartellaClinica;
	}

	public void setCartellaClinica(CartellaClinica cartellaClinica) {
		this.cartellaClinica = cartellaClinica;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_richiesta", length = 29)
	public Date getDataRichiesta() {
		return dataRichiesta;
	}

	public void setDataRichiesta(Date dataRichiesta) {
		this.dataRichiesta = dataRichiesta;
	}

	@Column(name = "outsideCC") 
	public boolean getOutsideCC() {
		return outsideCC;
	}
	
	@Column(name = "outsideCC") 
	public boolean isOutsideCC() {
		return outsideCC;
	}

	public void setOutsideCC(boolean outsideCC) {
		this.outsideCC = outsideCC;
	}
	
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_esito", length = 29)
	public Date getDataEsito() {
		return dataEsito;
	}

	public void setDataEsito(Date dataEsito) {
		this.dataEsito = dataEsito;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "entered", length = 29)
	public Date getEntered() {
		return this.entered;
	}

	public void setEntered(Date entered) {
		this.entered = entered;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "modified", length = 29)
	public Date getModified() {
		return this.modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "trashed_date", length = 29)
	public Date getTrashedDate() {
		return this.trashedDate;
	}

	public void setTrashedDate(Date trashedDate) {
		this.trashedDate = trashedDate;
	}

//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(name = "entered_by")
//	public BUtente getEnteredBy() {
//		return this.enteredBy;
//	}
//
//	public void setEnteredBy(BUtente enteredBy) {
//		this.enteredBy = enteredBy;
//	}
//
//
//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(name = "modified_by")
//	public BUtente getModifiedBy() {
//		return this.modifiedBy;
//	}
//
//	public void setModifiedBy(BUtente modifiedBy) {
//		this.modifiedBy = modifiedBy;
//	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tipo_prelievo")
	@NotNull(message="Selezionare il tipo di prelievo")
	public LookupEsameCitologicoTipoPrelievo getTipoPrelievo() {
		return tipoPrelievo;
	}

	public void setTipoPrelievo(LookupEsameCitologicoTipoPrelievo tipoPrelievo) {
		this.tipoPrelievo = tipoPrelievo;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "stato_generale_lookup")
	public LookupStatoGenerale getStatoGeneraleLookup() {
		return statoGeneraleLookup;
	}

	public void setStatoGeneraleLookup(LookupStatoGenerale statoGeneraleLookup) {
		this.statoGeneraleLookup = statoGeneraleLookup;
	}

	@Column(name = "tipo_prelievo_altro")
	@Type(type="text")
	public String getTipoPrelievoAltro() {
		return tipoPrelievoAltro;
	}

	public void setTipoPrelievoAltro(String tipoPrelievoAltro) {
		this.tipoPrelievoAltro = tipoPrelievoAltro;
	}

	@Column(name = "aspetto_lesione")
	@Type(type="text")
	public String getAspettoLesione() {
		return aspettoLesione;
	}

	public void setAspettoLesione(String aspettoLesione) {
		this.aspettoLesione = aspettoLesione;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "diagnosi")
	public LookupEsameCitologicoDiagnosi getDiagnosi() {
		return diagnosi;
	}

	public void setDiagnosi(LookupEsameCitologicoDiagnosi diagnosi) {
		this.diagnosi = diagnosi;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "diagnosi_padre")
	public LookupEsameCitologicoDiagnosi getDiagnosiPadre() {
		return diagnosiPadre;
	}

	public void setDiagnosiPadre(LookupEsameCitologicoDiagnosi diagnosiPadre) {
		this.diagnosiPadre = diagnosiPadre;
	}

	@Override
	@Transient
	public String getNomeEsame()
	{
		return "Citologico";
	}

	@Override
	@Transient
	public String getHtml()
	{
		return "<b>bla bla bla citologico</b>";
	}
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "entered_by")
	@NotNull

//	public BUtenteAll getEnteredBy() {
//		return this.enteredBy;
//	}
	
	public BUtente getEnteredBy() {
		return UtenteDAO.getUtente(enteredBy.getId());
	}

	public void setEnteredBy(BUtente enteredBy) {
		//this.enteredBy = enteredBy;
		this.enteredBy = UtenteDAO.getUtenteAll(enteredBy.getId());
	}
	
	
	public void setEnteredBy(BUtenteAll enteredBy) {
		//this.enteredBy = enteredBy;
		this.enteredBy = enteredBy;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "animale")
	public Animale getAnimale() {
		return animale;
	}

	public void setAnimale(Animale animale) {
		this.animale = animale;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "modified_by")
	public BUtenteAll getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(BUtente modifiedBy) {
	//	this.modifiedBy = modifiedBy;
	this.modifiedBy =	UtenteDAO.getUtenteAll(modifiedBy.getId());
	}
	
	
	public void setModifiedBy(BUtenteAll modifiedBy) {
	//	this.modifiedBy = modifiedBy;
	this.modifiedBy =	modifiedBy;
	}
	
	
	@Transient
	public String getIdentificativoAnimale() 
	{
		if(outsideCC)
		{
			if(animale!=null)
				return animale.getIdentificativo();
		}
		else
		{
			if(cartellaClinica!=null && cartellaClinica.getAccettazione()!=null && cartellaClinica.getAccettazione().getAnimale()!=null)
				return cartellaClinica.getAccettazione().getAnimale().getIdentificativo();
		}
		return "";
	
	}
	
	
	@Column(name = "peso")
	public String getPeso() {
		return peso;
	}

	public void setPeso(String peso) {
		this.peso = peso;
	}
	
	
	@Transient
	public String getNumero() {
		final DecimalFormat decimalFormat = new DecimalFormat( "000000" );
		
		return "CIT"+decimalFormat.format(id);
	}

	
}

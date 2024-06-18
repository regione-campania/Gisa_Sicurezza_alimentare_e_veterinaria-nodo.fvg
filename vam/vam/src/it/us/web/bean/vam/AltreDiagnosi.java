package it.us.web.bean.vam;

import it.us.web.bean.BUtente;
import it.us.web.bean.BUtenteAll;
import it.us.web.bean.sinantropi.lookup.LookupSinantropiEta;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupCMI;
import it.us.web.bean.vam.lookup.LookupComuni;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupMantelli;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.bean.vam.lookup.LookupRazze;
import it.us.web.bean.vam.lookup.LookupSpecie;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.constants.IdRichiesteVarie;
import it.us.web.dao.UtenteDAO;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.OrderBy;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.Where;
import org.hibernate.criterion.Order;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "altre_diagnosi", schema = "public")
@Where( clause = "trashed_date is null" )
public class AltreDiagnosi implements java.io.Serializable
{
	private static final long serialVersionUID = 3764880202719490784L;
	
	private int id;
	private String note;
	private Integer altraDiagnosi;
	private Date entered;
	private Date dataDiagnosi;
	private Date dataPrimaDiagnosi;
	private Boolean primaDiagnosi;
	private BUtenteAll enteredBy;
	private Animale animale;
	private LookupStatoGenerale statoGeneraleLookup;
	
	private Boolean base3Rm;
	private Boolean base3Rx;
	private Boolean base3Eco;
	private Boolean base3Tac;
	
	private String peso;
	private Set<LookupAlimentazioni> lookupAlimentazionis = new HashSet<LookupAlimentazioni>(0);
	private Set<LookupAlimentazioniQualita> lookupAlimentazioniQualitas = new HashSet<LookupAlimentazioniQualita>(0);
	private Set<LookupHabitat> lookupHabitats = new HashSet<LookupHabitat>(0);
	
	private String  noteBase1 ;
	private String  noteBase2 ;
	private String  noteBase3Rx ;
	private String  noteBase3Eco ;
	private String  noteBase3Tac ;
	private String  noteBase3Rm ;
	
	public AltreDiagnosi()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Altra Diagnosi";
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
	
	@Column(name = "peso")
	public String getPeso() {
		return peso;
	}

	public void setPeso(String peso) {
		this.peso = peso;
	}
	
	
	@Column(name = "note_base_1")
	public String getNoteBase1() {
		return noteBase1;
	}

	public void setNoteBase1(String noteBase1) {
		this.noteBase1 = noteBase1;
	}
	
	@Column(name = "note_base_2")
	public String getNoteBase2() {
		return noteBase2;
	}

	public void setNoteBase2(String noteBase2) {
		this.noteBase2 = noteBase2;
	}
	
	@Column(name = "note_base_3_rx")
	public String getNoteBase3Rx() {
		return noteBase3Rx;
	}

	public void setNoteBase3Rx(String noteBase3Rx) {
		this.noteBase3Rx = noteBase3Rx;
	}
	
	@Column(name = "note_base_3_tac")
	public String getNoteBase3Tac() {
		return noteBase3Tac;
	}

	public void setNoteBase3Tac(String noteBase3Tac) {
		this.noteBase3Tac = noteBase3Tac;
	}
	
	@Column(name = "note_base_3_rm")
	public String getNoteBase3Rm() {
		return noteBase3Rm;
	}

	public void setNoteBase3Rm(String noteBase3Rm) {
		this.noteBase3Rm = noteBase3Rm;
	}
	
	@Column(name = "note_base_3_eco")
	public String getNoteBase3Eco() {
		return noteBase3Eco;
	}

	public void setNoteBase3Eco(String noteBase3Eco) {
		this.noteBase3Eco = noteBase3Eco;
	}
	
	
	@Column(name = "base_3_rm")
	public Boolean getBase3RM() {
		return base3Rm;
	}

	public void setBase3RM(Boolean base3Rm) {
		this.base3Rm = base3Rm;
	}
	
	@Column(name = "base_3_eco")
	public Boolean getBase3Eco() {
		return base3Eco;
	}

	public void setBase3Eco(Boolean base3Eco) {
		this.base3Eco = base3Eco;
	}
	
	@Column(name = "base_3_tac")
	public Boolean getBase3Tac() {
		return base3Tac;
	}

	public void setBase3Tac(Boolean base3Tac) {
		this.base3Tac = base3Tac;
	}
	
	@Column(name = "base_3_rx")
	public Boolean getBase3Rx() {
		return base3Rx;
	}

	public void setBase3Rx(Boolean base3Rx) {
		this.base3Rx = base3Rx;
	}
	
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_alimentazioni_outside_altre_diagnosi", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "alimentazione", nullable = false, updatable = false) })
	public Set<LookupAlimentazioni> getLookupAlimentazionis() {
		return lookupAlimentazionis;
	}

	public void setLookupAlimentazionis(
			Set<LookupAlimentazioni> lookupAlimentazionis) {
		this.lookupAlimentazionis = lookupAlimentazionis;
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_alimentazioni_qualita_outside_altre_diagnosi", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "alimentazione", nullable = false, updatable = false) })
	public Set<LookupAlimentazioniQualita> getLookupAlimentazioniQualitas() {
		return lookupAlimentazioniQualitas;
	}

	public void setLookupAlimentazioniQualitas(
			Set<LookupAlimentazioniQualita> lookupAlimentazioniQualitas) {
		this.lookupAlimentazioniQualitas = lookupAlimentazioniQualitas;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_habitat_outside_altre_diagnosi", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "habitat", nullable = false, updatable = false) })
	public Set<LookupHabitat> getLookupHabitats() {
		return lookupHabitats;
	}

	public void setLookupHabitats(Set<LookupHabitat> lookupHabitats) {
		this.lookupHabitats = lookupHabitats;
	}
	
	@Temporal(TemporalType.DATE)
	@Column(name = "data_diagnosi", length = 13)
	public Date getDataDiagnosi() {
		return this.dataDiagnosi;
	}

	public void setDataDiagnosi(Date dataDiagnosi) {
		this.dataDiagnosi = dataDiagnosi;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "stato_generale_lookup")
	public LookupStatoGenerale getStatoGeneraleLookup() {
		return statoGeneraleLookup;
	}

	public void setStatoGeneraleLookup(LookupStatoGenerale statoGeneraleLookup) {
		this.statoGeneraleLookup = statoGeneraleLookup;
	}
	
	@Temporal(TemporalType.DATE)
	@Column(name = "data_prima_diagnosi", length = 13)
	public Date getDataPrimaDiagnosi() {
		return this.dataPrimaDiagnosi;
	}

	public void setDataPrimaDiagnosi(Date dataPrimaDiagnosi) {
		this.dataPrimaDiagnosi = dataPrimaDiagnosi;
	}
	
	@Column(name = "prima_diagnosi", length = 13)
	public Boolean getPrimaDiagnosi() {
		return this.primaDiagnosi;
	}

	public void setPrimaDiagnosi(Boolean primaDiagnosi) {
		this.primaDiagnosi = primaDiagnosi;
	}
	
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "entered", length = 29)
	public Date getEntered() {
		return this.entered;
	}

	public void setEntered(Date entered) {
		this.entered = entered;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "entered_by")
	public BUtenteAll getEnteredBy() {
		if(enteredBy!=null)
		{
		return UtenteDAO.getUtenteAll(enteredBy.getId());
		}
		else
		{
			return null;
		}
	}

	public void setEnteredBy(BUtenteAll enteredBy) {
		this.enteredBy = enteredBy;
	}
	
	

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "animale")
	public Animale getAnimale() {
		return this.animale;
	}

	public void setAnimale(Animale animale) {
		this.animale = animale;
	}
	
	@Column(name = "altra_diagnosi")
	public Integer getAltraDiagnosi() {
		return altraDiagnosi;
	}
	public void setAltraDiagnosi(Integer altraDiagnosi) {
		this.altraDiagnosi = altraDiagnosi;
	}
	
	@Column(name = "note")
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	
	@Transient
	public String getIdentificativoAnimale() 
	{
		if(animale!=null)
			return animale.getIdentificativo();
		else
			return "";
	}
}

package it.us.web.bean.vam;

import it.us.web.bean.BUtente;
import it.us.web.bean.BUtenteAll;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupAutopsiaSalaSettoria;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoInteressamentoLinfonodale;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoSedeLesione;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumore;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumoriPrecedenti;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.dao.UtenteDAO;

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

@Entity
@Table(name = "esame_istopatologico", schema = "public")
@Where( clause = "trashed_date is null" )
public class EsameIstopatologico implements java.io.Serializable, EsameInterface
{
	private static final long serialVersionUID = -5683301989406129454L;
	
	private int id;
	
	private CartellaClinica cartellaClinica;
	private boolean outsideCC;
	private Animale animale;
	
	private String numero;
	private String laboratorioPrivato;
	private String numeroAccettazioneSigla;
	private String tipoAccettazione;
	
	private String peso;
	private Set<LookupAlimentazioni> lookupAlimentazionis = new HashSet<LookupAlimentazioni>(0);
	private Set<LookupAlimentazioniQualita> lookupAlimentazioniQualitas = new HashSet<LookupAlimentazioniQualita>(0);
	private Set<LookupHabitat> lookupHabitats = new HashSet<LookupHabitat>(0);
	private LookupAutopsiaSalaSettoria lass;
	
	private Date dataRichiesta;
	private Date dataEsito;
	private String t;
	private String n;
	private String m;
	private String t1;
	private String n1;
	private String m1;
	private String t2;
	private String n2;
	private String m2;
	private String t3;
	private String n3;
	private String m3;
	private String t4;
	private String n4;
	private String m4;
	private String t5;
	private String n5;
	private String m5;
	private Date dataDiagnosi;
	private String diagnosiPrecedente;
	private Date dataDiagnosi1;
	private String diagnosiPrecedente1;
	private Date dataDiagnosi2;
	private String diagnosiPrecedente2;
	private Date dataDiagnosi3;
	private String diagnosiPrecedente3;
	private Date dataDiagnosi4;
	private String diagnosiPrecedente4;
	private Date dataDiagnosi5;
	private String diagnosiPrecedente5;
	private String tnm;
	private String tnm1;
	private String tnm2;
	private String tnm3;
	private String tnm4;
	private String tnm5;
	private Integer dimensione;
	private String descrizioneMorfologica;
	private String diagnosiNonTumorale;
	private LookupEsameIstopatologicoTipoPrelievo tipoPrelievo;
	private LookupEsameIstopatologicoTipoDiagnosi tipoDiagnosi;
	private LookupEsameIstopatologicoTumore tumore;
	private LookupEsameIstopatologicoTumoriPrecedenti tumoriPrecedenti;
	private LookupEsameIstopatologicoInteressamentoLinfonodale interessamentoLinfonodale;
	private LookupEsameIstopatologicoSedeLesione sedeLesione;
	private LookupEsameIstopatologicoWhoUmana whoUmana;
	private String trattOrm;
	private String statoGenerale;
	private LookupStatoGenerale statoGeneraleLookup;
	
	private Date entered;
	private Date modified;
	private Date trashedDate;
//	private BUtente enteredBy;
//	private BUtente modifiedBy;
	
	private BUtenteAll enteredBy;
	private BUtenteAll modifiedBy;

	public EsameIstopatologico()
	{
		
	}
	
	@Override
	public String toString()
	{
		return numero;
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
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "sala_settoria")
	public LookupAutopsiaSalaSettoria getLass() {
		return lass;
	}
	public void setLass(LookupAutopsiaSalaSettoria lass) {
		this.lass = lass;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "cartella_clinica")
	public CartellaClinica getCartellaClinica() {
		return this.cartellaClinica;
	}

	public void setCartellaClinica(CartellaClinica cartellaClinica) {
		this.cartellaClinica = cartellaClinica;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "animale")
	public Animale getAnimale() {
		return animale;
	}

	public void setAnimale(Animale animale) {
		this.animale = animale;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_richiesta", length = 29)
	public Date getDataRichiesta() {
		return dataRichiesta;
	}

	public void setDataRichiesta(Date dataRichiesta) {
		this.dataRichiesta = dataRichiesta;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_diagnosi", length = 29)
	public Date getDataDiagnosi() {
		return dataDiagnosi;
	}

	public void setDataDiagnosi(Date dataDiagnosi) {
		this.dataDiagnosi = dataDiagnosi;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_diagnosi1", length = 29)
	public Date getDataDiagnosi1() {
		return dataDiagnosi1;
	}

	public void setDataDiagnosi1(Date dataDiagnosi1) {
		this.dataDiagnosi1 = dataDiagnosi1;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_diagnosi2", length = 29)
	public Date getDataDiagnosi2() {
		return dataDiagnosi2;
	}

	public void setDataDiagnosi2(Date dataDiagnosi2) {
		this.dataDiagnosi2 = dataDiagnosi2;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_diagnosi3", length = 29)
	public Date getDataDiagnosi3() {
		return dataDiagnosi3;
	}

	public void setDataDiagnosi3(Date dataDiagnosi3) {
		this.dataDiagnosi3 = dataDiagnosi3;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_diagnosi4", length = 29)
	public Date getDataDiagnosi4() {
		return dataDiagnosi4;
	}

	public void setDataDiagnosi4(Date dataDiagnosi4) {
		this.dataDiagnosi4 = dataDiagnosi4;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_diagnosi5", length = 29)
	public Date getDataDiagnosi5() {
		return dataDiagnosi5;
	}

	public void setDataDiagnosi5(Date dataDiagnosi5) {
		this.dataDiagnosi5 = dataDiagnosi5;
	}
	
	

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_esito", length = 29)
	public Date getDataEsito() {
		return dataEsito;
	}

	public void setDataEsito(Date dataEsito) {
		this.dataEsito = dataEsito;
	}
	
	@Column(name = "numero")
	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}
	
	@Column(name = "laboratorio_privato")
	public String getLaboratorioPrivato() {
		return laboratorioPrivato;
	}

	public void setLaboratorioPrivato(String laboratorioPrivato) {
		this.laboratorioPrivato = laboratorioPrivato;
	}
	
	@Column(name = "tratt_orm")
	public String getTrattOrm() {
		return trattOrm;
	}

	public void setTrattOrm(String trattOrm) {
		this.trattOrm = trattOrm;
	}
	
	@Column(name = "stato_generale")
	public String getStatoGenerale() {
		return statoGenerale;
	}

	public void setStatoGenerale(String statoGenerale) {
		this.statoGenerale = statoGenerale;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "stato_generale_lookup")
	public LookupStatoGenerale getStatoGeneraleLookup() {
		return statoGeneraleLookup;
	}

	public void setStatoGeneraleLookup(LookupStatoGenerale statoGeneraleLookup) {
		this.statoGeneraleLookup = statoGeneraleLookup;
	}
	
	@Column(name = "numero_accettazione_sigla")	
	@Type(type = "text")
	public String getNumeroAccettazioneSigla() {
		return this.numeroAccettazioneSigla;
	}

	public void setNumeroAccettazioneSigla(String numeroAccettazioneSigla) {
		this.numeroAccettazioneSigla = numeroAccettazioneSigla;
	}
	
	@Column(name = "tipo_accettazione")	
	@Type(type = "text")
	public String getTipoAccettazione() {
		return this.tipoAccettazione;
	}

	public void setTipoAccettazione(String tipoAccettazione) {
		this.tipoAccettazione = tipoAccettazione;
	}

	@Column(name = "t1")
	public String getT1() {
		return t1;
	}

	public void setT1(String t1) {
		this.t1 = t1;
	}

	@Column(name = "n1")
	public String getN1() {
		return n1;
	}

	public void setN1(String n1) {
		this.n1 = n1;
	}

	@Column(name = "m1")
	public String getM1() {
		return m1;
	}

	public void setM1(String m1) {
		this.m1 = m1;
	}
	
	@Column(name = "t2")
	public String getT2() {
		return t2;
	}

	public void setT2(String t2) {
		this.t2 = t2;
	}

	@Column(name = "n2")
	public String getN2() {
		return n2;
	}

	public void setN2(String n2) {
		this.n2 = n2;
	}

	@Column(name = "m2")
	public String getM2() {
		return m2;
	}

	public void setM2(String m2) {
		this.m2 = m2;
	}
	@Column(name = "t3")
	public String getT3() {
		return t3;
	}

	public void setT3(String t3) {
		this.t3 = t3;
	}

	@Column(name = "n3")
	public String getN3() {
		return n3;
	}

	public void setN3(String n3) {
		this.n3 = n3;
	}

	@Column(name = "m3")
	public String getM3() {
		return m3;
	}

	public void setM3(String m3) {
		this.m3 = m3;
	}
	@Column(name = "t4")
	public String getT4() {
		return t4;
	}

	public void setT4(String t4) {
		this.t4 = t4;
	}

	@Column(name = "n4")
	public String getN4() {
		return n4;
	}

	public void setN4(String n4) {
		this.n4 = n4;
	}

	@Column(name = "m4")
	public String getM4() {
		return m4;
	}

	public void setM4(String m4) {
		this.m4 = m4;
	}
	@Column(name = "t5")
	public String getT5() {
		return t5;
	}

	public void setT5(String t5) {
		this.t5 = t5;
	}

	@Column(name = "n5")
	public String getN5() {
		return n5;
	}

	public void setN5(String n5) {
		this.n5 = n5;
	}

	@Column(name = "m5")
	public String getM5() {
		return m5;
	}

	public void setM5(String m5) {
		this.m5 = m5;
	}
	@Column(name = "t")
	public String getT() {
		return t;
	}

	public void setT(String t) {
		this.t = t;
	}

	@Column(name = "n")
	public String getN() {
		return n;
	}

	public void setN(String n) {
		this.n = n;
	}

	@Column(name = "m")
	public String getM() {
		return m;
	}

	public void setM(String m) {
		this.m = m;
	}

	@Column(name = "dimensione")
	public Integer getDimensione() {
		return dimensione;
	}

	public void setDimensione(Integer dimensione) {
		this.dimensione = dimensione;
	}

	@Column(name = "descrizione_morfologica")
	@Type(type = "text")
	public String getDescrizioneMorfologica() {
		return descrizioneMorfologica;
	}

	public void setDescrizioneMorfologica(String descrizioneMorfologica) {
		this.descrizioneMorfologica = descrizioneMorfologica;
	}
	
	@Column(name = "diagnosi_non_tumorale")
	@Type(type = "text")
	public String getDiagnosiNonTumorale() {
		return diagnosiNonTumorale;
	}

	public void setDiagnosiNonTumorale(String diagnosiNonTumorale) {
		this.diagnosiNonTumorale = diagnosiNonTumorale;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tipo_prelievo")
	public LookupEsameIstopatologicoTipoPrelievo getTipoPrelievo() {
		return tipoPrelievo;
	}

	public void setTipoPrelievo(LookupEsameIstopatologicoTipoPrelievo tipoPrelievo) {
		this.tipoPrelievo = tipoPrelievo;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tipo_diagnosi")
	public LookupEsameIstopatologicoTipoDiagnosi getTipoDiagnosi() {
		return tipoDiagnosi;
	}

	public void setTipoDiagnosi(LookupEsameIstopatologicoTipoDiagnosi tipoDiagnosi) {
		this.tipoDiagnosi = tipoDiagnosi;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tumore")
	public LookupEsameIstopatologicoTumore getTumore() {
		return tumore;
	}

	public void setTumore(LookupEsameIstopatologicoTumore tumore) {
		this.tumore = tumore;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tumori_precedenti")
	public LookupEsameIstopatologicoTumoriPrecedenti getTumoriPrecedenti() {
		return tumoriPrecedenti;
	}

	public void setTumoriPrecedenti(
			LookupEsameIstopatologicoTumoriPrecedenti tumoriPrecedenti) {
		this.tumoriPrecedenti = tumoriPrecedenti;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "interessamento_linfonodale")
	public LookupEsameIstopatologicoInteressamentoLinfonodale getInteressamentoLinfonodale() {
		return interessamentoLinfonodale;
	}

	public void setInteressamentoLinfonodale(
			LookupEsameIstopatologicoInteressamentoLinfonodale interessamentoLinfonodale) {
		this.interessamentoLinfonodale = interessamentoLinfonodale;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "sede_lesione")
	public LookupEsameIstopatologicoSedeLesione getSedeLesione() {
		return sedeLesione;
	}

	public void setSedeLesione(LookupEsameIstopatologicoSedeLesione sedeLesione) {
		this.sedeLesione = sedeLesione;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "who_umana")
	public LookupEsameIstopatologicoWhoUmana getWhoUmana() {
		return whoUmana;
	}

	public void setWhoUmana(LookupEsameIstopatologicoWhoUmana whoUmana) {
		this.whoUmana = whoUmana;
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
	
	
	
	@Column(name = "peso")
	public String getPeso() {
		return peso;
	}

	public void setPeso(String peso) {
		this.peso = peso;
	}
	
	
	@Column(name = "diagnosi_precedente")
	public String getDiagnosiPrecedente() {
		return diagnosiPrecedente;
	}

	public void setDiagnosiPrecedente(String diagnosiPrecedente) {
		this.diagnosiPrecedente = diagnosiPrecedente;
	}
	
	@Column(name = "diagnosi_precedente1")
	public String getDiagnosiPrecedente1() {
		return diagnosiPrecedente1;
	}

	public void setDiagnosiPrecedente1(String diagnosiPrecedente1) {
		this.diagnosiPrecedente1 = diagnosiPrecedente1;
	}
	
	@Column(name = "diagnosi_precedente2")
	public String getDiagnosiPrecedente2() {
		return diagnosiPrecedente2;
	}

	public void setDiagnosiPrecedente2(String diagnosiPrecedente2) {
		this.diagnosiPrecedente2 = diagnosiPrecedente2;
	}
	@Column(name = "diagnosi_precedente3")
	public String getDiagnosiPrecedente3() {
		return diagnosiPrecedente3;
	}

	public void setDiagnosiPrecedente3(String diagnosiPrecedente3) {
		this.diagnosiPrecedente3 = diagnosiPrecedente3;
	}
	@Column(name = "diagnosi_precedente4")
	public String getDiagnosiPrecedente4() {
		return diagnosiPrecedente4;
	}

	public void setDiagnosiPrecedente4(String diagnosiPrecedente4) {
		this.diagnosiPrecedente4 = diagnosiPrecedente4;
	}
	
	@Column(name = "diagnosi_precedente5")
	public String getDiagnosiPrecedente5() {
		return diagnosiPrecedente5;
	}

	public void setDiagnosiPrecedente5(String diagnosiPrecedente5) {
		this.diagnosiPrecedente5 = diagnosiPrecedente5;
	}
	
	
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_alimentazioni_outside", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "alimentazione", nullable = false, updatable = false) })
	public Set<LookupAlimentazioni> getLookupAlimentazionis() {
		return lookupAlimentazionis;
	}

	public void setLookupAlimentazionis(
			Set<LookupAlimentazioni> lookupAlimentazionis) {
		this.lookupAlimentazionis = lookupAlimentazionis;
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_alimentazioni_qualita_outside", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "alimentazione_qualita", nullable = false, updatable = false) })
	public Set<LookupAlimentazioniQualita> getLookupAlimentazioniQualitas() {
		return lookupAlimentazioniQualitas;
	}

	public void setLookupAlimentazioniQualitas(
			Set<LookupAlimentazioniQualita> lookupAlimentazioniQualitas) {
		this.lookupAlimentazioniQualitas = lookupAlimentazioniQualitas;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animali_habitat_outside", schema = "public", joinColumns = { @JoinColumn(name = "esame", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "habitat", nullable = false, updatable = false) })
	public Set<LookupHabitat> getLookupHabitats() {
		return lookupHabitats;
	}

	public void setLookupHabitats(Set<LookupHabitat> lookupHabitats) {
		this.lookupHabitats = lookupHabitats;
	}
	
	
	@Transient
	public String getDiagnosiReferto() 
	{
		return ((whoUmana==null)?(""):(whoUmana)) + " " + ((diagnosiNonTumorale==null)?(""):(diagnosiNonTumorale)) ;
	}

	@Override
	@Transient
	public String getNomeEsame()
	{
		return "Istopatologico";
	}

	@Override
	@Transient
	public String getHtml()
	{
		return "implementare istopatologico";
	}
	
	@Transient
	public String getTnm() 
	{
		tnm = "";
		
		String t = (this.t==null)?(""):("T: " + this.t);
		String n = (this.n==null)?(""):("N: " + this.n);
		String m = (this.m==null)?(""):("M: " + this.m);
		
		if(!t.equals(""))
		{
			tnm = t;
		}
		if(!n.equals(""))
		{
			if(tnm.equals(""))
				tnm = n;
			else
				tnm+=", " + n;
		}
		if(!m.equals(""))
		{
			if(tnm.equals(""))
				tnm = m;
			else
				tnm+=", " + m;
		}
			
		return tnm;
		
	}
	
	@Transient
	public String getTnm2() 
	{
		tnm2 = "";
		
		String t2 = (this.t2==null)?(""):("T: " + this.t2);
		String n2 = (this.n2==null)?(""):("N: " + this.n2);
		String m2 = (this.m2==null)?(""):("M: " + this.m2);
		
		if(!t2.equals(""))
		{
			tnm2 = t2;
		}
		if(!n2.equals(""))
		{
			if(tnm2.equals(""))
				tnm2 = n2;
			else
				tnm2+=", " + n2;
		}
		if(!m2.equals(""))
		{
			if(tnm2.equals(""))
				tnm2 = m2;
			else
				tnm2+=", " + m2;
		}
			
		return tnm2;
		
	}
	
	
	@Transient
	public String getTnm3() 
	{
		tnm3 = "";
		
		String t3 = (this.t3==null)?(""):("T: " + this.t3);
		String n3 = (this.n3==null)?(""):("N: " + this.n3);
		String m3 = (this.m3==null)?(""):("M: " + this.m3);
		
		if(!t3.equals(""))
		{
			tnm3 = t3;
		}
		if(!n3.equals(""))
		{
			if(tnm3.equals(""))
				tnm3 = n3;
			else
				tnm3+=", " + n3;
		}
		if(!m3.equals(""))
		{
			if(tnm3.equals(""))
				tnm3 = m3;
			else
				tnm3+=", " + m3;
		}
			
		return tnm3;
		
	}
	
	
	@Transient
	public String getTnm4() 
	{
		tnm4 = "";
		
		String t4 = (this.t4==null)?(""):("T: " + this.t4);
		String n4 = (this.n4==null)?(""):("N: " + this.n4);
		String m4 = (this.m4==null)?(""):("M: " + this.m4);
		
		if(!t4.equals(""))
		{
			tnm4 = t4;
		}
		if(!n4.equals(""))
		{
			if(tnm4.equals(""))
				tnm4 = n4;
			else
				tnm4+=", " + n4;
		}
		if(!m4.equals(""))
		{
			if(tnm4.equals(""))
				tnm4 = m4;
			else
				tnm4+=", " + m4;
		}
			
		return tnm4;
		
	}
	
	
	@Transient
	public String getTnm5() 
	{
		tnm5 = "";
		
		String t5 = (this.t5==null)?(""):("T: " + this.t5);
		String n5 = (this.n5==null)?(""):("N: " + this.n5);
		String m5 = (this.m5==null)?(""):("M: " + this.m5);
		
		if(!t5.equals(""))
		{
			tnm5 = t5;
		}
		if(!n5.equals(""))
		{
			if(tnm5.equals(""))
				tnm5 = n5;
			else
				tnm5+=", " + n5;
		}
		if(!m5.equals(""))
		{
			if(tnm5.equals(""))
				tnm5 = m5;
			else
				tnm5+=", " + m5;
		}
			
		return tnm5;
		
	}
	
	
	@Transient
	public String getTnm1() 
	{
		tnm = "";
		
		String t1 = (this.t1==null)?(""):("T: " + this.t1);
		String n1 = (this.n1==null)?(""):("N: " + this.n1);
		String m1 = (this.m1==null)?(""):("M: " + this.m1);
		
		if(!t1.equals(""))
		{
			tnm1 = t1;
		}
		if(!n1.equals(""))
		{
			if(tnm1.equals(""))
				tnm1 = n1;
			else
				tnm1+=", " + n1;
		}
		if(!m1.equals(""))
		{
			if(tnm1.equals(""))
				tnm1 = m1;
			else
				tnm1+=", " + m1;
		}
			
		return tnm1;
		
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
	
	@Transient
	public String getNumeroRifMittente() 
	{
		return getTipoAccettazione()+"-"+getNumeroAccettazioneSigla();
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
}

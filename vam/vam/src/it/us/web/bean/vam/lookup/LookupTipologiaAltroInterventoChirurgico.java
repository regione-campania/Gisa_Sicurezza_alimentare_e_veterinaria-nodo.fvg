package it.us.web.bean.vam.lookup;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;


@Entity
@Table(name = "lookup_tipologia_altro_intervento_chirurgico", schema = "public")
@Where( clause = "enabled" )
public class LookupTipologiaAltroInterventoChirurgico implements java.io.Serializable
{
	private static final long serialVersionUID = 4447343084372790967L;
	
	private int id;
	private String descrizione;
	private Integer level;
	private Boolean enabled;
	private Boolean isGroup;
	
	public LookupTipologiaAltroInterventoChirurgico()
	{
		
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

	@Column(name = "descrizione", length = 64)
	@Length(max = 64)
	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	@Column(name = "level")
	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	
	@Column(name = "is_group")
	public Boolean getIsGroup() {
		return this.isGroup;
	}

	public void setIsGroup(Boolean isGroup) {
		this.isGroup = isGroup;
	}
		
	@Override
	public String toString()
	{
		return descrizione;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Tipologia Altro Intervento Chirurgico";
	}
	
}

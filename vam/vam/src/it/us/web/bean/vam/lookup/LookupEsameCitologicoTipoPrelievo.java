package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.EsameCitologico;

import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_esame_citologico_tipo_prelievo", schema = "public")
public class LookupEsameCitologicoTipoPrelievo implements java.io.Serializable
{
	private static final long serialVersionUID = -8091002289851989785L;
	
	private int id;
	private String descrizione;
	private Set<EsameCitologico> esameCitologicos;

	@Transient
	public String getNomeEsame()
	{
		return "Tipo prelievo";
	}
	
	public LookupEsameCitologicoTipoPrelievo()
	{
		
	}
	
	@Override
	public String toString()
	{
		return descrizione;
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
	
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "tipoPrelievo")
	public Set<EsameCitologico> getEsameCitologicos() {
		return esameCitologicos;
	}

	public void setEsameCitologicos(Set<EsameCitologico> esameCitologicos) {
		this.esameCitologicos = esameCitologicos;
	}

}

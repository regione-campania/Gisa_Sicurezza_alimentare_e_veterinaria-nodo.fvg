package it.us.web.bean.vam;

import it.us.web.bean.vam.lookup.LookupEsameObiettivoEsito;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "diario_clinico_esito_eo", schema = "public")
public class DiarioClinicoEsitoEO implements java.io.Serializable
{
	private static final long serialVersionUID = -2271003577908569371L;
	
	private int id;
	private DiarioClinicoTipoEO diarioClinicoTipoEO;
	private LookupEsameObiettivoEsito esito;

	public DiarioClinicoEsitoEO()
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


	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "diario_clinico_tipo_eo")
	public DiarioClinicoTipoEO getDiarioClinicoTipoEO() {
		return this.diarioClinicoTipoEO;
	}

	public void setDiarioClinicoTipoEO(DiarioClinicoTipoEO diarioClinicoTipoEO) {
		this.diarioClinicoTipoEO = diarioClinicoTipoEO;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "esito")
	public LookupEsameObiettivoEsito getEsito() {
		return this.esito;
	}

	public void setEsito(LookupEsameObiettivoEsito esito) {
		this.esito = esito;
	}
	
	@Override
	public String toString()
	{
		return esito.toString();
	}

}

package it.us.web.bean.sinantropi.lookup;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "lookup_sinantropi_eta", schema = "public")
//@ScriptAssert(lang = "javascript", script = "_this.nome.equals(_this.cognome)", message="attenzioneeeeee!!!!" )
public class LookupSinantropiEta implements java.io.Serializable
{
	private static final long serialVersionUID = 7046648521134189879L;
	
	private int id;
	private String description;
	

	public LookupSinantropiEta()
	{
		
	}
	
	@Override
	public String toString()
	{
		return description;
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

	@Column(name = "description")
	@Type(type="text")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}

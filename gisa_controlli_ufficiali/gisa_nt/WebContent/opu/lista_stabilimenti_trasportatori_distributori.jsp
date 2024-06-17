<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="java.util.Iterator"%>
<jsp:useBean id="listaStabilimenti" class="org.aspcfs.modules.opu.base.StabilimentoList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<style type="text/css">
.clinicaDiv {
	width: 100%;
}

.clinicaDiv a {
	width: 100%;
	border: 1px solid aliceBlue;
	display:block;
	color:#555555;
	font-weight:bold;
	height:100px;
	line-height:29px;
	margin-bottom:14px;
	text-decoration:none;
	-webkit-transition: color 0.4s linear;
	-moz-transition: color 0.4s linear;
	-moz-border-radius: 8px;
	border-radius: 8px;
}

.clinicaDiv a:hover {
	color:#0066CC;

}

.clinicaSpanH {
	text-align: center;
	display:block;
	width:100%;
}

.clinicaSpanB {
	padding: 0px 10px 0px 10px;
	display:block;
	text-overflow: ellipsis;
	white-space: nowrap;
	width:100%;
	overflow: hidden;
	font-weight: normal;
	//color: black;
	line-height: normal;
}

</style>

<div style="width: 500px; margin: 10px auto;">
	<h2>Benvenuto</h2>
	<% if(listaStabilimenti.size()>0){%>
		<h3>Scegli lo Stabilimento in cui Vuoi Operare</h3>
		<%}else
			{
			%>
			<h3>NON ESISTONO STABILIMENTI ATTIVI ASSOCIATI ALLA PERSONA CON CODICE FISCALE :<%=User.getContact().getVisibilitaDelega() %></h3>
			<%
			}%>
</div>

		
<div style="width: 100%; margin: 40px auto;">
<%
Iterator it = listaStabilimenti.iterator();
while (it.hasNext())
{
	Stabilimento st = (Stabilimento) it.next();
	
%>
		<div class="clinicaDiv">
			<a onclick="loadModalWindow();" href="OpuStab.do?command=Details&stabId=<%=st.getIdStabilimento()%>">
				<span class="clinicaSpanH"><%=st.getOperatore().getRagioneSociale() %></span>
				<span class="clinicaSpanB">
				<%=st.getOperatore().getPartitaIva()!=null ? "<b>P.Iva</b> "+st.getOperatore().getPartitaIva()+"<br>" : "" %>
				
				<%=st.getOperatore().getRappLegale().getCodFiscale()!=null ? "<b>Codice Fiscale</b> "+st.getOperatore().getRappLegale().getCodFiscale()+"<br>" : "" %>
				<%=st.getOperatore().getRappLegale().getNome()!=null ? "<b>Nome</b> "+st.getOperatore().getRappLegale().getNome()+"<br>" : "" %>
				<%=st.getOperatore().getRappLegale().getCognome()!=null ? "<b>Cognome</b> "+st.getOperatore().getRappLegale().getCognome()+"<br>" : "" %>
				<%=st.getNumero_registrazione()!=null ? "<b>Num. Registrazione</b> "+st.getNumero_registrazione()+"<br>" : "" %>
				<%=st.getOperatore().getSedeLegaleImpresa().getVia()!=null ? "<b>Sede Legale</b> "+st.getOperatore().getSedeLegaleImpresa().getVia()+"<br>" : "" %>
				<%=st.getSedeOperativa().getVia()!=null ? "<b>Sede Operativa</b> "+st.getSedeOperativa().getVia()+"<br>" : "" %>
					
				
					
				</span>
			</a>
		</div>
		<br>
		<br>
<%}

%>
</div>
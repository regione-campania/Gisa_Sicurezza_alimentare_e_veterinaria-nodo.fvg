<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

<style type="text/css">
.lst
{
	height:26px;
	width:496px;
	font:19px arial,sans-serif;
	background:none repeat scroll 0 0 #FFFFFF;
	/*border-color: #999999;/*transparent;*/
	border: 1px solid #999999;/*#781351;*/
	color:#4E5873;
}
.lsb
{
	height:30px;
	border: 1px solid #999999;/*#781351;*/
	font:19px arial,sans-serif;
	color:#4E5873;
}
</style>

<div>

	<!-- form action="" method="post">
		<span>
			<input type="text" maxlength="2048" class="lst" />
			<input type="submit" value="Cerca" class="lsb" />
		</span>
	</form -->
</div>

<font face="Arial" size="2" style="font-weight:bold;">

<b>SinAgr</b> (Anagrafe Sinantropi/Marini/Zoo) è un sistema per la gestione delle categorie dei 
sinantropi.
<br>
<us:can f="AMMINISTRAZIONE" og="MAIN" r="w" sf="CAMBIO UTENTE">
<c:if test="${utente.ruolo=='17'}">	
	Username: <input type="text" name="username" id="username"/>
	<input type="button" value="Cambia Utente" onclick="location.href='login.CambioUtente.us?username='+document.getElementById('username').value"/>
</c:if>
	Codice fiscale: <input type="text" name="cf_spid" id="cf_spid"  />
	<input type="button" value="Cambia Utente" onclick="location.href='login.Logout.us?cf_spid='+document.getElementById('cf_spid').value"/>
						
</us:can>
<br>
<br>

</font>

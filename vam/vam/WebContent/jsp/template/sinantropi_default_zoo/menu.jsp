<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@page import="it.us.web.util.properties.Application"%>

<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/Test.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>

<div id="sidebar-left">

	<div class="mymoduletable">		
		
		<p id="p3_my"> Benvenuto 
			<br>						
				<c:out value="${utente.nome}"/> <c:out value="${utente.cognome}"/>
			<br>						
				${utente.clinica.nome }
			<br>
		</p>


	<ul id="qm0" class="qmmc">

	<li>
		<a 
		<c:choose>
			<c:when test="${entrypointSinantropi=='vam'}">
				href="vam.SwitchToVam.us"
			</c:when>
			<c:otherwise>
				href="vam.SwitchToVam.us"		
			</c:otherwise>
		</c:choose>
		accesskey="2"><span>Torna a V.A.M.</span></a>
	</li>
				
	
	<li>
		<a href="Home.us" accesskey=""><span>Home</span></a>
	</li>
	
	<li><a href="#">Anagrafe</a>
			<ul id="qm1" class="qmmc">
					<li>
						<a onclick="attendere()" href="sinantropi.ToAdd.us" accesskey="5"><span>Sinantropi/Selvatici</span></a>
					</li>
				
					<li>
						<a onclick="attendere()" href="sinantropi.ToAddMarini.us" accesskey="5"><span>Animale Marino</span></a>
					</li>
					
					<li>
						<a onclick="attendere()" href="sinantropi.ToAddZoo.us" accesskey="5"><span>Animale dello zoo/circo</span></a>
					</li>
			</ul>
		</li>
		
		
	
	<li>
		<a href="#" accesskey="4"><span>Ricerca</span></a>
		<ul id="qm1" class="qmmc">
					<li>
						<a onclick="attendere()" href="sinantropi.ToFind.us" accesskey="5"><span>Sinantropi/Selvatici</span></a>
					</li>
				
					<li>
						<a onclick="attendere()" href="sinantropi.ToFindMarini.us" accesskey="5"><span>Animale Marino</span></a>
					</li>
					
					<li>
						<a onclick="attendere()" href="sinantropi.ToFindZoo.us" accesskey="5"><span>Animale dello zoo/circo</span></a>
					</li>
			</ul>
		
	</li>		
	
	<li>
		<a href="sinantropi.List.us" accesskey="4"><span>Lista</span></a>
	</li>
	
	<li>
		<a href="vam.util.ShowDoc.us" accesskey="" target="_new"><span>Help</span></a>
	</li>	
	
   </ul>
   
   <p id="p3_my"> <br/>Help Desk: <br/><%=Application.get("TELEFONO_HD")%><br/> <br/> 
   </p>
   
</div>
	
<img id="finemenu" src="images/sinantropi/finemenu.jpg"/>	

</div>
	
				
			
	

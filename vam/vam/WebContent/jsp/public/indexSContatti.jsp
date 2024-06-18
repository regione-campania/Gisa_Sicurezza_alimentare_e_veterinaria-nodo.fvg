<%@page import="it.us.web.util.properties.Application"%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>

<div id="wrapper">
	<div id="header">
		<h1><a href="#">Anagrafe Sinantropi/Marini/Zoo</a></h1>
			<img src="./images/sinantropi/homePage/regione.png" align="right"/>
	</div>
	<!-- end header -->
	<div id="menu">
		<h2>Main Menu</h2>
		<ul>
			<li class="active"><a href="#">Home</a></li>			
			<li><a href="IndexContatti.us">Contatti</a></li>
		</ul>
	</div>
	<!-- end menu -->
	<div id="page">
		<div id="content">		
				<br>
				<br>
				<br>
				<br>
				<br>
				<p style="color:blue;">Per assistenza  al software è possibile contattare l'Help Desk nei giorni feriali dalle ore 9 alle ore 13 ai seguenti numeri:<br/>
					Telefoni: <b><%=Application.get("TELEFONO_HD")%></b><br/>
					Per migliorare i processi legati all'assistenza si prega di utilizzare sempre l'invio di 'segnalazioni' usando il comando presente nella home page.<br/>
					Per segnalare eventuali blocchi del sistema durante le ore non lavorative si prega di inviare una email alla casella <b><%=Application.get("MAIL_SENDER_ADDRESS")%></b> 
					avente oggetto 'SISTEMA DOWN'.
				</p>
		</div>
		<!-- end content -->
		<div id="sidebar">
			<ul>
				<li id="submenu">
					<h2>Login</h2>
					<ul>
						<form action="login.Login.us" method="post">					
							<b>Username  </b> <br> <input type="text" name="utente"/> <br>						
							<b>Password  </b> <br> <input type="password" name="password"/> <br>
							<br>						
							<input type="hidden" name="action" value="login"/>
							<input type="submit" onclick="attendere()" value="Entra" align="center">
						</form>	
					</ul>
				</li>
				<!--  li id="news">
					<h2>Note di Rilascio</h2>
					<ul>
						<li>
							<h3>10 giugno 2011</h3>
							<p>La versione 1.0 del sistema SinAgr e' on-line</p>
						</li>						
					</ul>
				</li-->
				<li id="news">
					<h2>Accesso BDR</h2>
					<ul>
							<li>
								<h3><a href="${BDU_PORTALE_URL}" accesskey="5" target="_new"><span>Cani/Gatti</span></a></h3>
							</li>
						<li>
							<h3><a href="indexV.jsp?" accesskey="1"><span>V.A.M.</span></a></h3>
						</li>						
					</ul>
				</li>
			</ul>
		</div>
		<!-- end sidebar -->
		<div style="clear: both;">&nbsp;</div>
	</div>
	<!-- end page -->
	<div id="footer">
		<p id="legal" align="cente">SinAgr - Anagrafe Sinantropi/Marini/Zoo</p>		
	</div>
	<!-- end footer -->
</div>
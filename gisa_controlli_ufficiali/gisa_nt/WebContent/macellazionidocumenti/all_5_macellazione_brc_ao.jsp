<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../../utils23/initPage.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<style>
@page { 
	margin: 5px 30px 30px 30px;
	 @bottom-center {
    content: counter(page) " su " counter(pages);
		}
}
td{
	  page-break-inside: avoid;
	  word-wrap:break-word;
	  font-size: x-small;
	  }
table { 
            -fs-table-paginate: paginate;
            border-spacing: 0;
            table-layout:fixed; width:100%;
            word-wrap:break-word;            
        }

table.tabellaHeader {
	width: 100%;
	text-align: center;
	border: 0.5px solid;
	border-collapse: collapse;
}

.tabellaHeader td{
	width: 50%;
	border: 0.5px solid;
	padding: 8px;
}

table.tabellaHeader-simple {
	width: 100%;
	text-align: center;
	border: 0.5px solid;
	border-collapse: collapse;
}

.tabellaHeader-simple td{
	border: 0.5px solid;
	padding: 8px;
}

table.tabellaContent {
	width: 100%;
	text-align: left;
	border: 1px solid;
	border-collapse: collapse;
}

.tabellaContent td{
	border: 1px solid;
	padding: 8px;
	line-height: 25px;
}

.tabellaContent .vertical{
	font-size: large;
	writing-mode: sideways-lr;
	width: 5%;
	background: lightgray;
}

table.tabellaContent-simple {
	width: 100%;
	text-align: left;
	border: 1px solid;
	border-collapse: collapse;
}

.tabellaContent-simple td{
	border: 1px solid;
}

.tabellaContent-simple .vertical-simple{
	writing-mode: sideways-lr;
	width: 5%;
}
 </style>
 
 
<html>
<body>
<div align="center">
	<table class="tabellaHeader">
		<tr>
			<td><b>BRUCELLOSI BOVINA/BUFALINA<br>ALLEVAMENTO BOVINO/BUFALINO</b></td>
			<td><b>ALLEGATO 5<br>FOCOLAIO CON ISOLAMENTO<br>DGRC 104/2022</b></td>
		</tr>
	</table>
	<br>
	<div align="right">
		<table>
			<tr>
				<td><b>Alla sede IZSM di __________________________ <br>e.p.c. All'OVER c/o IZSM __________________________</b></td>
			</tr>
			<tr>
				<td><b>Alla ASL _______________</b></td>
			</tr>
		</table>
	</div>
	<br>
		<table class="tabellaHeader">
			<tr>
				<td><b>VERBALE N._______________________________</b></td>
				<td><b>DEL _______________________________</b></td>
			</tr>
		</table>
	<br>
	
	<table class="tabellaContent">
		<tr>
			<td class="vertical" rowspan="8"><b>MACELLO</b></td>
			<td>MEDICO VETERINARIO
				<br>____________________________________________________________________________________________________________________________________________________________________________________
			</td>
			<td class="vertical" rowspan="8"><b>ALLEVAMENTO</b></td>
			<td>DENOMINAZIONE AZIENDA
				<br>____________________________________________________________________________________________________________________________________________________________________________________
			</td>
		</tr>
		<tr>
			<td>N. TEL
				<br>____________________________________________________________
			</td>
			<td>CODICE IDENTIFICAZIONE AZIENDA
				<br>____________________________________________________________
			</td>
		</tr>
		<tr>
			<td>ASL.
				<br>____________________________________________________________
			</td>
			<td>PROPRIETARIO
				<br>____________________________________________________________
			</td>
		</tr>
		<tr>
			<td>MACELLO
				<br>____________________________________________________________
			</td>
			<td>VIA
				<br>____________________________________________________________
			</td>
		</tr>
		<tr>
			<td>N. TEL
				<br>____________________________________________________________
			</td>
			<td>N.
				<br>____________________________________________________________
			</td>
		</tr>
		<tr>
			<td>VIA
				<br>____________________________________________________________
			</td>
			<td>COMUNE
				<br>____________________________________________________________
			</td>
		</tr>
		<tr>
			<td>COMUNE
				<br>____________________________________________________________
			</td>
			<td>PROV.
				<br>____________________________________________________________
			</td>
		</tr>
		<tr>
			<td>PROVINCIA
				<br>____________________________________________________________
			</td>
			<td>ASL
				<br>____________________________________________________________
			</td>
		</tr>
	</table>
	<br>
	<h3><u>SPECIE</u></h3>
	<br>
	<table width="50%">
		<tr style="text-align:center">
			<td>[ ] <b>BUFALINA</b></td>
			<td>[ ] <b>BOVINA</b></td>
		</tr>
	</table>
	<br>
	<table class="tabellaHeader-simple">
		<tr>
			<td width="33%" >[ ]<B>MACELLAZIONE REGOLARE<br><u>CAPO SIERONEGATIVO</u> PROVENIENTE DA</B></td>
			<td width="33%" rowspan="2">[ ]<b>ALLEVAMENTO FOCOLAIO</b><br>Con isolamento del_______________<br>come da <b>MOD 4 ALLEGATO</b></td>
			<td rowspan="2" style="background: lightgray;"><b>Quesito SIGLA BRMFI</b></td>
		</tr>
		<tr>
			<td><B>CAPO POSITIVO/DUBBIO PROVENIENTE DA</B></td>
		</tr>
	</table>
	<br>
	<h3><u>ALLEGARE COPIA DEL MODELLO 4</u></h3>
	<table width="90%">
		<tr  style="text-align:center">
			<td style="padding: 10px;">
				<b>BUFALI</b>
				<table class="tabellaContent" style="height: 450px;">
					<tr  style="text-align:center">
						<td style="background: lightgray;"><b>N. E TIPO DI <br> ANIMALI ESAMITANI</b></td>
					</tr>
					<tr>
						<td>ANNUTOLA (1) N.____</td>
					</tr>
					<tr>
						<td>ANNUTOLO (2) N.____</td>
					</tr>
					<tr>
						<td>TORI BUFALINI N.____</td>
					</tr>
					<tr>
						<td>BUFALE IN PRODUZIONE N.____</td>
					</tr>
					<tr>
						<td>BUFALE DA RIFORMA N.____</td>
					</tr>
					<tr>
						<td>
							(1)FEMMINA DAI 13 MESI ALLA PRIMA INSEMINAZIONE<br>
							(2)MASCHIO DAI 13 AI 24 MESI
						</td>
					</tr>
				</table>
				
			</td>
			<td style="padding: 10px;">
				<b>BOVINI</b>
				<table class="tabellaContent" style="height: 450px;">
					<tr  style="text-align:center">
						<td style="background: lightgray;"><b>N. E TIPO DI <br> ANIMALI ESAMITANI</b></td>
					</tr>
					<tr>
						<td>GIOVENCA (3)____</td>
					</tr>
					<tr>
						<td>MANZA (4)____</td>
					</tr>
					<tr>
						<td>VITELLONE____</td>
					</tr>
					<tr>
						<td>TORI N.____</td>
					</tr>
					<tr>
						<td>VACCHE IN PRODUZIONE N.____</td>
					</tr>
					<tr>
						<td>VACCHE DA RIFORMA N.____</td>
					</tr>
					<tr>
						<td>
							(3)FEMMINA DI 12 - 24 MESI CHE NON ABBIA PARTORITO<br>
							(4)FEMMINA DAI 18/24 MESI FINO A 3 ANNI<br>
							(5)MASCHIO DAI 12 AI 24 MESI
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br><br>
	<h3>DESCRIZIONE MATERIALE INVIATO PER ESAME PCR</h3>
	<table class="tabellaContent-simple">
		<tr style="text-align:center">
			<td><b>CONTRASSEGNO IDENTIFICAZIONE<br>(marca auricolare)</b></td>
			<td colspan="2"><b>TESSUTI COLPITI</b></td>
			<td class="vertical-simple"><b>TIPO<br>DI FLESSIONE (1)</b></td>
			<td class="vertical-simple"><b>LESIONI<br>ASPECIFICHE (2)</b></td>
			<td colspan="2"><b>TESSUSI PRELEVATI</b></td>
		</tr>
		
		<tr >
			<td rowspan="2"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
			<td rowspan="7"></td>
			<td rowspan="7"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
		</tr>
		<tr>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
		</tr>
		<tr>
			<td>SESSO: [ ]M [ ]F</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
		</tr>
		<tr>
			<td rowspan="2">DATA DI NASCITA<br>&nbsp</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
		</tr>
		<tr>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
		</tr>
		<tr>
			<td rowspan="2">RAZZA<br>&nbsp</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
		</tr>
		<tr>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
		</tr>
		<tr >
			<td rowspan="2"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
			<td rowspan="7"></td>
			<td rowspan="7"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
		</tr>
		<tr>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
		</tr>
		<tr>
			<td>SESSO: [ ]M [ ]F</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
		</tr>
		<tr>
			<td rowspan="2">DATA DI NASCITA<br>&nbsp</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
		</tr>
		<tr>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
		</tr>
		<tr>
			<td rowspan="2">RAZZA<br>&nbsp</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
		</tr>
		<tr>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
		</tr>
		<tr >
			<td rowspan="2"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
			<td rowspan="7"></td>
			<td rowspan="7"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
		</tr>
		<tr>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
		</tr>
		<tr>
			<td>SESSO: [ ]M [ ]F</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
		</tr>
		<tr>
			<td rowspan="2">DATA DI NASCITA<br>&nbsp</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
		</tr>
		<tr>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
		</tr>
		<tr>
			<td rowspan="2">RAZZA<br>&nbsp</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
		</tr>
		<tr>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
		</tr>
		<tr >
			<td rowspan="2"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
			<td rowspan="7"></td>
			<td rowspan="7"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
		</tr>
		<tr>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
		</tr>
		<tr>
			<td>SESSO: [ ]M [ ]F</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
		</tr>
		<tr>
			<td rowspan="2">DATA DI NASCITA<br>&nbsp</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
		</tr>
		<tr>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
		</tr>
		<tr>
			<td rowspan="2">RAZZA<br>&nbsp</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
		</tr>
		<tr>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
		</tr>
		<tr >
			<td rowspan="2"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
			<td rowspan="7"></td>
			<td rowspan="7"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
		</tr>
		<tr>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
		</tr>
		<tr>
			<td>SESSO: [ ]M [ ]F</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
		</tr>
		<tr>
			<td rowspan="2">DATA DI NASCITA<br>&nbsp</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
		</tr>
		<tr>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
		</tr>
		<tr>
			<td rowspan="2">RAZZA<br>&nbsp</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
		</tr>
		<tr>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
		</tr>
		<tr >
			<td rowspan="2"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
			<td rowspan="7"></td>
			<td rowspan="7"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
		</tr>
		<tr>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
		</tr>
		<tr>
			<td>SESSO: [ ]M [ ]F</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
		</tr>
		<tr>
			<td rowspan="2">DATA DI NASCITA<br>&nbsp</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
		</tr>
		<tr>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
		</tr>
		<tr>
			<td rowspan="2">RAZZA<br>&nbsp</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
		</tr>
		<tr>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
		</tr>
		<tr >
			<td rowspan="2"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
			<td rowspan="7"></td>
			<td rowspan="7"></td>
			<td>[ ] L.RETROFARINGEI</td>
			<td>[ ] L.MAMMARI</td>
		</tr>
		<tr>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
			<td>[ ] L.MANDIBOLARI</td>
			<td>[ ] L.POPLITEI</td>
		</tr>
		<tr>
			<td>SESSO: [ ]M [ ]F</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
			<td>[ ] L.TONSILLE</td>
			<td>[ ] L.PRESCAPOLARI</td>
		</tr>
		<tr>
			<td rowspan="2">DATA DI NASCITA<br>&nbsp</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
			<td>[ ] L.MEDIASTINITICI</td>
			<td>[ ] L.ILIACI</td>
		</tr>
		<tr>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
			<td>[ ] L.TRACHEOBRONCHIALI</td>
			<td>[ ] POLMONI</td>
		</tr>
		<tr>
			<td rowspan="2">RAZZA<br>&nbsp</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
			<td>[ ] L.MESERAICI</td>
			<td>[ ] FEGATO</td>
		</tr>
		<tr>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
			<td>[ ] L.PERIPORTALI</td>
			<td>[ ] ALTRO</td>
		</tr>
	</table>
	<div align="left">
		I campioni vanno confezionati in contenitore sterile a tenuta ed indetificati con etichetta riportante il n. di matricola
		dell'animale (nel caso dei FETI riportare il codice della MADRE) e natura dell'organo con i seguenti raggruppamenti:
		<ol>
		  <li>Linf. regione testa (retrofaringei - mandibolari)</li>
		  <li>Milza</li>
		  <li>Mammella - linf. sovramammari</li>
		  <li>Utero</li>
		  <li>Placenta con cotiledoni/liquido fetale (in provetta sterile) <u>oppure</u></li>
		  <li>Feto</li>
		  <li>Testicoli</li>
		</ol> 
		Devono essere inviati nel più breve tempo possibile alla vicina Sezione dell'Istituto Zooprofilattico, avendo cura di mantenerli
		a temperatura di refrigerazione. Se l'invio non è  effettuabile entro 48 ORE DAL PRELIEVO sottoporli a congelamento.
	</div>
	<br><br><br>
	<b>DATA DI INVIO ALL'ISTITUTO ZOOPROFILATTICO________________________________</b>
	<br><br><br>
	<table width="70%">
		<tr style="text-align:center">
			<td>[ ] <b>SEDE CENTRALE</b></td>
			<td>[ ] <b>SEZIONE DI ________________________</b></td>
		</tr>
	</table>
	<br><br><br><br>
	<br><br><br><br>
	<br><br><br><br>
	<br><br><br><br>
	<div align="right" style="width: 60%;">IL VETERINARIO</div>
	<br><br><br><br>
	<br><br><br><br>
	<br><br><br><br>
</div>

</body>
</html>
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
			<td rowspan="2"><b>TUBERCOLOSI BOVINA/BUFALINA<br>ALLEVAMENTO BOVINO/BUFALINO<br>SCHEDA DI RILEVAMENTO DATI AL MACELLO</b></td>
			<td><b>ALLEGATO 2<br>DGRC 104/2022</b></td>
		</tr>
		<tr>
			<td style="background: lightgray;"><b>Quesito TBC2</b></td>
		</tr>
	</table>
	<br>
	<div align="right">
		<table>
			<tr>
				<td><b>Alla sede IZSM di __________________________ <br>e.p.c.</b></td>
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
	<table class="tabellaHeader">
		<tr>
			<td style="background: lightgray;">[ ] CAPI <b><u>POSITIVI O DUBBI</u></b> ALLA PROVA <b>IDT</b> e/o [ ] CAPI <b><u>POSITIVI</u></b> ALLA PROVA <b>GAMMA INTERFERONE</b></td>
		</tr>
		<tr>
			<td>OGGETTO DI PROVVEDIMENTI DI ABBATTIMENTO PROVENIENTI DA <br> AZIENDA CON <b><u>QUALIFICA REVOCATA (FOCOLAIO) PER TBC</u></b></td>
		</tr>
	</table>
	<br>
	<h3><u>ALLEGARE COPIA DEL MODELLO 4<br><br>REPERTO ISPETTIVO</u></h3>
	
	<table width="90%">
		<tr  style="text-align:center">
			<td style="padding: 10px;">
				<b>BUFALI</b>
				<table class="tabellaContent">
					<tr  style="text-align:center">
						<td style="background: lightgray;"><b>N. E TIPO DI <br> ANIMALI ESAMITANI</b></td>
						<td style="background: lightgray;"><b>N. ANIMALI <br> CON LESIONI <br> TUBERCOLARI</b></td>
					</tr>
					<tr>
						<td>VITELLI BUFALINI (1) N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>ANNUTOLO (2) N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>ANNUTOLA (3) N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>TORI BUFALINI N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>BUFALE IN PRODUZIONE N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>BUFALE DA RIFORMA N.____</td>
						<td></td>
					</tr>
				</table>
				
			</td>
			<td style="padding: 10px;">
				<b>BOVINI</b>
				<table class="tabellaContent">
					<tr  style="text-align:center">
						<td style="background: lightgray;"><b>N. E TIPO DI <br> ANIMALI ESAMITANI</b></td>
						<td style="background: lightgray;"><b>N. ANIMALI <br> CON LESIONI <br> TUBERCOLARI</b></td>
					</tr>
					<tr>
						<td>VITELLI N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>VITELLONI N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>TORI (3) N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>MANZE N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>VACCHE IN PRODUZIONE N.____</td>
						<td></td>
					</tr>
					<tr>
						<td>VACCHE DA RIFORMA N.____</td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div align="left" style="width:80%">
	<b>
		(1) DALLA NASCITA ALLO SVEZZAMENTO<br>
		(2) DALLO SVEZZAMENTO A 24 MESI<br>
		(3) DALLO SVEZZAMENTO AL PRIMO INTERVENTO FECONDATIVO
	</b>
	</div>
	<br><br>
	<h3>MATERIALE PATOLOGICO DA PRELEVARE (1)</h3>(anche in caso di reperto anatomo-patologico negativo)
	<br><br><br>
	<table class="tabellaContent">
		<tr style="background: lightgray; text-align:center">
			<td rowspan="2" style="width:20%"><b>IN <u>PRESENZA</u> DI<br>LESIONI SOSPETTE</b></td>
			<td colspan="4"><b>IN APPARENTE <u>ASSENZA</u> DI LESIONI RIFERIBILI A TBC</b></td>
		</tr>
		<tr style="background: lightgray; text-align:center">
			<td><b>LINFONODI TESTA</b></td>
			<td><b>LINFONODI TORACE</b></td>
			<td><b>LINFONODI ADDOME</b></td>
			<td><b>ALTRI LINFONODI</b></td>
		</tr>
		<tr>
			<td rowspan="4">TESSUTI (ORGANI LINFONODI) SEDE DI LESIONE<br>Evitare di incidere a fondo i siti di lesione per non compromettere
			l'esito dell'esame colturale<br>(possibile inquinamento del campione)</td>
			<td>L. RETROFARINGEI</td>
			<td rowspan="2">L. MEDIASTINICI</td>
			<td rowspan="2">L. MESERAICI</td>
			<td>L. MAMMARI</td>
		</tr>
		<tr>
			<td>MANDIBOLARI</td>
			<td>POPLITEI</td>
		</tr>
		<tr>
			<td rowspan="2">TONSILLE</td>
			<td rowspan="2">L. TRACHEOBRONCHIALI</td>
			<td rowspan="2">L. PERIPORTALI</td>
			<td>L. PRESCAPOLARI</td>
		</tr>
		<tr>
			<td>L. ILIACI</td>
		</tr>
	</table>
	<br>
	<div align="left">
	(1): I campioni confezionati singolarmente in contenitore sterile a tenuta ed identificati con etichetta riportante il n. di matricola
dell'animale e natura dell'organo contenuto, devono essere inviati nel piu' breve tempo possibile alla vicina Sezione dell'Istituto
Zooprofilattico, avendo cura di mantenerli a temperatura di refrigerazione. Se l'invio non e' effettuabile entro 48 ORE DAL
PRELIEVO sottoporli a congelamento.
	</div>
	<br><br>
	
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
		(1) Tipo di lesione : 1- complesso primario, 2- generalizzazione acuta miliare, 3- generalizzazione protratta, 4- forma organica cronica evolutiva,
		5- collasso delle resistenze generali, 6-  nessuna lesione apparente (NVL). <br>
		(2) Descrivere le eventuali  lesioni non riconducibili all'infezione tubercolare ma a patologie in grado di generare false positivita': 1- Paratubercolosi,
		2- Distomatosi, 3- Actinogranulomastosi, 4- Elmintiasi gastro-int., 5- Lesioni da corpo estraneo, 6- Cisticercosi / idatidosi, 7- Granuloma di Roelckl,
		8- Ectoparassitosi, 9- Nocardiosi, 10- Dermatite nodosa, 11- Altro (specificare).
	</div>
	<br><br><br>
	<br><br><br>
	<br><br><br>
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
	<div align="right" style="width: 60%;">IL VETERINARIO</div>
	<br><br><br><br>
	<br><br><br><br>
	<br><br><br><br>
</div>

</body>
</html>
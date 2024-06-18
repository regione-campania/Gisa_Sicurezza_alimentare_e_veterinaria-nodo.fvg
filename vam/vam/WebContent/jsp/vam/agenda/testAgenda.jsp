	<link rel='stylesheet' type='text/css' href='js/vam/agenda/reset.css' />
	<link rel='stylesheet' type='text/css' href='js/vam/agenda/jquery.weekcalendar.css' />
		
	<script type='text/javascript' src='js/jquery/jquery-1.3.2.min.js'></script>
	<script type='text/javascript' src='js/jquery/jquery-ui-1.7.3.custom.min.js'></script>
	<script type='text/javascript' src='js/vam/agenda/jquery.weekcalendar.js'></script>
	
	<link rel='stylesheet' type='text/css' href='js/vam/agenda/calendar-us.css' />
	<script type='text/javascript' src='js/vam/agenda/calendar-us.js'></script> 
	
	
	
	<h1>Prenotazione Sala Operatoria</h1>
		
	<div id='calendar'></div>
	<div id="event_edit_container">
		<form action="vam.agenda.AddEvent.us" name="form" method="post" class="marginezero">
			<input type="hidden" />			
			<ul>
				<li>
					<span>Data: </span><span class="date_holder"></span> 
				</li>
				<li>
					<label for="start">Inizio prenotazione: </label><select name="start"><option value="">Select Start Time</option></select>
				</li>
				<li>
					<label for="end">Fine prenotazione: </label><select name="end"><option value="">Select End Time</option></select>
				</li>
				<li>
					<label for="title">Descrizione Sala: </label><input type="text" name="title" />
				</li>
				<li>
					<label for="body">Obiettivo: </label><textarea name="body"></textarea>
				</li>
			</ul>
		</form>
	</div>
	
	


<script language="JavaScript" TYPE="text/javascript"
	SRC="../javascript/gestoreCodiceFiscale.js"></script>

<script>
(function(document) {
	'use strict';

	var LightTableFilter = (function(Arr) {

		var _input;

		function _onInputEvent(e) {
			_input = e.target;
			var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
			Arr.forEach.call(tables, function(table) {
					Arr.forEach.call(table.tBodies, function(tbody) {
					Arr.forEach.call(tbody.rows, _filter);
				});
			});
		}

		function _filter(row) {
			var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
			row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
		}

		return {
			init: function() {
				var inputs = document.getElementsByClassName('light-table-filter');
				Arr.forEach.call(inputs, function(input) {
					input.oninput = _onInputEvent;
				});
			}
		};
	})(Array.prototype);

	document.addEventListener('readystatechange', function() {
		if (document.readyState === 'complete') {
			LightTableFilter.init();
		}
	});

})(document);
</script>

<span style="font-size: medium; font-family: trebuchet ms,geneva;">
     <h1>Comuni presenti in banca dati</h1> 	<input type="search" class="light-table-filter" data-table="order-table" placeholder="Filtra">
     <table border="1px" id="tabellaComuniNascita" style="border-collapse: collapse;table-layout:fixed;" width="100%" class="order-table table" >
     
     </table>
</span>     
      
    <script>    
//     var table = document.getElementById("tabellaComuniNascita");
//  	var row= table.insertRow(0);
//     for (g=arrComuni.length-1; g>-1; g=g-1){
//     	if (g%5==0 )
//     		row= table.insertRow(0);
//     	var cell1 = row.insertCell(0);
//     	// Add some text to the new cells:
//     	cell1.innerHTML = arrComuni[g][1];
    	
    var table = document.getElementById("tabellaComuniNascita");
 	var row= table.insertRow(0);
 	var numRiga= 0;
 	var numColonna = 0;
    for (g=0; g<arrComuni.length; g++){
    	if (g%1==0 ){
    		numRiga++;
    		numColonna = 0;
    		row= table.insertRow(numRiga);
    	}
    	var cell1 = row.insertCell(numColonna++);
    	// Add some text to the new cells:
    	cell1.innerHTML = arrComuni[g][1];
    		
    	
    	
    
    }
    	
    </script>
            

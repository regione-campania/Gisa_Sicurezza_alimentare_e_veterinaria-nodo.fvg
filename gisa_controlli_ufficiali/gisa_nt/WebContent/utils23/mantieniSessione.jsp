<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>


<script>
var varTimeout;

function checkKeepAlive(){
	//SE C'E' UN TIMER IN CORSO PER UN'ALTRA INTERAZIONE, LO AZZERO
	if (varTimeout!=null)
		clearTimeout(varTimeout);
	//LANCIO UN TIMER PER KEEPALIVE TRA 3 SECONDI
	varTimeout = setTimeout(keepAlive, 3000);
}

function keepAlive(){
	//CHIAMO UNA QUERY PER TENERE ATTIVA LA SESSIONE
	//PopolaCombo.keepAlive(true,{callback:keepAliveCallback,async:false }) ;
	
	//CHIAMO AJAX PER TENERE ATTIVA LA SESSIONE
	$.ajax({
        type: "POST",
        url: "welcome.jsp",
        contentType: "application/json",
        async: false,
        success: function (data) {
        }
    });
}

function keepAliveCallback(value){
	//POPOLO CAMPI DI SERVIZIO
// 	   document.getElementById("contatoreMantieni").value=parseInt((Math.random() * 10000), 10);
// 	   document.getElementById("contatoreInterazioni").value = parseInt( document.getElementById("contatoreInterazioni").value)+1;
}
</script>

<script>
$(document)
  .on('click', '*', function (evt) {
  // evt.stopImmediatePropagation();
   checkKeepAlive();
   });
  
$(document)
  .on('keypress', '*', function (evt) {
  //evt.stopImmediatePropagation();
  checkKeepAlive();
  });
  </script>
  
<!--   Rand <input type="text" readonly id="contatoreMantieni" name="contatoreMantieni" value="0" size="5"/> -->
<!--   N.Int. <input type="text" readonly id="contatoreInterazioni" name="contatoreInterazioni" value="0" size="3"/> -->
  
  
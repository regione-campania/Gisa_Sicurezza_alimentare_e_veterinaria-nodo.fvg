
var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
var eventer = window[eventMethod];
var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";

// Listen to message from child window
eventer(messageEvent,function(e) {
$("#continue_buttons").css("visibility","visible");
ShowToolTip(this, 'ATTENZIONE! E\' necessario cliccare sul pulsante <strong>Inserimento Registrazioni Completato</strong> per completare correttamente l\'inserimento della registrazione ');
$('a').removeAttr('href');
$('a').removeAttr('onclick');
},false);


function ShowToolTip(e, strText) {
    if (strText != "") {
        $("#divToolTip").show();
        var x = e.pageX;
        var y = e.pageY;
        var div = document.getElementById("divToolTip");
        div.innerHTML = strText;
        div.style.left = (x - $('#divToolTip').width() - 6) + "px";
        div.style.top = (y - $('#divToolTip').height() - 6) + "px";
    }
} 
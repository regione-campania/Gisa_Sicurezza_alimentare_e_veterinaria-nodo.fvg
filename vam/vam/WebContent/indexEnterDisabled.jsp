<script>
var blink_speed = 500; // every 1000 == 1 second, adjust to suit
var t = setInterval(function () {
    var ele = document.getElementById('myBlinkingDiv');
    ele.style.visibility = (ele.style.visibility == 'hidden' ? '' : 'hidden');
}, blink_speed);
</script>


<br/><br/>

<center>
<div id="myBlinkingDiv">
<font color="red" size="10px">ATTENZIONE!</font></div>
<br/>

<font color="red" size="6px">
L'applicazione non è accessibile. 
</font>
</center>
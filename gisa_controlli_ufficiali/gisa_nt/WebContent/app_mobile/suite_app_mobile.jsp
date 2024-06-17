

<table class="trails" cellspacing="0">
	<tr>
		<td>SUITE APP MOBILE GISA</td>
	</tr>
</table>

<center>

<dhv:permission name="campioni-campioni-preaccettazionesenzacampione-view"> 
<br>
<a href="#" onclick="linkAppPreaccettazioneSIGLA();"><h1 style="color:blue;text-decoration: underline;">App mobile Android Preaccettazione SIGLA</h1></a>
</dhv:permission>

<dhv:permission name="campioni-campioni-preaccettazionesenzacampione-view"> 
<br>
<a href="#" onclick="loadModalWindowCustom('Attendere Prego...'); window.location.href='DownloadAppMobile.do?command=AppMobileIosPreaccettazionesigla'"><h1 style="color:blue;text-decoration: underline;">App mobile iOS Preaccettazione SIGLA</h1></a>
</dhv:permission>

<dhv:permission name="campioni-campioni-preaccettazionesenzacampione-view"> 
<br>
<a href="#" onclick="linkAppWebGIS();"><h1 style="color:blue;text-decoration: underline;">App mobile Android GISA WebGIS</h1></a>
</dhv:permission>


<dhv:permission name="campioni-campioni-preaccettazionesenzacampione-view"> 
<br>
<a href="#" onclick="loadModalWindowCustom('Attendere Prego...'); window.location.href='DownloadAppMobile.do?command=AppMobileIosGisaWebGis'"><h1 style="color:blue;text-decoration: underline;">App mobile iOS GISA WebGIS</h1></a>
</dhv:permission>


</center>

<script>
function linkAppPreaccettazioneSIGLA()
{
	loadModalWindowUnlock();
	window.open('https://play.google.com/store/apps/details?id=com.preaccettazione&hl=it','_blank');
}

function linkAppWebGIS()
{
	loadModalWindowUnlock();
	window.open('https://play.google.com/store/apps/details?id=com.webgis&hl=it','_blank');
}
</script>
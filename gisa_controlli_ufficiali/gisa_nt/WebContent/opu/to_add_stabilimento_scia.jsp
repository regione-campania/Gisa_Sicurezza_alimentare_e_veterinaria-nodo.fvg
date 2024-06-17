<script language="JavaScript" TYPE="text/javascript" SRC="opu/to_add_stabilimento.js"></script>



<table>

<tr>


<td colspan="2" align= "center">
<input type="button" class="darkGreyBigButton" value="Gestione SCIA" onClick="showHide('reg1')">
</td>

<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

<td colspan="2" align="center">
<input type="button" class="darkGreyBigButton" value="Gestione Riconoscimento" onClick="goTo('OpuStab.do?command=Add&tipoInserimento=2&stato=3')">
</td>

</tr>

<tr>

<td name="reg1" style="visibility:hidden">
<input type="button" class="lightGreyBigButton" value="Gestione attività fissa"  onClick="goTo('OpuStab.do?command=Add&tipoInserimento=1&stato=7&fissa=true')">
</td>

<td name="reg1" style="visibility:hidden">
<input type="button" class="lightGreyBigButton" value="Gestione attività mobile" onClick="goTo('OpuStab.do?command=Add&tipoInserimento=1&stato=7&fissa=false')">
</td>

</tr></table>










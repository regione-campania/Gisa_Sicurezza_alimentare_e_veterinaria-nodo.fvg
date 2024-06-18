<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@page import="java.util.Date"%>

<script language="JavaScript" type="text/javascript" src="js/vam/cc/decessi/add.js"></script>

<form action="vam.cc.decessi.Add.us" name="form" method="post" id="form" class="marginezero" onsubmit="javascript:return checkform(this);">
           
  
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    <h4 class="titolopagina">
     		Registrazione Decesso
    </h4>   
       
    
    <table class="tabella">
    
    <tr class='even'>
    		<td>
    			 Data Decesso<font color="red"> *</font>
    		</td>
    		<td>    		
    			 <input type="text" id="dataMorte" name="dataMorte" maxlength="32" size="50" readonly="readonly" style="width:246px;"/>
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataMorte",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_1",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>   
    		</td>
    		<td>
			<input type="radio" name="dataMorteCerta" id="dataMorteCertaT" value="false"/><label for="dataMorteCertaT">Presunta</label>	
			<br>
			<input type="radio" name="dataMorteCerta" id="dataMorteCertaF" value="true" checked/> <label for="dataMorteCertaF">Certa</label>				
    		</td>
        </tr>
                
             
        <tr class='odd'>
	        <td>
	    		Probabile causa del decesso<font color="red"> *</font>
    		</td>
    		<td>
		        <select name="causaMorteIniziale">
		        	 <c:forEach items="${listCMI}" var="temp" >	
		        	 	<option value="${temp.id }">${temp.description }</option>	        	 				
					</c:forEach>
		        </select>
	        </td>
	        <td>
	        </td>
        </tr>
        
        <tr class='even'>
	        <td>
	    		Successiva necroscopia
    		</td>
    		<td>
		        <input type="checkbox" name="successivaNecroscopia" id="successivaNecroscopia" />
	        </td>
	        <td>
	        </td>
        </tr>
        
        
        <tr class='odd'>
        	<td>
				<font color="red">* </font> Campi obbligatori
			</td>
        	<td align="center">
        		<input type="submit" value="Salva" />
    			<input type="button" value="Annulla" onclick="attendere(), location.href='vam.cc.Detail.us'">
        	</td>
    		<td>    			
    		</td>     		   		
        </tr>
	</table>
</form>
        
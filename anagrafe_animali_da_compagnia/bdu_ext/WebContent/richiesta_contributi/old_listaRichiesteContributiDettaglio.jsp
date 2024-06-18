					<tr>						
						<td><%=c.getId_cane() %></td>
						<td><%=c.getMicrochip() %></td>
						<td><%=c.getProprietario() %></td>
						
						<% if(c.isPagato()==true) { %>
						<td>
  						<input type="radio" name="pagCane<%=i%>" value="true" disabled> Si 
						<input type="radio" name="pagCane<%=i%>" value="false" checked disabled> No<br>
						<input type="hidden" name="pagamentoCane<%=i%>" value="false">  
						</td>
						<td>						
						Questo animale risulta già pagato precedentemente						
						</td>	
						<%}
						else {
						%>
						
						<td>
  						<input type="radio" name="pagamentoCane<%=i%>" value="true" checked> Si
						<input type="radio" name="pagamentoCane<%=i%>" value="false" > No<br>
						</td>
						<td>
						</td>		
						<%}%>
					</tr>	
					
				<%}%>
 <h3>TIPO IMPRESA</h3>
        <fieldset>
                <legend>INDICARE IL TIPO DI IMPRESA CHE SI VUOLE INSERIRE</legend>
                <%
                        TipoImpresaList.setJsEvent("onchange=onChangeTipoImpresa();");
                %>
                <%=TipoImpresaList.getHtmlSelect("tipo_impresa", -1)%>
                <hr>
        </fieldset>
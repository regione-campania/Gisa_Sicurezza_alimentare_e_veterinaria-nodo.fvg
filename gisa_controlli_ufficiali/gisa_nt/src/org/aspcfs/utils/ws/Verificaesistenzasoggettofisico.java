package org.aspcfs.utils.ws;

import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.gestioneanagrafica.base.SoggettoFisico;
import org.aspcfs.modules.noscia.dao.SoggettoFisicoDAO;

import com.darkhorseventures.framework.actions.ActionContext;
import com.google.gson.Gson;

public class Verificaesistenzasoggettofisico extends CFSModule {

    public String executeCommandSearch(ActionContext context) throws Exception {

        Gson gson = new Gson();
        String json = "";
        Connection db = null;
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, String[]> parameterMap = context.getRequest().getParameterMap();
        SoggettoFisico sogg = new SoggettoFisico(parameterMap);
        ArrayList<SoggettoFisico> soggFis = new ArrayList<>();

        try {
            db = this.getConnection(context);
            SoggettoFisicoDAO soggDAO = new SoggettoFisicoDAO(sogg);
            soggFis = soggDAO.checkEsistenza(db);
        } catch (Exception errorMessage) {
            context.getRequest().setAttribute("Error", errorMessage);

        } finally {
            this.freeConnection(context, db);
        }

        if (soggFis.size() > 0)
        {
            map.put("status", "1");
            map.put("soggFisico", soggFis);
        } 
        else 
        {
            map.put("status", "2");
        }

        json = gson.toJson(map);

        PrintWriter writer = context.getResponse().getWriter();
        writer.print(json);
        writer.close();
        return "";
    }

}

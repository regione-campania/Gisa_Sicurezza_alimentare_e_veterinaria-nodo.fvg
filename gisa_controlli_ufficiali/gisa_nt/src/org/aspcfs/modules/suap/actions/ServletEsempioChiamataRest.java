package org.aspcfs.modules.suap.actions;

import java.io.File;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.modules.suap.utils.MultiPartClientUtility;
import org.json.JSONObject;
import org.json.JSONTokener;


public class ServletEsempioChiamataRest extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)  {
		

		String ip = req.getParameter("SuapIP");  
		String encryptedToken = req.getParameter("encryptedToken");
		HashMap<String, String> hmp = new HashMap<String, String>();
		hmp.put("suap_ip", ip);
		hmp.put("encrypted_token", encryptedToken);

		String pathPerFileRichiestaEsempio = getServletContext().getRealPath("/suap/richiestaEsempioServizioRest.zip");
		File fileToSend = new File(pathPerFileRichiestaEsempio);
		
		
		//chiamo servizio rest usando l'apposita utility
		try
		{
			URL urlServizioRest = new URL(req.getScheme(),req.getServerName(),req.getServerPort(),"/suap/rest/services/send");
			String rispostaServizioRest = MultiPartClientUtility.inviaRichiestaSingoloFile(urlServizioRest.toString(), fileToSend, "file1", hmp);
//			JSONParser parser = new JSONParser();
//			JSONObject jsonR = (JSONObject) parser.parse(rispostaServizioRest);
			JSONTokener tokener = new JSONTokener(rispostaServizioRest);
			JSONObject jsonR = new JSONObject(tokener);
			
			resp.getOutputStream().print(jsonR.toString());
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			
		}
		
		

	}
}

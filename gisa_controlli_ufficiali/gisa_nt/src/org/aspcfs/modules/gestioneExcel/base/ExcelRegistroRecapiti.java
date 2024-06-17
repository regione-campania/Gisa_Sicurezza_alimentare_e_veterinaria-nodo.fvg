package org.aspcfs.modules.gestioneExcel.base;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.aspcfs.utils.web.LookupList;

//DAVIDE
public class ExcelRegistroRecapiti {
	static String[] intestazioni;
	static
	{
		intestazioni= new String[]{
				"NUM REGISTRAZIONE",
				"DATA REGISTRAZIONE ENTRATA",
				"CODICE MITTENTE",
				"CODICE SPECIE",
				"CODICE RAZZA",
				"NOME CAPO",
				"MATRICOLA RIPRODUTTORE MASCHIO",
				"MATRICOLA RIPRODUTTORE FEMMINA",
				"IDENTIFICAZIONE PARTITA",
				"TIPO SEME/EMBRIONE",
				"DOSI/EMBRIONE ACQUISTATE",
				"DOCUMENTO COMMERCIALE ENTRATA",
				"DATA REGISTRAZIONE USCITA",
				"CODICE DESTINATARIO (SCARICO)",
				"DOSI/EMBRIONE VENDUTE",
				"DOSI/EMBRIONE DISTRUTTE",
				"DOCUMENTO COMMERCIALE USCITA"
			};
	}
	
	private int idRegistro = -1;
	private String dataInizio = null;
	private String dataFine = null;
	
	private String path = null;
	private String fullPath = null;
	private String nome = null;
	
	public int getIdRegistro() {
		return idRegistro;
	}


	public void setIdRegistro(int idRegistro) { 
		this.idRegistro = idRegistro;
	}


	public String getDataInizio() {
		return dataInizio;
	}


	public void setDataInizio(String dataInizio) {
		this.dataInizio = dataInizio;
	}


	public String getDataFine() {
		return dataFine;
	}


	public void setDataFine(String dataFine) {
		this.dataFine = dataFine;
	}


	public String getFullPath() {
		return fullPath;
	}


	public void setFullPath(String fullPath) {
		this.fullPath = fullPath;
	}


	public String getNome() {
		return nome;
	}


	public void setNome(String nome) {
		this.nome = nome;
	}


	public String getPath() {
		return path;
	}


	public void setPath(String path) {
		this.path = path;
	}


    public void genera(Connection db) throws SQLException, IOException {
		generaFoglioRegistro(db, idRegistro, dataInizio, dataFine, fullPath);
	}
	
	
	private void generaFoglioRegistro(Connection db, int idRegistro, String dataInizio, String dataFine, String outputPath) throws SQLException, IOException
	{
		
		XSSFWorkbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("registro recapiti");
		
		//-----stili----------------------------------------------------
		Font fontGrassetto = wb.createFont();
		fontGrassetto.setFontHeightInPoints((short)9);
		fontGrassetto.setFontName("Arial");
		fontGrassetto.setBold(true);
		
		Font fontNormale = wb.createFont();
		fontNormale.setFontHeightInPoints((short)9);
		fontNormale.setFontName("Arial");
		fontNormale.setBold(false);
		
		XSSFCellStyle stileHeader = wb.createCellStyle();
		stileHeader.setFillForegroundColor(IndexedColors.GREEN.getIndex());
		stileHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);
		stileHeader.setVerticalAlignment(CellStyle.ALIGN_CENTER);
		stileHeader.setAlignment(CellStyle.ALIGN_CENTER);
		stileHeader.setFont(fontGrassetto);
		stileHeader.setWrapText(true);
		stileHeader.setBorderBottom(CellStyle.BORDER_THIN);
		stileHeader.setBorderTop(CellStyle.BORDER_THIN);
		stileHeader.setBorderLeft(CellStyle.BORDER_THIN);
		stileHeader.setBorderRight(CellStyle.BORDER_THIN);
		
		XSSFCellStyle stileCella = wb.createCellStyle();
		stileCella.setWrapText(true);
		stileCella.setFont(fontNormale);
		stileCella.setVerticalAlignment(CellStyle.ALIGN_LEFT);
		stileCella.setAlignment(CellStyle.ALIGN_CENTER);
		
			//--------------------------------------------------------
		
		Row headerRow = sheet.createRow((short)0);
		int indiceCol = 0;
		 
		
		for(String intest : intestazioni)
		{
			Cell c = headerRow.createCell(indiceCol++);
			c.setCellValue(intest);
			c.setCellStyle(stileHeader);
			
		}
		
		CreationHelper helper = wb.getCreationHelper();
		XSSFDrawing drawing = ((XSSFSheet)sheet).createDrawingPatriarch();
		
		 
		LookupList TipiSpecie = new LookupList(db, "lookup_codici_specie_centri_riproduzione");
		LookupList TipiRazzaBovini = new LookupList(db, "lookup_razze_bovini_centri_riproduzione");
		LookupList TipiRazzaSuini = new LookupList(db, "lookup_razze_suini_centri_riproduzione");
		LookupList TipiRazzaEquini = new LookupList(db, "lookup_razze_equini_centri_riproduzione");
		LookupList TipiRazzaAsini = new LookupList(db, "lookup_razze_asini_centri_riproduzione");
		LookupList TipiSeme = new LookupList(db, "lookup_tipo_seme_embrioni");
		TipiSeme.addItem(-1, "-- SELEZIONA VOCE --");

		//estraggo le entries
		PreparedStatement pst = db.prepareStatement("select * from get_registro_carico_scarico_recapiti_excel(?, ?, ?)");
		pst.setInt(1, idRegistro);
		pst.setString(2, dataInizio);
		pst.setString(3, dataFine);
		ResultSet rs = pst.executeQuery();
		
		int indiceRiga = 0;
		HashMap<Integer,Integer> massimeLarghezzeColonne = new HashMap<Integer,Integer>();
		
		while (rs.next())
		{
			indiceCol = 0;
			indiceRiga++;
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
			
			String numRegistrazione = toHtml(rs.getString("num_registrazione"));
			String dataRegistrazioneEntrata = toHtml(rs.getString("data_registrazione_entrata"));
			String codiceMittente = toHtml(rs.getString("codice_mittente"));
			int idSpecie = rs.getInt("id_specie");
			int idRazza = rs.getInt("id_razza");
			String specie = idSpecie > 0 ? TipiSpecie.getSelectedValue(idSpecie) : "";
			String razza = idRazza > 0 ? (idSpecie==1 ? TipiRazzaBovini.getSelectedValue(idRazza) : idSpecie==2 ? TipiRazzaSuini.getSelectedValue(idRazza) : idSpecie==3 ? TipiRazzaEquini.getSelectedValue(idRazza) : idSpecie==4 ? TipiRazzaAsini.getSelectedValue(idRazza): "") : "";
			String nomeCapo = toHtml(rs.getString("nome_capo"));
			String matricolaRiproduttoreMaschio = toHtml(rs.getString("matricola_riproduttore_maschio"));
			String matricolaRiproduttoreFemmina = toHtml(rs.getString("matricola_riproduttore_femmina"));
			String identificazionePartita = toHtml(rs.getString("identificazione_partita"));
			int idTipoSeme = rs.getInt("id_tipo_seme");
			String seme = idTipoSeme > 0 ? TipiSeme.getSelectedValue(idTipoSeme) : "";
			int dosiAcquistate = rs.getInt("dosi_acquistate");
			String documentoCommercialeEntrata = toHtml(rs.getString("documento_commerciale_entrata"));
			String dataRegistrazioneUscita = toHtml(rs.getString("data_registrazione_uscita"));
			String codiceDestinatario = toHtml(rs.getString("codice_destinatario"));
			int dosiVendute = rs.getInt("dosi_vendute");
			int dosiDistrutte = rs.getInt("dosi_distrutte");
			String documentoCommercialeUscita = toHtml(rs.getString("documento_commerciale_uscita"));
			
			Row r = sheet.createRow(indiceRiga);
			
			Cell c = r.createCell(indiceCol);
			String val = numRegistrazione;
			c.setCellValue(val);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(dataRegistrazioneEntrata);
			c.setCellStyle(stileCella);
			
			c= r.createCell(++indiceCol);
			c.setCellValue(codiceMittente);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(specie);
			c.setCellStyle(stileCella);

			c = r.createCell(++indiceCol);
			c.setCellValue(razza);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(nomeCapo);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(matricolaRiproduttoreMaschio);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(matricolaRiproduttoreFemmina);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(identificazionePartita);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(seme);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(dosiAcquistate+"");
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(documentoCommercialeEntrata);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(dataRegistrazioneUscita);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(codiceDestinatario);
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(dosiVendute+"");
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(dosiDistrutte+"");
			c.setCellStyle(stileCella);
			
			c = r.createCell(++indiceCol);
			c.setCellValue(documentoCommercialeUscita);
			c.setCellStyle(stileCella);
		
		}
		
		for (int i = 0; i<20; i++ ) 
			sheet.setColumnWidth(i, 8000);
		
		//lock dell'header e delle prime 2 colonne (che scorrono )
		sheet.createFreezePane(1, 1);
		
		File out = new File(outputPath);
		FileOutputStream fos = new FileOutputStream(out);
		wb.write(fos);
		fos.close();
		
	}
	
	private String toHtml(String test){
		if (test == null)
			return "";
		return test;
	}
	
	private String toHtml(Timestamp test){
		if (test == null)
			return "";
		return test.toString();
	}
	
	
}
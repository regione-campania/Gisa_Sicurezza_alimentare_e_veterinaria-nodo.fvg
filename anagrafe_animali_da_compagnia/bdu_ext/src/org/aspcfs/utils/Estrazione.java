package org.aspcfs.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.servlet.ServletOutputStream;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.darkhorseventures.framework.actions.ActionContext;


public class Estrazione {
	 	
	static String targetFormat = "dd/MM/yyyy";
	static String currentFormat = "yyyy-MM-dd";
	
	
	public static void main(String[] args) throws SQLException {
		
		

	}

	public static String generaReportZipPOI(Connection conn, String  select, ActionContext context,String fileName) throws Exception
	{
		
		
		PreparedStatement pst = null;
		ResultSet rs = null;

		try
		{
	        
 	   		fileName = fileName +".xlsx";
 	     	
		    
		    ServletOutputStream sos =  context.getResponse().getOutputStream();
 	        context.getResponse().setContentType("application/vnd.ms-excel");
            context.getResponse().setHeader("Content-Disposition", "attachment; filename=" + fileName   );

			
			@SuppressWarnings("resource")
			//XSSFWorkbook wb = new XSSFWorkbook();
			SXSSFWorkbook wb = new SXSSFWorkbook(1000);
			
			wb.setCompressTempFiles(true);
			Sheet sheet = wb.createSheet("estrazione");
	
			
			
			//mpdifca senza cast
			XSSFCellStyle stileCellaVerde = (XSSFCellStyle) wb.createCellStyle();
			stileCellaVerde.setWrapText(true);
			stileCellaVerde.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
			stileCellaVerde.setFillPattern(CellStyle.SOLID_FOREGROUND);
//			stileCella.setLocked(true);
			stileCellaVerde.setVerticalAlignment(CellStyle.ALIGN_LEFT);
			stileCellaVerde.setAlignment(CellStyle.ALIGN_CENTER);
			pst = conn.prepareStatement( select);

			/*intestazione */
			int iRow = 0;
			rs = pst.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			while(rs.next())
			{
				if(iRow == 0)
				{
					
					Row headRow = sheet.createRow((short) 0);
					
					for(int j = 0; j<rsmd.getColumnCount(); j++)
					{
						Cell headCell = headRow.createCell(j);
						headCell.setCellStyle(stileCellaVerde);
						headCell.setCellValue(rsmd.getColumnName(j+1));
						sheet.setColumnWidth(j, 5000);
					}
					iRow++;
				}
				
				Row row = sheet.createRow(iRow);
				for(int j = 0; j< rsmd.getColumnCount(); j++)
				{
					Cell cell = row.createCell(j);
					cell.setCellValue(rs.getString(j+1));
				}
				
				iRow++;
				
		
			}
			wb.write(context.getResponse().getOutputStream());
			wb.dispose();
 		    sos.flush();
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
		finally
		{
			try{pst.close(); } catch(Exception ex){}
			try{rs.close(); } catch(Exception ex){}
		}
		
		return fileName;
	}
    

	
    
    
    
}


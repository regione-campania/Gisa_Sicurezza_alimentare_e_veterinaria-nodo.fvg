<%@ page import="java.awt.Color, java.awt.Graphics2D, java.awt.image.BufferedImage, com.itextpdf.text.pdf.Barcode128, java.io.IOException, com.sun.org.apache.xerces.internal.impl.dv.util.Base64,java.io.ByteArrayOutputStream,javax.imageio.ImageIO" %>

<%!
public static String createBarcodeImage(String code){  
	    
	com.itextpdf.text.pdf.Barcode128 code128 = new com.itextpdf.text.pdf.Barcode128();
	         code128.setCode(code);
	         java.awt.Image im = code128.createAwtImage(Color.BLACK, Color.WHITE);
	         int w = im.getWidth(null);
	     int h = im.getHeight(null);
	     BufferedImage img = new BufferedImage(w, h+12, BufferedImage.TYPE_INT_ARGB);
	     Graphics2D g2d = img.createGraphics();
	     g2d.drawImage(im, 0, 0, null);
	     g2d.drawRect(0, h, w, 12);
	     g2d.fillRect(0, h+1, w, 12);
	     g2d.setColor(Color.WHITE);
	     String s = code128.getCode();
	     g2d.setColor(Color.BLACK);
	     g2d.drawString(s,0,34);
	     g2d.dispose();
	     
	     ByteArrayOutputStream out = new ByteArrayOutputStream();
	     try {
				ImageIO.write(img, "PNG", out);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	     byte[] bytes = out.toByteArray();

	     String base64bytes = Base64.encode(bytes);
	     String src = "data:image/png;base64," + base64bytes;
	     
	     return src;
	}
	%>
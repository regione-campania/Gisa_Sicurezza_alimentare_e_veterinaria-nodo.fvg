package org.aspcfs.utils.images;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

import org.aspcfs.utils.ApplicationProperties;

public class GestioneImmagini {
	
	
	
	
	  public static BufferedImage resizeImage(BufferedImage originalImage, int type){
			BufferedImage resizedImage = new BufferedImage(Integer.parseInt(ApplicationProperties.getProperty("IMG_WIDTH")), 
					Integer.parseInt(ApplicationProperties.getProperty("IMG_HEIGHT")), type);
			Graphics2D g = resizedImage.createGraphics();
			g.drawImage(originalImage, 0, 0, Integer.parseInt(ApplicationProperties.getProperty("IMG_WIDTH")), 
					Integer.parseInt(ApplicationProperties.getProperty("IMG_HEIGHT")), null);
			g.dispose();
		 
			return resizedImage;
		    }

}

package org.aspcfs.utils;

public enum TipoCategoriaRendicontazione {


    Da_macello(1),
    Da_esportazione(2),
    Importati_per_allevamento(4),
    Altri_animali_trasportati(6);
 
    
    private int indice_categoria;
    
    private TipoCategoriaRendicontazione(int cat) {
            this.indice_categoria = cat;
    }

    public int getCategoria() {
            return indice_categoria;
    }

    public void setCategoria(int categoria) {
            this.indice_categoria = categoria;
    }
    
    
}

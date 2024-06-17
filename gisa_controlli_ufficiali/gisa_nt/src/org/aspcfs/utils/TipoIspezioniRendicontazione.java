package org.aspcfs.utils;

public enum TipoIspezioniRendicontazione {


    Durante_il_trasporto(69),
    Al_luogo_arrivo(74),
    Al_mercato(71),
    Al_luogo_partenza(73),
    Ai_punti_di_sosta(70),
    Ai_punti_trasferimento(72),
    Controlli_documentali(75);
 
    
    private int indiceTipoIspezione;
    
    private TipoIspezioniRendicontazione(int tipo) {
            this.indiceTipoIspezione = tipo;
    }

    public int getIndiceTipoIspezione() {
            return indiceTipoIspezione;
    }

    public void setTipoIspezione(int tipo) {
            this.indiceTipoIspezione = tipo;
    }
    
    
}

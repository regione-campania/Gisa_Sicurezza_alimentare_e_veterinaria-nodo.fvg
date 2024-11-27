/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ActivatedRouteSnapshot, ResolveFn, RouterStateSnapshot } from "@angular/router";
import { inject } from '@angular/core'
import { RiepilogoService, CapannoniService } from "../services";
import { AziendeService } from "../services";
import { CapiService } from "../services";
import { AllevamentiService } from "../services/allevamenti.service";
import { CapiInStallaService } from "../services/capiInStalla.service";
import { MovimentazioniCapoService } from "../services/movimentazioniCapo.service";
import { InterventiService } from "../services/interventi.service";
import { CapannoniComponent } from "../capannoni/capannoni.component";
import { PreaccettazioniService } from "../services/preaccettazioni.service";
import { PreaccettazioniCapiService } from "../services/preaccettazioniCapi.service";
import { PreaccettazioniStatiService } from "../services/preaccettazionStati.service";
import { SottoscrizioniService } from "../services/sottoscrizioni.service";
import { SottoscrizioniElaborazioniService } from "../services/sottoscrizioniElaborazioni.service";
import { SottoscrizioniElaborazioniFilesService } from "../services/sottoscrizioniElaborazioniFiles.service";
import { MonitoraggioAllevamentiService } from "../services/monitoraggioAllevamenti.service";

export const riepilogoResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  return inject(RiepilogoService).getAllevamentiRiep('get_allevamenti_riep');
}

export const aziendeResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  return inject(AziendeService).getAziende('get_aziende');
}

export const pianiResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  return inject(InterventiService).getPiani();
}

export const nuovoInterventoResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  return inject(InterventiService).getListaPiani();
}

export const risultatiResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  const id_intervento = parseInt(route.queryParams['id_intervento']);
  return inject(InterventiService).getRisultati(id_intervento);
}

export const giornataResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => { }

export const capiResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  // return inject(CapiService).getCapi('get_capi');
}

export const allevamentiResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  if (route.queryParams['specie_allev']) {
    const specie_allev = route.queryParams['specie_allev'];
    return inject(AllevamentiService).getAllevamenti('get_allevamenti', { specie_allev: specie_allev });
  } else {
    const id_azienda = parseInt(route.queryParams['id_azienda']);
    return inject(AllevamentiService).getAllevamenti('get_allevamenti', { id_azienda: id_azienda });
  }
}

export const capiInStallaResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  console.log("queryParams:", route.queryParams);
  const id_allevamento = parseInt(route.queryParams['id_allevamento']);
  const cod_gruppo_specie = route.queryParams['cod_gruppo_specie'];
  const ws: string = route.queryParams['ws'];
  const multiWS: string[] = ws?.split(';');
  console.log("multiWS:", multiWS);
  return inject(CapiInStallaService).getCapiInStalla(`get_${multiWS?.[0]}`, { id_allevamento: id_allevamento, cod_gruppo_specie: cod_gruppo_specie });
}

export const capapnnoniResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  const id_allevamento = parseInt(route.queryParams['id_allevamento']);
  console.log("id_allevamento:", id_allevamento);
  return inject(CapannoniService).getCapannoni({ id_allevamento: id_allevamento });
}

export const movimentazioniCapoResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  // const marchio = route.queryParams['marchio'];
  const idCapo = parseInt(route.queryParams['idCapo']);
  return inject(MovimentazioniCapoService).getMovimentazioniCapo('get_movimentazioni_capo', { id_capo: idCapo });
}


export const preaccettazioniResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  // const marchio = route.queryParams['marchio'];

  return inject(PreaccettazioniService).getPreaccettazioni('get_preacc');
}




export const preaccettazioniCapiResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  // const marchio = route.queryParams['marchio'];
  const idPreAcc = parseInt(route.queryParams['idPreAcc']);
  console.log("idPreAcc:", idPreAcc);
   return inject(PreaccettazioniCapiService).getPreaccettazioniCapiFiltered( idPreAcc );
}


export const preaccettazioniStatiResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  const idPreAcc = parseInt(route.queryParams['idPreAcc']);
  console.log("idPreAcc:", idPreAcc);
  return inject(PreaccettazioniStatiService).getPreaccettazioniStatiFiltered( idPreAcc );
}


export const sottoscrizioniResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {
  return inject(SottoscrizioniService).getSottoscrizioni('get_sottoscrizioni');
}



export const sottoscrizioniElaborazioniResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {

  const idSottoscrizione = parseInt(route.queryParams['id_sottoscrizione']);

  console.log("idSottoscrizione:", idSottoscrizione);
   return inject(SottoscrizioniElaborazioniService).getSottoscrizioniElaborazioniFiltered( idSottoscrizione );
  }




export const sottoscrizioniElaborazioniFilesResolver: ResolveFn<any> = (
  route: ActivatedRouteSnapshot, state: RouterStateSnapshot
) => {

  const idElaborazione = parseInt(route.queryParams['id_elaborazione']);

  console.log("idElaborazione:", idElaborazione);
   return inject(SottoscrizioniElaborazioniFilesService).getSottoscrizioniElaborazioniFilesFiltered( idElaborazione);
  }


  export const monitoraggioAllevamentiResolver: ResolveFn<any> = (
    route: ActivatedRouteSnapshot, state: RouterStateSnapshot
  ) => {
    return inject(MonitoraggioAllevamentiService).getMonitoraggioAllevamenti('get_confronto_allevamenti_gisa_bdn');
  }

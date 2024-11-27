/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ATreeComponent, LoadingDialogService, NotificationService } from '@us/utils';
import { AnagraficaService } from '../anagrafica.service';
import { anagraficaUnicaService } from 'src/app/portals/controlli-ufficiali/services/anagraficaUnica.service';
import { Location } from '@angular/common';

@Component({
  selector: 'app-allineamento-parix',
  templateUrl: './allineamento-parix.component.html',
  styleUrls: ['./allineamento-parix.component.scss']
})
export class AllineamentoParixComponent {

  @ViewChild('json_parix_tree') json_parix_tree?: ATreeComponent;

  json_parix: any
  xml_parix: any = ''
  _json_parix_tree: any
  saved_c: any = 0

  sedi: any
  persone: any
  sezione: any
  dati_impresa: any
  dati_stabilimento: any
  indirizzi_stabilimento: any = []
  id_sede_stabilimento: any
  id_stabilimento_figura: any

  mappaturaAlberi = ((node: any) => {
    //node.expanded = true
    return node
  })

  private _piva_presa: any
  private _id_impresa: any
  private _id_stabilimento: any
  private _impresa: any
  private _ui_impresa: any
  private _stabilimento: any
  private _ui_stabilimento: any

  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private cus: AnagraficaService,
    private LoadingService: LoadingDialogService,
    private aus: anagraficaUnicaService,
    private notificationService: NotificationService,
    private location: Location
  ) { }

  ngOnInit() {
    this.sezione = this.router.routerState.snapshot.url
    this.sezione = this.sezione.split('?')[0] //rimuove query string
    this.sezione = this.sezione.split('/') //divide ogni segmento
    this.sezione = this.sezione.pop() //prende l'ultimo

    this.route.queryParams.subscribe(params => {
      if (params['id_impresa']) {
        this._id_impresa = +params['id_impresa']

        this.cus.getImpresaSingolo(this._id_impresa).subscribe((res: any) => {
          this._impresa = res.info.dati[0]
          this._ui_impresa = res.info.ui
          this.dettaglioCompleto()

        })
      } else if (params['piva']) {
        this._piva_presa = params['piva']
        this.dettaglioCompleto()
      }

      if (params['id_stabilimento']) {
        this._id_stabilimento = params['id_stabilimento']
        this.cus.getStabilimentoSingolo(this._id_stabilimento).subscribe(res => {
          if (res.info) {
            this._stabilimento = res.info.dati[0]
            this._ui_stabilimento = res.info.ui
          }
        })
      }

      if (params['id_sede_stabilimento']) {
        this.id_sede_stabilimento = params['id_sede_stabilimento']
      }

      if (params['id_stabilimento_figura']) {
        this.id_stabilimento_figura = params['id_stabilimento_figura']
      }
    })

  }

  dettaglioCompleto() {
    this.LoadingService.openDialog('Caricamento PARIX in corso...')
    this.aus.dettaglioCompletoImpresa(this._piva_presa ?? this._impresa.piva ?? this._impresa.cf).subscribe((res: any) => {
      this.LoadingService.closeDialog()
      if (res) {
        this.json_parix = res.RISPOSTA
        const parser = new DOMParser()
        let xml = parser.parseFromString(res.RISPOSTA_RAW, "text/xml")
        this._json_parix_tree = []
        this.dati_impresa = this.json_parix.DATI[0].DATI_IMPRESA[0]

        // let dateString = this.dati_impresa.DURATA_SOCIETA[0].DT_COSTITUZIONE[0];
        // let year = parseInt(dateString.substring(0, 4), 10);
        // let month = parseInt(dateString.substring(4, 6), 10) - 1;
        // let day = parseInt(dateString.substring(6, 8), 10);
        // this.dati_impresa.DURATA_SOCIETA[0].DT_COSTITUZIONE[0] = new Date(year, month, day)

        // dateString = this.dati_impresa.DURATA_SOCIETA[0].DT_TERMINE[0];
        // year = parseInt(dateString.substring(0, 4), 10);
        // month = parseInt(dateString.substring(4, 6), 10) - 1;
        // day = parseInt(dateString.substring(6, 8), 10);
        // this.dati_impresa.DURATA_SOCIETA[0].DT_TERMINE[0] = new Date(year, month, day)
        if (this.json_parix.DATI[0].DATI_IMPRESA) {
          if (this.json_parix.DATI[0].DATI_IMPRESA[0].PERSONE_SEDE) {
            this.persone = this.json_parix.DATI[0].DATI_IMPRESA[0].PERSONE_SEDE[0].PERSONA
          }
        }
        this.sedi = this.json_parix.DATI[0].DATI_IMPRESA[0].INFORMAZIONI_SEDE
        if (this.sezione == 'stabilimento' || this.sezione == 'sede') {
          this.dati_stabilimento = this.dati_impresa
          this.sedi.forEach((sede: any) => {
            this.indirizzi_stabilimento.push(sede.INDIRIZZO[0])
          })
          // x le società
          if (this.dati_stabilimento.LOCALIZZAZIONI) {
            this.dati_stabilimento.LOCALIZZAZIONI[0].LOCALIZZAZIONE.forEach((sede: any) => {
              this.indirizzi_stabilimento.push(sede.INDIRIZZO[0])
            })
          }

          if (this._id_stabilimento) {
            if (this.dati_stabilimento.LOCALIZZAZIONI) {
              this.dati_stabilimento.LOCALIZZAZIONI[0].LOCALIZZAZIONE.forEach((sede: any) => {
                this.sedi.push({ INDIRIZZO: [sede.INDIRIZZO[0]] })
              })
            }
            // console.log(this.sedi)
          }
        }
        //this.stampaAlberoXML(xml.childNodes[0].childNodes[1], 0)
        this.stampaAlberoXML(xml, 0)
      } else {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Impresa non trovata.`
        });
        this.location.back()
      }
    })
  }

  stampaAlberoXML(xmlData: any, n: number) {
    this.saved_c++
    xmlData.childNodes.forEach((childNode: any) => {
      let descr = childNode.localName ?? childNode.nodeValue
      let node = { id_node: this.saved_c, id_node_parent: n > 0 ? n : null, descrizione_breve: descr }
      this._json_parix_tree.push(node)
      this.stampaAlberoXML(childNode, this.saved_c)
    })
  }

  upsertImpresa() {
    let toStr: any = {
      "ESTREMI_IMPRESA": this.dati_impresa.ESTREMI_IMPRESA,
      "INFORMAZIONI_SEDE": this.dati_impresa.INFORMAZIONI_SEDE,
    }
    // console.log(toStr)
    if (this._id_impresa) {
      this.router.navigate(['portali/anagrafica/allineamento-parix/impresa/modifica'], { queryParams: { id_impresa: this._id_impresa, parix_impresa: JSON.stringify(toStr) } })
    } else {
      this.router.navigate(['portali/anagrafica/allineamento-parix/impresa/aggiungi'], { queryParams: { id_impresa: this._id_impresa, parix_impresa: JSON.stringify(toStr) } })
    }
  }


  upsertStabilimento(indirizzo: any) {
    if (this._id_stabilimento) {
      this.router.navigate(['portali/anagrafica/allineamento-parix/stabilimento/modifica'], { queryParams: { id_stabilimento: this._id_stabilimento, parix_stabilimento: JSON.stringify(indirizzo) } })
    } else {
      this.router.navigate(['portali/anagrafica/allineamento-parix/stabilimento/aggiungi'], { queryParams: { id_impresa: this._id_impresa, parix_stabilimento: JSON.stringify(indirizzo) } })
    }
  }

  upsertSede(sede: any) {
    if (this._id_stabilimento) {
      //sedi
      if (this.id_sede_stabilimento) {
        //modifica
        this.router.navigate(['portali/anagrafica/allineamento-parix/sede/modifica'], { queryParams: { id_sede_parix: this.id_sede_stabilimento, id_stabilimento_parix: this._id_stabilimento, parix_sede: JSON.stringify(sede), nome: this.dati_impresa.ESTREMI_IMPRESA[0].DENOMINAZIONE[0] } })
      } else {
        this.router.navigate(['portali/anagrafica/allineamento-parix/sede/aggiungi'], { queryParams: { id_stabilimento: this._id_stabilimento, parix_sede: JSON.stringify(sede), nome: this.dati_impresa.ESTREMI_IMPRESA[0].DENOMINAZIONE[0] } })
      }
    } else if (this._id_impresa) {
      //imprese
      this.cus.getImpreseSedi(this._id_impresa).subscribe((res: any) => {
        if (res.info) {
          let id_sede_legale
          res.info.dati.forEach((sede: any) => {
            if (!sede.fine_validita && sede.cod_tipo_sede == 'sl') {
              id_sede_legale = sede.id
            }
          });

          if (id_sede_legale) {
            //modifica
            this.router.navigate(['portali/anagrafica/allineamento-parix/sede/modifica'], { queryParams: { id_sede_parix: id_sede_legale, id_impresa_parix: this._id_impresa, parix_sede: JSON.stringify(sede), nome: this.dati_impresa.ESTREMI_IMPRESA[0].DENOMINAZIONE[0] } })
          } else {
            this.router.navigate(['portali/anagrafica/allineamento-parix/sede/aggiungi'], { queryParams: { id_impresa_parix: this._id_impresa, parix_sede: JSON.stringify(sede), nome: this.dati_impresa.ESTREMI_IMPRESA[0].DENOMINAZIONE[0] } })
          }
        }
      })
    }
  }

  upsertPersona(persona: any) {
    let rapp_legale: any = null
    let flag_soggetto: 'modifica' | 'aggiungi'
    let flag_figura: 'modifica' | 'aggiungi'
    let id_figura_parix: any
    let id_soggetto_parix: any

    if (this._id_stabilimento) {

      let params = { "cf": persona.PERSONA_FISICA[0].CODICE_FISCALE[0], "nome": null, "cognome": null, "comune_nascita": null, "data_nascita": null, "limite": "1000" }
      this.cus.getSoggettiBySel(params).subscribe(res => {
        if (res.info) {
          flag_soggetto = 'modifica'
          id_soggetto_parix = res.info.dati[0].id_soggetto_fisico
        } else {
          flag_soggetto = 'aggiungi'
          id_soggetto_parix = null
        }

        if (this.id_stabilimento_figura) {
          flag_figura = 'modifica'
          id_figura_parix = this.id_stabilimento_figura
        } else {
          flag_figura = 'aggiungi'
          id_figura_parix = null
        }

        //goto ...
        if (flag_soggetto == 'aggiungi')
          this.router.navigate(['portali/anagrafica/allineamento-parix/figura/soggetti/aggiungi'], { queryParams: { id_soggetto_parix: id_soggetto_parix, id_figura_parix: id_figura_parix, id_stabilimento_parix: this._id_stabilimento, parix_soggetto: JSON.stringify(persona) } })
        else
          //this.router.navigate(['portali/anagrafica/allineamento-parix/figura/soggetti/modifica'], { queryParams: { id_soggetto_parix: id_soggetto_parix, id_figura_parix: id_figura_parix, id_impresa_parix: this._id_impresa, parix_soggetto: JSON.stringify(persona) } })
          if (id_figura_parix) {
            //modifica figura -> cessa e aggiungi nuova
            // this.router.navigate(['portali/anagrafica/allineamento-parix/figura/modifica'], { queryParams: { id_impresa_figura_parix: id_figura_parix, parix_soggetto: JSON.stringify(persona) } })
            this.router.navigate(['portali/anagrafica/allineamento-parix/figura/aggiungi'], { queryParams: { id_stabilimento: this._id_stabilimento, parix_soggetto: JSON.stringify(persona) } })
          } else {
            //aggiungi figura
            this.router.navigate(['portali/anagrafica/allineamento-parix/figura/aggiungi'], { queryParams: { id_stabilimento: this._id_stabilimento, parix_soggetto: JSON.stringify(persona) } })
          }
      })


    } else if (this._id_impresa) {
      this.cus.getImpreseFigure(this._id_impresa).subscribe((res: any) => {
        if (res.info) {
          res.info.dati.forEach((ele: any) => {
            if (ele.descr_tipo_figura === 'Legale Rappresentante' && ele.fine_validita == null) {
              rapp_legale = ele
            }
          })
          //persona.PERSONA_FISICA[0].CODICE_FISCALE[0] == rapp_legale.cf_figura

          if (rapp_legale) {
            flag_figura = 'modifica'
            id_figura_parix = rapp_legale.id_impresa_figura
          } else {
            flag_figura = 'aggiungi'
            id_figura_parix = null
          }

          let params = { "cf": persona.PERSONA_FISICA[0].CODICE_FISCALE[0], "nome": null, "cognome": null, "comune_nascita": null, "data_nascita": null, "limite": "1000" }
          this.cus.getSoggettiBySel(params).subscribe((res: any) => {
            if (res.info) {
              flag_soggetto = 'modifica'
              id_soggetto_parix = res.info.dati[0].id_soggetto_fisico
            } else {
              flag_soggetto = 'aggiungi'
              id_soggetto_parix = null
            }

            //console.log('soggetto: ' + flag_soggetto + ' - figura: ' + flag_figura)
            //console.log('soggetto_parix: ' + id_soggetto_parix + ' - figura: ' + id_figura_parix)

            //goto ...
            if (flag_soggetto == 'aggiungi')
              this.router.navigate(['portali/anagrafica/allineamento-parix/figura/soggetti/aggiungi'], { queryParams: { id_soggetto_parix: id_soggetto_parix, id_figura_parix: id_figura_parix, id_impresa_parix: this._id_impresa, parix_soggetto: JSON.stringify(persona) } })
            else
              //this.router.navigate(['portali/anagrafica/allineamento-parix/figura/soggetti/modifica'], { queryParams: { id_soggetto_parix: id_soggetto_parix, id_figura_parix: id_figura_parix, id_impresa_parix: this._id_impresa, parix_soggetto: JSON.stringify(persona) } })
              if (id_figura_parix) {
                //modifica figura -> cessa e aggiungi nuova
                // this.router.navigate(['portali/anagrafica/allineamento-parix/figura/modifica'], { queryParams: { id_impresa_figura_parix: id_figura_parix, parix_soggetto: JSON.stringify(persona) } })
                this.router.navigate(['portali/anagrafica/allineamento-parix/figura/aggiungi'], { queryParams: { id_impresa: this._id_impresa, parix_soggetto: JSON.stringify(persona) } })
              } else {
                //aggiungi figura
                this.router.navigate(['portali/anagrafica/allineamento-parix/figura/aggiungi'], { queryParams: { id_impresa: this._id_impresa, parix_soggetto: JSON.stringify(persona) } })
              }
          })
        }
      })
    }
  }

  get impresa() { return this._impresa }
  get ui_impresa() { return this._ui_impresa }
  get stabilimento() { return this._stabilimento }
  get ui_stabilimento() { return this._ui_stabilimento }
}

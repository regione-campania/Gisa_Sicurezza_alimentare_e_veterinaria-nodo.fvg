/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { anagraficaUnicaService } from 'src/app/portals/controlli-ufficiali/services/anagraficaUnica.service';

@Component({
  selector: 'app-imprese-dettaglio',
  templateUrl: './imprese-dettaglio.component.html',
  styleUrls: ['./imprese-dettaglio.component.scss']
})
export class ImpreseDettaglioComponent {

  _xml: any
  output_xml: any = ''
  output_json: any = ''

  private _id_impresa: any
  private _impresa: any
  private _ui_impresa: any

  private _stabilimenti: any
  private _ui_stabilimenti: any
  private _figure: any
  private _ui_figure: any
  private _sedi: any
  private _ui_sedi: any

  disabilitaAggFigure: boolean = false
  disabilitaAggSedi: boolean = false
  disabilitaStabEImpresa: boolean = false
  disabilitaModFigureESedi: boolean = false

  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private cus: AnagraficaService,
    private LoadingService: LoadingDialogService,
    private aus: anagraficaUnicaService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()
    this.route.queryParams.subscribe(params => {
      this._id_impresa = +params['id_impresa']

      this.cus.getImpresaSingolo(this._id_impresa).subscribe((res: any) => {
        this._impresa = res.info.dati[0]
        this._ui_impresa = res.info.ui

        if (!this._impresa.impresa_modificabile) {
          this.disabilitaStabEImpresa = true;
          this.disabilitaModFigureESedi = true;
        }
        if (!this._impresa.figure_modificabili) {
          this.disabilitaAggFigure = true;
        }
        if (!this._impresa.sedi_modificabili) {
          this.disabilitaAggSedi = true;
        }


        this.cus.getImpresaStabilimenti(this._id_impresa).subscribe((res: any) => {
          if (res.info) {
            this._stabilimenti = res.info.dati
            this._ui_stabilimenti = res.info.ui
          }
          if (this._impresa.fine_validita) {
            this.disabilitaStabEImpresa = true;
            this.disabilitaModFigureESedi = true;
          }

          // this.cus.getStabilimentiFigureByImpresa(this._id_impresa).subscribe((res: any) => {
          //   if (res.info) {
          //     this._figure = res.info.dati
          //     this._ui_figure = res.info.ui
          //   }

          //   this.LoadingService.closeDialog()
          // });
          this.cus.getImpreseFigure(this._id_impresa).subscribe((res: any) => {
            if (res.info) {
              this._figure = res.info.dati
              this._ui_figure = res.info.ui

              let cnt = 0 // x figure max 1
              this._figure.forEach((figura: any) => {
                //impossibile avere piu sedi con la stessa tipologia attive quindi basta contare quelle
                if (!figura.fine_validita) {
                  cnt++
                }
              });
              // issue #12599
              // if (cnt >= 1 || this._impresa.fine_validita) {
              //   this.disabilitaAggFigure = true
              // }

            }

            this.cus.getImpreseSedi(this._id_impresa).subscribe((res: any) => {
              if (res.info) {
                this._sedi = res.info.dati
                this._ui_sedi = res.info.ui

                let cnt = 0 // x sedi max 2
                this._sedi.forEach((sede: any) => {
                  //impossibile avere piu sedi con la stessa tipologia attive quindi basta contare quelle
                  if (!sede.fine_validita) {
                    cnt++
                  }
                });

                if (cnt >= 2 || this._impresa.fine_validita) {
                  this.disabilitaAggSedi = true
                }
              }

              this.LoadingService.closeDialog()
            })
          })
        });
      });
    });

  }

  goToModifica() {
    if (this.disabilitaStabEImpresa == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/imprese/modifica'], { queryParams: { id_impresa: this._id_impresa } })
  }

  goToAggiungiStabilimento() {
    if (this.disabilitaStabEImpresa == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/aggiungi'], { queryParams: { id_impresa: this._id_impresa } })
  }

  goToStabilimento(id_stabilimento: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/dettaglio'], { queryParams: { id_stabilimento: +id_stabilimento } })
  }

  goToAggiungiSede() {
    if (this.disabilitaAggSedi == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/sedi/aggiungi'], { queryParams: { id_impresa: this._id_impresa, nome: this._impresa.nome } })
  }

  goToAggiungiFigura() {
    if (this.disabilitaAggFigure == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/figure/aggiungi'], { queryParams: { id_impresa: this._id_impresa } })
  }

  goToSede(id_sede: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/sedi'], { queryParams: { id_sede_impresa: id_sede } })
  }

  goToFigura(id_figura: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/figure'], { queryParams: { id_impresa_figura: id_figura } })
  }

  goToPARIX() {
    this.router.navigate(['portali/anagrafica/allineamento-parix/impresa'], { queryParams: { id_impresa: this._id_impresa } })
  }

  dettaglioCompleto() {
    this.aus.dettaglioCompletoImpresa(this._impresa.piva ?? this._impresa.cf).subscribe((res: any) => {
      //const parser = new DOMParser()
      console.log(res)
      //this._xml = parser.parseFromString(res, "text/xml")
      //this.stampaAlberoXML(this._xml, 0)
      console.log('HEADER', res.RISPOSTA.HEADER[0])
      console.log('DATI IMPRESA', res.RISPOSTA.DATI[0].DATI_IMPRESA[0])
    })
  }

  stampaAlberoXML(xmlData: XMLDocument, n: number) {
    xmlData.childNodes.forEach((childNode: any) => {
      for (let i = 0; i <= n; i++) this.output_xml += '\t' //formatta x livello
      if (childNode.localName) this.output_xml += childNode.localName + ': \n'
      else if (childNode.nodeValue) this.output_xml += '\t"' + childNode.nodeValue + '"\n'
      this.stampaAlberoXML(childNode, n + 1)
    })
  }

  get impresa() { return this._impresa }
  get ui_impresa() { return this._ui_impresa }
  get stabilimenti() { return this._stabilimenti }
  get ui_stabilimenti() { return this._ui_stabilimenti }
  get figure() { return this._figure }
  get ui_figure() { return this._ui_figure }
  get sedi() { return this._sedi }
  get ui_sedi() { return this._ui_sedi }
}

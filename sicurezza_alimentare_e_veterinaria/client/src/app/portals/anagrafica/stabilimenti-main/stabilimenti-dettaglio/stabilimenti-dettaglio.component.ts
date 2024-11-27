/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { PdfRiepilogoService } from '../../services/pdf-riepilogo.service';
import { AppService } from 'src/app/app.service';

@Component({
  selector: 'app-stabilimenti-dettaglio',
  templateUrl: './stabilimenti-dettaglio.component.html',
  styleUrls: ['./stabilimenti-dettaglio.component.scss']
})
export class StabilimentiDettaglioComponent {

  disabilitaAggSedi: boolean = false
  disabilitaAggFigure: boolean = false
  disabilitaModificaSedi: boolean = false
  disabilitaModificaFigure: boolean = false
  disabilitaAggLinee: boolean = false
  disabilitaModificaStab: boolean = false
  abilitaSubingresso: boolean = true

  private _id_stabilimento: any
  private _stabilimento: any
  private _ui_stabilimento: any

  private _ui_sedi: any
  private _sedi: any
  private _sedi_v: any
  private _ui_figure: any
  private _figure: any
  private _figure_v: any
  private _ui_linee: any
  private _linee: any
  private _linee_v: any
  private _tipiSedi: any;
  private _tipiFigure: any;
  private _tipiStrutture: any;

  private _cu_effettuati: any
  private _cu_programmati: any
  private _provv_passati: any
  private _provv_in_corso: any

  private _ui_storico: any
  private _storico: any
  private _sede_legale: any
  private _rapp_legale: any

  private maxValueDate: number = 8.64e15;
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private ans: AnagraficaService,
    private LoadingService: LoadingDialogService,
    private rs: PdfRiepilogoService,
    private app: AppService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()
    this.route.queryParams.subscribe(params => {
      this._id_stabilimento = +params['id_stabilimento']
      this.ans.getStabilimentoSingolo(this._id_stabilimento).subscribe((res: any) => {
        this._stabilimento = res.info.dati[0]
        this._ui_stabilimento = res.info.ui

        this.abilitaSubingresso = this._stabilimento.subingresso_abilitato

        //Per le sedi e le figure devo disabilitare il tasto "Dettaglio", quindi per il modifica, solamente quando mi restituisce
        //sedi o figure modificabili a false
        if (this._stabilimento.figure_modificabili == false) {
          this.disabilitaModificaFigure = this.stabilimento.figure_modificabili;
          this.disabilitaModificaFigure = !this.disabilitaModificaFigure;
        }
        if (this._stabilimento.sedi_modificabili == false) {
          this.disabilitaModificaSedi = this.stabilimento.sedi_modificabili;
          this.disabilitaModificaSedi = !this.disabilitaModificaSedi;
        }
        if (this._stabilimento.stabilimento_modificabile == false) {
          this.disabilitaModificaStab = this.stabilimento.stabilimento_modificabile;
          this.disabilitaModificaStab = !this.disabilitaModificaStab;
        }

        this.ans.getImpreseSedi(this.stabilimento.id_impresa).subscribe((res: any) => {
          if (res.info) {
            res.info.dati.forEach((ele: any) => {
              if (ele.descr_tipo_sede === 'Sede Legale') {
                this._sede_legale = ele
              }
            })
          }
        })

        this.ans.getImpreseFigure(this.stabilimento.id_impresa).subscribe((res: any) => {
          if (res.info) {
            res.info.dati.forEach((ele: any) => {
              if (ele.descr_tipo_figura === 'Legale Rappresentante' && ele.fine_validita == null) {
                this._rapp_legale = ele
              }
            })
          }
        })

        this.ans.getStabilimentiSedi(this._id_stabilimento).subscribe((res: any) => {
          if (res.info) {
            this._sedi = res.info.dati
            this._sedi_v = res.info.dati_validi
            this._ui_sedi = res.info.ui

            this.ans.getTipiSedi().subscribe((res: any) => {
              this._tipiSedi = res.info?.dati;
              let cntTipoSedi = 0
              if (this._sedi) {
                this._sedi.forEach((sede: any) => {
                  //impossibile avere piu sedi con la stessa tipologia attive quindi basta contare quelle
                  if (!sede.fine_validita) {
                    cntTipoSedi++
                  }
                });
              }
              //Per l'aggiungi devo tenere conto anche se è chiuso e i tipi sedi inserite
              if (this._stabilimento.chiuso || cntTipoSedi >= Object.keys(this._tipiSedi).length || this._stabilimento.sedi_modificabili == false)
                this.disabilitaAggSedi = true;
              else
                this.disabilitaAggSedi = false;

            })
          }

          this.ans.getStabilimentiFigure(this._id_stabilimento).subscribe((res: any) => {
            if (res.info) {
              this._figure = res.info.dati
              this._figure_v = res.info.dati_validi
              this._ui_figure = res.info.ui

              this.ans.getTipiFigure().subscribe((res: any) => {
                this._tipiFigure = res.info?.dati;
                let cntTipoFigure = 0
                if (this._figure) {
                  this._figure.forEach((figure: any) => {
                    if (!figure.fine_validita) {
                      cntTipoFigure++;
                    }
                  })
                }
                //Per l'aggiungi devo tenere conto anche se è chiuso e i tipi figure inserite
                if (this._stabilimento.chiuso || cntTipoFigure >= Object.keys(this._tipiFigure).length || this._stabilimento.figure_modificabili == false)
                  this.disabilitaAggFigure = true;
                else
                  this.disabilitaAggFigure = false;
              })
            }


            this.ans.getStabilimentiLinee(this._id_stabilimento).subscribe((res: any) => {
              if (res.info) {
                //Controllo per la linea principale
                if (res.info.dati.length > 0) {
                  this._linee = res.info.dati
                  this._linee_v = res.info.dati_validi
                  this._ui_linee = res.info.ui

                  let cntPrinc = 0
                  this._linee.forEach((linea: any) => {
                    if (linea.linea_principale)
                      cntPrinc++
                  });

                  if (cntPrinc != 1) {
                    //Se è l'unica la setto automaticamente a principale
                    if (res.info.dati.length === 1) {
                      this.updLineaPrincipale(res.info.dati[0].id_linea)
                    }
                    else {
                      let id_linea_min: any = null
                      let dt_linea_min: any = null

                      this._linee.forEach((linea: any) => {
                        if (!linea.fine_validita) {
                          if (id_linea_min == null && dt_linea_min == null) {
                            id_linea_min = linea.id_linea
                            dt_linea_min = linea.inizio_validita
                          } else if (linea.inizio_validita < dt_linea_min) {
                            id_linea_min = linea.id_linea
                            dt_linea_min = linea.inizio_validita
                          } else if (linea.inizio_validita == dt_linea_min && linea.id_linea < id_linea_min) {
                            id_linea_min = linea.id_linea
                            dt_linea_min = linea.inizio_validita
                          }
                        }
                      });

                      console.log("linea: ", id_linea_min, dt_linea_min)
                      this.updLineaPrincipale(id_linea_min)
                    }
                  }
                }

                if (this._stabilimento.chiuso || this._stabilimento.linee_modificabili == false)
                  this.disabilitaAggLinee = true;
                else
                  this.disabilitaAggLinee = false;
              }

              this.ans.getCuEffettuatiByStabilimento(this._id_stabilimento).subscribe((res: any) => {
                if (res.info) this._cu_effettuati = res.info.dati

                this.ans.getCuProgrammatiByStabilimento(this._id_stabilimento).subscribe((res: any) => {
                  if (res.info) this._cu_programmati = res.info.dati

                  this.ans.getProvvedimentiInCorsoByStabilimento(this._id_stabilimento).subscribe((res: any) => {
                    if (res.info) this._provv_in_corso = res.info.dati

                    this.LoadingService.closeDialog();
                  });
                });
              });

              this.ans.getStoricoStabilimento(this._id_stabilimento).subscribe((res: any) => {
                if (res.info) {
                  this._ui_storico = res.info.ui
                  this._storico = res.info.dati
                }
              })
            });
          });
        });
      });
    });
  }

  updLineaPrincipale(id_linea: any) {
    let params = {
      id_linea: +id_linea,
      id_stabilimento: +this._id_stabilimento
    }
    this.ans.updStabilimentiLineaPrincipale(params).subscribe((res: any) => {
      if (!res.esito) return
      this.ans.getStabilimentiLinee(this._id_stabilimento).subscribe((res: any) => {
        if (res.info) this._linee = res.info.dati
      });
    });
  }

  goToImpresa() {
    this.router.navigate(['portali/anagrafica/imprese/dettaglio'], { queryParams: { id_impresa: this._stabilimento.id_impresa } })
  }

  goToModifica() {
    if (this.disabilitaModificaStab == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/modifica'], { queryParams: { id_stabilimento: this._id_stabilimento } })
  }

  goToSubingresso() {
    if (!this.abilitaSubingresso) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/subingresso'], { queryParams: { id_stabilimento: this._id_stabilimento } })
  }

  goToAggiungiSede() {
    if (this.disabilitaAggSedi == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/sedi/aggiungi'], { queryParams: { id_stabilimento: this._id_stabilimento, nome: this._stabilimento.nome } })
  }

  goToAggiungiFigura() {
    if (this.disabilitaAggFigure == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/figure/aggiungi'], { queryParams: { id_stabilimento: this._id_stabilimento } })
  }

  goToAggiungiLinea() {
    if (this.disabilitaAggLinee == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/linee/aggiungi'], { queryParams: { id_stabilimento: this._id_stabilimento } })
  }

  goToSede(id_sede: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/sedi'], { queryParams: { id_sede_stabilimento: id_sede } })
  }

  goToFigura(id_figura: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/figure'], { queryParams: { id_stabilimento_figura: id_figura } })
  }

  goToLinea(id_linea: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/linee'], { queryParams: { id_linea: id_linea } })
  }

  goToModificaFigura(id_figura: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/figure/modifica'], { queryParams: { id_figura: id_figura } })
  }

  goToModificaLinea(id_linea: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/linee/modifica'], { queryParams: { id_linea: id_linea } })
  }

  goToPratiche() {
    this.router.navigate(['portali/anagrafica/stabilimenti/dettaglio/pratiche'], { queryParams: { id_stabilimento: this._id_stabilimento } })
  }

  generaPDF(ridotto: boolean) {

    this.app.getUser().subscribe((res: any) => {
      if (res) {
        let user_info = res
        let data = new Date().toLocaleDateString('en-GB') + ' alle ore ' + new Date().getHours() + ':' + new Date().getMinutes()
        console.log("generaPDF_" + this._id_stabilimento);
        //costruire oggetto completo da passare al posto di this.stabilimento
        let res_stab = {}

        if (ridotto) {
          Object.assign(
            res_stab
            , { 'data': data }
            , { user_info: user_info }
            , { stabilimento: this.stabilimento }
            , { rapp_legale: this.rapp_legale }
            , { sede_legale: this.sede_legale }
            , { isDomicili: this._sedi_v?.length > 0 ? true : false }
            , { sedi_stab: this._sedi_v }
            , { isFigure: this._figure_v?.length > 0 ? true : false }
            , { figure_stab: this._figure_v }
            , { isLinee: this._linee_v?.length > 0 ? true : false }
            , { linee_stab: this._linee_v }
            // , { isStorico: this.storico != undefined ? true : false }
            // , { storico: this.storico }
            , { ridotto: ridotto }
          )
        } else {
          Object.assign(
            res_stab
            , { 'data': data }
            , { user_info: user_info }
            , { stabilimento: this.stabilimento }
            , { rapp_legale: this.rapp_legale }
            , { sede_legale: this.sede_legale }
            , { isDomicili: this.sedi?.length > 0 ? true : false }
            , { sedi_stab: this.sedi }
            , { isFigure: this.figure?.length > 0 ? true : false }
            , { figure_stab: this.figure }
            , { isLinee: this.linee?.length > 0 ? true : false }
            , { linee_stab: this.linee }
            , { isStorico: this.storico != undefined ? true : false }
            , { storico: this.storico }
            , { ridotto: ridotto }
          )
        }
        console.log(res_stab)
        this.rs.downloadRiepilogoStab(res_stab, true, 'riepilogoStabilimento').subscribe((data) => {
          const url = URL.createObjectURL(data);
          const a = document.createElement('a');
          a.href = url;
          a.download = `riepilogo_stabilimento_${this._id_stabilimento}.pdf`;
          a.click();
          setTimeout(function () {
            a.remove();
            URL.revokeObjectURL(url);
          }, 100);
        })
      }

    })

  }


  get stabilimento() { return this._stabilimento }
  get ui_stabilimento() { return this._ui_stabilimento }
  get sedi() { return this._sedi }
  get ui_sedi() { return this._ui_sedi }
  get figure() { return this._figure }
  get ui_figure() { return this._ui_figure }
  get linee() { return this._linee }
  get ui_linee() { return this._ui_linee }
  get tipiSedi() { return this._tipiSedi; }
  get tipiFigure() { return this._tipiFigure; }

  get cu_effettuati() { return this._cu_effettuati }
  get cu_programmati() { return this._cu_programmati }
  get provv_passati() { return this._provv_passati }
  get provv_in_corso() { return this._provv_in_corso }

  get ui_storico() { return this._ui_storico }
  get storico() { return this._storico }
  get sede_legale() { return this._sede_legale }
  get rapp_legale() { return this._rapp_legale }
}

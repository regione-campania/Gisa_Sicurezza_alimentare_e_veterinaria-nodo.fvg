/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  AfterViewChecked,
  ChangeDetectorRef,
  Component,
  Input,
  OnInit,
  ViewChild,
} from "@angular/core";
import { InfoStrutturaPrimaria } from "../types";
import { GestioneAttivitaService } from "../../gestione-attivita.service";
import {
  ASmartTableComponent,
  Data,
  LoadingDialogService,
  NotificationService,
  ValueTracker,
} from "@us/utils";

@Component({
  selector: "tipologia-stabilimento",
  templateUrl: "./tipologia-stabilimento.component.html",
  styleUrls: ["./tipologia-stabilimento.component.scss"],
})
export class TipologiaStabilimentoComponent
  implements OnInit, AfterViewChecked {
  @Input() info?: InfoStrutturaPrimaria;
  private _ui: any;
  private _retDati: any;
  private _uiCategRischio: any;
  private _retDatiCategRischio: any;
  private _id_categorizzazione_rischio: any;
  private _id_tipo_stabilimento: any;
  selected: any;

  TipologiaStabilimentoLoading = false;
  CategorizzazioneRischioLoading = false;
  showCategRischio = false;

  @ViewChild("tabellaCategoriaRischio")
  tabellaCategoriaRischio?: ASmartTableComponent;
  @ViewChild("tabellaTipologiaStabilimento")
  tabellaTipologiaStabilimento?: ASmartTableComponent;

  constructor(
    private gs: GestioneAttivitaService,
    private loading: LoadingDialogService,
    private notification: NotificationService,
    private changeDetector: ChangeDetectorRef
  ) { }
  ngOnInit(): void {
    this.TipologiaStabilimentoLoading = true;
    this.gs.getTipologiaStrutturaStabilimento({}).subscribe((res: any) => {
      this.TipologiaStabilimentoLoading = false;
      console.log(res);
      this._ui = res.info.ui;
      this._retDati = res.info.dati;
    });
  }

  ngAfterViewChecked(): void {
    if (this.tabellaCategoriaRischio && this.infoCategorizzazioneRischio) {
      // if (!this.infoCategorizzazioneRischio.trackerModifiche) {
      //   this.infoCategorizzazioneRischio.trackerModifiche = new ValueTracker(this._id_categorizzazione_rischio);
      //   console.log("valore tracker 1:",this.infoCategorizzazioneRischio);
      // }
      // else {
      //   this.infoCategorizzazioneRischio.trackerModifiche.updateValue(this._id_categorizzazione_rischio)
      //   console.log("valore tracker 2:",this.infoCategorizzazioneRischio);
      // }
    }
    this.changeDetector.detectChanges();
  }

  dataMapping(d: any) {
    d.selected = d.selezionato;
    return d as Data;
  }

  showCategorizzazioneRischio(ar: any, event: any) {
    let trTipoStab = document.querySelectorAll(".tr-tipoStab");
    trTipoStab.forEach((p: Element) => {
      (p as HTMLElement).classList.remove("cliccato");
    });
    (event.srcElement.parentElement as HTMLElement).classList.add("cliccato");

    this.showCategRischio = true;
    console.log(ar);
    this._id_tipo_stabilimento = ar;
    this.CategorizzazioneRischioLoading = true;
    this.gs
      .getCategorizzazioneRischioAlberi({ id_tipo_struttura: ar })
      .subscribe((res: any) => {
        this.CategorizzazioneRischioLoading = false;
        this._uiCategRischio = res.info.ui;
        this._retDatiCategRischio = res.info.dati;
        this._id_categorizzazione_rischio = res.info.dati.find(
          (elem: any) => elem.selezionato
        )?.id_node;
        this.infoCategorizzazioneRischio!.trackerModifiche = new ValueTracker(
          this._id_categorizzazione_rischio
        );
      });
  }

  salva() {
    if (this.strutturaSecondariaAttiva) {
      switch (this.strutturaSecondariaAttiva.label) {
        case "Categorizzazione Rischio":
          this.salvaCategorizzazioneRischio();
          break;
      }
    }
  }

  // Funzione che controlla tramite la checkbox di selezionarlo uno alla volta
  // e controlla anche da DB se c'è già un elemento se si rimane selezionato
  checkCheckBox(ar: any) {
    //Bug fix #11743 - #11926 cambiato ar.id con ar.id_node
    this.retDatiCategRischio.forEach((item: any) => {
      if (item.id_node != ar.id_node) item.selected = false;
    });
    ar.selected = !ar.selected;
    this._id_categorizzazione_rischio = ar.selected ? ar.id_node : null;
    this.infoCategorizzazioneRischio?.trackerModifiche?.updateValue(
      this._id_categorizzazione_rischio
    );
  }

  salvaCategorizzazioneRischio() {
    this.loading.openDialog(
      "Aggiunta categorizzazione rischio al tipo stabilimento..."
    );
    if (!this._id_categorizzazione_rischio) {
      this.gs
        .updCategorizzazioneRischioAlberi({
          id_tipo_struttura: this._id_tipo_stabilimento,
          id_categorizzazione_rischio: [],
        })
        .subscribe((res: any) => {
          if (!res.esito) {
            this.loading.closeDialog();
            this.notification.push({
              notificationClass: "error",
              content: "Errore nell'associazione della categoria del rischio",
            });
            return;
          } else {
            this.notification.push({
              notificationClass: "success",
              content:
                "Aggiunta della categoria del rischio avvenuta con successo!",
            });
            if (
              this.tabellaCategoriaRischio &&
              this.infoCategorizzazioneRischio
            )
              this.infoCategorizzazioneRischio.trackerModifiche =
                new ValueTracker(this._id_categorizzazione_rischio);
          }
          this.loading.closeDialog();
        });
    } else {
      this.gs
        .updCategorizzazioneRischioAlberi({
          id_tipo_struttura: this._id_tipo_stabilimento,
          id_categorizzazione_rischio: [this._id_categorizzazione_rischio],
        })
        .subscribe((res: any) => {
          if (!res.esito) {
            this.loading.closeDialog();
            this.notification.push({
              notificationClass: "error",
              content: "Errore nell'associazione della categoria del rischio",
            });
            return;
          } else {
            this.notification.push({
              notificationClass: "success",
              content:
                "Aggiunta della categoria del rischio avvenuta con successo!",
            });
            if (
              this.tabellaCategoriaRischio &&
              this.infoCategorizzazioneRischio
            )
              this.infoCategorizzazioneRischio.trackerModifiche =
                new ValueTracker(this._id_categorizzazione_rischio);
          }
          this.loading.closeDialog();
        });
    }
  }

  get infoCategorizzazioneRischio() {
    return this.info?.struttureAssociate.find(
      (s) => s.label == "Categorizzazione Rischio"
    );
  }

  get strutturaSecondariaAttiva() {
    return this.info?.struttureAssociate.find((s) => s.active);
  }
  get ui() {
    return this._ui;
  }
  get retDati() {
    return this._retDati;
  }
  get uiCategRischio() {
    return this._uiCategRischio;
  }
  get retDatiCategRischio() {
    return this._retDatiCategRischio;
  }
}

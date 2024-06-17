-----------------------------------------
-- OPERAZIONI PRELIMINARI
-----------------------------------------

-----------------------------------------
-- PRELIMINARE 1: Ottenere da classyfarm i codici delle checklist da sviluppare (da farsi mandare via mail)

78
VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2022
89
VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2022
90
VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI A BASSA CAPACITA CONTROLLO UFFICIALE REV.1_2022
91
VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI A BASSA CAPACITA CONTROLLO UFFICIALE REV.1_2022

-----------------------------------------
-- PRELIMINARE 2: Creare entry nella lookup delle checklist, associando il nome corretto, il codice specie, il codice classyfarm, il codice gisa e la versione

-- Il codice gisa è un nome univoco che diamo noi a ogni checklist 
-- La versione corrisponde all'anno della versione della checklist (es. 2022)
-- Il codice specie deve coincidere con la specie oggetto della checklist. Se è già utilizzato (es. perchè ci sono 2 checklist suini con versione 2022) bisogna usarne un altro aggiungendo ad esempio dei progressivi in coda (es 0122 -> 01221, 01222...) 

insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2022', 'biosicurezza-2022-suini-stab_alta-01', '78', '0122', 2022);

insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2022', 'biosicurezza-2022-suini-semib_alta-01', '89', '01221', 2022);

insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI A BASSA CAPACITA CONTROLLO UFFICIALE REV.1_2022', 'biosicurezza-2022-suini-stab_bassa-01', '90', '01222', 2022);

insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI A BASSA CAPACITA CONTROLLO UFFICIALE REV.1_2022', 'biosicurezza-2022-suini-semib_bassa-01', '91', '01223', 2022);

-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------

-----------------------------------------
-- CHECKLIST VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2022 (78)
-----------------------------------------
-- (per corretto modus operandi vedere seconda checklist (89)

-- 1: Eseguire la chiamata ai webservice di classyfarm per ottenere i template delle checklist

-- Chiamare il servizio login da postman per avere il token
https://cf-function02-test.azurewebsites.net/api/autenticazione/login

{"username": "regcampania_CF","password": "yrq5nKqSr8CdOPOLmMxi4h/HtPM="}

-- Usare il token su chrome (estensione MOD HEADER, parametro x-api-key)

eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoicmVnY2FtcGFuaWFfQ0YiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJyZWdjYW1wYW5pYV9DRkBpenNsZXIuaXQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2V4cGlyYXRpb24iOiIxMS8yMi8yMDIyIDEwOjQyOjM1IEFNIiwiZXhwIjoxNjY5MTEzNzU1LCJpc3MiOiJJemxzZXJBcGkiLCJhdWQiOiJNdWx0aVVzZXJzIn0.ArhQRey2qfGIX65gKpNPJ7slBJkYE_WULOxHdhWyYHY

-- Collegarsi a https://cf-function02-test.azurewebsites.net/api/izsler/ui/ e nella sezione /api/checklist/getTemplateCL fare "try it out" usando il codice classyfarm

{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "4031",
      "DescrDomanda": "Ndeg totale animali",
      "ListaRisposte": [
        {
          "IDRisposta": "11269",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "4032",
      "DescrDomanda": "NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :",
      "ListaRisposte": [
        {
          "IDRisposta": "11270",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "11271",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "4117",
      "DescrDomanda": "Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2021/605?",
      "ListaRisposte": [
        {
          "IDRisposta": "11597",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "11596",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "4118",
      "DescrDomanda": "E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a VIII dellallegato II Regolamento (UE) 2021/605?",
      "ListaRisposte": [
        {
          "IDRisposta": "11598",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "11599",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "4740",
      "DescrDomanda": "Veterinario Ufficiale ispettore",
      "ListaRisposte": [
        {
          "IDRisposta": "13783",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "4030",
      "DescrDomanda": "Tipologia di suini presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "11268",
          "ControlType": "CheckBoxList",
          "ListItems": " Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1",
          "TemaplateName": "Categorie presenti"
        }
      ]
    },
    {
      "IDDomanda": "4034",
      "DescrDomanda": "2. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11279",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11277",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11276",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4035",
      "DescrDomanda": "3. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11280",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11281",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11283",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4037",
      "DescrDomanda": "4. Lazienda dispone di una zona filtro, con accesso obbligatorio, dotata di locali adibiti a spogliatoio?",
      "ListaRisposte": [
        {
          "IDRisposta": "11291",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11289",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11288",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11290",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4038",
      "DescrDomanda": "5. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?",
      "ListaRisposte": [
        {
          "IDRisposta": "11292",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11293",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11295",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4039",
      "DescrDomanda": "6. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?",
      "ListaRisposte": [
        {
          "IDRisposta": "11299",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11297",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11296",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4041",
      "DescrDomanda": "7. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11304",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11305",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11307",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4042",
      "DescrDomanda": "8. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11311",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11309",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11308",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4043",
      "DescrDomanda": "9. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11312",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11313",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11315",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4119",
      "DescrDomanda": "10. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?",
      "ListaRisposte": [
        {
          "IDRisposta": "11601",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11602",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "11600",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4044",
      "DescrDomanda": "11. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?",
      "ListaRisposte": [
        {
          "IDRisposta": "11319",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11317",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11316",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4045",
      "DescrDomanda": "12. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?",
      "ListaRisposte": [
        {
          "IDRisposta": "11320",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11321",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11323",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4046",
      "DescrDomanda": "13. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?",
      "ListaRisposte": [
        {
          "IDRisposta": "11327",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11325",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11324",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4047",
      "DescrDomanda": "14. Larea tutta intorno ai ricoveri degli animali e mantenuta pulita, coperta da ghiaia o con erba sfalciata, libera da ingombri, oggetti, attrezzature, macchinari, veicoli, ecc. estranei alla funzionalita e gestione dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "11328",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11329",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11331",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11330",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4048",
      "DescrDomanda": "15. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "11335",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11333",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11332",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4201",
      "DescrDomanda": "16. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "11878",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11877",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11879",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4049",
      "DescrDomanda": "17. E previsto e documentato un piano di derattizzazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "11338",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11336",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11337",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11339",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4050",
      "DescrDomanda": "18. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "11343",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11341",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11340",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11342",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4051",
      "DescrDomanda": "19. E previsto e documentato un piano di disinfestazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "11346",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11347",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11344",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11345",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4052",
      "DescrDomanda": "20. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "11349",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11348",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11351",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11350",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4053",
      "DescrDomanda": "21. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?",
      "ListaRisposte": [
        {
          "IDRisposta": "11352",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11353",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11355",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4054",
      "DescrDomanda": "22. Esiste un piano di profilassi vaccinale documentato?",
      "ListaRisposte": [
        {
          "IDRisposta": "11357",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11356",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11358",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11359",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4055",
      "DescrDomanda": "23. Esiste una prassi igienica e sanitaria di gestione delle attrezzature utilizzate per la profilassi vaccinale e i trattamenti terapeutici individuali o di gruppo?",
      "ListaRisposte": [
        {
          "IDRisposta": "11363",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11362",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11360",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11361",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4056",
      "DescrDomanda": "24. Sono presenti eventuali risultati delle analisi, ufficiali o effettuate in autocontrollo, su campioni prelevati da animali o da altre matrici che abbiano rilevanza per la salute umana e animale?",
      "ListaRisposte": [
        {
          "IDRisposta": "11365",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11364",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11366",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11367",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4057",
      "DescrDomanda": "25. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "11371",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11370",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11368",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11369",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4058",
      "DescrDomanda": "26. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?",
      "ListaRisposte": [
        {
          "IDRisposta": "11373",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11372",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11375",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4061",
      "DescrDomanda": "29. Lallevamento dispone di una piazzola per la pulizia e la disinfezione degli automezzi localizzata in prossimita dellaccesso allallevamento o, in ogni caso, separata dallarea aziendale destinata alla stabulazione e al governo animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11385",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11386",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11387",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11384",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4062",
      "DescrDomanda": "30. Sono presenti apparecchiature fisse a pressione per la pulizia, il lavaggio e la disinfezione degli automezzi in entrata?",
      "ListaRisposte": [
        {
          "IDRisposta": "11389",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11388",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11391",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11390",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4059",
      "DescrDomanda": "27. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?",
      "ListaRisposte": [
        {
          "IDRisposta": "11379",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11376",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11377",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4060",
      "DescrDomanda": "28. E presente una documentazione attestante lavvenuta disinfezione degli automezzi?",
      "ListaRisposte": [
        {
          "IDRisposta": "11381",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11380",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11383",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11382",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4063",
      "DescrDomanda": "31. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?",
      "ListaRisposte": [
        {
          "IDRisposta": "11395",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11392",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11393",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4064",
      "DescrDomanda": "32. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11397",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11396",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11399",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4065",
      "DescrDomanda": "33. Esiste una rampa/corridoio di carico/scarico degli animali vivi, fissa o mobile?",
      "ListaRisposte": [
        {
          "IDRisposta": "11403",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11402",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11400",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11401",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4066",
      "DescrDomanda": "34. Il carico dei suini vivi avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "11405",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11404",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11407",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4067",
      "DescrDomanda": "35. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11411",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11408",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11409",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4068",
      "DescrDomanda": "36. Il carico degli scarti avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "11413",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11412",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11415",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11414",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4069",
      "DescrDomanda": "37. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11418",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11419",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11416",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11417",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4070",
      "DescrDomanda": "38. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11421",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11420",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11423",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4076",
      "DescrDomanda": "44. Le aree sottostanti i silos dei mangimi consentono una efficace pulizia e il deflusso delle acque di lavaggio?",
      "ListaRisposte": [
        {
          "IDRisposta": "11444",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11447",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11446",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11445",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4077",
      "DescrDomanda": "45. Sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11450",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11451",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11448",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11449",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4071",
      "DescrDomanda": "39.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11427",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11424",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11425",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4072",
      "DescrDomanda": "40. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?",
      "ListaRisposte": [
        {
          "IDRisposta": "11429",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11428",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11431",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4073",
      "DescrDomanda": "41. Qualora le carcasse dei suinetti siano temporaneamente immagazzinate nei locali di allevamento, in attesa del loro allontanamento, i contenitori utilizzati sono adeguatamente sigillati ed idonei alla conservazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "11434",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11432",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11433",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11435",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4074",
      "DescrDomanda": "42. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11437",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11436",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11439",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4075",
      "DescrDomanda": "43. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?",
      "ListaRisposte": [
        {
          "IDRisposta": "11443",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11440",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11441",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4078",
      "DescrDomanda": "46. Se sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte e presente il nulla-osta al loro utilizzo ed e garantita la loro tracciabilita?",
      "ListaRisposte": [
        {
          "IDRisposta": "11453",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11452",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11455",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11454",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4079",
      "DescrDomanda": "47. Il punto di pesa e di esclusivo utilizzo dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "11459",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11456",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11457",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4080",
      "DescrDomanda": "48. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11460",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11463",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11461",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4081",
      "DescrDomanda": "49. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11465",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11464",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11467",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4082",
      "DescrDomanda": "50. I terreni attigui allazienda sono utilizzati per lo spandimento di liquami provenienti da altre aziende?",
      "ListaRisposte": [
        {
          "IDRisposta": "11471",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11468",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11469",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11470",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4083",
      "DescrDomanda": "51. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?",
      "ListaRisposte": [
        {
          "IDRisposta": "11473",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11472",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11475",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4084",
      "DescrDomanda": "52. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?",
      "ListaRisposte": [
        {
          "IDRisposta": "11479",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11477",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11476",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4741",
      "DescrDomanda": "53. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?",
      "ListaRisposte": [
        {
          "IDRisposta": "13785",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "13784",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "13786",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4742",
      "DescrDomanda": "54. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?",
      "ListaRisposte": [
        {
          "IDRisposta": "13789",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "13787",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "13788",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4743",
      "DescrDomanda": "55. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "13791",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "13790",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "13792",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4744",
      "DescrDomanda": "56. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "13795",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "13793",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "13794",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4033",
      "DescrDomanda": "1. Lazienda e dotata di unarea apposita, posta prima della barriera di entrata per la sosta dei veicoli del personale dellallevamento e/o visitatori? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11274",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11272",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11273",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11275",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4087",
      "DescrDomanda": "58. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11491",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11489",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11488",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11490",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4088",
      "DescrDomanda": "59. Viene pratico il pieno/tutto vuoto e un idoneo periodo di vuoto sanitario?",
      "ListaRisposte": [
        {
          "IDRisposta": "11494",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11492",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11493",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11495",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4089",
      "DescrDomanda": "60. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "11499",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11497",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11496",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11498",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4090",
      "DescrDomanda": "61. I locali di quarantena dispongono di fossa/e separata/e?",
      "ListaRisposte": [
        {
          "IDRisposta": "11502",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11500",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11501",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11503",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4091",
      "DescrDomanda": "62. I locali di quarantena dispongono di ingresso/i separato/i?",
      "ListaRisposte": [
        {
          "IDRisposta": "11507",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11505",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11504",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11506",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4092",
      "DescrDomanda": "63. Sono disponibili attrezzature destinate esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "11510",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11508",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11509",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11511",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4093",
      "DescrDomanda": "64. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "11515",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11513",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11512",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11514",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4094",
      "DescrDomanda": "65. E prevista lesecuzione pianificata di accertamenti diagnostici negli animali in quarantena? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11518",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11516",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11517",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11519",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4095",
      "DescrDomanda": "66. E richiesta e disponibile alle aziende di provenienza una documentazione che attesti lo stato sanitario degli animali di nuova introduzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "11523",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11521",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11520",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11522",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4096",
      "DescrDomanda": "67. La rimonta dei riproduttori viene effettuata con cadenza superiore a 3 mesi?",
      "ListaRisposte": [
        {
          "IDRisposta": "11526",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11524",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11525",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11527",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4097",
      "DescrDomanda": "68.  Lesame ecografico effettuato da operatori esterni?",
      "ListaRisposte": [
        {
          "IDRisposta": "11531",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11529",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11528",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11530",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4098",
      "DescrDomanda": "69. Nel caso in cui si pratichi la fecondazione artificiale il materiale seminale questo proviene da centri di raccolta seme autorizzati? Hai fornito una risposta valida?",
      "ListaRisposte": [
        {
          "IDRisposta": "11534",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11532",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11533",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11535",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4099",
      "DescrDomanda": "70. Nel caso in cui si pratichi la monta naturale i verri sono stati sottoposti agli accertamenti diagnostici previsti per i riproduttori maschi della specie suina?",
      "ListaRisposte": [
        {
          "IDRisposta": "11539",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11537",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11536",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11538",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4100",
      "DescrDomanda": "71. I suinetti in sala parto sono destinati a piu di due allevamenti?",
      "ListaRisposte": [
        {
          "IDRisposta": "11542",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11540",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11541",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11543",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4085",
      "DescrDomanda": "57. La rimonta viene effettuata ad opera di riproduttori esterni?",
      "ListaRisposte": [
        {
          "IDRisposta": "11483",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11481",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11480",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11482",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4105",
      "DescrDomanda": "76. I suini a fine ciclo sono destinati a piu di 1  allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "11563",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11561",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11560",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11562",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4102",
      "DescrDomanda": "73. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "11550",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11548",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11549",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11551",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4103",
      "DescrDomanda": "74. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11555",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11553",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11552",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11554",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4104",
      "DescrDomanda": "75. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11558",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11556",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11557",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11559",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4101",
      "DescrDomanda": "72. I suini provengono da piu di un allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "11546",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11544",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11545",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11547",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4107",
      "DescrDomanda": "78. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "11571",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11569",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11568",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11570",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4108",
      "DescrDomanda": "79. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11574",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11572",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11573",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11575",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4109",
      "DescrDomanda": "80. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ",
      "ListaRisposte": [
        {
          "IDRisposta": "11579",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11577",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11576",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11578",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4110",
      "DescrDomanda": "81. I suini a fine ciclo sono destinati a solo macelli industriali?",
      "ListaRisposte": [
        {
          "IDRisposta": "11582",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "11580",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11581",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11583",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4106",
      "DescrDomanda": "77. I suini provengono da piu di un allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "11567",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "11565",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "11564",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "11566",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4111",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "11585",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "11584",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        }
      ]
    },
    {
      "IDDomanda": "4745",
      "DescrDomanda": "Sono state assegnate delle prescrizioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "13796",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "13797",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14012",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se si quali:"
        },
        {
          "IDRisposta": "14013",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Entro quale data dovranno essere eseguite?"
        }
      ]
    },
    {
      "IDDomanda": "4746",
      "DescrDomanda": "Sono state applicate delle sanzioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "13800",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se altro specificare:"
        },
        {
          "IDRisposta": "13798",
          "ControlType": "CheckBoxList",
          "ListItems": " Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6",
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "13799",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "4826",
      "DescrDomanda": "ESITO DEL CONTROLLO",
      "ListaRisposte": [
        {
          "IDRisposta": "14011",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SFAVOREVOLE"
        },
        {
          "IDRisposta": "14010",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "FAVOREVOLE"
        }
      ]
    }
  ],
  "message": null,
  "esito": 0
}

-----------------------------------------
-- 2: Aprire il PDF ed individuare le sezioni. Inserirle nella tabella delle sezioni.

QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE
QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA
QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO
QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO

insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE', 1, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA', 2, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO', 3, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO',4 , (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_alta-01'));

-----------------------------------------
-- 3: Estrarre da JSON del template tutte le domande ed inserirle 

-- Usare un convertitore da JSON a CSV https://www.convertcsv.com/json-to-csv.htm  (-> json to excel)
-- Formare le insert riportando: id_sezione, ordine, id_classyfarm e domanda. Gli ultimi due valori vanno letti dal JSON, il primo va valorizzato a mano e "ordine" va usato come progressivo totale (non si azzera quando cambi sezione)
-- Se ci sono domande non riconducibili a nessuna sezione, si creano sezioni nuove e si posizionano come ordine guardando il PDF

-- Creo nuove sezioni

insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('DATI AGGIUNTIVI', 0, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('VALUTAZIONE FINALE E PROVVEDIMENTI', 5, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_alta-01'));

-- Inserisco domande

insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  0),1,4031, 'Ndeg totale animali');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  0),2,4740, 'Veterinario Ufficiale ispettore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  0),3,4030, 'Tipologia di suini presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  0),4,4117, 'Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2021/605?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  0),5,4118, 'E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a VIII dellallegato II Regolamento (UE) 2021/605?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),6,4033, '1. Lazienda e dotata di unarea apposita, posta prima della barriera di entrata per la sosta dei veicoli del personale dellallevamento e/o visitatori? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),7,4034, '2. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),8,4035, '3. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),9,4037, '4. Lazienda dispone di una zona filtro, con accesso obbligatorio, dotata di locali adibiti a spogliatoio?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),10,4038, '5. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),11,4039, '6. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),12,4041, '7. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),13,4042, '8. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),14,4043, '9. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),15,4119, '10. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),16,4044, '11. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),17,4045, '12. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),18,4046, '13. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),19,4047, '14. Larea tutta intorno ai ricoveri degli animali e mantenuta pulita, coperta da ghiaia o con erba sfalciata, libera da ingombri, oggetti, attrezzature, macchinari, veicoli, ecc. estranei alla funzionalita e gestione dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),20,4048, '15. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),21,4201, '16. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),22,4049, '17. E previsto e documentato un piano di derattizzazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),23,4050, '18. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),24,4051, '19. E previsto e documentato un piano di disinfestazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),25,4052, '20. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),26,4053, '21. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),27,4054, '22. Esiste un piano di profilassi vaccinale documentato?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),28,4055, '23. Esiste una prassi igienica e sanitaria di gestione delle attrezzature utilizzate per la profilassi vaccinale e i trattamenti terapeutici individuali o di gruppo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),29,4056, '24. Sono presenti eventuali risultati delle analisi, ufficiali o effettuate in autocontrollo, su campioni prelevati da animali o da altre matrici che abbiano rilevanza per la salute umana e animale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),30,4057, '25. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),31,4058, '26. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),32,4059, '27. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),33,4060, '28. E presente una documentazione attestante lavvenuta disinfezione degli automezzi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),34,4061, '29. Lallevamento dispone di una piazzola per la pulizia e la disinfezione degli automezzi localizzata in prossimita dellaccesso allallevamento o, in ogni caso, separata dallarea aziendale destinata alla stabulazione e al governo animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),35,4062, '30. Sono presenti apparecchiature fisse a pressione per la pulizia, il lavaggio e la disinfezione degli automezzi in entrata?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),36,4063, '31. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),37,4064, '32. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),38,4065, '33. Esiste una rampa/corridoio di carico/scarico degli animali vivi, fissa o mobile?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),39,4066, '34. Il carico dei suini vivi avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),40,4067, '35. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),41,4068, '36. Il carico degli scarti avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),42,4069, '37. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),43,4070, '38. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),44,4071, '39.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),45,4072, '40. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),46,4073, '41. Qualora le carcasse dei suinetti siano temporaneamente immagazzinate nei locali di allevamento, in attesa del loro allontanamento, i contenitori utilizzati sono adeguatamente sigillati ed idonei alla conservazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),47,4074, '42. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),48,4075, '43. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),49,4076, '44. Le aree sottostanti i silos dei mangimi consentono una efficace pulizia e il deflusso delle acque di lavaggio?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),50,4077, '45. Sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),51,4078, '46. Se sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte e presente il nulla-osta al loro utilizzo ed e garantita la loro tracciabilita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),52,4079, '47. Il punto di pesa e di esclusivo utilizzo dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),53,4080, '48. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),54,4081, '49. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),55,4082, '50. I terreni attigui allazienda sono utilizzati per lo spandimento di liquami provenienti da altre aziende?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),56,4083, '51. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),57,4084, '52. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),58,4741, '53. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),59,4742, '54. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),60,4743, '55. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  1),61,4744, '56. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),62,4085, '57. La rimonta viene effettuata ad opera di riproduttori esterni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),63,4087, '58. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),64,4088, '59. Viene pratico il pieno/tutto vuoto e un idoneo periodo di vuoto sanitario?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),65,4089, '60. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),66,4090, '61. I locali di quarantena dispongono di fossa/e separata/e?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),67,4091, '62. I locali di quarantena dispongono di ingresso/i separato/i?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),68,4092, '63. Sono disponibili attrezzature destinate esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),69,4093, '64. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),70,4094, '65. E prevista lesecuzione pianificata di accertamenti diagnostici negli animali in quarantena? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),71,4095, '66. E richiesta e disponibile alle aziende di provenienza una documentazione che attesti lo stato sanitario degli animali di nuova introduzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),72,4096, '67. La rimonta dei riproduttori viene effettuata con cadenza superiore a 3 mesi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),73,4097, '68.  Lesame ecografico effettuato da operatori esterni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),74,4098, '69. Nel caso in cui si pratichi la fecondazione artificiale il materiale seminale questo proviene da centri di raccolta seme autorizzati? Hai fornito una risposta valida?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),75,4099, '70. Nel caso in cui si pratichi la monta naturale i verri sono stati sottoposti agli accertamenti diagnostici previsti per i riproduttori maschi della specie suina?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  2),76,4100, '71. I suinetti in sala parto sono destinati a piu di due allevamenti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  3),77,4101, '72. I suini provengono da piu di un allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  3),78,4102, '73. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  3),79,4103, '74. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  3),80,4104, '75. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  3),81,4105, '76. I suini a fine ciclo sono destinati a piu di 1  allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  4),82,4106, '77. I suini provengono da piu di un allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  4),83,4107, '78. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  4),84,4108, '79. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  4),85,4109, '80. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  4),86,4110, '81. I suini a fine ciclo sono destinati a solo macelli industriali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  5),87,4826, 'ESITO DEL CONTROLLO');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  5),88,4745, 'Sono state assegnate delle prescrizioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  5),89,4746, 'Sono state applicate delle sanzioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2022 and s.ordine =  5),90,4032, 'NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :');

-- Bonifico domande
update biosicurezza_domande set domanda = 'Numero totale degli animali' where domanda ilike 'Ndeg totale animali';

-----------------------------------------
-- 4: Estrarre le risposte dal JSON ed inserirle nella tabella

insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4030), 11268, 'CheckBoxList', ' Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1', 'Categorie presenti');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4031), 11269, 'TextBox', '', 'ndeg:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4032), 11270, 'TextArea', '', ':');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4032), 11271, 'Button', '', 'NA');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4033), 11272, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4033), 11273, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4033), 11274, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4033), 11275, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4034), 11276, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4034), 11277, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4034), 11279, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4035), 11280, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4035), 11281, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4035), 11283, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4037), 11288, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4037), 11289, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4037), 11290, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4037), 11291, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4038), 11292, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4038), 11293, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4038), 11295, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4039), 11296, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4039), 11297, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4039), 11299, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4041), 11304, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4041), 11305, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4041), 11307, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4042), 11308, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4042), 11309, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4042), 11311, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4043), 11312, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4043), 11313, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4043), 11315, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4044), 11316, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4044), 11317, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4044), 11319, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4045), 11320, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4045), 11321, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4045), 11323, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4046), 11324, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4046), 11325, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4046), 11327, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4047), 11328, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4047), 11329, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4047), 11330, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4047), 11331, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4048), 11332, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4048), 11333, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4048), 11335, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4049), 11336, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4049), 11337, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4049), 11338, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4049), 11339, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4050), 11340, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4050), 11341, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4050), 11342, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4050), 11343, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4051), 11344, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4051), 11345, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4051), 11346, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4051), 11347, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4052), 11348, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4052), 11349, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4052), 11350, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4052), 11351, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4053), 11352, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4053), 11353, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4053), 11355, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4054), 11356, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4054), 11357, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4054), 11358, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4054), 11359, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4055), 11360, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4055), 11361, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4055), 11362, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4055), 11363, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4056), 11364, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4056), 11365, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4056), 11366, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4056), 11367, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4057), 11368, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4057), 11369, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4057), 11370, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4057), 11371, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4058), 11372, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4058), 11373, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4058), 11375, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4059), 11376, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4059), 11377, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4059), 11379, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4060), 11380, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4060), 11381, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4060), 11382, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4060), 11383, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4061), 11384, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4061), 11385, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4061), 11386, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4061), 11387, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4062), 11388, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4062), 11389, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4062), 11390, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4062), 11391, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4063), 11392, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4063), 11393, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4063), 11395, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4064), 11396, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4064), 11397, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4064), 11399, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4065), 11400, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4065), 11401, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4065), 11402, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4065), 11403, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4066), 11404, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4066), 11405, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4066), 11407, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4067), 11408, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4067), 11409, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4067), 11411, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4068), 11412, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4068), 11413, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4068), 11414, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4068), 11415, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4069), 11416, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4069), 11417, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4069), 11418, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4069), 11419, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4070), 11420, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4070), 11421, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4070), 11423, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4071), 11424, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4071), 11425, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4071), 11427, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4072), 11428, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4072), 11429, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4072), 11431, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4073), 11432, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4073), 11433, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4073), 11434, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4073), 11435, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4074), 11436, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4074), 11437, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4074), 11439, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4075), 11440, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4075), 11441, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4075), 11443, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4076), 11444, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4076), 11445, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4076), 11446, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4076), 11447, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4077), 11448, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4077), 11449, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4077), 11450, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4077), 11451, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4078), 11452, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4078), 11453, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4078), 11454, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4078), 11455, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4079), 11456, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4079), 11457, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4079), 11459, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4080), 11460, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4080), 11461, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4080), 11463, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4081), 11464, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4081), 11465, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4081), 11467, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4082), 11468, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4082), 11469, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4082), 11470, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4082), 11471, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4083), 11472, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4083), 11473, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4083), 11475, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4084), 11476, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4084), 11477, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4084), 11479, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4085), 11480, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4085), 11481, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4085), 11482, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4085), 11483, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4087), 11488, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4087), 11489, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4087), 11490, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4087), 11491, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4088), 11492, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4088), 11493, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4088), 11494, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4088), 11495, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4089), 11496, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4089), 11497, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4089), 11498, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4089), 11499, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4090), 11500, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4090), 11501, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4090), 11502, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4090), 11503, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4091), 11504, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4091), 11505, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4091), 11506, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4091), 11507, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4092), 11508, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4092), 11509, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4092), 11510, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4092), 11511, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4093), 11512, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4093), 11513, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4093), 11514, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4093), 11515, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4094), 11516, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4094), 11517, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4094), 11518, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4094), 11519, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4095), 11520, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4095), 11521, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4095), 11522, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4095), 11523, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4096), 11524, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4096), 11525, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4096), 11526, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4096), 11527, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4097), 11528, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4097), 11529, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4097), 11530, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4097), 11531, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4098), 11532, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4098), 11533, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4098), 11534, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4098), 11535, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4099), 11536, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4099), 11537, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4099), 11538, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4099), 11539, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4100), 11540, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4100), 11541, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4100), 11542, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4100), 11543, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4101), 11544, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4101), 11545, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4101), 11546, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4101), 11547, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4102), 11548, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4102), 11549, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4102), 11550, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4102), 11551, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4103), 11552, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4103), 11553, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4103), 11554, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4103), 11555, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4104), 11556, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4104), 11557, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4104), 11558, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4104), 11559, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4105), 11560, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4105), 11561, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4105), 11562, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4105), 11563, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4106), 11564, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4106), 11565, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4106), 11566, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4106), 11567, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4107), 11568, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4107), 11569, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4107), 11570, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4107), 11571, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4108), 11572, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4108), 11573, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4108), 11574, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4108), 11575, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4109), 11576, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4109), 11577, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4109), 11578, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4109), 11579, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4110), 11580, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4110), 11581, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4110), 11582, 'Button', '', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4110), 11583, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4111), 11584, 'TextBox', '', 'carica');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4111), 11585, 'Button', '', 'NA');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4117), 11596, 'Button', '', 'SI');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4117), 11597, 'Button', '', 'NO');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4118), 11598, 'Button', '', 'SI');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4118), 11599, 'Button', '', 'NO');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4119), 11600, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4119), 11601, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4119), 11602, 'TextArea', '', 'Note - Motivo N/A:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4201), 11877, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4201), 11878, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4201), 11879, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4740), 13783, 'TextArea', '', ':');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4741), 13784, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4741), 13785, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4741), 13786, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4742), 13787, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4742), 13788, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4742), 13789, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4743), 13790, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4743), 13791, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4743), 13792, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4744), 13793, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4744), 13794, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4744), 13795, 'TextArea', '', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4745), 13796, 'Button', '', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4745), 13797, 'Button', '', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4745), 14012, 'TextArea', '', 'Se si quali:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4745), 14013, 'TextBox', '', 'Entro quale data dovranno essere eseguite?');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4746), 13798, 'CheckBoxList', 'Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) – 6', '');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4746), 13799, 'Button', '', 'NA');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4746), 13800, 'TextArea', '', 'Se altro specificare:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4826), 14010, 'Button', '', 'FAVOREVOLE');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm =4826), 14011, 'Button', '', 'SFAVOREVOLE');

-- Aggiorno "ordine" nel seguente ordine: 
--SI, NO, NA, NOTE
--FAVOREVOLE, SFAVOREVOLE

update biosicurezza_risposte set ordine = 1 where risposta ilike 'si' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'no' and ordine is null;
update biosicurezza_risposte set ordine = 3 where risposta ilike 'na' and ordine is null;
update biosicurezza_risposte set ordine = 3 where risposta ilike 'n/a' and ordine is null;
update biosicurezza_risposte set ordine = 4 where risposta ilike '%note%' and ordine is null;
update biosicurezza_risposte set ordine = 1 where risposta ilike 'favorevole' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'sfavorevole' and ordine is null;

-- Bonifico risposte

delete from biosicurezza_risposte where id_domanda is null;
update biosicurezza_risposte set tipo = 'checkbox' where tipo = 'Button';
update biosicurezza_risposte set tipo = 'textarea' where tipo like '%Text%';
update biosicurezza_risposte set risposta = '' where risposta in ('ndeg:', 'm2:', ':', 'Generalita:');
update biosicurezza_risposte set tipo = 'checkboxList' where tipo = 'CheckBoxList';

-- Modifico unico campo numerico nel tipo number

update biosicurezza_risposte set tipo = 'number' where id_domanda in (select id from biosicurezza_domande where domanda = 'Numero totale degli animali' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_alta-01')))


-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------

-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------

-----------------------------------------
-- VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2022 (89)
-----------------------------------------

-- 1: Eseguire la chiamata ai webservice di classyfarm per ottenere i template delle checklist

-- Chiamare il servizio login da postman per avere il token
https://cf-function02-test.azurewebsites.net/api/autenticazione/login

{"username": "regcampania_CF","password": "yrq5nKqSr8CdOPOLmMxi4h/HtPM="}

-- Usare il token su chrome (estensione MOD HEADER, parametro x-api-key)

eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoicmVnY2FtcGFuaWFfQ0YiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJyZWdjYW1wYW5pYV9DRkBpenNsZXIuaXQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2V4cGlyYXRpb24iOiIxMS8yMi8yMDIyIDEwOjQyOjM1IEFNIiwiZXhwIjoxNjY5MTEzNzU1LCJpc3MiOiJJemxzZXJBcGkiLCJhdWQiOiJNdWx0aVVzZXJzIn0.ArhQRey2qfGIX65gKpNPJ7slBJkYE_WULOxHdhWyYHY

-- Collegarsi a https://cf-function02-test.azurewebsites.net/api/izsler/ui/ e nella sezione /api/checklist/getTemplateCL fare "try it out" usando il codice classyfarm

{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "4827",
      "DescrDomanda": "Tipologia di suini presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "14014",
          "ControlType": "CheckBoxList",
          "ListItems": " Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1",
          "TemaplateName": "Categorie presenti"
        }
      ]
    },
    {
      "IDDomanda": "4828",
      "DescrDomanda": "Ndeg totale animali",
      "ListaRisposte": [
        {
          "IDRisposta": "14015",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "4829",
      "DescrDomanda": "NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :",
      "ListaRisposte": [
        {
          "IDRisposta": "14016",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "14017",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "4830",
      "DescrDomanda": "Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2021/605?",
      "ListaRisposte": [
        {
          "IDRisposta": "14019",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "14018",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "4831",
      "DescrDomanda": "E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a VIII dellallegato II Regolamento (UE) 2021/605?",
      "ListaRisposte": [
        {
          "IDRisposta": "14020",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "14021",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "4832",
      "DescrDomanda": "Veterinario Ufficiale ispettore",
      "ListaRisposte": [
        {
          "IDRisposta": "14022",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "4834",
      "DescrDomanda": "2. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14029",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14027",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14028",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4836",
      "DescrDomanda": "4. Lazienda dispone di una zona filtro, con accesso obbligatorio, dotata di locali adibiti a spogliatoio?",
      "ListaRisposte": [
        {
          "IDRisposta": "14035",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14033",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14036",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14034",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4835",
      "DescrDomanda": "3. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14031",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14030",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14032",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4837",
      "DescrDomanda": "5. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?",
      "ListaRisposte": [
        {
          "IDRisposta": "14038",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14037",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14039",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4838",
      "DescrDomanda": "6. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?",
      "ListaRisposte": [
        {
          "IDRisposta": "14042",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14040",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14041",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4839",
      "DescrDomanda": "7. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14044",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14043",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14045",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4840",
      "DescrDomanda": "8. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14048",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14046",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14047",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4841",
      "DescrDomanda": "9. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14050",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14049",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14051",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4842",
      "DescrDomanda": "10. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?",
      "ListaRisposte": [
        {
          "IDRisposta": "14053",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14054",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "14052",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4843",
      "DescrDomanda": "11. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?",
      "ListaRisposte": [
        {
          "IDRisposta": "14057",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14055",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14056",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4844",
      "DescrDomanda": "12. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?",
      "ListaRisposte": [
        {
          "IDRisposta": "14059",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14058",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14060",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4845",
      "DescrDomanda": "13. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?",
      "ListaRisposte": [
        {
          "IDRisposta": "14063",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14061",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14062",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4846",
      "DescrDomanda": "14. Larea tutta intorno ai ricoveri degli animali e mantenuta pulita, coperta da ghiaia o con erba sfalciata, libera da ingombri, oggetti, attrezzature, macchinari, veicoli, ecc. estranei alla funzionalita e gestione dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14065",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14064",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14067",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14066",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4847",
      "DescrDomanda": "15. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14070",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14068",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14069",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4848",
      "DescrDomanda": "16. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14072",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14071",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14073",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4849",
      "DescrDomanda": "17. E previsto e documentato un piano di derattizzazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "14077",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14076",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14075",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14074",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4850",
      "DescrDomanda": "18. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "14078",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14079",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14080",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14081",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4851",
      "DescrDomanda": "19. E previsto e documentato un piano di disinfestazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "14085",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14084",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14083",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14082",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4852",
      "DescrDomanda": "20. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "14086",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14087",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14088",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14089",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4853",
      "DescrDomanda": "21. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?",
      "ListaRisposte": [
        {
          "IDRisposta": "14092",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14091",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14090",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4854",
      "DescrDomanda": "22. Esiste un piano di profilassi vaccinale documentato?",
      "ListaRisposte": [
        {
          "IDRisposta": "14093",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14094",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14096",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14095",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4855",
      "DescrDomanda": "23. Esiste una prassi igienica e sanitaria di gestione delle attrezzature utilizzate per la profilassi vaccinale e i trattamenti terapeutici individuali o di gruppo?",
      "ListaRisposte": [
        {
          "IDRisposta": "14099",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14100",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14098",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14097",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4856",
      "DescrDomanda": "24. Sono presenti eventuali risultati delle analisi, ufficiali o effettuate in autocontrollo, su campioni prelevati da animali o da altre matrici che abbiano rilevanza per la salute umana e animale?",
      "ListaRisposte": [
        {
          "IDRisposta": "14101",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14102",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14104",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14103",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4857",
      "DescrDomanda": "25. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "14107",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14108",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14106",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14105",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4858",
      "DescrDomanda": "26. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?",
      "ListaRisposte": [
        {
          "IDRisposta": "14109",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14110",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14111",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4868",
      "DescrDomanda": "36. Il carico degli scarti avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "14146",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14145",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14143",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14144",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4859",
      "DescrDomanda": "27. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?",
      "ListaRisposte": [
        {
          "IDRisposta": "14114",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14113",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14112",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4860",
      "DescrDomanda": "28. E presente una documentazione attestante lavvenuta disinfezione degli automezzi?",
      "ListaRisposte": [
        {
          "IDRisposta": "14115",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14116",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14118",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14117",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4861",
      "DescrDomanda": "29. Lallevamento dispone di una piazzola per la pulizia e la disinfezione degli automezzi localizzata in prossimita dellaccesso allallevamento o, in ogni caso, separata dallarea aziendale destinata alla stabulazione e al governo animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14121",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14122",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14120",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14119",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4862",
      "DescrDomanda": "30. Sono presenti apparecchiature fisse a pressione per la pulizia, il lavaggio e la disinfezione degli automezzi in entrata?",
      "ListaRisposte": [
        {
          "IDRisposta": "14123",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14124",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14126",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14125",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4863",
      "DescrDomanda": "31. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?",
      "ListaRisposte": [
        {
          "IDRisposta": "14129",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14128",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14127",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4864",
      "DescrDomanda": "32. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14130",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14131",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14132",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4865",
      "DescrDomanda": "33. Esiste una rampa/corridoio di carico/scarico degli animali vivi, fissa o mobile?",
      "ListaRisposte": [
        {
          "IDRisposta": "14136",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14135",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14134",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14133",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4866",
      "DescrDomanda": "34. Il carico dei suini vivi avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "14137",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14138",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14139",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4867",
      "DescrDomanda": "35. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14142",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14141",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14140",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4869",
      "DescrDomanda": "37. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14149",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14150",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14148",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14147",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4870",
      "DescrDomanda": "38. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14151",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14152",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14153",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4871",
      "DescrDomanda": "39.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14156",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14155",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14154",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4872",
      "DescrDomanda": "40. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?",
      "ListaRisposte": [
        {
          "IDRisposta": "14157",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14158",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14159",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4873",
      "DescrDomanda": "41. Qualora le carcasse dei suinetti siano temporaneamente immagazzinate nei locali di allevamento, in attesa del loro allontanamento, i contenitori utilizzati sono adeguatamente sigillati ed idonei alla conservazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "14163",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14162",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14161",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14160",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4874",
      "DescrDomanda": "42. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14164",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14165",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14166",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4875",
      "DescrDomanda": "43. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?",
      "ListaRisposte": [
        {
          "IDRisposta": "14169",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14168",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14167",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4876",
      "DescrDomanda": "44. Le aree sottostanti i silos dei mangimi consentono una efficace pulizia e il deflusso delle acque di lavaggio?",
      "ListaRisposte": [
        {
          "IDRisposta": "14170",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14171",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14173",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14172",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4877",
      "DescrDomanda": "45. Sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14176",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14177",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14175",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14174",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4878",
      "DescrDomanda": "46. Se sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte e presente il nulla-osta al loro utilizzo ed e garantita la loro tracciabilita?",
      "ListaRisposte": [
        {
          "IDRisposta": "14178",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14179",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14181",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14180",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4879",
      "DescrDomanda": "47. Il punto di pesa e di esclusivo utilizzo dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14184",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14183",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14182",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4884",
      "DescrDomanda": "52. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?",
      "ListaRisposte": [
        {
          "IDRisposta": "14198",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14199",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14200",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4880",
      "DescrDomanda": "48. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14185",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14187",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14186",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4881",
      "DescrDomanda": "49. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14190",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14188",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14189",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4882",
      "DescrDomanda": "50. I terreni attigui allazienda sono utilizzati per lo spandimento di liquami provenienti da altre aziende?",
      "ListaRisposte": [
        {
          "IDRisposta": "14192",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14191",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14194",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14193",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4883",
      "DescrDomanda": "51. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?",
      "ListaRisposte": [
        {
          "IDRisposta": "14197",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14196",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14195",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4885",
      "DescrDomanda": "53. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?",
      "ListaRisposte": [
        {
          "IDRisposta": "14202",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14201",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14203",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4886",
      "DescrDomanda": "54. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?",
      "ListaRisposte": [
        {
          "IDRisposta": "14206",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14204",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14205",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4887",
      "DescrDomanda": "55. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "14208",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14207",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14209",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4889",
      "DescrDomanda": "57. La rimonta viene effettuata ad opera di riproduttori esterni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14216",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14213",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14214",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14215",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4888",
      "DescrDomanda": "56. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "14212",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14210",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14211",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4833",
      "DescrDomanda": "1. Lazienda e dotata di unarea apposita, posta prima della barriera di entrata per la sosta dei veicoli del personale dellallevamento e/o visitatori? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14026",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14025",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14024",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14023",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4890",
      "DescrDomanda": "58. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14220",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14219",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14218",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14217",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4891",
      "DescrDomanda": "59. Viene pratico il pieno/tutto vuoto e un idoneo periodo di vuoto sanitario?",
      "ListaRisposte": [
        {
          "IDRisposta": "14221",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14222",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14223",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14224",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4892",
      "DescrDomanda": "60. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "14228",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14227",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14226",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14225",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4893",
      "DescrDomanda": "61. I locali di quarantena dispongono di fossa/e separata/e?",
      "ListaRisposte": [
        {
          "IDRisposta": "14229",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14230",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14231",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14232",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4894",
      "DescrDomanda": "62. I locali di quarantena dispongono di ingresso/i separato/i?",
      "ListaRisposte": [
        {
          "IDRisposta": "14236",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14235",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14234",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14233",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4895",
      "DescrDomanda": "63. Sono disponibili attrezzature destinate esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "14237",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14238",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14239",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14240",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4896",
      "DescrDomanda": "64. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "14244",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14243",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14242",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14241",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4897",
      "DescrDomanda": "65. E prevista lesecuzione pianificata di accertamenti diagnostici negli animali in quarantena? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14245",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14246",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14247",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14248",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4898",
      "DescrDomanda": "66. E richiesta e disponibile alle aziende di provenienza una documentazione che attesti lo stato sanitario degli animali di nuova introduzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "14252",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14251",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14250",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14249",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4899",
      "DescrDomanda": "67. La rimonta dei riproduttori viene effettuata con cadenza superiore a 3 mesi?",
      "ListaRisposte": [
        {
          "IDRisposta": "14253",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14254",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14255",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14256",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4900",
      "DescrDomanda": "68.  Lesame ecografico effettuato da operatori esterni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14260",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14259",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14258",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14257",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4901",
      "DescrDomanda": "69. Nel caso in cui si pratichi la fecondazione artificiale il materiale seminale questo proviene da centri di raccolta seme autorizzati? Hai fornito una risposta valida?",
      "ListaRisposte": [
        {
          "IDRisposta": "14261",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14262",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14263",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14264",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4902",
      "DescrDomanda": "70. Nel caso in cui si pratichi la monta naturale i verri sono stati sottoposti agli accertamenti diagnostici previsti per i riproduttori maschi della specie suina?",
      "ListaRisposte": [
        {
          "IDRisposta": "14268",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14267",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14266",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14265",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4903",
      "DescrDomanda": "71. I suinetti in sala parto sono destinati a piu di due allevamenti?",
      "ListaRisposte": [
        {
          "IDRisposta": "14269",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14270",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14271",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14272",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4904",
      "DescrDomanda": "72. I suini provengono da piu di un allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14276",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14275",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14274",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14273",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4905",
      "DescrDomanda": "73. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14277",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14278",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14279",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14280",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4906",
      "DescrDomanda": "74. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14284",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14283",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14282",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14281",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4907",
      "DescrDomanda": "75. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14285",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14286",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14287",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14288",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4908",
      "DescrDomanda": "76. I suini a fine ciclo sono destinati a piu di 1  allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14292",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14291",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14290",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14289",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4910",
      "DescrDomanda": "78. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14297",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14298",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14299",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14300",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4911",
      "DescrDomanda": "79. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14304",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14303",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14302",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14301",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4912",
      "DescrDomanda": "80. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14305",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14306",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14307",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14308",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4913",
      "DescrDomanda": "81. I suini a fine ciclo sono destinati a solo macelli industriali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14312",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14311",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14310",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14309",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4909",
      "DescrDomanda": "77. I suini provengono da piu di un allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14293",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14294",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14295",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14296",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4914",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "14314",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "14313",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        }
      ]
    },
    {
      "IDDomanda": "4915",
      "DescrDomanda": "ESITO DEL CONTROLLO",
      "ListaRisposte": [
        {
          "IDRisposta": "14316",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SFAVOREVOLE"
        },
        {
          "IDRisposta": "14315",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "FAVOREVOLE"
        }
      ]
    },
    {
      "IDDomanda": "4916",
      "DescrDomanda": "Sono state assegnate delle prescrizioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14318",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14319",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se si quali:"
        },
        {
          "IDRisposta": "14320",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Entro quale data dovranno essere eseguite?"
        },
        {
          "IDRisposta": "14317",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4917",
      "DescrDomanda": "Sono state applicate delle sanzioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14322",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "14321",
          "ControlType": "CheckBoxList",
          "ListItems": " Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6",
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "14323",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se altro specificare:"
        }
      ]
    }
  ],
  "message": null,
  "esito": 0
}

-----------------------------------------
-- 2: Aprire il PDF ed individuare le sezioni. Inserirle nella tabella delle sezioni.

QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE
QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA
QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO
QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO

insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE', 1, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA', 2, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO', 3, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO',4 , (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_alta-01'));

-----------------------------------------
-- 3: Estrarre da JSON del template tutte le domande ed inserirle 

-- Usare un convertitore da JSON a CSV https://www.convertcsv.com/json-to-csv.htm (-> json to excel)
-- Compilare il foglio "ClassyFarmGeneratore.ods" incollando il contenuto della conversione nel tab "JSON". (LIBREOFFICE)
-- Nel tab "Domande" valorizzare correttamente COD SPECIE e VERSIONE e incollando le colonne da ID DOMANDA e DESCR DOMANDA
-- Verificare una ad una a quale sezione appartengono. Se si riesce a risalire, indicare ORDINE SEZIONE nella apposita colonna. Se non si riesce a risalire, inserire nuove sezioni e riportare il relativo ordine. Eventualmente eliminare le righe inutili tipo "Documento 1"
-- Ordinare per ORDINE SEZIONE, e quindi valorizzare ORDINE DOMANDA rispettando l'ordine nel PDF. Nota: ORDINE DOMANDA è un progressivo generale, quindi non si azzera quando si cambia sezione
-- Lanciare le insert. Nota: ricordarsi di eliminare gli spazi o non funzioneranno i recuperi di id



-- Creo nuove sezioni

insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('DATI AGGIUNTIVI', 0, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('VALUTAZIONE FINALE E PROVVEDIMENTI', 5, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_alta-01'));

-- Inserisco domande


insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 0),1,4828, 'Ndeg totale animali');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 0),2,4832, 'Veterinario Ufficiale ispettore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 0),3,4827, 'Tipologia di suini presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 0),4,4830, 'Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2021/605?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 0),5,4831, 'E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a VIII dellallegato II Regolamento (UE) 2021/605?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),6,4833, '1. Lazienda e dotata di unarea apposita, posta prima della barriera di entrata per la sosta dei veicoli del personale dellallevamento e/o visitatori? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),7,4834, '2. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),8,4836, '4. Lazienda dispone di una zona filtro, con accesso obbligatorio, dotata di locali adibiti a spogliatoio?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),9,4835, '3. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),10,4837, '5. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),11,4838, '6. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),12,4839, '7. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),13,4840, '8. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),14,4841, '9. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),15,4842, '10. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),16,4843, '11. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),17,4844, '12. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),18,4845, '13. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),19,4846, '14. Larea tutta intorno ai ricoveri degli animali e mantenuta pulita, coperta da ghiaia o con erba sfalciata, libera da ingombri, oggetti, attrezzature, macchinari, veicoli, ecc. estranei alla funzionalita e gestione dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),20,4847, '15. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),21,4848, '16. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),22,4849, '17. E previsto e documentato un piano di derattizzazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),23,4850, '18. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),24,4851, '19. E previsto e documentato un piano di disinfestazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),25,4852, '20. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),26,4853, '21. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),27,4854, '22. Esiste un piano di profilassi vaccinale documentato?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),28,4855, '23. Esiste una prassi igienica e sanitaria di gestione delle attrezzature utilizzate per la profilassi vaccinale e i trattamenti terapeutici individuali o di gruppo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),29,4856, '24. Sono presenti eventuali risultati delle analisi, ufficiali o effettuate in autocontrollo, su campioni prelevati da animali o da altre matrici che abbiano rilevanza per la salute umana e animale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),30,4857, '25. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),31,4858, '26. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),32,4868, '36. Il carico degli scarti avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),33,4859, '27. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),34,4860, '28. E presente una documentazione attestante lavvenuta disinfezione degli automezzi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),35,4861, '29. Lallevamento dispone di una piazzola per la pulizia e la disinfezione degli automezzi localizzata in prossimita dellaccesso allallevamento o, in ogni caso, separata dallarea aziendale destinata alla stabulazione e al governo animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),36,4862, '30. Sono presenti apparecchiature fisse a pressione per la pulizia, il lavaggio e la disinfezione degli automezzi in entrata?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),37,4863, '31. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),38,4864, '32. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),39,4865, '33. Esiste una rampa/corridoio di carico/scarico degli animali vivi, fissa o mobile?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),40,4866, '34. Il carico dei suini vivi avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),41,4867, '35. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),42,4869, '37. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),43,4870, '38. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),44,4871, '39.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),45,4872, '40. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),46,4873, '41. Qualora le carcasse dei suinetti siano temporaneamente immagazzinate nei locali di allevamento, in attesa del loro allontanamento, i contenitori utilizzati sono adeguatamente sigillati ed idonei alla conservazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),47,4874, '42. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),48,4875, '43. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),49,4876, '44. Le aree sottostanti i silos dei mangimi consentono una efficace pulizia e il deflusso delle acque di lavaggio?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),50,4877, '45. Sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),51,4878, '46. Se sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte e presente il nulla-osta al loro utilizzo ed e garantita la loro tracciabilita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),52,4879, '47. Il punto di pesa e di esclusivo utilizzo dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),53,4884, '52. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),54,4880, '48. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),55,4881, '49. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),56,4882, '50. I terreni attigui allazienda sono utilizzati per lo spandimento di liquami provenienti da altre aziende?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),57,4883, '51. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),58,4885, '53. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),59,4886, '54. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),60,4887, '55. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 1),61,4888, '56. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),62,4889, '57. La rimonta viene effettuata ad opera di riproduttori esterni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),63,4890, '58. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),64,4891, '59. Viene pratico il pieno/tutto vuoto e un idoneo periodo di vuoto sanitario?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),65,4892, '60. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),66,4893, '61. I locali di quarantena dispongono di fossa/e separata/e?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),67,4894, '62. I locali di quarantena dispongono di ingresso/i separato/i?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),68,4895, '63. Sono disponibili attrezzature destinate esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),69,4896, '64. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),70,4897, '65. E prevista lesecuzione pianificata di accertamenti diagnostici negli animali in quarantena? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),71,4898, '66. E richiesta e disponibile alle aziende di provenienza una documentazione che attesti lo stato sanitario degli animali di nuova introduzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),72,4899, '67. La rimonta dei riproduttori viene effettuata con cadenza superiore a 3 mesi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),73,4900, '68.  Lesame ecografico effettuato da operatori esterni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),74,4901, '69. Nel caso in cui si pratichi la fecondazione artificiale il materiale seminale questo proviene da centri di raccolta seme autorizzati? Hai fornito una risposta valida?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),75,4902, '70. Nel caso in cui si pratichi la monta naturale i verri sono stati sottoposti agli accertamenti diagnostici previsti per i riproduttori maschi della specie suina?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 2),76,4903, '71. I suinetti in sala parto sono destinati a piu di due allevamenti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 3),77,4904, '72. I suini provengono da piu di un allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 3),78,4905, '73. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 3),79,4906, '74. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 3),80,4907, '75. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 3),81,4908, '76. I suini a fine ciclo sono destinati a piu di 1  allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 4),82,4909, '77. I suini provengono da piu di un allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 4),83,4910, '78. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 4),84,4911, '79. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 4),85,4912, '80. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 4),86,4913, '81. I suini a fine ciclo sono destinati a solo macelli industriali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 5),87,4915, 'ESITO DEL CONTROLLO');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 5),88,4916, 'Sono state assegnate delle prescrizioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 5),89,4917, 'Sono state applicate delle sanzioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2022 and s.ordine = 5),90,4829, 'NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :');

-- Bonifico domande
update biosicurezza_domande set domanda = 'Numero totale degli animali' where domanda ilike 'Ndeg totale animali';

-----------------------------------------
-- 4: Aprire nel foglio "ClassyFarmGeneratore.ods" il tab "Risposte" 
-- Dovrebbero già essere disponibili tutti gli script di insert. Assicurarsi che la lista di domande corrisponda (se la checklist ne prevede di più di quella di esempio utilizzata nel foglio occorre estendere le ultime righe)
-- Rimuovere come al solito gli spazi

insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4827), 14014, 'CheckBoxList', 'Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1', 'Categorie presenti');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4827), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4827), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4827), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4828), 14015, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4828), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4828), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4828), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4829), 14016, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4829), 14017, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4829), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4829), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4830), 14019, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4830), 14018, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4830), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4830), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4831), 14020, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4831), 14021, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4831), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4831), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4832), 14022, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4832), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4832), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4832), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4834), 14029, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4834), 14027, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4834), 14028, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4834), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4836), 14035, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4836), 14033, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4836), 14036, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4836), 14034, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4835), 14031, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4835), 14030, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4835), 14032, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4835), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4837), 14038, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4837), 14037, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4837), 14039, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4837), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4838), 14042, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4838), 14040, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4838), 14041, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4838), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4839), 14044, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4839), 14043, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4839), 14045, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4839), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4840), 14048, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4840), 14046, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4840), 14047, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4840), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4841), 14050, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4841), 14049, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4841), 14051, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4841), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4842), 14053, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4842), 14054, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4842), 14052, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4842), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4843), 14057, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4843), 14055, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4843), 14056, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4843), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4844), 14059, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4844), 14058, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4844), 14060, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4844), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4845), 14063, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4845), 14061, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4845), 14062, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4845), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4846), 14065, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4846), 14064, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4846), 14067, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4846), 14066, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4847), 14070, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4847), 14068, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4847), 14069, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4847), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4848), 14072, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4848), 14071, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4848), 14073, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4848), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4849), 14077, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4849), 14076, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4849), 14075, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4849), 14074, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4850), 14078, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4850), 14079, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4850), 14080, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4850), 14081, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4851), 14085, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4851), 14084, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4851), 14083, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4851), 14082, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4852), 14086, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4852), 14087, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4852), 14088, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4852), 14089, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4853), 14092, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4853), 14091, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4853), 14090, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4853), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4854), 14093, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4854), 14094, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4854), 14096, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4854), 14095, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4855), 14099, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4855), 14100, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4855), 14098, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4855), 14097, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4856), 14101, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4856), 14102, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4856), 14104, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4856), 14103, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4857), 14107, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4857), 14108, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4857), 14106, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4857), 14105, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4858), 14109, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4858), 14110, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4858), 14111, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4858), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4868), 14146, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4868), 14145, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4868), 14143, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4868), 14144, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4859), 14114, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4859), 14113, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4859), 14112, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4859), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4860), 14115, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4860), 14116, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4860), 14118, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4860), 14117, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4861), 14121, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4861), 14122, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4861), 14120, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4861), 14119, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4862), 14123, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4862), 14124, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4862), 14126, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4862), 14125, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4863), 14129, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4863), 14128, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4863), 14127, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4863), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4864), 14130, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4864), 14131, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4864), 14132, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4864), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4865), 14136, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4865), 14135, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4865), 14134, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4865), 14133, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4866), 14137, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4866), 14138, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4866), 14139, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4866), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4867), 14142, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4867), 14141, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4867), 14140, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4867), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4869), 14149, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4869), 14150, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4869), 14148, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4869), 14147, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4870), 14151, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4870), 14152, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4870), 14153, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4870), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4871), 14156, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4871), 14155, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4871), 14154, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4871), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4872), 14157, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4872), 14158, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4872), 14159, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4872), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4873), 14163, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4873), 14162, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4873), 14161, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4873), 14160, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4874), 14164, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4874), 14165, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4874), 14166, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4874), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4875), 14169, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4875), 14168, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4875), 14167, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4875), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4876), 14170, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4876), 14171, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4876), 14173, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4876), 14172, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4877), 14176, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4877), 14177, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4877), 14175, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4877), 14174, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4878), 14178, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4878), 14179, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4878), 14181, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4878), 14180, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4879), 14184, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4879), 14183, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4879), 14182, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4879), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4884), 14198, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4884), 14199, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4884), 14200, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4884), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4880), 14185, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4880), 14187, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4880), 14186, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4880), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4881), 14190, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4881), 14188, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4881), 14189, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4881), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4882), 14192, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4882), 14191, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4882), 14194, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4882), 14193, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4883), 14197, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4883), 14196, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4883), 14195, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4883), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4885), 14202, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4885), 14201, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4885), 14203, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4885), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4886), 14206, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4886), 14204, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4886), 14205, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4886), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4887), 14208, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4887), 14207, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4887), 14209, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4887), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4889), 14216, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4889), 14213, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4889), 14214, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4889), 14215, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4888), 14212, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4888), 14210, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4888), 14211, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4888), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4833), 14026, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4833), 14025, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4833), 14024, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4833), 14023, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4890), 14220, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4890), 14219, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4890), 14218, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4890), 14217, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4891), 14221, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4891), 14222, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4891), 14223, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4891), 14224, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4892), 14228, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4892), 14227, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4892), 14226, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4892), 14225, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4893), 14229, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4893), 14230, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4893), 14231, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4893), 14232, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4894), 14236, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4894), 14235, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4894), 14234, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4894), 14233, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4895), 14237, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4895), 14238, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4895), 14239, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4895), 14240, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4896), 14244, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4896), 14243, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4896), 14242, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4896), 14241, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4897), 14245, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4897), 14246, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4897), 14247, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4897), 14248, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4898), 14252, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4898), 14251, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4898), 14250, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4898), 14249, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4899), 14253, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4899), 14254, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4899), 14255, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4899), 14256, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4900), 14260, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4900), 14259, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4900), 14258, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4900), 14257, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4901), 14261, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4901), 14262, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4901), 14263, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4901), 14264, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4902), 14268, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4902), 14267, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4902), 14266, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4902), 14265, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4903), 14269, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4903), 14270, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4903), 14271, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4903), 14272, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4904), 14276, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4904), 14275, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4904), 14274, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4904), 14273, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4905), 14277, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4905), 14278, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4905), 14279, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4905), 14280, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4906), 14284, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4906), 14283, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4906), 14282, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4906), 14281, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4907), 14285, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4907), 14286, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4907), 14287, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4907), 14288, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4908), 14292, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4908), 14291, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4908), 14290, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4908), 14289, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4910), 14297, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4910), 14298, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4910), 14299, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4910), 14300, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4911), 14304, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4911), 14303, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4911), 14302, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4911), 14301, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4912), 14305, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4912), 14306, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4912), 14307, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4912), 14308, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4913), 14312, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4913), 14311, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4913), 14310, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4913), 14309, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4909), 14293, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4909), 14294, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4909), 14295, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4909), 14296, 'TextArea', '0', 'Note - Motivo NA:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4914), 14314, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4914), 14313, 'TextBox', '0', 'carica');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4914), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4914), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4915), 14316, 'Button', '0', 'SFAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4915), 14315, 'Button', '0', 'FAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4915), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4915), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4916), 14318, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4916), 14319, 'TextArea', '0', 'Se si quali:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4916), 14320, 'TextBox', '0', 'Entro quale data dovranno essere eseguite?');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4916), 14317, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4917), 14322, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4917), 14321, 'CheckBoxList', 'Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4917), 14323, 'TextArea', '0', 'Se altro specificare:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4917), 0, '0', '0', '0');


-- Ripulisco risposte eliminando quelle inesistenti e valorizzando correttamente i dati vuoti (libreoffice setta "0" invece di "vuoto")

delete from biosicurezza_risposte where risposta = '0';
update biosicurezza_risposte set lista = null where lista = '0';

-- Aggiorno "ordine" nel seguente ordine: 
--SI, NO, NA, NOTE
--FAVOREVOLE, SFAVOREVOLE

update biosicurezza_risposte set ordine = 1 where risposta ilike 'si' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'no' and ordine is null;
update biosicurezza_risposte set ordine = 3 where risposta ilike 'na' and ordine is null;
update biosicurezza_risposte set ordine = 3 where risposta ilike 'n/a' and ordine is null;
update biosicurezza_risposte set ordine = 4 where risposta ilike '%note%' and ordine is null;
update biosicurezza_risposte set ordine = 1 where risposta ilike 'favorevole' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'sfavorevole' and ordine is null;

-- Bonifico risposte

delete from biosicurezza_risposte where id_domanda is null;
update biosicurezza_risposte set tipo = 'checkbox' where tipo = 'Button';
update biosicurezza_risposte set tipo = 'textarea' where tipo like '%Text%';
update biosicurezza_risposte set risposta = '' where risposta in ('ndeg:', 'm2:', ':', 'Generalita:');
update biosicurezza_risposte set tipo = 'checkboxList' where tipo = 'CheckBoxList';

-- Modifico unico campo numerico nel tipo number

update biosicurezza_risposte set tipo = 'number' where id_domanda in (select id from biosicurezza_domande where domanda = 'Numero totale degli animali' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_alta-01')))


-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------

-- id 90 checklist VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI A BASSA CAPACITA CONTROLLO UFFICIALE REV.1_2022
{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "4918",
      "DescrDomanda": "Tipologia di suini presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "14324",
          "ControlType": "CheckBoxList",
          "ListItems": " Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1",
          "TemaplateName": "Categorie presenti"
        }
      ]
    },
    {
      "IDDomanda": "4919",
      "DescrDomanda": "Ndeg totale animali",
      "ListaRisposte": [
        {
          "IDRisposta": "14325",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "4920",
      "DescrDomanda": "NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :",
      "ListaRisposte": [
        {
          "IDRisposta": "14326",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "14327",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "4921",
      "DescrDomanda": "Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2021/605?",
      "ListaRisposte": [
        {
          "IDRisposta": "14329",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "14328",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "4922",
      "DescrDomanda": "E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a VIII dellallegato II Regolamento (UE) 2021/605?",
      "ListaRisposte": [
        {
          "IDRisposta": "14330",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "14331",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "4923",
      "DescrDomanda": "Veterinario Ufficiale ispettore",
      "ListaRisposte": [
        {
          "IDRisposta": "14332",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "4926",
      "DescrDomanda": "2. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14342",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14341",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14340",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5005",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "14623",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        },
        {
          "IDRisposta": "14624",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "5006",
      "DescrDomanda": "ESITO DEL CONTROLLO",
      "ListaRisposte": [
        {
          "IDRisposta": "14626",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SFAVOREVOLE"
        },
        {
          "IDRisposta": "14625",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "FAVOREVOLE"
        }
      ]
    },
    {
      "IDDomanda": "4927",
      "DescrDomanda": "3. Lazienda dispone di una zona filtro, con accesso obbligatorio, dotata di locali adibiti a spogliatoio?",
      "ListaRisposte": [
        {
          "IDRisposta": "14343",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14344",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14346",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14345",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4928",
      "DescrDomanda": "4. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?",
      "ListaRisposte": [
        {
          "IDRisposta": "14349",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14348",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14347",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4929",
      "DescrDomanda": "5. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?",
      "ListaRisposte": [
        {
          "IDRisposta": "14350",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14351",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14352",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4930",
      "DescrDomanda": "6. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14355",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14354",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14353",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4931",
      "DescrDomanda": "7. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14356",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14357",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14358",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4932",
      "DescrDomanda": "8. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14361",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14360",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14359",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4933",
      "DescrDomanda": "9. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?",
      "ListaRisposte": [
        {
          "IDRisposta": "14363",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14364",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "14362",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4934",
      "DescrDomanda": "10. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?",
      "ListaRisposte": [
        {
          "IDRisposta": "14367",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14365",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14366",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4935",
      "DescrDomanda": "11. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?",
      "ListaRisposte": [
        {
          "IDRisposta": "14369",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14368",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14370",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4936",
      "DescrDomanda": "12. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?",
      "ListaRisposte": [
        {
          "IDRisposta": "14373",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14371",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14372",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4938",
      "DescrDomanda": "13. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14379",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14378",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14380",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4939",
      "DescrDomanda": "14. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14382",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14381",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14383",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4944",
      "DescrDomanda": "15. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?",
      "ListaRisposte": [
        {
          "IDRisposta": "14402",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14400",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14401",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4949",
      "DescrDomanda": "16. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?",
      "ListaRisposte": [
        {
          "IDRisposta": "14420",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14419",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14421",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4950",
      "DescrDomanda": "17. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?",
      "ListaRisposte": [
        {
          "IDRisposta": "14424",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14422",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14423",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4954",
      "DescrDomanda": "18. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?",
      "ListaRisposte": [
        {
          "IDRisposta": "14438",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14437",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14439",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4955",
      "DescrDomanda": "19. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14442",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14440",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14441",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4957",
      "DescrDomanda": "20. Il carico dei suini vivi avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "14448",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14447",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14449",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4958",
      "DescrDomanda": "21. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14452",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14450",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14451",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4960",
      "DescrDomanda": "22. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14458",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14457",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14460",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14459",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4961",
      "DescrDomanda": "23. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14463",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14461",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14462",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4962",
      "DescrDomanda": "24.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14465",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14464",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14466",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4963",
      "DescrDomanda": "25. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?",
      "ListaRisposte": [
        {
          "IDRisposta": "14469",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14467",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14468",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4965",
      "DescrDomanda": "26. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14475",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14474",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14476",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4966",
      "DescrDomanda": "27. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?",
      "ListaRisposte": [
        {
          "IDRisposta": "14479",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14477",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14478",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4970",
      "DescrDomanda": "28. Il punto di pesa e di esclusivo utilizzo dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14493",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14492",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14494",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4971",
      "DescrDomanda": "29. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14495",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14497",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14496",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4972",
      "DescrDomanda": "30. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14500",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14498",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14499",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4974",
      "DescrDomanda": "31. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?",
      "ListaRisposte": [
        {
          "IDRisposta": "14507",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14506",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14505",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4975",
      "DescrDomanda": "32. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?",
      "ListaRisposte": [
        {
          "IDRisposta": "14510",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14509",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14508",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4976",
      "DescrDomanda": "33. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?",
      "ListaRisposte": [
        {
          "IDRisposta": "14512",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14511",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14513",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4977",
      "DescrDomanda": "34. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?",
      "ListaRisposte": [
        {
          "IDRisposta": "14516",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14514",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14515",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4978",
      "DescrDomanda": "35. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "14518",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14517",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14519",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "4979",
      "DescrDomanda": "36. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "14522",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14520",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14521",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4925",
      "DescrDomanda": "1. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14339",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14337",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14338",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4983",
      "DescrDomanda": "38. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "14535",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14536",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14538",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14537",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4985",
      "DescrDomanda": "39. I locali di quarantena dispongono di ingresso/i separato/i?",
      "ListaRisposte": [
        {
          "IDRisposta": "14545",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14546",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14543",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14544",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "4986",
      "DescrDomanda": "40. Sono disponibili attrezzature destinate esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "14547",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14548",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14550",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14549",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4987",
      "DescrDomanda": "41. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "14553",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14554",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14552",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14551",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4981",
      "DescrDomanda": "37. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14527",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14528",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14530",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14529",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "4997",
      "DescrDomanda": "43. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14593",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14594",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14592",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14591",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "4996",
      "DescrDomanda": "42. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14587",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14588",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14590",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14589",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5002",
      "DescrDomanda": "45. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14613",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14614",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14612",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14611",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5001",
      "DescrDomanda": "44. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "14608",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14607",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14610",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14609",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5007",
      "DescrDomanda": "Sono state assegnate delle prescrizioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14628",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14629",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se si quali:"
        },
        {
          "IDRisposta": "14630",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Entro quale data dovranno essere eseguite?"
        },
        {
          "IDRisposta": "14627",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5008",
      "DescrDomanda": "Sono state applicate delle sanzioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14632",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "14633",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se altro specificare:"
        },
        {
          "IDRisposta": "14631",
          "ControlType": "CheckBoxList",
          "ListItems": " Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6",
          "TemaplateName": ":"
        }
      ]
    }
  ],
  "message": null,
  "esito": 0
}

-- 2: Aprire il PDF ed individuare le sezioni. Inserirle nella tabella delle sezioni.

QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE
QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA
QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO
QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO

insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE', 1, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA', 2, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO', 3, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO',4 , (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_bassa-01'));

-- Creo nuove sezioni
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('DATI AGGIUNTIVI', 0, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('VALUTAZIONE FINALE E PROVVEDIMENTI', 5, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_bassa-01'));

insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 0),5,4922, 'E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a VIII dellallegato II Regolamento (UE) 2021/605?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 0),4,4921, 'Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2021/605?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 0),1,4919, 'Ndeg totale animali');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 0),2,4918, 'Tipologia di suini presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 0),3,4923, 'Veterinario Ufficiale ispettore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),6,4925, '1. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),15,4934, '10. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),16,4935, '11. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),17,4936, '12. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),18,4938, '13. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),19,4939, '14. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),20,4944, '15. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),21,4949, '16. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),22,4950, '17. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),23,4954, '18. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),24,4955, '19. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),7,4926, '2. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),25,4957, '20. Il carico dei suini vivi avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),26,4958, '21. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?');
--corretto alla riga successiva insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),27,4960, '22. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),27,4960, '22. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per l''eliminazione delle stesse conformemente alle disposizioni sanitarie');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),28,4961, '23. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),29,4962, '24.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),30,4963, '25. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),31,4965, '26. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),32,4966, '27. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),33,4970, '28. Il punto di pesa e di esclusivo utilizzo dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),34,4971, '29. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),8,4927, '3. Lazienda dispone di una zona filtro, con accesso obbligatorio, dotata di locali adibiti a spogliatoio?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),35,4972, '30. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),36,4974, '31. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),37,4975, '32. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),38,4976, '33. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),39,4977, '34. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),40,4978, '35. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),41,4979, '36. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),9,4928, '4. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),10,4929, '5. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),11,4930, '6. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),12,4931, '7. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),13,4932, '8. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 1),14,4933, '9. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 2),42,4981, '37. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 2),43,4983, '38. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 2),44,4985, '39. I locali di quarantena dispongono di ingresso/i separato/i?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 2),45,4986, '40. Sono disponibili attrezzature destinate esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 2),46,4987, '41. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 3),47,4996, '42. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 3),48,4997, '43. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 4),49,5001, '44. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 4),50,5002, '45. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 5),51,5006, 'ESITO DEL CONTROLLO');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 5),54,4920, 'NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 5),53,5008, 'Sono state applicate delle sanzioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2022 and s.ordine = 5),52,5007, 'Sono state assegnate delle prescrizioni?');

-- bonifica domande
update biosicurezza_domande set domanda = 'Numero totale degli animali' where domanda ilike 'Ndeg totale animali';

-------- RISPOSTE
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4918), 14324, 'CheckBoxList', ' Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1', 'Categorie presenti');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4918), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4918), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4918), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4919), 14325, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4919), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4919), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4919), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4920), 14326, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4920), 14327, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4920), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4920), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4921), 14329, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4921), 14328, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4921), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4921), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4922), 14330, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4922), 14331, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4922), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4922), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4923), 14332, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4923), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4923), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4923), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4926), 14342, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4926), 14341, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4926), 14340, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4926), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5005), 14623, 'TextBox', '0', 'carica');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5005), 14624, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5005), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5005), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5006), 14626, 'Button', '0', 'SFAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5006), 14625, 'Button', '0', 'FAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5006), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5006), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4927), 14343, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4927), 14344, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4927), 14346, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4927), 14345, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4928), 14349, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4928), 14348, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4928), 14347, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4928), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4929), 14350, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4929), 14351, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4929), 14352, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4929), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4930), 14355, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4930), 14354, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4930), 14353, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4930), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4931), 14356, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4931), 14357, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4931), 14358, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4931), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4932), 14361, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4932), 14360, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4932), 14359, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4932), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4933), 14363, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4933), 14364, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4933), 14362, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4933), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4934), 14367, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4934), 14365, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4934), 14366, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4934), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4935), 14369, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4935), 14368, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4935), 14370, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4935), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4936), 14373, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4936), 14371, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4936), 14372, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4936), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4938), 14379, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4938), 14378, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4938), 14380, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4938), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4939), 14382, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4939), 14381, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4939), 14383, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4939), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4944), 14402, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4944), 14400, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4944), 14401, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4944), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4949), 14420, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4949), 14419, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4949), 14421, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4949), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4950), 14424, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4950), 14422, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4950), 14423, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4950), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4954), 14438, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4954), 14437, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4954), 14439, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4954), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4955), 14442, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4955), 14440, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4955), 14441, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4955), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4957), 14448, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4957), 14447, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4957), 14449, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4957), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4958), 14452, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4958), 14450, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4958), 14451, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4958), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4960), 14458, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4960), 14457, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4960), 14460, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4960), 14459, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4961), 14463, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4961), 14461, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4961), 14462, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4961), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4962), 14465, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4962), 14464, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4962), 14466, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4962), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4963), 14469, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4963), 14467, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4963), 14468, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4963), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4965), 14475, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4965), 14474, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4965), 14476, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4965), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4966), 14479, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4966), 14477, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4966), 14478, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4966), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4970), 14493, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4970), 14492, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4970), 14494, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4970), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4971), 14495, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4971), 14497, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4971), 14496, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4971), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4972), 14500, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4972), 14498, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4972), 14499, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4972), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4974), 14507, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4974), 14506, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4974), 14505, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4974), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4975), 14510, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4975), 14509, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4975), 14508, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4975), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4976), 14512, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4976), 14511, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4976), 14513, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4976), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4977), 14516, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4977), 14514, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4977), 14515, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4977), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4978), 14518, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4978), 14517, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4978), 14519, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4978), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4979), 14522, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4979), 14520, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4979), 14521, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4979), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4925), 14339, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4925), 14337, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4925), 14338, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4925), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4983), 14535, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4983), 14536, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4983), 14538, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4983), 14537, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4985), 14545, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4985), 14546, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4985), 14543, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4985), 14544, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4986), 14547, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4986), 14548, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4986), 14550, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4986), 14549, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4987), 14553, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4987), 14554, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4987), 14552, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4987), 14551, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4981), 14527, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4981), 14528, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4981), 14530, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4981), 14529, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4997), 14593, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4997), 14594, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4997), 14592, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4997), 14591, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4996), 14587, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4996), 14588, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4996), 14590, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 4996), 14589, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5002), 14613, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5002), 14614, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5002), 14612, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5002), 14611, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5001), 14608, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5001), 14607, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5001), 14610, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5001), 14609, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5007), 14628, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5007), 14629, 'TextArea', '0', 'Se si quali:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5007), 14630, 'TextBox', '0', 'Entro quale data dovranno essere eseguite?');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5007), 14627, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5008), 14632, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5008), 14633, 'TextArea', '0', 'Se altro specificare:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5008), 14631, 'CheckBoxList', ' Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5008), 0, '0', '0', '0');

-- Ripulisco risposte eliminando quelle inesistenti e valorizzando correttamente i dati vuoti (libreoffice setta "0" invece di "vuoto")


delete from biosicurezza_risposte where risposta = '0';
update biosicurezza_risposte set lista = null where lista = '0';

-- Aggiorno "ordine" nel seguente ordine: 
--SI, NO, NA, NOTE
--FAVOREVOLE, SFAVOREVOLE

update biosicurezza_risposte set ordine = 1 where risposta ilike 'si' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'no' and ordine is null;
update biosicurezza_risposte set ordine = 3 where risposta ilike 'na' and ordine is null;
update biosicurezza_risposte set ordine = 3 where risposta ilike 'n/a' and ordine is null;
update biosicurezza_risposte set ordine = 4 where risposta ilike '%note%' and ordine is null;
update biosicurezza_risposte set ordine = 1 where risposta ilike 'favorevole' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'sfavorevole' and ordine is null;

delete from biosicurezza_risposte where id_domanda is null;
update biosicurezza_risposte set tipo = 'checkbox' where tipo = 'Button';
update biosicurezza_risposte set tipo = 'textarea' where tipo like '%Text%';
update biosicurezza_risposte set risposta = '' where risposta in ('ndeg:', 'm2:', ':', 'Generalita:');
update biosicurezza_risposte set tipo = 'checkboxList' where tipo = 'CheckBoxList';

update biosicurezza_risposte set tipo = 'number' where id_domanda in (select id from biosicurezza_domande where domanda = 'Numero totale degli animali' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-stab_bassa-01')))

91 - VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI A BASSA CAPACITA CONTROLLO UFFICIALE REV.1_2022

{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "5010",
      "DescrDomanda": "Ndeg totale animali",
      "ListaRisposte": [
        {
          "IDRisposta": "14635",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "5011",
      "DescrDomanda": "NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :",
      "ListaRisposte": [
        {
          "IDRisposta": "14637",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "14636",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "5012",
      "DescrDomanda": "Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2021/605?",
      "ListaRisposte": [
        {
          "IDRisposta": "14639",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "14638",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "5014",
      "DescrDomanda": "Veterinario Ufficiale ispettore",
      "ListaRisposte": [
        {
          "IDRisposta": "14642",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "5009",
      "DescrDomanda": "Tipologia di suini presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "14634",
          "ControlType": "CheckBoxList",
          "ListItems": " Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1",
          "TemaplateName": "Categorie presenti"
        }
      ]
    },
    {
      "IDDomanda": "5019",
      "DescrDomanda": "2. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?",
      "ListaRisposte": [
        {
          "IDRisposta": "14659",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14657",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14658",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5021",
      "DescrDomanda": "3. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14664",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14663",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14665",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5022",
      "DescrDomanda": "4. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14668",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14666",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14667",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5024",
      "DescrDomanda": "5. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?",
      "ListaRisposte": [
        {
          "IDRisposta": "14673",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14674",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "14672",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5025",
      "DescrDomanda": "6. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?",
      "ListaRisposte": [
        {
          "IDRisposta": "14677",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14676",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14675",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5039",
      "DescrDomanda": "9. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "14726",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14728",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14725",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14727",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5027",
      "DescrDomanda": "7. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?",
      "ListaRisposte": [
        {
          "IDRisposta": "14681",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14682",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14683",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5035",
      "DescrDomanda": "8. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?",
      "ListaRisposte": [
        {
          "IDRisposta": "14712",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14711",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14710",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5040",
      "DescrDomanda": "10. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?",
      "ListaRisposte": [
        {
          "IDRisposta": "14731",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14729",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14730",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5041",
      "DescrDomanda": "11. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?",
      "ListaRisposte": [
        {
          "IDRisposta": "14733",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14732",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14734",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5045",
      "DescrDomanda": "12. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?",
      "ListaRisposte": [
        {
          "IDRisposta": "14749",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14747",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14748",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5046",
      "DescrDomanda": "13. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14751",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14750",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14752",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5051",
      "DescrDomanda": "14. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14770",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14769",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "14767",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14768",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5062",
      "DescrDomanda": "15. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "14805",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14806",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14807",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5067",
      "DescrDomanda": "16. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?",
      "ListaRisposte": [
        {
          "IDRisposta": "14823",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14821",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14822",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5069",
      "DescrDomanda": "17. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "14828",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14827",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14829",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5070",
      "DescrDomanda": "18. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "14832",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14830",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14831",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5016",
      "DescrDomanda": "1. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ",
      "ListaRisposte": [
        {
          "IDRisposta": "14649",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "14647",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "14648",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5096",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "14934",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "14933",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        }
      ]
    },
    {
      "IDDomanda": "5097",
      "DescrDomanda": "ESITO DEL CONTROLLO",
      "ListaRisposte": [
        {
          "IDRisposta": "14936",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SFAVOREVOLE"
        },
        {
          "IDRisposta": "14935",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "FAVOREVOLE"
        }
      ]
    },
    {
      "IDDomanda": "5098",
      "DescrDomanda": "Sono state assegnate delle prescrizioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14938",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "14939",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se si quali:"
        },
        {
          "IDRisposta": "14940",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Entro quale data dovranno essere eseguite?"
        },
        {
          "IDRisposta": "14937",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5099",
      "DescrDomanda": "Sono state applicate delle sanzioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "14942",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "14941",
          "ControlType": "CheckBoxList",
          "ListItems": " Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6",
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "14943",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se altro specificare:"
        }
      ]
    }
  ],
  "message": null,
  "esito": 0
}

--QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE', 1, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('DATI AGGIUNTIVI', 0, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('VALUTAZIONE FINALE E PROVVEDIMENTI', 2, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_bassa-01'));

insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 0),1,5010, 'Ndeg totale animali');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 0),4,5012, 'Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2021/605?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 0),2,5014, 'Veterinario Ufficiale ispettore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 0),3,5009, 'Tipologia di suini presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),5,5016, '1. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),6,5019, '2. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),7,5021, '3. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),8,5022, '4. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),9,5024, '5. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),10,5025, '6. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),11,5027, '7. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),12,5035, '8. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),13,5039, '9. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),14,5040, '10. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),15,5041, '11. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),16,5045, '12. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),17,5046, '13. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?');
-- corretto nella riga successiva insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),18,5051, '14. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),18,5051, '14. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per l''eliminazione delle stesse conformemente alle disposizioni sanitarie');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),19,5062, '15. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),20,5067, '16. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),21,5069, '17. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 1),22,5070, '18. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 2),23,5097, 'ESITO DEL CONTROLLO');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 2),24,5098, 'Sono state assegnate delle prescrizioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 2),25,5099, 'Sono state applicate delle sanzioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2022 and s.ordine = 2),26,5011, 'NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :');

update biosicurezza_domande set domanda = 'Numero totale degli animali' where domanda ilike 'Ndeg totale animali';

-- RISPOSTE
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5010), 14635, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5010), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5010), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5010), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5011), 14637, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5011), 14636, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5011), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5011), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5012), 14639, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5012), 14638, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5012), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5012), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5014), 14642, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5014), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5014), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5014), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5009), 14634, 'CheckBoxList', ' Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1', 'Categorie presenti');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5009), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5009), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5009), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5019), 14659, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5019), 14657, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5019), 14658, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5019), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5021), 14664, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5021), 14663, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5021), 14665, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5021), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5022), 14668, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5022), 14666, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5022), 14667, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5022), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5024), 14673, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5024), 14674, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5024), 14672, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5024), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5025), 14677, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5025), 14676, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5025), 14675, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5025), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5039), 14726, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5039), 14728, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5039), 14725, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5039), 14727, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5027), 14681, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5027), 14682, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5027), 14683, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5027), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5035), 14712, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5035), 14711, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5035), 14710, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5035), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5040), 14731, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5040), 14729, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5040), 14730, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5040), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5041), 14733, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5041), 14732, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5041), 14734, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5041), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5045), 14749, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5045), 14747, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5045), 14748, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5045), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5046), 14751, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5046), 14750, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5046), 14752, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5046), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5051), 14770, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5051), 14769, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5051), 14767, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5051), 14768, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5062), 14805, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5062), 14806, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5062), 14807, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5062), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5067), 14823, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5067), 14821, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5067), 14822, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5067), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5069), 14828, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5069), 14827, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5069), 14829, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5069), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5070), 14832, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5070), 14830, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5070), 14831, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5070), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5016), 14649, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5016), 14647, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5016), 14648, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5016), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5096), 14934, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5096), 14933, 'TextBox', '0', 'carica');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5096), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5096), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5097), 14936, 'Button', '0', 'SFAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5097), 14935, 'Button', '0', 'FAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5097), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5097), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5098), 14938, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5098), 14939, 'TextArea', '0', 'Se si quali:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5098), 14940, 'TextBox', '0', 'Entro quale data dovranno essere eseguite?');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5098), 14937, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5099), 14942, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5099), 14941, 'CheckBoxList', ' Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5099), 14943, 'TextArea', '0', 'Se altro specificare:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5099), 0, '0', '0', '0');


-- Ripulisco risposte eliminando quelle inesistenti e valorizzando correttamente i dati vuoti (libreoffice setta "0" invece di "vuoto")

delete from biosicurezza_risposte where risposta = '0';
update biosicurezza_risposte set lista = null where lista = '0';

-- Aggiorno "ordine" nel seguente ordine: 
--SI, NO, NA, NOTE
--FAVOREVOLE, SFAVOREVOLE

update biosicurezza_risposte set ordine = 1 where risposta ilike 'si' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'no' and ordine is null;
update biosicurezza_risposte set ordine = 3 where risposta ilike 'na' and ordine is null;
update biosicurezza_risposte set ordine = 3 where risposta ilike 'n/a' and ordine is null;
update biosicurezza_risposte set ordine = 4 where risposta ilike '%note%' and ordine is null;
update biosicurezza_risposte set ordine = 1 where risposta ilike 'favorevole' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'sfavorevole' and ordine is null;

-- Bonifico risposte

delete from biosicurezza_risposte where id_domanda is null;
update biosicurezza_risposte set tipo = 'checkbox' where tipo = 'Button';
update biosicurezza_risposte set tipo = 'textarea' where tipo like '%Text%';
update biosicurezza_risposte set risposta = '' where risposta in ('ndeg:', 'm2:', ':', 'Generalita:');
update biosicurezza_risposte set tipo = 'checkboxList' where tipo = 'CheckBoxList';

-- Modifico unico campo numerico nel tipo number

update biosicurezza_risposte set tipo = 'number' where id_domanda in (select id from biosicurezza_domande where domanda = 'Numero totale degli animali' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2022-suini-semib_alta-01')))


--QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE


update biosicurezza_domande  set domanda = replace(domanda, 'Lallevamento','L''allevamento')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'e posto','e'' posto')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'E presente','E'' presente')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'Lazienda','L''azienda')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'e dotata','e'' dotata')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'unarea','un''area')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'nellazienda','nell''azienda')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'continuita','continuita''')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'Larea','L''area')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'funzionalita','funzionalita''')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'dellautomezzo','dell''automezzo')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'lavvenuta','l''avvenuta')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'prossimita','prossimita''')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'dellaccesso','dell''accesso')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'allallevamento','all''allevamento')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'dellarea','dell''area')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'allallegato','all''allegato')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'dellallegato','dell''allegato')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'dellallevamento','dell''allevamento')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'lingresso','l''ingresso')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'E vietato','E'' vietato')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'dellazienda','dell''azienda')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'E previsto','E'' previsto')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'leliminazione','l''eliminazione')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'limpossibilita','l''impossibilita''')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'puo venire','puo''venire')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'lesecuzione','l''esecuzione')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'Lesame','L''esame')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'allesterno','all''esterno')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'lalimentazione','l''alimentazione')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'e garantita','e'' garantita')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'e di esclusivo','e'' di esclusivo')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'E vietata','E'' vietata')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'allazienda','all''azienda')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'e comunque garantita','e'' comunque garantita')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'E prevista','E'' prevista')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'E richiesta','E'' richiesta')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'piu di','piu'' di')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));
update biosicurezza_domande  set domanda = replace(domanda, 'dallarea','dall''area')where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_classyfarm::integer in (78,89,90,91)));

-- bugfixing
update biosicurezza_risposte set lista = replace(lista,'Suini allingrasso','Suini in ingrasso') where lista   ilike '%Suini allingrasso%'
update biosicurezza_risposte set lista = replace(lista,'– 6','- 6') where lista ilike '%– 6%'
update biosicurezza_domande set domanda = replace(domanda,'ALLISPEZIONE','ALL''ISPEZIONE') where  domanda   ilike '%ALLISPEZIONE%';
-- associazione nuovi sottopiani per biosicurezza suini (in ufficiale occorre vedere il valore del codice raggruppamento)
insert into rel_motivi_eventi_cu(id_evento_cu, entered, enteredby, modified, modifiedby, note_hd, cod_raggrup_ind)
values (20, now(), 6567, now(), 6567, 'Richiesta ORSA per Flusso 311',5677);
insert into rel_motivi_eventi_cu(id_evento_cu, entered, enteredby, modified, modifiedby, note_hd, cod_raggrup_ind)
values (20, now(), 6567, now(), 6567, 'Richiesta ORSA per Flusso 311',5678);
insert into rel_motivi_eventi_cu(id_evento_cu, entered, enteredby, modified, modifiedby, note_hd, cod_raggrup_ind)
values (20, now(), 6567, now(), 6567, 'Richiesta ORSA per Flusso 311',5679);
insert into rel_motivi_eventi_cu(id_evento_cu, entered, enteredby, modified, modifiedby, note_hd, cod_raggrup_ind)
values (20, now(), 6567, now(), 6567, 'Richiesta ORSA per Flusso 311',5680);

-- associazione singola checklist tramite descrizione (questi script non sono pi� necessari!!!)
--update dpat_indicatore_new set codice_interno_piani_gestione_cu = 1346 where alias_indicatore ='B2_G'; --bassa capacit�
--update dpat_indicatore_new set codice_interno_piani_gestione_cu = 1347 where alias_indicatore ='B2_H'; --alta capacit�
--update dpat_indicatore_new set codice_interno_piani_gestione_cu = 1348 where alias_indicatore ='B2_I'; --semibradi bassi
--update dpat_indicatore_new set codice_interno_piani_gestione_cu = 1349 where alias_indicatore ='B2_L'; --semibradi alti
--

update biosicurezza_risposte set tipo = 'date' where id_classyfarm in (14940,14013,14630,14320);


-----------------------------------------
-- OPERAZIONI PRELIMINARI
-----------------------------------------

-----------------------------------------
-- PRELIMINARE 1: Ottenere da classyfarm i codici delle checklist da sviluppare (da farsi mandare via mail)

112 
VALUTAZIONE DELLA BIOSICUREZZA: TACCHINI DA CARNE CONTROLLO UFFICIALE REV.1_2023
113 
VALUTAZIONE DELLA BIOSICUREZZA: POLLI DA CARNE CONTROLLO UFFICIALE REV.1_2023
114 
VALUTAZIONE DELLA BIOSICUREZZA: GALLINE OVAIOLE CONTROLLO UFFICIALE REV.1_2023
115 
VALUTAZIONE DELLA BIOSICUREZZA: INCUBATOI CONTROLLO UFFICIALE REV.1_2023
116 
VALUTAZIONE DELLA BIOSICUREZZA: ALLEVAMENTI AVICOLI < 250 CONTROLLO UFFICIALE REV.1_2023
117 
VALUTAZIONE DELLA BIOSICUREZZA: ALLEVAMENT AVICOLI AD INDIRIZZO SVEZZAMENTO CONTROLLO UFFICIALE REV.1_2023
118 
VALUTAZIONE DELLA BIOSICUREZZA: ALTRE SPECIE (> 250 CAPI) CONTROLLO UFFICIALE REV.1_2023

-----------------------------------------
-- PRELIMINARE 2: Creare entry nella lookup delle checklist, associando il nome corretto, il codice specie, il codice classyfarm, il codice gisa e la versione

-- Il codice gisa e' un nome univoco che diamo noi a ogni checklist 
-- La versione corrisponde all'anno della versione della checklist (es. 2023)
-- Il codice specie deve coincidere con la specie oggetto della checklist. Se e' utilizzato (es. perchè ci sono 2 checklist suini con versione 2023) bisogna usarne un altro aggiungendo ad esempio dei progressivi in coda (es 0122 -> 01221, 01222...) 
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: TACCHINI DA CARNE CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-tacchini-01', '112', '0132', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: POLLI DA CARNE CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-broiler-01', '113', '01310', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: GALLINE OVAIOLE CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-galline-01', '114', '0131', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: INCUBATOI CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-incubatoi-01', '115', '13101', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: ALLEVAMENTI AVICOLI < 250 CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-avicoli-meno250-01', '116', '13102', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: ALLEVAMENT AVICOLI AD INDIRIZZO SVEZZAMENTO CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-avicoli-oltre250-01', '117', '13100', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: ALTRE SPECIE (> 250 CAPI) CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-altre_specie-01', '118', '13103', 2023);

-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------

-----------------------------------------
-- CHECKLIST VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2023 (106)
-----------------------------------------

-- 1: Eseguire la chiamata ai webservice di classyfarm per ottenere i template delle checklist

-- Chiamare il servizio login da postman per avere il token
https://cf-function02-test.azurewebsites.net/api/autenticazione/login

{"username": "regcampania_CF","password": "yrq5nKqSr8CdOPOLmMxi4h/HtPM="}

-- Usare il token su chrome (estensione MOD HEADER, parametro x-api-key)

-- Collegarsi a http://cf-function02-test.azurewebsites.net/api/swagger/ui e nella sezione /api/checklist/getTemplateCL fare "try it out" usando il codice classyfarm 106
{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "6135",
      "DescrDomanda": "2.1 Anno costruzione",
      "ListaRisposte": [
        {
          "IDRisposta": "17918",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "6136",
      "DescrDomanda": "2.2 Superficie utile di allevamento (m2):",
      "ListaRisposte": [
        {
          "IDRisposta": "17919",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "m2:"
        }
      ]
    },
    {
      "IDDomanda": "6137",
      "DescrDomanda": "2.3 Numero capannoni in muratura",
      "ListaRisposte": [
        {
          "IDRisposta": "17920",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "6138",
      "DescrDomanda": "2.4 Numero tunnel",
      "ListaRisposte": [
        {
          "IDRisposta": "17921",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "6139",
      "DescrDomanda": "2.5 N. totale silos",
      "ListaRisposte": [
        {
          "IDRisposta": "17922",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "6140",
      "DescrDomanda": "2.6 Allevamento a sessi misti",
      "ListaRisposte": [
        {
          "IDRisposta": "17923",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "17924",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "6141",
      "DescrDomanda": "2.7 Nellallevamento e presente un impianto di biogas",
      "ListaRisposte": [
        {
          "IDRisposta": "17925",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "17926",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "6142",
      "DescrDomanda": "2.8 E presente un impianto di biogas a meno di 500 metri",
      "ListaRisposte": [
        {
          "IDRisposta": "17928",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "17927",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "6143",
      "DescrDomanda": "3.1 Personale familiare ",
      "ListaRisposte": [
        {
          "IDRisposta": "17930",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "17931",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17932",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "17929",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "6144",
      "DescrDomanda": "3.2 Personale esterno (non familiare) dipendente ",
      "ListaRisposte": [
        {
          "IDRisposta": "17934",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "17933",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "17935",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17936",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        }
      ]
    },
    {
      "IDDomanda": "6145",
      "DescrDomanda": "3.3 Personale esterno qualificato non dipendente ",
      "ListaRisposte": [
        {
          "IDRisposta": "17940",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17939",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17937",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17938",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6146",
      "DescrDomanda": "3.3bis Personale esterno (non familiare e non dipendente) con accesso occasionale per operazioni routinarie (amici, vicini, ecc...)",
      "ListaRisposte": [
        {
          "IDRisposta": "17942",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "17943",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17941",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "17944",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        }
      ]
    },
    {
      "IDDomanda": "6147",
      "DescrDomanda": "3.4\tIl personale certifica di rispettare i requisiti in materia di biosicurezza previsti dal Decreto Ministeriale per poter accedere allarea di allevamento*",
      "ListaRisposte": [
        {
          "IDRisposta": "17948",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "17947",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17946",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "17945",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "6148",
      "DescrDomanda": "3.5 Il personale che opera in allevamento e dedito ad un solo stabilimento**",
      "ListaRisposte": [
        {
          "IDRisposta": "17951",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17950",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "17952",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A"
        },
        {
          "IDRisposta": "17949",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "6149",
      "DescrDomanda": "8.1 Laccesso di qualsiasi persona (allevatore, dipendenti, visitatori di qualsiasi tipo) allarea di allevamento e vincolato esclusivamente al passaggio obbligatorio (ovvero anche tramite percorsi dedicati) attraverso una zona filtro posizionata allingresso dellallevamento * ",
      "ListaRisposte": [
        {
          "IDRisposta": "17954",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17953",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17955",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17956",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6150",
      "DescrDomanda": "8.1bis E presente una divisione funzionale della zona filtro in una zona \"sporca\" e \"pulita\"*",
      "ListaRisposte": [
        {
          "IDRisposta": "17960",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17959",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17957",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17958",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6151",
      "DescrDomanda": "8.2 Il locale e pulito, lavabile e disinfettabile",
      "ListaRisposte": [
        {
          "IDRisposta": "17962",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17961",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17963",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17964",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6152",
      "DescrDomanda": "8.3 E presente almeno un punto disinfezione (lavandino funzionante attrezzato con acqua corrente, detergente e disinfettante per le mani)*",
      "ListaRisposte": [
        {
          "IDRisposta": "17968",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17967",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17965",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17966",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6153",
      "DescrDomanda": "8.4 Sono presenti asciugamani monouso/erogatori ad aria e un armadietto pulito in materiale lavabile e disinfettabile per gli indumenti",
      "ListaRisposte": [
        {
          "IDRisposta": "17970",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17969",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17971",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17972",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6154",
      "DescrDomanda": "8.5 Presenza di indumenti puliti o monouso per il personale dipendente e il personale esterno e relativi contenitori per il deposito degli indumenti e dei materiali utilizzati*",
      "ListaRisposte": [
        {
          "IDRisposta": "17976",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17975",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17973",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17974",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6157",
      "DescrDomanda": "10.1 ANTICAMERA CAPANNONI - La dogana danese e presente e correttamente utilizzata *",
      "ListaRisposte": [
        {
          "IDRisposta": "17987",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17988",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17986",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17985",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6158",
      "DescrDomanda": "10.1bis ANTICAMERA CAPANNONI - Lanticamera dei capannoni si presenta sempre priva di macchinari/attrezzature/oggetti non funzionali allallevamento",
      "ListaRisposte": [
        {
          "IDRisposta": "17992",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17991",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17990",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17989",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6159",
      "DescrDomanda": "10.2 ANTICAMERA CAPANNONI - Presenza di calzature dedicate per ogni singolo capannone *",
      "ListaRisposte": [
        {
          "IDRisposta": "17993",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17994",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17995",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17996",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6160",
      "DescrDomanda": "10.3 STRUTTURE CAPANNONI - Presenza di adeguate chiusure dei capannoni (serrature, lucchetti, ecc.)",
      "ListaRisposte": [
        {
          "IDRisposta": "18000",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17999",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17998",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17997",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6161",
      "DescrDomanda": "10.4 STRUTTURE CAPANNONI - Pavimento, pareti e soffitti sono lavabili, disinfettabili e mantenuti in buono stato di manutenzione* *",
      "ListaRisposte": [
        {
          "IDRisposta": "18001",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18002",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18003",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18004",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6162",
      "DescrDomanda": "10.5 STRUTTURE CAPANNONI - Sono presenti adeguati sistemi volti ad impedire laccesso ai volatili (es. reti antipassero, cupolino protetto) su tutte le aperture del capannone*",
      "ListaRisposte": [
        {
          "IDRisposta": "18008",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18007",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18006",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18005",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6163",
      "DescrDomanda": "10.6 STRUTTURE CAPANNONI - La ventilazione e esclusivamente forzata (estrattiva)",
      "ListaRisposte": [
        {
          "IDRisposta": "18009",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18010",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18011",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18012",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6164",
      "DescrDomanda": "10.6bis STRUTTURE CAPANNONI - Le prese daria sono in uno stato di pulizia soddisfacente",
      "ListaRisposte": [
        {
          "IDRisposta": "18016",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note: Motivo NA"
        },
        {
          "IDRisposta": "18015",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18014",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18013",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6165",
      "DescrDomanda": "10.8 AREE DI STOCCAGGIO DEI MATERIALI DUSO - Presenza di una o piu locali/aree di stoccaggio dei materiali duso (attrezzature di allevamento, materiali, lettiere vergini ecc.), adeguatamente protette in modo da evitare contatti con lavifauna selvatica (es. magazzino)* ",
      "ListaRisposte": [
        {
          "IDRisposta": "18017",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18020",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note: Motivo NA:"
        },
        {
          "IDRisposta": "18018",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18019",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6166",
      "DescrDomanda": "7.1 Presenza di unarea di disinfezione dei mezzi in ingresso con fondo impermeabile dotata di impianto fisso, antistante larea di allevamento e separata dalla zona pulita*",
      "ListaRisposte": [
        {
          "IDRisposta": "18023",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18024",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18022",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18021",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6167",
      "DescrDomanda": "7.2 Per gli automezzi che accedono allarea di allevamento, laccesso avviene esclusivamente attraverso la piazzola di disinfezione*",
      "ListaRisposte": [
        {
          "IDRisposta": "18028",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18027",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18026",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18025",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6168",
      "DescrDomanda": "7.3 Il sistema di disinfezione e funzionante e automatizzato**",
      "ListaRisposte": [
        {
          "IDRisposta": "18029",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18030",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18031",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18032",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6169",
      "DescrDomanda": "7.4 Presenza di pozzetto raccolta acque di scarico per allevamenti nuovi ed in quelli oggetto di ristrutturazione*",
      "ListaRisposte": [
        {
          "IDRisposta": "18036",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18035",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18034",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18033",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6174",
      "DescrDomanda": "19.1 Attivita agricola del conduttore",
      "ListaRisposte": [
        {
          "IDRisposta": "18055",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18053",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18056",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18054",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6175",
      "DescrDomanda": "19.2 Esiste una netta separazione tra le due diverse attivita",
      "ListaRisposte": [
        {
          "IDRisposta": "18058",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18057",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18060",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note -Motivo NA:"
        },
        {
          "IDRisposta": "18059",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6176",
      "DescrDomanda": "19.3 Lallevatore o i dipendenti si dedicano allattivita venatoria o di pesca",
      "ListaRisposte": [
        {
          "IDRisposta": "18063",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18061",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18064",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18062",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6177",
      "DescrDomanda": "19.5 Altri allevamenti di proprieta dellallevatore o di familiari ",
      "ListaRisposte": [
        {
          "IDRisposta": "18066",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18068",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note- Motivo NA:"
        },
        {
          "IDRisposta": "18065",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18067",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6178",
      "DescrDomanda": "19.6 Specificare la specie avicola",
      "ListaRisposte": [
        {
          "IDRisposta": "18070",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18071",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18069",
          "ControlType": "CheckBoxList",
          "ListItems": " GALLUS GALLUS - 1; PERNICI - 2; QUAGLIE - 3; STARNE - 4; PICCIONI - 5; OCHE - 6; FARAONE - 7; FAGIANI - 8; STRUZZI - 9;  ANATRE - 10; COLOMBE - 11; EMU - 12; VOLATILI PER RICHIAMI VIVI - 13;  AVICOLI MISTI - 14;  ALTRE SPECIE DI VOLATILI - 15; TACCHINI - 16",
          "TemaplateName": null
        }
      ]
    },
    {
      "IDDomanda": "6179",
      "DescrDomanda": "19.7 Altri allevamenti di suini di proprieta dellallevatore o di familiari",
      "ListaRisposte": [
        {
          "IDRisposta": "18073",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18072",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18074",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18075",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6180",
      "DescrDomanda": "19.8 Altri allevamenti di altri mammiferi di proprieta dellallevatore o di familiari",
      "ListaRisposte": [
        {
          "IDRisposta": "18079",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18078",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18076",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18077",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6181",
      "DescrDomanda": "19.9 Specificare la specie",
      "ListaRisposte": [
        {
          "IDRisposta": "18082",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18080",
          "ControlType": "CheckBoxList",
          "ListItems": " BOVINI - 1; DROMEDARIO - 22; YAK - 23; GNU - 24; ZEBU - 25; CAPRIOLO - 26; CAMOSCIO - 27; DAINO - 28; MUFLONE - 29; STAMBECCO - 30; ANTILOPE - 31; GAZZELLA - 32; ALCE - 33; RENNA - 34; LAMA - 35; ALPACA - 36; CAMMELLO - 21; CERVIDI - 20; CROSTACEI - 19; MOLLUSCHI - 18; OVINI - 2; CAPRINI - 3; CAVALLI - 4; CONIGLI - 5; BUFALINI - 6; API - 7; MULI - 8; GUANACO - 37; BARDOTTI - 9; ERMELLINI - 11; RANE - 12; CHIOCCIOLE - 13; ZEBRA - 14; ZEBRALLO - 15; LERPI - 16; PESCI - 17; ASINI - 10; VIGONA - 38",
          "TemaplateName": null
        },
        {
          "IDRisposta": "18081",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6182",
      "DescrDomanda": "19.10 Lallevatore possiede o gestisce impianti di biogas",
      "ListaRisposte": [
        {
          "IDRisposta": "18085",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18086",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18083",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18084",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6456",
      "DescrDomanda": "19.4 Nellallevamento sono presenti tacchini e/o selvaggina da penna e/o riproduttori*",
      "ListaRisposte": [
        {
          "IDRisposta": "19052",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19055",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19053",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19054",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6183",
      "DescrDomanda": "1.1 Detentore degli animali",
      "ListaRisposte": [
        {
          "IDRisposta": "18087",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "6184",
      "DescrDomanda": "1.2 Eta",
      "ListaRisposte": [
        {
          "IDRisposta": "18088",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "6185",
      "DescrDomanda": "1.3 Ditta soccidante",
      "ListaRisposte": [
        {
          "IDRisposta": "18090",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18089",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "6186",
      "DescrDomanda": "1.4 Veterinario aziendale",
      "ListaRisposte": [
        {
          "IDRisposta": "18092",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18091",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "6187",
      "DescrDomanda": "1.5 Tecnico",
      "ListaRisposte": [
        {
          "IDRisposta": "18093",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "18094",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6190",
      "DescrDomanda": "4.1 Il carico dei silos avviene esclusivamente dallesterno dellarea di allevamento**",
      "ListaRisposte": [
        {
          "IDRisposta": "18097",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "18100",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "18099",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18098",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "6191",
      "DescrDomanda": "4.2 I silos vengono puliti e disinfettati ad ogni nuovo ingresso di animali* ",
      "ListaRisposte": [
        {
          "IDRisposta": "18102",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18103",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18104",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18101",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6192",
      "DescrDomanda": "5.1 Larea di parcheggio e separata dallarea di allevamento e chiaramente identificata*",
      "ListaRisposte": [
        {
          "IDRisposta": "18105",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "18108",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "18107",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18106",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "6193",
      "DescrDomanda": "6.1 Sono presenti idonee barriere allingresso (Cancelli, Sbarre mobili) *",
      "ListaRisposte": [
        {
          "IDRisposta": "18110",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "18111",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18112",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "18109",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "6194",
      "DescrDomanda": "6.2 Esiste la possibilita che le persone e gli automezzi accedano allallevamento in modo non controllato* ",
      "ListaRisposte": [
        {
          "IDRisposta": "18114",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "18116",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "18115",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18113",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "6195",
      "DescrDomanda": "6.3 E presente idonea cartellonistica per la segnalazione di divieto di accesso e di procedure da adottare dopo laccesso alle aree di allevamento *",
      "ListaRisposte": [
        {
          "IDRisposta": "18118",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "18119",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18120",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "18117",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "6196",
      "DescrDomanda": "6.4 Sono presenti edifici non pertinenti e automezzi non dedicati allattivita allinterno dellarea di allevamento",
      "ListaRisposte": [
        {
          "IDRisposta": "18121",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "18124",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo N/A:"
        },
        {
          "IDRisposta": "18123",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18122",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "6197",
      "DescrDomanda": "12.1 Il sistema di lavaggio, pulizia e disinfezione dei locali di allevamento e delle attrezzature e adeguato e prevede lutilizzo di disinfettanti di provata efficacia*",
      "ListaRisposte": [
        {
          "IDRisposta": "18126",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18127",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18128",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18125",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6198",
      "DescrDomanda": "12.2 Lallevamento rispetta lobbligo di presenza di pozzetti per la raccolta dellacqua di scolo dei capannoni*",
      "ListaRisposte": [
        {
          "IDRisposta": "18129",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18132",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18131",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18130",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6199",
      "DescrDomanda": "12.3 Le attrezzature, una volta pulite e disinfettate, vengono correttamente gestite e stoccate in un luogo protetto (tettoia o magazzino) in modo da evitare la successiva contaminazione*",
      "ListaRisposte": [
        {
          "IDRisposta": "18134",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18135",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18133",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18136",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6200",
      "DescrDomanda": "12.4 Presenza di protocollo completo (procedura scritta) che certifichi lavvenuta pulizia e disinfezione di automezzi, materiale, attrezzature, locali e strutture di allevamento*",
      "ListaRisposte": [
        {
          "IDRisposta": "18138",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18137",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18139",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18140",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6201",
      "DescrDomanda": "12.5 Loperatore conserva per almeno 12 mesi la documentazione di avvenuta pulizia e disinfezione degli automezzi provenienti da altri stabilimenti e la rende disponibile per le eventuali verifiche da parte dellautorita competente*",
      "ListaRisposte": [
        {
          "IDRisposta": "18144",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18143",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18142",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18141",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6446",
      "DescrDomanda": "12.6 E rispettato periodo di vuoto biologico*",
      "ListaRisposte": [
        {
          "IDRisposta": "19012",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19015",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19013",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19014",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6447",
      "DescrDomanda": "12.7 E rispettato periodo di vuoto sanitario*",
      "ListaRisposte": [
        {
          "IDRisposta": "19018",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "19017",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19019",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19016",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6448",
      "DescrDomanda": "12.8 Le operazione di pulizia/disinfezione sono a carico di una ditta esterna specializzata",
      "ListaRisposte": [
        {
          "IDRisposta": "19020",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19023",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19021",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19022",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6202",
      "DescrDomanda": "9.1 Presenza di piazzole di carico/scarico dei materiali duso e degli animali costituite da una superficie lavabile e disinfettabile, e in stato di manutenzione adeguato*",
      "ListaRisposte": [
        {
          "IDRisposta": "18147",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18146",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18148",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18145",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6203",
      "DescrDomanda": "9.2 Le piazzole sono posizionate agli ingressi dei capannoni, hanno dimensioni minime pari allapertura del capannone e consentono che tutte le fasi di carico/scarico avvengano su tale area *",
      "ListaRisposte": [
        {
          "IDRisposta": "18149",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18152",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18150",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18151",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6204",
      "DescrDomanda": "11.1 Presenza di idonei contenitori protetti per il deposito dei rifiuti in prossimita della barriera*",
      "ListaRisposte": [
        {
          "IDRisposta": "18155",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18156",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18153",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18154",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6205",
      "DescrDomanda": "11.2 Larea circostante i capannoni e mantenuta in condizioni idonee con erba tagliata e priva di oggetti e materiali non pertinenti*",
      "ListaRisposte": [
        {
          "IDRisposta": "18157",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18158",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18159",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18160",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6207",
      "DescrDomanda": "13.1 Viene effettuato laccasamento esclusivamente di tacchinotti di un giorno provenienti direttamente da un incubatoio**",
      "ListaRisposte": [
        {
          "IDRisposta": "18168",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18167",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18166",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18165",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6208",
      "DescrDomanda": "13.2 Lo spostamento dei tacchini tra i diversi capannoni e limitato a situazioni eccezionali, che esulano dalla routinaria prassi di allevamento**",
      "ListaRisposte": [
        {
          "IDRisposta": "18169",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18170",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18171",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18172",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6449",
      "DescrDomanda": "13.3 Linvio dei tacchini al macello viene effettuato garantendo lo svuotamento dellallevamento nellarco di un tempo massimo di dieci giorni e di ciascun capannone nellarco di un tempo massimo di 36 ore**",
      "ListaRisposte": [
        {
          "IDRisposta": "19026",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "19024",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19027",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19025",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6450",
      "DescrDomanda": "13.4 La gestione della pulcinaia e adeguata",
      "ListaRisposte": [
        {
          "IDRisposta": "19029",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19031",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19028",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19030",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6451",
      "DescrDomanda": "13.5 Presenza di reti o altri sistemi di protezione nel caso di apertura portoni per circolazione aria in stagioni calde",
      "ListaRisposte": [
        {
          "IDRisposta": "19034",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "19035",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19032",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19033",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6452",
      "DescrDomanda": "13.6 Vengono effettuati carichi multipli**",
      "ListaRisposte": [
        {
          "IDRisposta": "19037",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19039",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19036",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19038",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6209",
      "DescrDomanda": "14.1 Presenza di idonea cella di congelamento allesterno dellallevamento** ",
      "ListaRisposte": [
        {
          "IDRisposta": "18175",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18174",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18176",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18173",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6210",
      "DescrDomanda": "14.2 Larea antistante e sottostante le celle e in materiale facilmente lavabile e disinfettabile*",
      "ListaRisposte": [
        {
          "IDRisposta": "18177",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18180",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18178",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18179",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6211",
      "DescrDomanda": "14.3 La gestione dei sottoprodotti di origine animale (carcasse pollame) e conforme*",
      "ListaRisposte": [
        {
          "IDRisposta": "18183",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18182",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18184",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18181",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6212",
      "DescrDomanda": "14.4 Sono presenti le bolle di ritiro presso lallevamento",
      "ListaRisposte": [
        {
          "IDRisposta": "18185",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18188",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18186",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18187",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6213",
      "DescrDomanda": "15.1 La lettiera vergine viene stoccata in un luogo coperto e chiuso e ad uso esclusivo",
      "ListaRisposte": [
        {
          "IDRisposta": "18190",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18192",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18189",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18191",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6214",
      "DescrDomanda": "15.2 Viene effettuata fresatura durante il ciclo",
      "ListaRisposte": [
        {
          "IDRisposta": "18194",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18196",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18193",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18195",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6215",
      "DescrDomanda": "15.3 Viene aggiunta lettiera durante il ciclo ",
      "ListaRisposte": [
        {
          "IDRisposta": "18199",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18197",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18200",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18198",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6216",
      "DescrDomanda": "16.1 La lettiera a fine ciclo viene stoccata ",
      "ListaRisposte": [
        {
          "IDRisposta": "18202",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18204",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18201",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18203",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6217",
      "DescrDomanda": "16.2 La gestione della lettiera a fine ciclo e corretta*",
      "ListaRisposte": [
        {
          "IDRisposta": "18207",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18206",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18208",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18205",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6218",
      "DescrDomanda": "16.3 A fine ciclo la lettiera e smaltita tramite ditta autorizzata",
      "ListaRisposte": [
        {
          "IDRisposta": "18210",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18212",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18209",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18211",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6219",
      "DescrDomanda": "16.4 A fine ciclo la lettiera e smaltita tramite smaltimento agronomico autorizzato in campi di proprieta",
      "ListaRisposte": [
        {
          "IDRisposta": "18215",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18213",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18216",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18214",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6221",
      "DescrDomanda": "17.1 E presente un registro compilato e aggiornato (preferibilmente informatizzato), di tutti i movimenti in ingresso e in uscita del personale autorizzato, automezzi, animali e attrezzature*",
      "ListaRisposte": [
        {
          "IDRisposta": "18221",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18224",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18222",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18223",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6222",
      "DescrDomanda": "17.2 E presente un registro mortalita degli animali correttamente compilato e aggiornato*",
      "ListaRisposte": [
        {
          "IDRisposta": "18227",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18226",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18228",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18225",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6453",
      "DescrDomanda": "17.3 Presenza di una procedura redatta che preveda la gestione dei flussi comunicati e operativi in caso di emergenza epidemica o insorgenza di sospetti di malattie infettive (IA, etc)*",
      "ListaRisposte": [
        {
          "IDRisposta": "19040",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19043",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19041",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19042",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6454",
      "DescrDomanda": "17.4 Loperatore conserva le prove di acquisto di materiali (tute, calzari, ecc.) e dei disinfettanti*",
      "ListaRisposte": [
        {
          "IDRisposta": "19046",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "19045",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19047",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19044",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6223",
      "DescrDomanda": "18.1 E presente e attuato un piano aziendale di derattizzazione e lotta agli insetti nocivi*",
      "ListaRisposte": [
        {
          "IDRisposta": "18229",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18231",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18230",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18232",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6224",
      "DescrDomanda": "18.2 Lattivita di disinfestazione/derattizzazione e gestita da una ditta esterna",
      "ListaRisposte": [
        {
          "IDRisposta": "18236",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "18234",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18235",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18233",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6225",
      "DescrDomanda": "18.3 Esiste una procedura scritta datata e firmata, che prevede una verifica delle operazioni di derattizzazione e disinfestazione",
      "ListaRisposte": [
        {
          "IDRisposta": "18238",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18239",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18237",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18240",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6455",
      "DescrDomanda": "18.4 Evidenza diretta/indiretta (es: feci) di ratti/topi o altri animali nocivi",
      "ListaRisposte": [
        {
          "IDRisposta": "19050",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "19049",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19048",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19051",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        }
      ]
    },
    {
      "IDDomanda": "6226",
      "DescrDomanda": "20.1\tLallevamento presenta un problema di recidive per Salmonella spp.",
      "ListaRisposte": [
        {
          "IDRisposta": "18242",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "18241",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "18243",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "18244",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "6227",
      "DescrDomanda": "21.1 Prescrizioni",
      "ListaRisposte": [
        {
          "IDRisposta": "18245",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "18246",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "6228",
      "DescrDomanda": "21.2 Eventuali prescrizioni",
      "ListaRisposte": [
        {
          "IDRisposta": "18247",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "18248",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "6229",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "18250",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "18249",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        }
      ]
    },
    {
      "IDDomanda": "6457",
      "DescrDomanda": "21.1 Il pollame viene allevato in un luogo delimitato da unadeguata recinzione con aree di alimentazione e abbeverata protette da idonea copertura*",
      "ListaRisposte": [
        {
          "IDRisposta": "19058",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "19059",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19056",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19057",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "6458",
      "DescrDomanda": "21.2 Lacqua di abbeverata proviene da serbatoi di superficie e sono presenti corsi e/o ristagni stabili dacqua*",
      "ListaRisposte": [
        {
          "IDRisposta": "19060",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19061",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "19063",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19062",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "6459",
      "DescrDomanda": "21.3 I volatili, se richiesto dallautorita competente in relazione a particolari situazioni epidemiologiche, vengono tenuti in strutture e superfici in grado di ospitare gli animali al coperto, dove la rete puo essere utilizzata solo per la delimitazione laterale*",
      "ListaRisposte": [
        {
          "IDRisposta": "19066",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "19067",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA"
        },
        {
          "IDRisposta": "19064",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "19065",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    }
  ],
  "message": null,
  "esito": 0
}

-- creo sezioni
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('1. INDIVIDUAZIONE DELLE RESPONSABILITA', 1, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('2. CARATTERISTICHE DELL''ALLEVAMENTO', 2, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('3. PERSONALE ADDETTO (OLTRE AL TITOLARE)', 3, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('4. SILOS', 4, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('5. PARCHEGGIO', 5, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('6. BARRIERE ALL''INGRESSO E DELIMITAZIONE DELL''AREA DI ALLEVAMENTO', 6, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('7. ATTREZZATURE DI PULIZIA E DISINFEZIONE DEGLI AUTOMEZZI', 7, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('8. ZONA FILTRO', 8, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('9. PIAZZOLE DI CARICO E SCARICO DEI MATERIALI D''USO E DEGLI ANIMALI', 9, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('10. CARATTERISTICHE STRUTTURALI DELL''ALLEVAMENTO', 10, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('11. DEPOSITO RIFIUTI E ALTRI MATERIALI', 11, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('12. PULIZIA E DISINFEZIONE', 12, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('13. GESTIONE ANIMALI', 13, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('14. GESTIONE ANIMALI MORTI', 14, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('15. GESTIONE LETTIERA VERGINE', 15, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('16. GESTIONE DELLA LETTIERA A FINE CICLO', 16, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('17. REGISTRI', 17, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('18. PROCEDURA DI DERATTIZZAZIONE E DISINFESTAZIONE', 18, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('19. ALTRE ATTIVITA', 19, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('20. STATO SANITARIO', 20, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('21. AREE ALL''APERTO', 21, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('PRESCRIZIONI', 22, 
(select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01'));

-- creo domande

insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 0),1,6183, '1.1 Detentore degli animali');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 0),2,6184, '1.2 Eta');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 0),3,6185, '1.3 Ditta soccidante');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 1),4,6186, '1.4 Veterinario aziendale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 1),5,6187, '1.5 Tecnico');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 2),6,6135, '2.1 Anno costruzione');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 2),7,6136, '2.2 Superficie utile di allevamento (m2):');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 2),8,6137, '2.3 Numero capannoni in muratura');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 2),9,6138, '2.4 Numero tunnel');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 2),10,6139, '2.5 N. totale silos');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 2),11,6140, '2.6 Allevamento a sessi misti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 2),12,6141, '2.7 Nellallevamento e presente un impianto di biogas');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 2),13,6142, '2.8 E presente un impianto di biogas a meno di 500 metri');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 3),14,6143, '3.1 Personale familiare ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 3),15,6144, '3.2 Personale esterno (non familiare) dipendente ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 3),16,6145, '3.3 Personale esterno qualificato non dipendente ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 3),17,6146, '3.3bis Personale esterno (non familiare e non dipendente) con accesso occasionale per operazioni routinarie (amici, vicini, ecc...)');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 3),18,6147, '3.4 Il personale certifica di rispettare i requisiti in materia di biosicurezza previsti dal Decreto Ministeriale per poter accedere allarea di allevamento*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 3),19,6148, '3.5 Il personale che opera in allevamento e dedito ad un solo stabilimento**');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 4),20,6190, '4.1 Il carico dei silos avviene esclusivamente dallesterno dellarea di allevamento**');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 4),21,6191, '4.2 I silos vengono puliti e disinfettati ad ogni nuovo ingresso di animali* ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 5),22,6192, '5.1 Larea di parcheggio e separata dallarea di allevamento e chiaramente identificata*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 5),23,6193, '6.1 Sono presenti idonee barriere allingresso (Cancelli, Sbarre mobili) *');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 6),24,6194, '6.2 Esiste la possibilita che le persone e gli automezzi accedano allallevamento in modo non controllato* ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 6),25,6195, '6.3 E presente idonea cartellonistica per la segnalazione di divieto di accesso e di procedure da adottare dopo laccesso alle aree di allevamento *');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 6),26,6196, '6.4 Sono presenti edifici non pertinenti e automezzi non dedicati allattivita allinterno dellarea di allevamento');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 6),27,6166, '7.1 Presenza di unarea di disinfezione dei mezzi in ingresso con fondo impermeabile dotata di impianto fisso, antistante larea di allevamento e separata dalla zona pulita*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 7),28,6167, '7.2 Per gli automezzi che accedono allarea di allevamento, laccesso avviene esclusivamente attraverso la piazzola di disinfezione*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 7),29,6168, '7.3 Il sistema di disinfezione e funzionante e automatizzato**');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 7),30,6169, '7.4 Presenza di pozzetto raccolta acque di scarico per allevamenti nuovi ed in quelli oggetto di ristrutturazione*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 7),31,6149, '8.1 Laccesso di qualsiasi persona (allevatore, dipendenti, visitatori di qualsiasi tipo) allarea di allevamento e vincolato esclusivamente al passaggio obbligatorio (ovvero anche tramite percorsi dedicati) attraverso una zona filtro posizionata allingress');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 8),32,6150, '8.1bis E presente una divisione funzionale della zona filtro in una zona "sporca" e "pulita"*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 8),33,6151, '8.2 Il locale e pulito, lavabile e disinfettabile');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 8),34,6152, '8.3 E presente almeno un punto disinfezione (lavandino funzionante attrezzato con acqua corrente, detergente e disinfettante per le mani)*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 8),35,6153, '8.4 Sono presenti asciugamani monouso/erogatori ad aria e un armadietto pulito in materiale lavabile e disinfettabile per gli indumenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 8),36,6154, '8.5 Presenza di indumenti puliti o monouso per il personale dipendente e il personale esterno e relativi contenitori per il deposito degli indumenti e dei materiali utilizzati*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 9),37,6202, '9.1 Presenza di piazzole di carico/scarico dei materiali duso e degli animali costituite da una superficie lavabile e disinfettabile, e in stato di manutenzione adeguato*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 9),38,6203, '9.2 Le piazzole sono posizionate agli ingressi dei capannoni, hanno dimensioni minime pari allapertura del capannone e consentono che tutte le fasi di carico/scarico avvengano su tale area *');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),39,6157, '10.1 ANTICAMERA CAPANNONI - La dogana danese e presente e correttamente utilizzata *');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),40,6158, '10.1bis ANTICAMERA CAPANNONI - Lanticamera dei capannoni si presenta sempre priva di macchinari/attrezzature/oggetti non funzionali allallevamento');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),41,6159, '10.2 ANTICAMERA CAPANNONI - Presenza di calzature dedicate per ogni singolo capannone *');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),42,6160, '10.3 STRUTTURE CAPANNONI - Presenza di adeguate chiusure dei capannoni (serrature, lucchetti, ecc.)');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),43,6161, '10.4 STRUTTURE CAPANNONI - Pavimento, pareti e soffitti sono lavabili, disinfettabili e mantenuti in buono stato di manutenzione* *');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),44,6162, '10.5 STRUTTURE CAPANNONI - Sono presenti adeguati sistemi volti ad impedire laccesso ai volatili (es. reti antipassero, cupolino protetto) su tutte le aperture del capannone*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),45,6163, '10.6 STRUTTURE CAPANNONI - La ventilazione e esclusivamente forzata (estrattiva)');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),46,6164, '10.6bis STRUTTURE CAPANNONI - Le prese daria sono in uno stato di pulizia soddisfacente');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 10),47,6165, '10.8 AREE DI STOCCAGGIO DEI MATERIALI DUSO - Presenza di una o piu locali/aree di stoccaggio dei materiali duso (attrezzature di allevamento, materiali, lettiere vergini ecc.), adeguatamente protette in modo da evitare contatti con lavifauna selvatica (es');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 11),48,6204, '11.1 Presenza di idonei contenitori protetti per il deposito dei rifiuti in prossimita della barriera*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 11),49,6205, '11.2 Larea circostante i capannoni e mantenuta in condizioni idonee con erba tagliata e priva di oggetti e materiali non pertinenti*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 12),50,6197, '12.1 Il sistema di lavaggio, pulizia e disinfezione dei locali di allevamento e delle attrezzature e adeguato e prevede lutilizzo di disinfettanti di provata efficacia*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 12),51,6198, '12.2 Lallevamento rispetta lobbligo di presenza di pozzetti per la raccolta dellacqua di scolo dei capannoni*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 12),52,6199, '12.3 Le attrezzature, una volta pulite e disinfettate, vengono correttamente gestite e stoccate in un luogo protetto (tettoia o magazzino) in modo da evitare la successiva contaminazione*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 12),53,6200, '12.4 Presenza di protocollo completo (procedura scritta) che certifichi lavvenuta pulizia e disinfezione di automezzi, materiale, attrezzature, locali e strutture di allevamento*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 12),54,6201, '12.5 Loperatore conserva per almeno 12 mesi la documentazione di avvenuta pulizia e disinfezione degli automezzi provenienti da altri stabilimenti e la rende disponibile per le eventuali verifiche da parte dellautorita competente*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 12),55,6446, '12.6 E rispettato periodo di vuoto biologico*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 12),56,6447, '12.7 E rispettato periodo di vuoto sanitario*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 12),57,6448, '12.8 Le operazione di pulizia/disinfezione sono a carico di una ditta esterna specializzata');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 13),58,6207, '13.1 Viene effettuato laccasamento esclusivamente di tacchinotti di un giorno provenienti direttamente da un incubatoio**');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 13),59,6208, '13.2 Lo spostamento dei tacchini tra i diversi capannoni e limitato a situazioni eccezionali, che esulano dalla routinaria prassi di allevamento**');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 13),60,6449, '13.3 Linvio dei tacchini al macello viene effettuato garantendo lo svuotamento dellallevamento nellarco di un tempo massimo di dieci giorni e di ciascun capannone nellarco di un tempo massimo di 36 ore**');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 13),61,6450, '13.4 La gestione della pulcinaia e adeguata');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 13),62,6451, '13.5 Presenza di reti o altri sistemi di protezione nel caso di apertura portoni per circolazione aria in stagioni calde');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 13),63,6452, '13.6 Vengono effettuati carichi multipli**');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 14),64,6209, '14.1 Presenza di idonea cella di congelamento allesterno dellallevamento** ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 14),65,6210, '14.2 Larea antistante e sottostante le celle e in materiale facilmente lavabile e disinfettabile*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 14),66,6211, '14.3 La gestione dei sottoprodotti di origine animale (carcasse pollame) e conforme*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 14),67,6212, '14.4 Sono presenti le bolle di ritiro presso lallevamento');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 15),68,6213, '15.1 La lettiera vergine viene stoccata in un luogo coperto e chiuso e ad uso esclusivo');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 15),69,6214, '15.2 Viene effettuata fresatura durante il ciclo');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 15),70,6215, '15.3 Viene aggiunta lettiera durante il ciclo ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 16),71,6216, '16.1 La lettiera a fine ciclo viene stoccata ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 16),72,6217, '16.2 La gestione della lettiera a fine ciclo e corretta*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 16),73,6218, '16.3 A fine ciclo la lettiera e smaltita tramite ditta autorizzata');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 16),74,6219, '16.4 A fine ciclo la lettiera e smaltita tramite smaltimento agronomico autorizzato in campi di proprieta');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 17),75,6221, '17.1 E presente un registro compilato e aggiornato (preferibilmente informatizzato), di tutti i movimenti in ingresso e in uscita del personale autorizzato, automezzi, animali e attrezzature*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 17),76,6222, '17.2 E presente un registro mortalita degli animali correttamente compilato e aggiornato*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 17),77,6453, '17.3 Presenza di una procedura redatta che preveda la gestione dei flussi comunicati e operativi in caso di emergenza epidemica o insorgenza di sospetti di malattie infettive (IA, etc)*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 17),78,6454, '17.4 Loperatore conserva le prove di acquisto di materiali (tute, calzari, ecc.) e dei disinfettanti*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 18),79,6223, '18.1 E presente e attuato un piano aziendale di derattizzazione e lotta agli insetti nocivi*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 18),80,6224, '18.2 Lattivita di disinfestazione/derattizzazione e gestita da una ditta esterna');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 18),81,6225, '18.3 Esiste una procedura scritta datata e firmata, che prevede una verifica delle operazioni di derattizzazione e disinfestazione');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 18),82,6455, '18.4 Evidenza diretta/indiretta (es: feci) di ratti/topi o altri animali nocivi');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),83,6174, '19.1 Attivita agricola del conduttore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),84,6175, '19.2 Esiste una netta separazione tra le due diverse attivita');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),85,6176, '19.3 Lallevatore o i dipendenti si dedicano allattivita venatoria o di pesca');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),86,6456, '19.4 Nellallevamento sono presenti tacchini e/o selvaggina da penna e/o riproduttori*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),87,6177, '19.5 Altri allevamenti di proprieta dellallevatore o di familiari ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),88,6178, '19.6 Specificare la specie avicola');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),89,6179, '19.7 Altri allevamenti di suini di proprieta dellallevatore o di familiari');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),90,6180, '19.8 Altri allevamenti di altri mammiferi di proprieta dellallevatore o di familiari');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),91,6181, '19.9 Specificare la specie');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 19),92,6182, '19.10 Lallevatore possiede o gestisce impianti di biogas');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 20),93,6226, '20.1 Lallevamento presenta un problema di recidive per Salmonella spp.');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 21),94,6457, '21.1 Il pollame viene allevato in un luogo delimitato da unadeguata recinzione con aree di alimentazione e abbeverata protette da idonea copertura*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 21),95,6458, '21.2 Lacqua di abbeverata proviene da serbatoi di superficie e sono presenti corsi e/o ristagni stabili dacqua*');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 21),96,6459, '21.3 I volatili, se richiesto dallautorita competente in relazione a particolari situazioni epidemiologiche, vengono tenuti in strutture e superfici in grado di ospitare gli animali al coperto, dove la rete puo essere utilizzata solo per la delimitazione ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 21),97,6227, '21.1 Prescrizioni');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0132' and m.versione =2023 and s.ordine = 21),98,6228, '21.2 Eventuali prescrizioni');

-- bonifica ordine sezione 
update biosicurezza_domande set id_sezione=122  where id =963;
update biosicurezza_domande set id_sezione=123  where id in(967);
update biosicurezza_domande set id_sezione=124 where id in(971);
update biosicurezza_domande set id_sezione=138  where id_domanda in(1037,1038);

update biosicurezza_domande set domanda = replace(domanda, 'lallevamento', 'l''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'e dedito', 'e'' dedito') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e dedito%');
update biosicurezza_domande set domanda = replace(domanda, 'possibilita ', 'possibilita''') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%possibilita %');
update biosicurezza_domande set domanda = replace(domanda, 'larea', 'l''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%larea%');
update biosicurezza_domande set domanda = replace(domanda, 'laccesso', 'l''accesso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%laccesso%');
update biosicurezza_domande set domanda = replace(domanda, 'e funzionante', 'e'' funzionante') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e funzionante%');
update biosicurezza_domande set domanda = replace(domanda, 'Laccesso ', 'L''accesso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Laccesso %');
update biosicurezza_domande set domanda = replace(domanda, 'e vincolato', 'e'' vincolato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e vincolato%');
update biosicurezza_domande set domanda = replace(domanda, 'e pulito', 'e'' pulito') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e pulito%');
update biosicurezza_domande set domanda = replace(domanda, 'duso ', 'd''uso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%duso %');
update biosicurezza_domande set domanda = replace(domanda, 'e presente', 'e'' presente') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e presente%');
update biosicurezza_domande set domanda = replace(domanda, 'Lanticamera', 'L''anticamera') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lanticamera%');
update biosicurezza_domande set domanda = replace(domanda, ' e esclusivamente', ' e'' esclusivamente') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '% e esclusivamente%');
update biosicurezza_domande set domanda = replace(domanda, 'daria ', 'd''aria ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%daria %');
update biosicurezza_domande set domanda = replace(domanda, 'e adeguato', 'e'' adeguato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e adeguato%');
update biosicurezza_domande set domanda = replace(domanda, 'lutilizzo ', 'l''utilizzo ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lutilizzo %');
update biosicurezza_domande set domanda = replace(domanda, 'Loperatore ', 'L''operatore ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Loperatore %');
update biosicurezza_domande set domanda = replace(domanda, 'E rispettato', 'E'' rispettato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E rispettato%');
update biosicurezza_domande set domanda = replace(domanda, 'laccasamento ', 'l''accasamento ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%laccasamento %');
update biosicurezza_domande set domanda = replace(domanda, 'e limitato', 'e'' limitato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e limitato%');
update biosicurezza_domande set domanda = replace(domanda, 'Linvio ', 'L''invio ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Linvio %');
update biosicurezza_domande set domanda = replace(domanda, 'nellarco ', 'nell''arco ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%nellarco %');
update biosicurezza_domande set domanda = replace(domanda, 'e adeguata ', 'e'' adeguata ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e adeguata %');
update biosicurezza_domande set domanda = replace(domanda, 'e sottostante', 'e'' sottostante') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e sottostante%');
update biosicurezza_domande set domanda = replace(domanda, 'e conforme', 'e'' conforme') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e conforme%');
update biosicurezza_domande set domanda = replace(domanda, 'e corretta', 'e'' corretta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e corretta%');
update biosicurezza_domande set domanda = replace(domanda, 'Lattivita ', 'L''attivita ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lattivita %');
update biosicurezza_domande set domanda = replace(domanda, 'Lallevatore ', 'L''allevatore ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lallevatore %');
update biosicurezza_domande set domanda = replace(domanda, 'proprieta ', 'proprieta'' ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%proprieta %');
update biosicurezza_domande set domanda = replace(domanda, 'dellallevatore ', 'dell''allevatore ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellallevatore %');
update biosicurezza_domande set domanda = replace(domanda, 'Lacqua ', 'L''acqua ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lacqua %');
update biosicurezza_domande set domanda = replace(domanda, 'dacqua', 'd''acqua') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dacqua%');
update biosicurezza_domande set domanda = replace(domanda, 'dallautorita ', 'dall''autorita ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dallautorita %');
update biosicurezza_domande set domanda = replace(domanda, 'puo ', 'puo'' ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%puo %');
-- creo risposte

insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6183 and c.cod_specie = '0132'),18087, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6183 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6183 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6183 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6183 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6184 and c.cod_specie = '0132'),18088, 'TextBox', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6184 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6184 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6184 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6184 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6185 and c.cod_specie = '0132'),18090, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6185 and c.cod_specie = '0132'),18089, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6185 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6185 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6185 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6186 and c.cod_specie = '0132'),18092, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6186 and c.cod_specie = '0132'),18091, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6186 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6186 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6186 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6187 and c.cod_specie = '0132'),18093, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6187 and c.cod_specie = '0132'),18094, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6187 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6187 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6187 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6135 and c.cod_specie = '0132'),17918, 'TextBox', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6135 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6135 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6135 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6135 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6136 and c.cod_specie = '0132'),17919, 'TextBox', '0', 'm2:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6136 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6136 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6136 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6136 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6137 and c.cod_specie = '0132'),17920, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6137 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6137 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6137 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6137 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6138 and c.cod_specie = '0132'),17921, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6138 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6138 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6138 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6138 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6139 and c.cod_specie = '0132'),17922, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6139 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6139 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6139 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6139 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6140 and c.cod_specie = '0132'),17923, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6140 and c.cod_specie = '0132'),17924, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6140 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6140 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6140 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6141 and c.cod_specie = '0132'),17925, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6141 and c.cod_specie = '0132'),17926, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6141 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6141 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6141 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6142 and c.cod_specie = '0132'),17928, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6142 and c.cod_specie = '0132'),17927, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6142 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6142 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6142 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6143 and c.cod_specie = '0132'),17930, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6143 and c.cod_specie = '0132'),17931, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6143 and c.cod_specie = '0132'),17932, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6143 and c.cod_specie = '0132'),17929, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6143 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6144 and c.cod_specie = '0132'),17934, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6144 and c.cod_specie = '0132'),17933, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6144 and c.cod_specie = '0132'),17935, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6144 and c.cod_specie = '0132'),17936, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6144 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6145 and c.cod_specie = '0132'),17940, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6145 and c.cod_specie = '0132'),17939, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6145 and c.cod_specie = '0132'),17937, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6145 and c.cod_specie = '0132'),17938, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6145 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6146 and c.cod_specie = '0132'),17942, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6146 and c.cod_specie = '0132'),17943, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6146 and c.cod_specie = '0132'),17941, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6146 and c.cod_specie = '0132'),17944, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6146 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6147 and c.cod_specie = '0132'),17948, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6147 and c.cod_specie = '0132'),17947, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6147 and c.cod_specie = '0132'),17946, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6147 and c.cod_specie = '0132'),17945, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6147 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6148 and c.cod_specie = '0132'),17951, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6148 and c.cod_specie = '0132'),17950, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6148 and c.cod_specie = '0132'),17952, 'TextArea', '0', 'Note - Motivo N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6148 and c.cod_specie = '0132'),17949, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6148 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6190 and c.cod_specie = '0132'),18097, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6190 and c.cod_specie = '0132'),18100, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6190 and c.cod_specie = '0132'),18099, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6190 and c.cod_specie = '0132'),18098, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6190 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6191 and c.cod_specie = '0132'),18102, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6191 and c.cod_specie = '0132'),18103, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6191 and c.cod_specie = '0132'),18104, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6191 and c.cod_specie = '0132'),18101, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6191 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6192 and c.cod_specie = '0132'),18105, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6192 and c.cod_specie = '0132'),18108, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6192 and c.cod_specie = '0132'),18107, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6192 and c.cod_specie = '0132'),18106, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6192 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6193 and c.cod_specie = '0132'),18110, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6193 and c.cod_specie = '0132'),18111, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6193 and c.cod_specie = '0132'),18112, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6193 and c.cod_specie = '0132'),18109, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6193 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6194 and c.cod_specie = '0132'),18114, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6194 and c.cod_specie = '0132'),18116, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6194 and c.cod_specie = '0132'),18115, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6194 and c.cod_specie = '0132'),18113, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6194 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6195 and c.cod_specie = '0132'),18118, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6195 and c.cod_specie = '0132'),18119, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6195 and c.cod_specie = '0132'),18120, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6195 and c.cod_specie = '0132'),18117, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6195 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6196 and c.cod_specie = '0132'),18121, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6196 and c.cod_specie = '0132'),18124, 'TextArea', '0', 'Note - Motivo N/A:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6196 and c.cod_specie = '0132'),18123, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6196 and c.cod_specie = '0132'),18122, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6196 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6166 and c.cod_specie = '0132'),18023, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6166 and c.cod_specie = '0132'),18024, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6166 and c.cod_specie = '0132'),18022, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6166 and c.cod_specie = '0132'),18021, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6166 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6167 and c.cod_specie = '0132'),18028, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6167 and c.cod_specie = '0132'),18027, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6167 and c.cod_specie = '0132'),18026, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6167 and c.cod_specie = '0132'),18025, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6167 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6168 and c.cod_specie = '0132'),18029, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6168 and c.cod_specie = '0132'),18030, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6168 and c.cod_specie = '0132'),18031, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6168 and c.cod_specie = '0132'),18032, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6168 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6169 and c.cod_specie = '0132'),18036, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6169 and c.cod_specie = '0132'),18035, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6169 and c.cod_specie = '0132'),18034, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6169 and c.cod_specie = '0132'),18033, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6169 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6149 and c.cod_specie = '0132'),17954, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6149 and c.cod_specie = '0132'),17953, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6149 and c.cod_specie = '0132'),17955, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6149 and c.cod_specie = '0132'),17956, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6149 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6150 and c.cod_specie = '0132'),17960, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6150 and c.cod_specie = '0132'),17959, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6150 and c.cod_specie = '0132'),17957, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6150 and c.cod_specie = '0132'),17958, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6150 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6151 and c.cod_specie = '0132'),17962, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6151 and c.cod_specie = '0132'),17961, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6151 and c.cod_specie = '0132'),17963, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6151 and c.cod_specie = '0132'),17964, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6151 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6152 and c.cod_specie = '0132'),17968, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6152 and c.cod_specie = '0132'),17967, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6152 and c.cod_specie = '0132'),17965, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6152 and c.cod_specie = '0132'),17966, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6152 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6153 and c.cod_specie = '0132'),17970, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6153 and c.cod_specie = '0132'),17969, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6153 and c.cod_specie = '0132'),17971, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6153 and c.cod_specie = '0132'),17972, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6153 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6154 and c.cod_specie = '0132'),17976, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6154 and c.cod_specie = '0132'),17975, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6154 and c.cod_specie = '0132'),17973, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6154 and c.cod_specie = '0132'),17974, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6154 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6202 and c.cod_specie = '0132'),18147, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6202 and c.cod_specie = '0132'),18146, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6202 and c.cod_specie = '0132'),18148, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6202 and c.cod_specie = '0132'),18145, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6202 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6203 and c.cod_specie = '0132'),18149, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6203 and c.cod_specie = '0132'),18152, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6203 and c.cod_specie = '0132'),18150, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6203 and c.cod_specie = '0132'),18151, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6203 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6157 and c.cod_specie = '0132'),17987, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6157 and c.cod_specie = '0132'),17988, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6157 and c.cod_specie = '0132'),17986, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6157 and c.cod_specie = '0132'),17985, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6157 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6158 and c.cod_specie = '0132'),17992, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6158 and c.cod_specie = '0132'),17991, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6158 and c.cod_specie = '0132'),17990, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6158 and c.cod_specie = '0132'),17989, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6158 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6159 and c.cod_specie = '0132'),17993, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6159 and c.cod_specie = '0132'),17994, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6159 and c.cod_specie = '0132'),17995, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6159 and c.cod_specie = '0132'),17996, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6159 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6160 and c.cod_specie = '0132'),18000, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6160 and c.cod_specie = '0132'),17999, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6160 and c.cod_specie = '0132'),17998, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6160 and c.cod_specie = '0132'),17997, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6160 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6161 and c.cod_specie = '0132'),18001, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6161 and c.cod_specie = '0132'),18002, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6161 and c.cod_specie = '0132'),18003, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6161 and c.cod_specie = '0132'),18004, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6161 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6162 and c.cod_specie = '0132'),18008, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6162 and c.cod_specie = '0132'),18007, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6162 and c.cod_specie = '0132'),18006, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6162 and c.cod_specie = '0132'),18005, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6162 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6163 and c.cod_specie = '0132'),18009, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6163 and c.cod_specie = '0132'),18010, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6163 and c.cod_specie = '0132'),18011, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6163 and c.cod_specie = '0132'),18012, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6163 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6164 and c.cod_specie = '0132'),18016, 'TextArea', '0', 'Note: Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6164 and c.cod_specie = '0132'),18015, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6164 and c.cod_specie = '0132'),18014, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6164 and c.cod_specie = '0132'),18013, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6164 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6165 and c.cod_specie = '0132'),18017, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6165 and c.cod_specie = '0132'),18020, 'TextArea', '0', 'Note: Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6165 and c.cod_specie = '0132'),18018, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6165 and c.cod_specie = '0132'),18019, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6165 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6204 and c.cod_specie = '0132'),18155, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6204 and c.cod_specie = '0132'),18156, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6204 and c.cod_specie = '0132'),18153, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6204 and c.cod_specie = '0132'),18154, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6204 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6205 and c.cod_specie = '0132'),18157, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6205 and c.cod_specie = '0132'),18158, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6205 and c.cod_specie = '0132'),18159, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6205 and c.cod_specie = '0132'),18160, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6205 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6197 and c.cod_specie = '0132'),18126, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6197 and c.cod_specie = '0132'),18127, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6197 and c.cod_specie = '0132'),18128, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6197 and c.cod_specie = '0132'),18125, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6197 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6198 and c.cod_specie = '0132'),18129, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6198 and c.cod_specie = '0132'),18132, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6198 and c.cod_specie = '0132'),18131, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6198 and c.cod_specie = '0132'),18130, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6198 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6199 and c.cod_specie = '0132'),18134, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6199 and c.cod_specie = '0132'),18135, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6199 and c.cod_specie = '0132'),18133, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6199 and c.cod_specie = '0132'),18136, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6199 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6200 and c.cod_specie = '0132'),18138, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6200 and c.cod_specie = '0132'),18137, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6200 and c.cod_specie = '0132'),18139, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6200 and c.cod_specie = '0132'),18140, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6200 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6201 and c.cod_specie = '0132'),18144, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6201 and c.cod_specie = '0132'),18143, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6201 and c.cod_specie = '0132'),18142, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6201 and c.cod_specie = '0132'),18141, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6201 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6446 and c.cod_specie = '0132'),19012, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6446 and c.cod_specie = '0132'),19015, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6446 and c.cod_specie = '0132'),19013, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6446 and c.cod_specie = '0132'),19014, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6446 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6447 and c.cod_specie = '0132'),19018, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6447 and c.cod_specie = '0132'),19017, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6447 and c.cod_specie = '0132'),19019, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6447 and c.cod_specie = '0132'),19016, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6447 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6448 and c.cod_specie = '0132'),19020, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6448 and c.cod_specie = '0132'),19023, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6448 and c.cod_specie = '0132'),19021, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6448 and c.cod_specie = '0132'),19022, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6448 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6207 and c.cod_specie = '0132'),18168, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6207 and c.cod_specie = '0132'),18167, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6207 and c.cod_specie = '0132'),18166, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6207 and c.cod_specie = '0132'),18165, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6207 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6208 and c.cod_specie = '0132'),18169, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6208 and c.cod_specie = '0132'),18170, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6208 and c.cod_specie = '0132'),18171, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6208 and c.cod_specie = '0132'),18172, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6208 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6449 and c.cod_specie = '0132'),19026, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6449 and c.cod_specie = '0132'),19024, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6449 and c.cod_specie = '0132'),19027, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6449 and c.cod_specie = '0132'),19025, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6449 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6450 and c.cod_specie = '0132'),19029, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6450 and c.cod_specie = '0132'),19031, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6450 and c.cod_specie = '0132'),19028, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6450 and c.cod_specie = '0132'),19030, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6450 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6451 and c.cod_specie = '0132'),19034, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6451 and c.cod_specie = '0132'),19035, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6451 and c.cod_specie = '0132'),19032, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6451 and c.cod_specie = '0132'),19033, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6451 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6452 and c.cod_specie = '0132'),19037, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6452 and c.cod_specie = '0132'),19039, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6452 and c.cod_specie = '0132'),19036, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6452 and c.cod_specie = '0132'),19038, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6452 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6209 and c.cod_specie = '0132'),18175, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6209 and c.cod_specie = '0132'),18174, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6209 and c.cod_specie = '0132'),18176, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6209 and c.cod_specie = '0132'),18173, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6209 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6210 and c.cod_specie = '0132'),18177, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6210 and c.cod_specie = '0132'),18180, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6210 and c.cod_specie = '0132'),18178, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6210 and c.cod_specie = '0132'),18179, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6210 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6211 and c.cod_specie = '0132'),18183, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6211 and c.cod_specie = '0132'),18182, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6211 and c.cod_specie = '0132'),18184, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6211 and c.cod_specie = '0132'),18181, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6211 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6212 and c.cod_specie = '0132'),18185, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6212 and c.cod_specie = '0132'),18188, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6212 and c.cod_specie = '0132'),18186, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6212 and c.cod_specie = '0132'),18187, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6212 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6213 and c.cod_specie = '0132'),18190, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6213 and c.cod_specie = '0132'),18192, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6213 and c.cod_specie = '0132'),18189, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6213 and c.cod_specie = '0132'),18191, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6213 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6214 and c.cod_specie = '0132'),18194, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6214 and c.cod_specie = '0132'),18196, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6214 and c.cod_specie = '0132'),18193, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6214 and c.cod_specie = '0132'),18195, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6214 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6215 and c.cod_specie = '0132'),18199, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6215 and c.cod_specie = '0132'),18197, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6215 and c.cod_specie = '0132'),18200, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6215 and c.cod_specie = '0132'),18198, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6215 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6216 and c.cod_specie = '0132'),18202, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6216 and c.cod_specie = '0132'),18204, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6216 and c.cod_specie = '0132'),18201, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6216 and c.cod_specie = '0132'),18203, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6216 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6217 and c.cod_specie = '0132'),18207, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6217 and c.cod_specie = '0132'),18206, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6217 and c.cod_specie = '0132'),18208, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6217 and c.cod_specie = '0132'),18205, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6217 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6218 and c.cod_specie = '0132'),18210, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6218 and c.cod_specie = '0132'),18212, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6218 and c.cod_specie = '0132'),18209, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6218 and c.cod_specie = '0132'),18211, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6218 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6219 and c.cod_specie = '0132'),18215, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6219 and c.cod_specie = '0132'),18213, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6219 and c.cod_specie = '0132'),18216, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6219 and c.cod_specie = '0132'),18214, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6219 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6221 and c.cod_specie = '0132'),18221, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6221 and c.cod_specie = '0132'),18224, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6221 and c.cod_specie = '0132'),18222, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6221 and c.cod_specie = '0132'),18223, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6221 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6222 and c.cod_specie = '0132'),18227, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6222 and c.cod_specie = '0132'),18226, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6222 and c.cod_specie = '0132'),18228, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6222 and c.cod_specie = '0132'),18225, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6222 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6453 and c.cod_specie = '0132'),19040, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6453 and c.cod_specie = '0132'),19043, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6453 and c.cod_specie = '0132'),19041, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6453 and c.cod_specie = '0132'),19042, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6453 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6454 and c.cod_specie = '0132'),19046, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6454 and c.cod_specie = '0132'),19045, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6454 and c.cod_specie = '0132'),19047, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6454 and c.cod_specie = '0132'),19044, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6454 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6223 and c.cod_specie = '0132'),18229, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6223 and c.cod_specie = '0132'),18231, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6223 and c.cod_specie = '0132'),18230, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6223 and c.cod_specie = '0132'),18232, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6223 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6224 and c.cod_specie = '0132'),18236, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6224 and c.cod_specie = '0132'),18234, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6224 and c.cod_specie = '0132'),18235, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6224 and c.cod_specie = '0132'),18233, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6224 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6225 and c.cod_specie = '0132'),18238, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6225 and c.cod_specie = '0132'),18239, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6225 and c.cod_specie = '0132'),18237, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6225 and c.cod_specie = '0132'),18240, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6225 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6455 and c.cod_specie = '0132'),19050, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6455 and c.cod_specie = '0132'),19049, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6455 and c.cod_specie = '0132'),19048, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6455 and c.cod_specie = '0132'),19051, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6455 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6174 and c.cod_specie = '0132'),18055, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6174 and c.cod_specie = '0132'),18053, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6174 and c.cod_specie = '0132'),18056, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6174 and c.cod_specie = '0132'),18054, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6174 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6175 and c.cod_specie = '0132'),18058, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6175 and c.cod_specie = '0132'),18057, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6175 and c.cod_specie = '0132'),18060, 'TextArea', '0', 'Note -Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6175 and c.cod_specie = '0132'),18059, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6175 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6176 and c.cod_specie = '0132'),18063, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6176 and c.cod_specie = '0132'),18061, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6176 and c.cod_specie = '0132'),18064, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6176 and c.cod_specie = '0132'),18062, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6176 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6456 and c.cod_specie = '0132'),19052, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6456 and c.cod_specie = '0132'),19055, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6456 and c.cod_specie = '0132'),19053, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6456 and c.cod_specie = '0132'),19054, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6456 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6177 and c.cod_specie = '0132'),18066, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6177 and c.cod_specie = '0132'),18068, 'TextArea', '0', 'Note- Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6177 and c.cod_specie = '0132'),18065, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6177 and c.cod_specie = '0132'),18067, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6177 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6178 and c.cod_specie = '0132'),18070, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6178 and c.cod_specie = '0132'),18071, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6178 and c.cod_specie = '0132'),18069, 'CheckBoxList', ' GALLUS GALLUS - 1; PERNICI - 2; QUAGLIE - 3; STARNE - 4; PICCIONI - 5; OCHE - 6; FARAONE - 7; FAGIANI - 8; STRUZZI - 9;  ANATRE - 10; COLOMBE - 11; EMU - 12; VOLATILI PER RICHIAMI VIVI - 13;  AVICOLI MISTI - 14;  ALTRE SPECIE DI VOLATILI - 15; TACCHINI -', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6178 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6178 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6179 and c.cod_specie = '0132'),18073, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6179 and c.cod_specie = '0132'),18072, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6179 and c.cod_specie = '0132'),18074, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6179 and c.cod_specie = '0132'),18075, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6179 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6180 and c.cod_specie = '0132'),18079, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6180 and c.cod_specie = '0132'),18078, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6180 and c.cod_specie = '0132'),18076, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6180 and c.cod_specie = '0132'),18077, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6180 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6181 and c.cod_specie = '0132'),18082, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6181 and c.cod_specie = '0132'),18080, 'CheckBoxList', ' BOVINI - 1; DROMEDARIO - 22; YAK - 23; GNU - 24; ZEBU - 25; CAPRIOLO - 26; CAMOSCIO - 27; DAINO - 28; MUFLONE - 29; STAMBECCO - 30; ANTILOPE - 31; GAZZELLA - 32; ALCE - 33; RENNA - 34; LAMA - 35; ALPACA - 36; CAMMELLO - 21; CERVIDI - 20; CROSTACEI - 19; ', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6181 and c.cod_specie = '0132'),18081, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6181 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6181 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6182 and c.cod_specie = '0132'),18085, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6182 and c.cod_specie = '0132'),18086, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6182 and c.cod_specie = '0132'),18083, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6182 and c.cod_specie = '0132'),18084, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6182 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6226 and c.cod_specie = '0132'),18242, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6226 and c.cod_specie = '0132'),18241, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6226 and c.cod_specie = '0132'),18243, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6226 and c.cod_specie = '0132'),18244, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6226 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6457 and c.cod_specie = '0132'),19058, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6457 and c.cod_specie = '0132'),19059, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6457 and c.cod_specie = '0132'),19056, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6457 and c.cod_specie = '0132'),19057, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6457 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6458 and c.cod_specie = '0132'),19060, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6458 and c.cod_specie = '0132'),19061, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6458 and c.cod_specie = '0132'),19063, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6458 and c.cod_specie = '0132'),19062, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6458 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6459 and c.cod_specie = '0132'),19066, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6459 and c.cod_specie = '0132'),19067, 'TextArea', '0', 'Note - Motivo NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6459 and c.cod_specie = '0132'),19064, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6459 and c.cod_specie = '0132'),19065, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6459 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6227 and c.cod_specie = '0132'),18245, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6227 and c.cod_specie = '0132'),18246, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6227 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6227 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6227 and c.cod_specie = '0132'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6228 and c.cod_specie = '0132'),18247, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6228 and c.cod_specie = '0132'),18248, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6228 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6228 and c.cod_specie = '0132'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6228 and c.cod_specie = '0132'),0, '0', '0', '0');

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
update biosicurezza_risposte set ordine = 5 where risposta ilike 'n/d' and ordine is null;
update biosicurezza_risposte set ordine = 1 where risposta ilike 'favorevole' and ordine is null;
update biosicurezza_risposte set ordine = 2 where risposta ilike 'sfavorevole' and ordine is null;
update biosicurezza_risposte set trashed_date = now() where risposta ilike 'n/d';

-- Bonifico risposte
delete from biosicurezza_risposte where id_domanda is null;
update biosicurezza_risposte set tipo = 'checkbox' where tipo = 'Button';
update biosicurezza_risposte set tipo = 'textarea' where tipo like '%Text%';
update biosicurezza_risposte set risposta = '' where risposta in ('ndeg:', 'm2:', ':', 'Generalita:');
update biosicurezza_risposte set tipo = 'checkboxList' where tipo = 'CheckBoxList';
update biosicurezza_risposte set tipo = 'date' where risposta in ('Entro quale data dovranno essere eseguite?') and tipo <> 'date';

update biosicurezza_risposte set risposta = '', tipo = 'number' where id_domanda in 
(select id from biosicurezza_domande where domanda ilike '%Numero%' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-tacchini-01')))

-- numero da 2.1 a 2.5
update biosicurezza_risposte set tipo = 'number' where id_domanda in (946,947,948,949,950);




























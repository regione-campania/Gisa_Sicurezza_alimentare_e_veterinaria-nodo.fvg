-----------------------------------------
-- OPERAZIONI PRELIMINARI
-----------------------------------------

-----------------------------------------
-- PRELIMINARE 1: Ottenere da classyfarm i codici delle checklist da sviluppare (da farsi mandare via mail)

106
VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI AD ALTA CAPACITA CONTROLLO UFFICIALE
107
VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI A BASSA CAPACITA CONTROLLO UFFICIALE
108
VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI AD ALTA CAPACITA CONTROLLO UFFICIALE
109
VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI A BASSA CAPACITA CONTROLLO UFFICIALE
-----------------------------------------
-- PRELIMINARE 2: Creare entry nella lookup delle checklist, associando il nome corretto, il codice specie, il codice classyfarm, il codice gisa e la versione

-- Il codice gisa è un nome univoco che diamo noi a ogni checklist 
-- La versione corrisponde all'anno della versione della checklist (es. 2023)
-- Il codice specie deve coincidere con la specie oggetto della checklist. Se è già utilizzato (es. perchè ci sono 2 checklist suini con versione 2023) bisogna usarne un altro aggiungendo ad esempio dei progressivi in coda (es 0122 -> 01221, 01222...) 

insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-suini-stab_alta-01', '106', '0122', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI AD ALTA CAPACITA CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-suini-semib_alta-01', '108', '01221', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI A BASSA CAPACITA CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-suini-stab_bassa-01', '107', '01222', 2023);
insert into lookup_chk_classyfarm_mod (description, codice_gisa, codice_classyfarm, cod_specie, versione) values ('VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI A BASSA CAPACITA CONTROLLO UFFICIALE REV.1_2023', 'biosicurezza-2023-suini-semib_bassa-01', '109', '01223', 2023);

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

eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoicmVnY2FtcGFuaWFfQ0YiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJyZWdjYW1wYW5pYV9DRkBpenNsZXIuaXQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2V4cGlyYXRpb24iOiI0LzQvMjAyNCA5OjE4OjAyIEFNIiwiZXhwIjoxNzEyMjIyMjgyLCJpc3MiOiJJemxzZXJBcGkiLCJhdWQiOiJNdWx0aVVzZXJzIn0.FEoiUjFuJ6blltXzdZBs_XP8DyQQXk1rAnHf4PlXbZo
-- Collegarsi a http://cf-function02-test.azurewebsites.net/api/swagger/ui e nella sezione /api/checklist/getTemplateCL fare "try it out" usando il codice classyfarm 106

{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "5700",
      "DescrDomanda": "Tipologia di suini presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "16403",
          "ControlType": "CheckBoxList",
          "ListItems": " Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1",
          "TemaplateName": "Categorie presenti"
        }
      ]
    },
    {
      "IDDomanda": "5701",
      "DescrDomanda": "Ndeg totale animali (capienza)",
      "ListaRisposte": [
        {
          "IDRisposta": "16404",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "5702",
      "DescrDomanda": "NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :",
      "ListaRisposte": [
        {
          "IDRisposta": "16405",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "16406",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "5703",
      "DescrDomanda": "Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2023/594?",
      "ListaRisposte": [
        {
          "IDRisposta": "16408",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "16407",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "5704",
      "DescrDomanda": "E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a IX dellallegato III Regolamento (UE) 2023/594?",
      "ListaRisposte": [
        {
          "IDRisposta": "16409",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "16410",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "5705",
      "DescrDomanda": "Veterinario Ufficiale ispettore",
      "ListaRisposte": [
        {
          "IDRisposta": "16411",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "5791",
      "DescrDomanda": "Ndeg animali presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "16713",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "5706",
      "DescrDomanda": "1. Lazienda e dotata di unarea apposita, posta prima della barriera di entrata per la sosta dei veicoli del personale dellallevamento e/o visitatori? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16415",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16414",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16413",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16412",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5707",
      "DescrDomanda": "2. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16416",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16417",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16418",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5708",
      "DescrDomanda": "3. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16421",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16420",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16419",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5710",
      "DescrDomanda": "4. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?",
      "ListaRisposte": [
        {
          "IDRisposta": "16426",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16427",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16428",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5711",
      "DescrDomanda": "5. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?",
      "ListaRisposte": [
        {
          "IDRisposta": "16431",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16430",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16429",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5712",
      "DescrDomanda": "6. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16432",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16433",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16434",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5713",
      "DescrDomanda": "7. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16437",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16436",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16435",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5714",
      "DescrDomanda": "8. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16438",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16439",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16440",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5715",
      "DescrDomanda": "9. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?",
      "ListaRisposte": [
        {
          "IDRisposta": "16442",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16443",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16441",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5716",
      "DescrDomanda": "10. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?",
      "ListaRisposte": [
        {
          "IDRisposta": "16446",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16445",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16444",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5717",
      "DescrDomanda": "11. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?",
      "ListaRisposte": [
        {
          "IDRisposta": "16447",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16448",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16449",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5718",
      "DescrDomanda": "12. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?",
      "ListaRisposte": [
        {
          "IDRisposta": "16452",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16451",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16450",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5719",
      "DescrDomanda": "13. Larea tutta intorno ai ricoveri degli animali e mantenuta pulita, coperta da ghiaia o con erba sfalciata, libera da ingombri, oggetti, attrezzature, macchinari, veicoli, ecc. estranei alla funzionalita e gestione dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16453",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16454",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16456",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16455",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5720",
      "DescrDomanda": "14. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16459",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16458",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16457",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5721",
      "DescrDomanda": "15. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16461",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16460",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16462",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5724",
      "DescrDomanda": "18. E previsto e documentato un piano di disinfestazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16474",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16471",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16472",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5725",
      "DescrDomanda": "19. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "16476",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16475",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16478",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16477",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5726",
      "DescrDomanda": "20. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?",
      "ListaRisposte": [
        {
          "IDRisposta": "16481",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16479",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16480",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5727",
      "DescrDomanda": "21. Esiste un piano di profilassi vaccinale documentato?",
      "ListaRisposte": [
        {
          "IDRisposta": "16483",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16482",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16485",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16484",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5728",
      "DescrDomanda": "22. Esiste una prassi igienica e sanitaria di gestione delle attrezzature utilizzate per la profilassi vaccinale e i trattamenti terapeutici individuali o di gruppo?",
      "ListaRisposte": [
        {
          "IDRisposta": "16488",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16489",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16486",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16487",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5729",
      "DescrDomanda": "23. Sono presenti eventuali risultati delle analisi, ufficiali o effettuate in autocontrollo, su campioni prelevati da animali o da altre matrici che abbiano rilevanza per la salute umana e animale?",
      "ListaRisposte": [
        {
          "IDRisposta": "16491",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16490",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16493",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16492",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5730",
      "DescrDomanda": "24. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16496",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16497",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16494",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16495",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5731",
      "DescrDomanda": "25. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?",
      "ListaRisposte": [
        {
          "IDRisposta": "16499",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16498",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16500",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5732",
      "DescrDomanda": "26. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?",
      "ListaRisposte": [
        {
          "IDRisposta": "16503",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16501",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16502",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5733",
      "DescrDomanda": "27. E presente una documentazione attestante lavvenuta disinfezione degli automezzi?",
      "ListaRisposte": [
        {
          "IDRisposta": "16505",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16504",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16507",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16506",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5734",
      "DescrDomanda": "28. Lallevamento dispone di una piazzola per la pulizia e la disinfezione degli automezzi localizzata in prossimita dellaccesso allallevamento o, in ogni caso, separata dallarea aziendale destinata alla stabulazione e al governo animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16510",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16511",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16508",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16509",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5735",
      "DescrDomanda": "29. Sono presenti apparecchiature fisse a pressione per la pulizia, il lavaggio e la disinfezione degli automezzi in entrata?",
      "ListaRisposte": [
        {
          "IDRisposta": "16513",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16512",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16515",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16514",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5736",
      "DescrDomanda": "30. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?",
      "ListaRisposte": [
        {
          "IDRisposta": "16518",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16516",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16517",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5737",
      "DescrDomanda": "31. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16520",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16519",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16521",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5738",
      "DescrDomanda": "32. Esiste una rampa/corridoio di carico/scarico degli animali vivi, fissa o mobile?",
      "ListaRisposte": [
        {
          "IDRisposta": "16525",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16524",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16522",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16523",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5739",
      "DescrDomanda": "33. Il carico/scarico dei suini vivi avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "16527",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16526",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16528",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5740",
      "DescrDomanda": "34. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16531",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16529",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16530",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5741",
      "DescrDomanda": "35. Il carico degli scarti avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "16533",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16532",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16535",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16534",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5742",
      "DescrDomanda": "36. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16538",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16539",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16536",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16537",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5743",
      "DescrDomanda": "37. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16541",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16540",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16542",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5744",
      "DescrDomanda": "38.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16545",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16543",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16544",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5745",
      "DescrDomanda": "39. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16547",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16546",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16548",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5746",
      "DescrDomanda": "40. Qualora le carcasse dei suinetti siano temporaneamente immagazzinate nei locali di allevamento, in attesa del loro allontanamento, i contenitori utilizzati sono adeguatamente sigillati ed idonei alla conservazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16552",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16551",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16549",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16550",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5747",
      "DescrDomanda": "41. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16554",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16553",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16555",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5748",
      "DescrDomanda": "42. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?",
      "ListaRisposte": [
        {
          "IDRisposta": "16558",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16556",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16557",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5749",
      "DescrDomanda": "43. Le aree sottostanti i silos dei mangimi consentono una efficace pulizia e il deflusso delle acque di lavaggio?",
      "ListaRisposte": [
        {
          "IDRisposta": "16560",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16559",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16562",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16561",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5750",
      "DescrDomanda": "44. Sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16565",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16566",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16563",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16564",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5751",
      "DescrDomanda": "45. Se sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte e presente il nulla-osta al loro utilizzo ed e garantita la loro tracciabilita?",
      "ListaRisposte": [
        {
          "IDRisposta": "16568",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16567",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16570",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16569",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5752",
      "DescrDomanda": "46. Il punto di pesa e di esclusivo utilizzo dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16573",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16571",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16572",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5753",
      "DescrDomanda": "47. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16574",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16576",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16575",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5754",
      "DescrDomanda": "48. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16579",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16578",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16577",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5755",
      "DescrDomanda": "49. I terreni attigui allazienda sono utilizzati per lo spandimento di liquami provenienti da altre aziende?",
      "ListaRisposte": [
        {
          "IDRisposta": "16580",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16581",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16583",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16582",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5756",
      "DescrDomanda": "50. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?",
      "ListaRisposte": [
        {
          "IDRisposta": "16586",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16584",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16585",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5757",
      "DescrDomanda": "51. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?",
      "ListaRisposte": [
        {
          "IDRisposta": "16589",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17191",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16588",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16587",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5758",
      "DescrDomanda": "52. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?",
      "ListaRisposte": [
        {
          "IDRisposta": "16591",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16590",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16592",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5759",
      "DescrDomanda": "53. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?",
      "ListaRisposte": [
        {
          "IDRisposta": "16595",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16593",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16594",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5760",
      "DescrDomanda": "54. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "16597",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16596",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16598",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5761",
      "DescrDomanda": "55. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "16601",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16599",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16600",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5998",
      "DescrDomanda": "16. E previsto e documentato un piano di derattizzazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "17460",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17461",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17459",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17458",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5999",
      "DescrDomanda": "17. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "17462",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17463",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17465",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17464",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5762",
      "DescrDomanda": "56. La rimonta viene effettuata ad opera di riproduttori esterni?",
      "ListaRisposte": [
        {
          "IDRisposta": "17406",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16604",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16605",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16602",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16603",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5763",
      "DescrDomanda": "57. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16607",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16606",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16609",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17407",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5766",
      "DescrDomanda": "60. I locali di quarantena dispongono di fossa/e separata/e?",
      "ListaRisposte": [
        {
          "IDRisposta": "17410",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16621",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16620",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16618",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16619",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5764",
      "DescrDomanda": "58. Viene praticato il tutto pieno/tutto vuoto e un idoneo periodo di vuoto sanitario?",
      "ListaRisposte": [
        {
          "IDRisposta": "16612",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17408",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16613",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16610",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16611",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5765",
      "DescrDomanda": "59. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "16615",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16614",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16617",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17409",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5767",
      "DescrDomanda": "61. I locali di quarantena dispongono di ingresso/i separato/i?",
      "ListaRisposte": [
        {
          "IDRisposta": "16623",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16622",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16625",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17411",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5771",
      "DescrDomanda": "65. E richiesta e disponibile alle aziende di provenienza una documentazione che attesti lo stato sanitario degli animali di nuova introduzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16638",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16641",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16639",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17415",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16640",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5768",
      "DescrDomanda": "62. Sono disponibili attrezzature destinate esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "17412",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16629",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16626",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16627",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5769",
      "DescrDomanda": "63. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "16631",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16630",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16633",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17413",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5770",
      "DescrDomanda": "64. E prevista lesecuzione pianificata di accertamenti diagnostici negli animali in quarantena? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17414",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16636",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16637",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16634",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16635",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5772",
      "DescrDomanda": "66. La rimonta dei riproduttori viene effettuata con cadenza superiore a 3 mesi?",
      "ListaRisposte": [
        {
          "IDRisposta": "16644",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17416",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16645",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16642",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16643",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5773",
      "DescrDomanda": "67.  Lesame ecografico viene effettuato da operatori esterni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16647",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16646",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16649",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17417",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16648",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5774",
      "DescrDomanda": "68. Nel caso in cui si pratichi la fecondazione artificiale il materiale seminale questo proviene da centri di raccolta seme autorizzati?",
      "ListaRisposte": [
        {
          "IDRisposta": "16652",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17418",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16653",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16650",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16651",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5775",
      "DescrDomanda": "69. Nel caso in cui si pratichi la monta naturale i verri sono stati sottoposti agli accertamenti diagnostici previsti per i riproduttori maschi della specie suina?",
      "ListaRisposte": [
        {
          "IDRisposta": "16655",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16654",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16657",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17419",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16656",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5776",
      "DescrDomanda": "70. I suinetti in sala parto sono destinati a piu di due allevamenti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17420",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16660",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16661",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16658",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16659",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5777",
      "DescrDomanda": "71. I suini provengono da piu di un allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16663",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16662",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16665",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17421",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16664",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5778",
      "DescrDomanda": "72. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16668",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17422",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16669",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16666",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16667",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5779",
      "DescrDomanda": "73. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16671",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16670",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16673",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17423",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16672",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5780",
      "DescrDomanda": "74. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17396",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16677",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16674",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16675",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5781",
      "DescrDomanda": "76. I suini a fine ciclo sono destinati a piu di 1  allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16679",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16678",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16681",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17425",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16680",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5940",
      "DescrDomanda": "75. I capannoni sono suddivisi in settori da pareti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17424",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17197",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17196",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17195",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17198",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5782",
      "DescrDomanda": "77. I suini provengono da piu di un allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17426",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16684",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16685",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16682",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16683",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5783",
      "DescrDomanda": "78. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16687",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16686",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16689",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17427",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16688",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5784",
      "DescrDomanda": "79. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16692",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17428",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16693",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16690",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16691",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5785",
      "DescrDomanda": "80. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16695",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16694",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16697",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17395",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5786",
      "DescrDomanda": "82. I suini a fine ciclo sono destinati a solo macelli industriali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16700",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17430",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16701",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16698",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16699",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5941",
      "DescrDomanda": "81. I capannoni sono suddivisi in settori da pareti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17429",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17201",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17200",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17202",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo: "
        },
        {
          "IDRisposta": "17199",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5787",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "16702",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        },
        {
          "IDRisposta": "16703",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "5788",
      "DescrDomanda": "ESITO DEL CONTROLLO",
      "ListaRisposte": [
        {
          "IDRisposta": "16705",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SFAVOREVOLE"
        },
        {
          "IDRisposta": "16704",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "FAVOREVOLE"
        }
      ]
    },
    {
      "IDDomanda": "5789",
      "DescrDomanda": "Sono state assegnate delle prescrizioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16707",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16709",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Entro quale data dovranno essere eseguite?"
        },
        {
          "IDRisposta": "16708",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se si quali:"
        },
        {
          "IDRisposta": "16706",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5790",
      "DescrDomanda": "Sono state applicate delle sanzioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16711",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "16710",
          "ControlType": "CheckBoxList",
          "ListItems": " Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6",
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "16712",
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

insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE', 1, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA', 2, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO', 3, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO',4 , (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_alta-01'));

-----------------------------------------
-- 3: Estrarre da JSON del template tutte le domande ed inserirle 

-- Usare un convertitore da JSON a CSV https://www.convertcsv.com/json-to-csv.htm (-> json to excel)
-- Compilare il foglio "ClassyFarmGeneratore.ods" incollando il contenuto della conversione nel tab "JSON". (LIBREOFFICE)
-- Nel tab "Domande" valorizzare correttamente COD SPECIE e VERSIONE e incollando le colonne da ID DOMANDA e DESCR DOMANDA

-- Verificare una ad una a quale sezione appartengono. Se si riesce a risalire, indicare ORDINE SEZIONE nella apposita colonna. Se non si riesce a risalire, inserire nuove sezioni e riportare il relativo ordine. Eventualmente eliminare le righe inutili tipo "Documento 1"
-- Ordinare per ORDINE SEZIONE, e quindi valorizzare ORDINE DOMANDA rispettando l'ordine nel PDF. Nota: ORDINE DOMANDA e' un progressivo generale, quindi non si azzera quando si cambia sezione
-- Lanciare le insert. Nota: ricordarsi di eliminare gli spazi o non funzioneranno i recuperi di id

-- Creo nuove sezioni

insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('DATI AGGIUNTIVI', 0, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('VALUTAZIONE FINALE E PROVVEDIMENTI', 5, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_alta-01'));

-- Inserisco domande

insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  0),1,5700,'Tipologia di suini presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  0),2,5701,'Ndeg totale animali (capienza)');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  0),3,5702,'NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  0),4,5703,'Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2023/594?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  0),5,5704,'E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a IX dellallegato III Regolamento (UE) 2023/594?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  0),6,5705,'Veterinario Ufficiale ispettore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  0),7,5791,'Ndeg animali presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),8,5706,'1. Lazienda e dotata di unarea apposita, posta prima della barriera di entrata per la sosta dei veicoli del personale dellallevamento e/o visitatori? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),9,5707,'2. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),10,5708,'3. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),11,5710,'4. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),12,5711,'5. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),13,5712,'6. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),14,5713,'7. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),15,5714,'8. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),16,5715,'9. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),17,5716,'10. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),18,5717,'11. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),19,5718,'12. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),20,5719,'13. Larea tutta intorno ai ricoveri degli animali e mantenuta pulita, coperta da ghiaia o con erba sfalciata, libera da ingombri, oggetti, attrezzature, macchinari, veicoli, ecc. estranei alla funzionalita e gestione dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),21,5720,'14. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),22,5721,'15. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),61,5998,'16. E previsto e documentato un piano di derattizzazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),62,5999,'17. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),23,5724,'18. E previsto e documentato un piano di disinfestazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),24,5725,'19. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),25,5726,'20. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),26,5727,'21. Esiste un piano di profilassi vaccinale documentato?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),27,5728,'22. Esiste una prassi igienica e sanitaria di gestione delle attrezzature utilizzate per la profilassi vaccinale e i trattamenti terapeutici individuali o di gruppo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),28,5729,'23. Sono presenti eventuali risultati delle analisi, ufficiali o effettuate in autocontrollo, su campioni prelevati da animali o da altre matrici che abbiano rilevanza per la salute umana e animale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),29,5730,'24. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),30,5731,'25. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),31,5732,'26. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),32,5733,'27. E presente una documentazione attestante lavvenuta disinfezione degli automezzi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),33,5734,'28. Lallevamento dispone di una piazzola per la pulizia e la disinfezione degli automezzi localizzata in prossimita dellaccesso allallevamento o, in ogni caso, separata dallarea aziendale destinata alla stabulazione e al governo animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),34,5735,'29. Sono presenti apparecchiature fisse a pressione per la pulizia, il lavaggio e la disinfezione degli automezzi in entrata?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),35,5736,'30. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),36,5737,'31. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),37,5738,'32. Esiste una rampa/corridoio di carico/scarico degli animali vivi, fissa o mobile?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),38,5739,'33. Il carico/scarico dei suini vivi avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),39,5740,'34. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),40,5741,'35. Il carico degli scarti avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),41,5742,'36. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),42,5743,'37. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),43,5744,'38. Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),44,5745,'39. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),45,5746,'40. Qualora le carcasse dei suinetti siano temporaneamente immagazzinate nei locali di allevamento, in attesa del loro allontanamento, i contenitori utilizzati sono adeguatamente sigillati ed idonei alla conservazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),46,5747,'41. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),47,5748,'42. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),48,5749,'43. Le aree sottostanti i silos dei mangimi consentono una efficace pulizia e il deflusso delle acque di lavaggio?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),49,5750,'44. Sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),50,5751,'45. Se sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte e presente il nulla-osta al loro utilizzo ed e garantita la loro tracciabilita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),51,5752,'46. Il punto di pesa e di esclusivo utilizzo dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),52,5753,'47. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),53,5754,'48. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),54,5755,'49. I terreni attigui allazienda sono utilizzati per lo spandimento di liquami provenienti da altre aziende?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),55,5756,'50. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),56,5757,'51. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),57,5758,'52. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),58,5759,'53. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),59,5760,'54. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  1),60,5761,'55. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),63,5762,'56. La rimonta viene effettuata ad opera di riproduttori esterni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),64,5763,'57. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),66,5764,'58. Viene praticato il tutto pieno/tutto vuoto e un idoneo periodo di vuoto sanitario?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),67,5765,'59. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),65,5766,'60. I locali di quarantena dispongono di fossa/e separata/e?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),68,5767,'61. I locali di quarantena dispongono di ingresso/i separato/i?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),70,5768,'62. Sono disponibili attrezzature destinate esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),71,5769,'63. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),72,5770,'64. E prevista lesecuzione pianificata di accertamenti diagnostici negli animali in quarantena? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),69,5771,'65. E richiesta e disponibile alle aziende di provenienza una documentazione che attesti lo stato sanitario degli animali di nuova introduzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),73,5772,'66. La rimonta dei riproduttori viene effettuata con cadenza superiore a 3 mesi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),74,5773,'67. Lesame ecografico viene effettuato da operatori esterni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),75,5774,'68. Nel caso in cui si pratichi la fecondazione artificiale il materiale seminale questo proviene da centri di raccolta seme autorizzati?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),76,5775,'69. Nel caso in cui si pratichi la monta naturale i verri sono stati sottoposti agli accertamenti diagnostici previsti per i riproduttori maschi della specie suina?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  2),77,5776,'70. I suinetti in sala parto sono destinati a piu di due allevamenti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  3),78,5777,'71. I suini provengono da piu di un allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  3),79,5778,'72. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  3),80,5779,'73. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  3),81,5780,'74. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  3),83,5940,'75. I capannoni sono suddivisi in settori da pareti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  3),82,5781,'76. I suini a fine ciclo sono destinati a piu di 1  allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  4),84,5782,'77. I suini provengono da piu di un allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  4),85,5783,'78. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  4),86,5784,'79. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  4),87,5785,'80. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  4),89,5941,'81. I capannoni sono suddivisi in settori da pareti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  4),88,5786,'82. I suini a fine ciclo sono destinati a solo macelli industriali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  5),90,5787,'Documento 1');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  5),91,5788,'ESITO DEL CONTROLLO');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  5),92,5789,'Sono state assegnate delle prescrizioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '0122' and m.versione = 2023 and s.ordine =  5),93,5790,'Sono state applicate delle sanzioni?');

-- bonifico domande. OPERAZIONI AD HOC
delete from biosicurezza_domande where domanda ilike 'Documento 1';
update biosicurezza_domande set domanda = 'Numero totale degli animali (capienza)' where domanda ilike 'Ndeg totale animali (capienza)';
update biosicurezza_domande set domanda = 'Numero totale animali presenti' where domanda ilike 'Ndeg animali presenti';

update biosicurezza_domande set ordine = 1 where id_classyfarm = 5701;
update biosicurezza_domande set ordine = 2 where id_classyfarm = 5791;
update biosicurezza_domande set ordine = 3 where id_classyfarm = 5705;
update biosicurezza_domande set ordine = 4 where id_classyfarm = 5700;
update biosicurezza_domande set ordine = 5 where id_classyfarm = 5703;
update biosicurezza_domande set ordine = 6 where id_classyfarm = 5704;

update biosicurezza_domande set ordine = ordine-1 where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod = 11) and ordine > 7

update biosicurezza_domande set id_sezione = (select id from biosicurezza_sezioni  where id_lookup_chk_classyfarm_mod = 11 and sezione ilike 'VALUTAZIONE FINALE E PROVVEDIMENTI' ), ordine = 93 where id_classyfarm = 5702;

-- inserisco risposte

insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5700), 16403, 'CheckBoxList', ' Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1', 'Categorie presenti');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5700), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5700), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5700), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5700), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5701), 16404, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5701), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5701), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5701), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5701), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5702), 16405, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5702), 16406, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5702), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5702), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5702), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5703), 16408, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5703), 16407, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5703), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5703), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5703), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5704), 16409, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5704), 16410, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5704), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5704), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5704), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5705), 16411, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5705), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5705), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5705), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5705), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5791), 16713, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5791), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5791), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5791), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5791), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5706), 16415, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5706), 16414, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5706), 16413, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5706), 16412, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5706), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5707), 16416, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5707), 16417, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5707), 16418, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5707), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5707), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5708), 16421, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5708), 16420, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5708), 16419, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5708), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5708), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5710), 16426, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5710), 16427, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5710), 16428, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5710), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5710), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5711), 16431, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5711), 16430, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5711), 16429, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5711), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5711), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5712), 16432, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5712), 16433, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5712), 16434, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5712), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5712), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5713), 16437, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5713), 16436, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5713), 16435, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5713), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5713), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5714), 16438, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5714), 16439, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5714), 16440, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5714), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5714), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5715), 16442, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5715), 16443, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5715), 16441, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5715), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5715), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5716), 16446, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5716), 16445, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5716), 16444, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5716), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5716), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5717), 16447, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5717), 16448, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5717), 16449, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5717), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5717), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5718), 16452, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5718), 16451, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5718), 16450, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5718), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5718), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5719), 16453, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5719), 16454, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5719), 16456, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5719), 16455, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5719), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5720), 16459, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5720), 16458, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5720), 16457, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5720), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5720), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5721), 16461, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5721), 16460, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5721), 16462, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5721), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5721), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5724), 16474, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5724), 16471, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5724), 16472, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5724), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5724), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5725), 16476, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5725), 16475, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5725), 16478, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5725), 16477, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5725), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5726), 16481, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5726), 16479, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5726), 16480, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5726), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5726), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5727), 16483, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5727), 16482, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5727), 16485, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5727), 16484, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5727), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5728), 16488, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5728), 16489, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5728), 16486, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5728), 16487, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5728), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5729), 16491, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5729), 16490, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5729), 16493, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5729), 16492, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5729), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5730), 16496, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5730), 16497, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5730), 16494, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5730), 16495, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5730), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5731), 16499, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5731), 16498, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5731), 16500, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5731), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5731), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5732), 16503, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5732), 16501, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5732), 16502, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5732), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5732), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5733), 16505, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5733), 16504, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5733), 16507, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5733), 16506, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5733), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5734), 16510, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5734), 16511, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5734), 16508, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5734), 16509, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5734), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5735), 16513, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5735), 16512, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5735), 16515, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5735), 16514, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5735), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5736), 16518, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5736), 16516, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5736), 16517, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5736), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5736), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5737), 16520, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5737), 16519, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5737), 16521, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5737), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5737), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5738), 16525, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5738), 16524, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5738), 16522, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5738), 16523, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5738), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5739), 16527, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5739), 16526, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5739), 16528, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5739), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5739), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5740), 16531, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5740), 16529, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5740), 16530, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5740), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5740), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5741), 16533, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5741), 16532, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5741), 16535, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5741), 16534, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5741), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5742), 16538, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5742), 16539, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5742), 16536, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5742), 16537, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5742), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5743), 16541, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5743), 16540, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5743), 16542, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5743), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5743), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5744), 16545, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5744), 16543, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5744), 16544, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5744), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5744), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5745), 16547, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5745), 16546, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5745), 16548, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5745), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5745), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5746), 16552, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5746), 16551, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5746), 16549, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5746), 16550, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5746), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5747), 16554, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5747), 16553, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5747), 16555, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5747), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5747), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5748), 16558, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5748), 16556, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5748), 16557, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5748), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5748), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5749), 16560, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5749), 16559, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5749), 16562, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5749), 16561, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5749), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5750), 16565, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5750), 16566, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5750), 16563, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5750), 16564, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5750), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5751), 16568, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5751), 16567, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5751), 16570, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5751), 16569, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5751), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5752), 16573, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5752), 16571, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5752), 16572, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5752), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5752), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5753), 16574, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5753), 16576, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5753), 16575, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5753), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5753), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5754), 16579, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5754), 16578, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5754), 16577, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5754), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5754), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5755), 16580, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5755), 16581, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5755), 16583, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5755), 16582, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5755), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5756), 16586, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5756), 16584, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5756), 16585, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5756), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5756), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5757), 16589, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5757), 17191, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5757), 16588, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5757), 16587, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5757), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5758), 16591, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5758), 16590, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5758), 16592, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5758), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5758), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5759), 16595, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5759), 16593, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5759), 16594, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5759), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5759), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5760), 16597, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5760), 16596, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5760), 16598, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5760), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5760), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5761), 16601, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5761), 16599, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5761), 16600, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5761), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5761), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5998), 17460, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5998), 17461, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5998), 17459, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5998), 17458, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5998), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5999), 17462, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5999), 17463, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5999), 17465, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5999), 17464, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5999), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5762), 17406, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5762), 16604, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5762), 16605, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5762), 16602, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5762), 16603, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5763), 16607, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5763), 16606, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5763), 16609, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5763), 17407, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5763), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5766), 17410, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5766), 16621, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5766), 16620, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5766), 16618, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5766), 16619, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5764), 16612, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5764), 17408, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5764), 16613, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5764), 16610, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5764), 16611, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5765), 16615, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5765), 16614, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5765), 16617, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5765), 17409, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5765), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5767), 16623, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5767), 16622, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5767), 16625, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5767), 17411, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5767), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5771), 16638, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5771), 16641, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5771), 16639, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5771), 17415, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5771), 16640, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5768), 17412, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5768), 16629, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5768), 16626, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5768), 16627, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5768), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5769), 16631, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5769), 16630, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5769), 16633, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5769), 17413, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5769), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5770), 17414, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5770), 16636, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5770), 16637, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5770), 16634, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5770), 16635, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5772), 16644, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5772), 17416, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5772), 16645, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5772), 16642, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5772), 16643, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5773), 16647, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5773), 16646, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5773), 16649, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5773), 17417, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5773), 16648, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5774), 16652, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5774), 17418, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5774), 16653, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5774), 16650, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5774), 16651, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5775), 16655, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5775), 16654, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5775), 16657, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5775), 17419, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5775), 16656, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5776), 17420, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5776), 16660, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5776), 16661, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5776), 16658, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5776), 16659, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5777), 16663, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5777), 16662, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5777), 16665, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5777), 17421, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5777), 16664, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5778), 16668, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5778), 17422, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5778), 16669, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5778), 16666, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5778), 16667, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5779), 16671, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5779), 16670, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5779), 16673, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5779), 17423, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5779), 16672, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5780), 17396, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5780), 16677, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5780), 16674, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5780), 16675, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5780), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5781), 16679, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5781), 16678, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5781), 16681, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5781), 17425, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5781), 16680, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5940), 17424, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5940), 17197, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5940), 17196, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5940), 17195, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5940), 17198, 'TextArea', '0', 'Note - Motivo:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5782), 17426, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5782), 16684, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5782), 16685, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5782), 16682, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5782), 16683, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5783), 16687, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5783), 16686, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5783), 16689, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5783), 17427, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5783), 16688, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5784), 16692, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5784), 17428, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5784), 16693, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5784), 16690, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5784), 16691, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5785), 16695, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5785), 16694, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5785), 16697, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5785), 17395, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5785), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5786), 16700, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5786), 17430, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5786), 16701, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5786), 16698, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5786), 16699, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5941), 17429, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5941), 17201, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5941), 17200, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5941), 17202, 'TextArea', '0', 'Note - Motivo: ');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5941), 17199, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5787), 16702, 'TextBox', '0', 'carica');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5787), 16703, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5787), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5787), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5787), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5788), 16705, 'Button', '0', 'SFAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5788), 16704, 'Button', '0', 'FAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5788), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5788), 0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5788), 0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5789), 16707, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5789), 16709, 'TextBox', '0', 'Entro quale data dovranno essere eseguite?');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5789), 16708, 'TextArea', '0', 'Se si quali:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5789), 16706, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5790), 16711, 'Button', '0', 'NA');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5790), 16710, 'CheckBoxList', ' Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5790), 16712, 'TextArea', '0', 'Se altro specificare:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select id from biosicurezza_domande where id_classyfarm = 5790), 0, '0', '0', '0');


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

-- Modifico unico campo numerico nel tipo number

update biosicurezza_risposte set tipo = 'number' where id_domanda in 
(select id from biosicurezza_domande where domanda ilike '%Numero%' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_alta-01')))

-- Aggiorno ordine "Se altro...". OPERAZIONE AD HOC
update biosicurezza_risposte set ordine = 4 where id_classyfarm = 16710;
update biosicurezza_risposte set ordine = 5 where id_classyfarm = 16712;

-- Aggiorno ordine "Se si quali / entro quale data". OPERAZIONE AD HOC
update biosicurezza_risposte set ordine = 3 where id_classyfarm = 16708;
update biosicurezza_risposte set ordine = 4 where id_classyfarm = 16709;

-- Bonifica accenti e apostrofi
update biosicurezza_domande set domanda = replace(domanda, 'lallegato', 'l''allegato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lallegato%');
update biosicurezza_domande set domanda = replace(domanda, 'Lallevamento', 'L''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'Lazienda', 'L''azienda') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lazienda%');
update biosicurezza_domande set domanda = replace(domanda, 'e posto', 'e'' posto') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e posto%');
update biosicurezza_domande set domanda = replace(domanda, 'e dotata', 'e'' dotata') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e dotata%');
update biosicurezza_domande set domanda = replace(domanda, 'lingresso', 'l''ingresso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lingresso%');
update biosicurezza_domande set domanda = replace(domanda, 'E presente', 'E'' presente') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E presente%');
update biosicurezza_domande set domanda = replace(domanda, 'unarea', 'un''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%unarea%');
update biosicurezza_domande set domanda = replace(domanda, 'E vietato', 'E'' vietato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E vietato%');
update biosicurezza_domande set domanda = replace(domanda, 'Larea', 'L''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Larea%');
update biosicurezza_domande set domanda = replace(domanda, 'e mantenuta', 'e'' mantenuta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e mantenuta%');
update biosicurezza_domande set domanda = replace(domanda, 'dellaccesso', 'dell''accesso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellaccesso%');
update biosicurezza_domande set domanda = replace(domanda, 'allallevamento', 'all''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%allallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'lavvenuta', 'l''avvenuta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lavvenuta%');
update biosicurezza_domande set domanda = replace(domanda, 'allesterno', 'all''esterno') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%allesterno%');
update biosicurezza_domande set domanda = replace(domanda, 'dellarea', 'dell''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellarea%');
update biosicurezza_domande set domanda = replace(domanda, 'e idonea', 'e'' idonea') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e idonea%');
update biosicurezza_domande set domanda = replace(domanda, 'lalimentazione', 'l''alimentazione') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lalimentazione%');
update biosicurezza_domande set domanda = replace(domanda, 'e garantita', 'e'' garantita') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e garantita%');
update biosicurezza_domande set domanda = replace(domanda, ' piu ', ' piu'' ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '% piu %');
update biosicurezza_domande set domanda = replace(domanda, 'Lesame', 'L''esame') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lesame%');
update biosicurezza_domande set domanda = replace(domanda, 'E prevista', 'E'' prevista') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E prevista%');
update biosicurezza_domande set domanda = replace(domanda, 'lesecuzione', 'l''esecuzione') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lesecuzione%');
update biosicurezza_domande set domanda = replace(domanda, 'E richiesta', 'E'' richiesta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E richiesta%');
update biosicurezza_domande set domanda = replace(domanda, 'limpossibilita', 'l''impossibilita') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%limpossibilita%');
update biosicurezza_domande set domanda = replace(domanda, 'dellallevamento', 'dell''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'tracciabilita?', 'tracciabilita''?') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%tracciabilita?%');
update biosicurezza_domande set domanda = replace(domanda, 'E vietata', 'E'' vietata') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E vietata%');


-- Bonifica finale ordine domande
select 'update biosicurezza_domande set ordine = '||nuovo_ordine||' where id = '||id||';' from (
select *, 6+ord::integer as nuovo_ordine from (
select id, replace(substring(domanda, 0, 3), '.', '') as ord, ordine from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023-suini-stab_alta-01' )) ) aa where (ord ilike '%1%' or ord ilike '%2%' or  ord ilike '%3%' or ord ilike '%4%' or ord ilike '%5%' or ord ilike '%6%' or ord ilike '%7%' or ord ilike '%8%' or ord ilike '%9%' ) order by ordine asc)bb

-----------------------------------------
-----------------------------------------
-----------------------------------------


-----------------------------------------
-- VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI A BASSA CAPACITA CONTROLLO UFFICIALE (107)
-----------------------------------------

alter table biosicurezza_risposte add entered timestamp without time zone default now();
alter table biosicurezza_domande add entered timestamp without time zone default now();

-- 1: Eseguire la chiamata ai webservice di classyfarm per ottenere i template delle checklist

-- Chiamare il servizio login da postman per avere il token
https://cf-function02-test.azurewebsites.net/api/autenticazione/login

{"username": "regcampania_CF","password": "yrq5nKqSr8CdOPOLmMxi4h/HtPM="}

-- Usare il token su chrome (estensione MOD HEADER, parametro x-api-key)

-- Collegarsi a http://cf-function02-test.azurewebsites.net/api/swagger/ui e nella sezione /api/checklist/getTemplateCL fare "try it out" usando il codice classyfarm 106

{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "5791",
      "DescrDomanda": "Ndeg animali presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "16713",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "5792",
      "DescrDomanda": "Tipologia di suini presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "16714",
          "ControlType": "CheckBoxList",
          "ListItems": " Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1",
          "TemaplateName": "Categorie presenti"
        }
      ]
    },
    {
      "IDDomanda": "5793",
      "DescrDomanda": "Ndeg totale animali (capienza)",
      "ListaRisposte": [
        {
          "IDRisposta": "16715",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "5794",
      "DescrDomanda": "NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :",
      "ListaRisposte": [
        {
          "IDRisposta": "16716",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "16717",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "5795",
      "DescrDomanda": "Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2023/594?",
      "ListaRisposte": [
        {
          "IDRisposta": "16719",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "16718",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "5796",
      "DescrDomanda": "E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a VIII dellallegato II Regolamento (UE) 2023/594?",
      "ListaRisposte": [
        {
          "IDRisposta": "16720",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "16721",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "5797",
      "DescrDomanda": "Veterinario Ufficiale ispettore",
      "ListaRisposte": [
        {
          "IDRisposta": "16722",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "5722",
      "DescrDomanda": "16. E previsto e documentato un piano di disinfestazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16466",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16464",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16463",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5829",
      "DescrDomanda": "35. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?",
      "ListaRisposte": [
        {
          "IDRisposta": "17216",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16819",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16820",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16818",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5723",
      "DescrDomanda": "15. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "16467",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16468",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16470",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16469",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5798",
      "DescrDomanda": "1. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16725",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16724",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16723",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5799",
      "DescrDomanda": "2. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16726",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16727",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16728",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5801",
      "DescrDomanda": "3. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?",
      "ListaRisposte": [
        {
          "IDRisposta": "16735",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16734",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16733",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5802",
      "DescrDomanda": "4. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?",
      "ListaRisposte": [
        {
          "IDRisposta": "16736",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16737",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16738",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5803",
      "DescrDomanda": "5. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16741",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16740",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16739",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5804",
      "DescrDomanda": "6. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16742",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16743",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16744",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5805",
      "DescrDomanda": "7. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16747",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16746",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16745",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5806",
      "DescrDomanda": "8. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?",
      "ListaRisposte": [
        {
          "IDRisposta": "16749",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16750",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16748",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5807",
      "DescrDomanda": "9. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?",
      "ListaRisposte": [
        {
          "IDRisposta": "16753",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16751",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16752",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5808",
      "DescrDomanda": "10. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?",
      "ListaRisposte": [
        {
          "IDRisposta": "16755",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16754",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16756",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5809",
      "DescrDomanda": "11. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?",
      "ListaRisposte": [
        {
          "IDRisposta": "16759",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16757",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16758",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5810",
      "DescrDomanda": "12. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16761",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16760",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16762",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5811",
      "DescrDomanda": "13. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16764",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16763",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16765",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5812",
      "DescrDomanda": "18. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?",
      "ListaRisposte": [
        {
          "IDRisposta": "16768",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16766",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16767",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5813",
      "DescrDomanda": "19. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?",
      "ListaRisposte": [
        {
          "IDRisposta": "16770",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16769",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16771",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5814",
      "DescrDomanda": "20. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?",
      "ListaRisposte": [
        {
          "IDRisposta": "16774",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16772",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16773",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5815",
      "DescrDomanda": "21. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?",
      "ListaRisposte": [
        {
          "IDRisposta": "16776",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16775",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16777",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5816",
      "DescrDomanda": "22. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16780",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16778",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16779",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5817",
      "DescrDomanda": "23. Il carico/scarico dei suini vivi avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "16782",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16781",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16783",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5818",
      "DescrDomanda": "24. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16786",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16784",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16785",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5819",
      "DescrDomanda": "25. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16788",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16787",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16790",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16789",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5820",
      "DescrDomanda": "26. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16793",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16791",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16792",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5821",
      "DescrDomanda": "27. Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16795",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16794",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16796",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5822",
      "DescrDomanda": "28. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16799",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16797",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16798",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5823",
      "DescrDomanda": "29. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16801",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16800",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16802",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5824",
      "DescrDomanda": "30. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?",
      "ListaRisposte": [
        {
          "IDRisposta": "16805",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16803",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16804",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5825",
      "DescrDomanda": "31. Il punto di pesa e di esclusivo utilizzo dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16807",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16806",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16808",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5826",
      "DescrDomanda": "32. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16809",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16811",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16810",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5827",
      "DescrDomanda": "33. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16814",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16812",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16813",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5828",
      "DescrDomanda": "34. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?",
      "ListaRisposte": [
        {
          "IDRisposta": "16817",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16815",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16816",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5830",
      "DescrDomanda": "36. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?",
      "ListaRisposte": [
        {
          "IDRisposta": "16822",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16821",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16823",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5831",
      "DescrDomanda": "37. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?",
      "ListaRisposte": [
        {
          "IDRisposta": "16826",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16824",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16825",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5832",
      "DescrDomanda": "38. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "16828",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16827",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16829",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5833",
      "DescrDomanda": "39. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "16832",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16830",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16831",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5870",
      "DescrDomanda": "17. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "16946",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16947",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16944",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16945",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5939",
      "DescrDomanda": "14. E previsto e documentato un piano di derattizzazione? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17193",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17192",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17190",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17194",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5834",
      "DescrDomanda": "40. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17388",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16836",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16834",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16833",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5835",
      "DescrDomanda": "41. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "16837",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16838",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16840",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17389",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5836",
      "DescrDomanda": "42. I locali di quarantena dispongono di ingresso/i separato/i?",
      "ListaRisposte": [
        {
          "IDRisposta": "17390",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16844",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16842",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16841",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5837",
      "DescrDomanda": "43. Sono disponibili attrezzature destinate esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "16845",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16846",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16848",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17391",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5838",
      "DescrDomanda": "44. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "17392",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16852",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16850",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16849",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5839",
      "DescrDomanda": "45. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16853",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16854",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16856",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17398",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16855",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5840",
      "DescrDomanda": "46. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16859",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17399",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16860",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16858",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16857",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5946",
      "DescrDomanda": "47. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza?",
      "ListaRisposte": [
        {
          "IDRisposta": "17393",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17218",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17219",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17217",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5947",
      "DescrDomanda": "48. I capannoni sono suddivisi in settori da pareti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17220",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17223",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17221",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17222",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17400",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5841",
      "DescrDomanda": "49. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17401",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "16863",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16864",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16861",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16862",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5842",
      "DescrDomanda": "50. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16866",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16865",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16868",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16867",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17402",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5948",
      "DescrDomanda": "51. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza?",
      "ListaRisposte": [
        {
          "IDRisposta": "17394",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17225",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17226",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17224",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5949",
      "DescrDomanda": "52. I capannoni sono suddivisi in settori da pareti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17227",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17230",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17228",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17229",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17403",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5843",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "16870",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "16869",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        }
      ]
    },
    {
      "IDDomanda": "5844",
      "DescrDomanda": "ESITO DEL CONTROLLO",
      "ListaRisposte": [
        {
          "IDRisposta": "16872",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SFAVOREVOLE"
        },
        {
          "IDRisposta": "16871",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "FAVOREVOLE"
        }
      ]
    },
    {
      "IDDomanda": "5845",
      "DescrDomanda": "Sono state assegnate delle prescrizioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16874",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16876",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Entro quale data dovranno essere eseguite?"
        },
        {
          "IDRisposta": "16875",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se si quali:"
        },
        {
          "IDRisposta": "16873",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5846",
      "DescrDomanda": "Sono state applicate delle sanzioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16878",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "16879",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se altro specificare:"
        },
        {
          "IDRisposta": "16877",
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


-- creo le sezioni
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('VALUTAZIONE FINALE E PROVVEDIMENTI', 5, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('DATI AGGIUNTIVI', 0, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO',4 , (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE', 1, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA', 2, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO', 3, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01'));


-- creo le domande partendo dal ClassyFarmGeneratore.ods

insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 0),1,5791, 'Ndeg animali presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 0),2,5792, 'Tipologia di suini presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 0),3,5793, 'Ndeg totale animali (capienza)');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 0),4,5794, 'NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 0),5,5795, 'Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2023/594?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 0),6,5796, 'E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a VIII dellallegato II Regolamento (UE) 2023/594?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 5),7,5797, 'Veterinario Ufficiale ispettore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),8,5798, '1. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),9,5799, '2. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),10,5801, '3. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),11,5802, '4. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),12,5803, '5. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),13,5804, '6. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),14,5805, '7. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),15,5806, '8. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),16,5807, '9. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),17,5808, '10. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),18,5809, '11. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),19,5810, '12. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),20,5811, '13. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),21,5939, '14. E previsto e documentato un piano di derattizzazione? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),22,5723, '15. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),23,5722, '16. E previsto e documentato un piano di disinfestazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),24,5870, '17. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),25,5812, '18. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),26,5813, '19. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),27,5814, '20. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),28,5815, '21. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),29,5816, '22. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),30,5817, '23. Il carico/scarico dei suini vivi avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),31,5818, '24. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),32,5819, '25. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),33,5820, '26. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),34,5821, '27. Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),35,5822, '28. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),36,5823, '29. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),37,5824, '30. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),38,5825, '31. Il punto di pesa e di esclusivo utilizzo dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),39,5826, '32. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),40,5827, '33. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),41,5828, '34. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),42,5829, '35. Sono presenti delle reti antipassero o e comunque garantita limpossibilita di ingresso degli uccelli negli stabili?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),43,5830, '36. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),44,5831, '37. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),45,5832, '38. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 1),46,5833, '39. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 2),47,5834, '40. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 2),48,5835, '41. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 2),49,5836, '42. I locali di quarantena dispongono di ingresso/i separato/i?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 2),50,5837, '43. Sono disponibili attrezzature destinate esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 2),51,5838, '44. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 3),52,5839, '45. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 3),53,5840, '46. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 3),54,5946, '47. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 3),55,5947, '48. I capannoni sono suddivisi in settori da pareti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 4),56,5841, '49. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 4),57,5842, '50. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 4),58,5948, '51. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 4),59,5949, '52. I capannoni sono suddivisi in settori da pareti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 5),60,5844, 'ESITO DEL CONTROLLO');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 5),61,5845, 'Sono state assegnate delle prescrizioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01222' and m.versione =2023 and s.ordine = 5),62,5846, 'Sono state applicate delle sanzioni?');


-- bonifico domande. OPERAZIONI AD HOC
update biosicurezza_domande set domanda = 'Numero totale degli animali (capienza)' where domanda ilike 'Ndeg totale animali (capienza)';
update biosicurezza_domande set domanda = 'Numero totale animali presenti' where domanda ilike 'Ndeg animali presenti';
update biosicurezza_domande set id_sezione = 104 where  domanda ilike '%Veterinario ufficiale ispettore%' and id_classyfarm=5797;
update biosicurezza_domande set id_sezione = 105 where  domanda ilike '%nome e cognome del proprietario%' and id_classyfarm=5794;

update biosicurezza_domande set ordine = 1 where id_classyfarm = 5793;
update biosicurezza_domande set ordine = 2 where id_classyfarm = 5791;
update biosicurezza_domande set ordine = 3 where id_classyfarm = 5797;
update biosicurezza_domande set ordine = 4 where id_classyfarm = 5792;
update biosicurezza_domande set ordine = 5 where id_classyfarm = 5795;
update biosicurezza_domande set ordine = 6 where id_classyfarm = 5796;

-- creo le risposte


insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01222'),16713, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5792 and c.cod_specie = '01222'),16714, 'CheckBoxList', ' Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1', 'Categorie presenti');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5792 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5792 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5792 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5792 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5793 and c.cod_specie = '01222'),16715, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5793 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5793 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5793 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5793 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5794 and c.cod_specie = '01222'),16716, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5794 and c.cod_specie = '01222'),16717, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5794 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5794 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5794 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5795 and c.cod_specie = '01222'),16719, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5795 and c.cod_specie = '01222'),16718, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5795 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5795 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5795 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5796 and c.cod_specie = '01222'),16720, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5796 and c.cod_specie = '01222'),16721, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5796 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5796 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5796 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5797 and c.cod_specie = '01222'),16722, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5797 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5797 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5797 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5797 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5722 and c.cod_specie = '01222'),16466, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5722 and c.cod_specie = '01222'),16464, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5722 and c.cod_specie = '01222'),16463, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5722 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5722 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5829 and c.cod_specie = '01222'),17216, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5829 and c.cod_specie = '01222'),16819, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5829 and c.cod_specie = '01222'),16820, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5829 and c.cod_specie = '01222'),16818, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5829 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5723 and c.cod_specie = '01222'),16467, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5723 and c.cod_specie = '01222'),16468, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5723 and c.cod_specie = '01222'),16470, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5723 and c.cod_specie = '01222'),16469, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5723 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5798 and c.cod_specie = '01222'),16725, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5798 and c.cod_specie = '01222'),16724, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5798 and c.cod_specie = '01222'),16723, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5798 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5798 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5799 and c.cod_specie = '01222'),16726, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5799 and c.cod_specie = '01222'),16727, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5799 and c.cod_specie = '01222'),16728, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5799 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5799 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5801 and c.cod_specie = '01222'),16735, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5801 and c.cod_specie = '01222'),16734, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5801 and c.cod_specie = '01222'),16733, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5801 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5801 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5802 and c.cod_specie = '01222'),16736, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5802 and c.cod_specie = '01222'),16737, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5802 and c.cod_specie = '01222'),16738, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5802 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5802 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5803 and c.cod_specie = '01222'),16741, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5803 and c.cod_specie = '01222'),16740, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5803 and c.cod_specie = '01222'),16739, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5803 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5803 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5804 and c.cod_specie = '01222'),16742, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5804 and c.cod_specie = '01222'),16743, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5804 and c.cod_specie = '01222'),16744, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5804 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5804 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5805 and c.cod_specie = '01222'),16747, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5805 and c.cod_specie = '01222'),16746, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5805 and c.cod_specie = '01222'),16745, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5805 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5805 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5806 and c.cod_specie = '01222'),16749, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5806 and c.cod_specie = '01222'),16750, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5806 and c.cod_specie = '01222'),16748, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5806 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5806 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5807 and c.cod_specie = '01222'),16753, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5807 and c.cod_specie = '01222'),16751, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5807 and c.cod_specie = '01222'),16752, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5807 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5807 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5808 and c.cod_specie = '01222'),16755, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5808 and c.cod_specie = '01222'),16754, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5808 and c.cod_specie = '01222'),16756, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5808 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5808 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5809 and c.cod_specie = '01222'),16759, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5809 and c.cod_specie = '01222'),16757, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5809 and c.cod_specie = '01222'),16758, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5809 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5809 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5810 and c.cod_specie = '01222'),16761, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5810 and c.cod_specie = '01222'),16760, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5810 and c.cod_specie = '01222'),16762, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5810 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5810 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5811 and c.cod_specie = '01222'),16764, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5811 and c.cod_specie = '01222'),16763, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5811 and c.cod_specie = '01222'),16765, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5811 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5811 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5812 and c.cod_specie = '01222'),16768, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5812 and c.cod_specie = '01222'),16766, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5812 and c.cod_specie = '01222'),16767, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5812 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5812 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5813 and c.cod_specie = '01222'),16770, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5813 and c.cod_specie = '01222'),16769, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5813 and c.cod_specie = '01222'),16771, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5813 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5813 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5814 and c.cod_specie = '01222'),16774, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5814 and c.cod_specie = '01222'),16772, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5814 and c.cod_specie = '01222'),16773, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5814 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5814 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5815 and c.cod_specie = '01222'),16776, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5815 and c.cod_specie = '01222'),16775, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5815 and c.cod_specie = '01222'),16777, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5815 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5815 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5816 and c.cod_specie = '01222'),16780, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5816 and c.cod_specie = '01222'),16778, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5816 and c.cod_specie = '01222'),16779, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5816 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5816 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5817 and c.cod_specie = '01222'),16782, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5817 and c.cod_specie = '01222'),16781, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5817 and c.cod_specie = '01222'),16783, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5817 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5817 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5818 and c.cod_specie = '01222'),16786, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5818 and c.cod_specie = '01222'),16784, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5818 and c.cod_specie = '01222'),16785, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5818 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5818 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5819 and c.cod_specie = '01222'),16788, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5819 and c.cod_specie = '01222'),16787, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5819 and c.cod_specie = '01222'),16790, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5819 and c.cod_specie = '01222'),16789, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5819 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5820 and c.cod_specie = '01222'),16793, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5820 and c.cod_specie = '01222'),16791, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5820 and c.cod_specie = '01222'),16792, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5820 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5820 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5821 and c.cod_specie = '01222'),16795, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5821 and c.cod_specie = '01222'),16794, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5821 and c.cod_specie = '01222'),16796, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5821 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5821 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5822 and c.cod_specie = '01222'),16799, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5822 and c.cod_specie = '01222'),16797, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5822 and c.cod_specie = '01222'),16798, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5822 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5822 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5823 and c.cod_specie = '01222'),16801, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5823 and c.cod_specie = '01222'),16800, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5823 and c.cod_specie = '01222'),16802, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5823 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5823 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5824 and c.cod_specie = '01222'),16805, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5824 and c.cod_specie = '01222'),16803, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5824 and c.cod_specie = '01222'),16804, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5824 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5824 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5825 and c.cod_specie = '01222'),16807, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5825 and c.cod_specie = '01222'),16806, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5825 and c.cod_specie = '01222'),16808, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5825 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5825 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5826 and c.cod_specie = '01222'),16809, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5826 and c.cod_specie = '01222'),16811, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5826 and c.cod_specie = '01222'),16810, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5826 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5826 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5827 and c.cod_specie = '01222'),16814, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5827 and c.cod_specie = '01222'),16812, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5827 and c.cod_specie = '01222'),16813, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5827 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5827 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5828 and c.cod_specie = '01222'),16817, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5828 and c.cod_specie = '01222'),16815, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5828 and c.cod_specie = '01222'),16816, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5828 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5828 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5830 and c.cod_specie = '01222'),16822, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5830 and c.cod_specie = '01222'),16821, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5830 and c.cod_specie = '01222'),16823, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5830 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5830 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5831 and c.cod_specie = '01222'),16826, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5831 and c.cod_specie = '01222'),16824, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5831 and c.cod_specie = '01222'),16825, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5831 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5831 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5832 and c.cod_specie = '01222'),16828, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5832 and c.cod_specie = '01222'),16827, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5832 and c.cod_specie = '01222'),16829, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5832 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5832 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5833 and c.cod_specie = '01222'),16832, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5833 and c.cod_specie = '01222'),16830, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5833 and c.cod_specie = '01222'),16831, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5833 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5833 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5870 and c.cod_specie = '01222'),16946, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5870 and c.cod_specie = '01222'),16947, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5870 and c.cod_specie = '01222'),16944, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5870 and c.cod_specie = '01222'),16945, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5870 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5939 and c.cod_specie = '01222'),17193, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5939 and c.cod_specie = '01222'),17192, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5939 and c.cod_specie = '01222'),17190, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5939 and c.cod_specie = '01222'),17194, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5939 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5834 and c.cod_specie = '01222'),17388, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5834 and c.cod_specie = '01222'),16836, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5834 and c.cod_specie = '01222'),16834, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5834 and c.cod_specie = '01222'),16833, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5834 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5835 and c.cod_specie = '01222'),16837, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5835 and c.cod_specie = '01222'),16838, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5835 and c.cod_specie = '01222'),16840, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5835 and c.cod_specie = '01222'),17389, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5835 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5836 and c.cod_specie = '01222'),17390, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5836 and c.cod_specie = '01222'),16844, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5836 and c.cod_specie = '01222'),16842, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5836 and c.cod_specie = '01222'),16841, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5836 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5837 and c.cod_specie = '01222'),16845, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5837 and c.cod_specie = '01222'),16846, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5837 and c.cod_specie = '01222'),16848, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5837 and c.cod_specie = '01222'),17391, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5837 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5838 and c.cod_specie = '01222'),17392, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5838 and c.cod_specie = '01222'),16852, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5838 and c.cod_specie = '01222'),16850, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5838 and c.cod_specie = '01222'),16849, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5838 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5839 and c.cod_specie = '01222'),16853, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5839 and c.cod_specie = '01222'),16854, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5839 and c.cod_specie = '01222'),16856, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5839 and c.cod_specie = '01222'),17398, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5839 and c.cod_specie = '01222'),16855, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5840 and c.cod_specie = '01222'),16859, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5840 and c.cod_specie = '01222'),17399, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5840 and c.cod_specie = '01222'),16860, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5840 and c.cod_specie = '01222'),16858, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5840 and c.cod_specie = '01222'),16857, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5946 and c.cod_specie = '01222'),17393, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5946 and c.cod_specie = '01222'),17218, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5946 and c.cod_specie = '01222'),17219, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5946 and c.cod_specie = '01222'),17217, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5946 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5947 and c.cod_specie = '01222'),17220, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5947 and c.cod_specie = '01222'),17223, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5947 and c.cod_specie = '01222'),17221, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5947 and c.cod_specie = '01222'),17222, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5947 and c.cod_specie = '01222'),17400, 'Button', '0', 'N/D');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5841 and c.cod_specie = '01222'),17401, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5841 and c.cod_specie = '01222'),16863, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5841 and c.cod_specie = '01222'),16864, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5841 and c.cod_specie = '01222'),16861, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5841 and c.cod_specie = '01222'),16862, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5842 and c.cod_specie = '01222'),16866, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5842 and c.cod_specie = '01222'),16865, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5842 and c.cod_specie = '01222'),16868, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5842 and c.cod_specie = '01222'),16867, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5842 and c.cod_specie = '01222'),17402, 'Button', '0', 'N/D');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5948 and c.cod_specie = '01222'),17394, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5948 and c.cod_specie = '01222'),17225, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5948 and c.cod_specie = '01222'),17226, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5948 and c.cod_specie = '01222'),17224, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5948 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5949 and c.cod_specie = '01222'),17227, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5949 and c.cod_specie = '01222'),17230, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5949 and c.cod_specie = '01222'),17228, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5949 and c.cod_specie = '01222'),17229, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5949 and c.cod_specie = '01222'),17403, 'Button', '0', 'N/D');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5844 and c.cod_specie = '01222'),16872, 'Button', '0', 'SFAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5844 and c.cod_specie = '01222'),16871, 'Button', '0', 'FAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5844 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5844 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5844 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5845 and c.cod_specie = '01222'),16874, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5845 and c.cod_specie = '01222'),16876, 'TextBox', '0', 'Entro quale data dovranno essere eseguite?');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5845 and c.cod_specie = '01222'),16875, 'TextArea', '0', 'Se si quali:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5845 and c.cod_specie = '01222'),16873, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5845 and c.cod_specie = '01222'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5846 and c.cod_specie = '01222'),16878, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5846 and c.cod_specie = '01222'),16879, 'TextArea', '0', 'Se altro specificare:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5846 and c.cod_specie = '01222'),16877, 'CheckBoxList', ' Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5846 and c.cod_specie = '01222'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5846 and c.cod_specie = '01222'),0, '0', '0', '0');


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

-- Modifico unico campo numerico nel tipo number

update biosicurezza_risposte set tipo = 'number' where id_domanda in 
(select id from biosicurezza_domande where domanda ilike '%Numero%' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01')))


-- Bonifica accenti e apostrofi
update biosicurezza_domande set domanda = replace(domanda, 'lallegato', 'l''allegato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lallegato%');
update biosicurezza_domande set domanda = replace(domanda, 'Lallevamento', 'L''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'Lazienda', 'L''azienda') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lazienda%');
update biosicurezza_domande set domanda = replace(domanda, 'e posto', 'e'' posto') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e posto%');
update biosicurezza_domande set domanda = replace(domanda, 'e dotata', 'e'' dotata') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e dotata%');
update biosicurezza_domande set domanda = replace(domanda, 'lingresso', 'l''ingresso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lingresso%');
update biosicurezza_domande set domanda = replace(domanda, 'E presente', 'E'' presente') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E presente%');
update biosicurezza_domande set domanda = replace(domanda, 'unarea', 'un''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%unarea%');
update biosicurezza_domande set domanda = replace(domanda, 'E vietato', 'E'' vietato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E vietato%');
update biosicurezza_domande set domanda = replace(domanda, 'Larea', 'L''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Larea%');
update biosicurezza_domande set domanda = replace(domanda, 'e mantenuta', 'e'' mantenuta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e mantenuta%');
update biosicurezza_domande set domanda = replace(domanda, 'dellaccesso', 'dell''accesso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellaccesso%');
update biosicurezza_domande set domanda = replace(domanda, 'allallevamento', 'all''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%allallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'lavvenuta', 'l''avvenuta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lavvenuta%');
update biosicurezza_domande set domanda = replace(domanda, 'allesterno', 'all''esterno') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%allesterno%');
update biosicurezza_domande set domanda = replace(domanda, 'dellarea', 'dell''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellarea%');
update biosicurezza_domande set domanda = replace(domanda, 'e idonea', 'e'' idonea') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e idonea%');
update biosicurezza_domande set domanda = replace(domanda, 'lalimentazione', 'l''alimentazione') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lalimentazione%');
update biosicurezza_domande set domanda = replace(domanda, 'e garantita', 'e'' garantita') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e garantita%');
update biosicurezza_domande set domanda = replace(domanda, ' piu ', ' piu'' ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '% piu %');
update biosicurezza_domande set domanda = replace(domanda, 'Lesame', 'L''esame') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lesame%');
update biosicurezza_domande set domanda = replace(domanda, 'E prevista', 'E'' prevista') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E prevista%');
update biosicurezza_domande set domanda = replace(domanda, 'lesecuzione', 'l''esecuzione') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lesecuzione%');
update biosicurezza_domande set domanda = replace(domanda, 'E richiesta', 'E'' richiesta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E richiesta%');
update biosicurezza_domande set domanda = replace(domanda, 'limpossibilita', 'l''impossibilita') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%limpossibilita%');
update biosicurezza_domande set domanda = replace(domanda, 'dellallevamento', 'dell''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'tracciabilita?', 'tracciabilita''?') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%tracciabilita?%');
update biosicurezza_domande set domanda = replace(domanda, 'E vietata', 'E'' vietata') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E vietata%');
update biosicurezza_domande set domanda = replace(domanda, 'E previsto', 'E'' previsto') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E previsto%');

-- Aggiorno ordine "Se altro...". OPERAZIONE AD HOC
update biosicurezza_risposte set ordine = 4 where id_classyfarm = 16877;
update biosicurezza_risposte set ordine = 5 where id_classyfarm = 16879;


-- 1: Eseguire la chiamata ai webservice di classyfarm per ottenere i template delle checklist

-- Chiamare il servizio login da postman per avere il token
https://cf-function02-test.azurewebsites.net/api/autenticazione/login

{"username": "regcampania_CF","password": "yrq5nKqSr8CdOPOLmMxi4h/HtPM="}

-- Usare il token su chrome (estensione MOD HEADER, parametro x-api-key)

-- Collegarsi a http://cf-function02-test.azurewebsites.net/api/swagger/ui e nella sezione /api/checklist/getTemplateCL fare "try it out" usando il codice classyfarm 106

{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "5847",
      "DescrDomanda": "Tipologia di suini presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "16880",
          "ControlType": "CheckBoxList",
          "ListItems": " Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1",
          "TemaplateName": "Categorie presenti"
        }
      ]
    },
    {
      "IDDomanda": "5848",
      "DescrDomanda": "Ndeg totale animali (capienza)",
      "ListaRisposte": [
        {
          "IDRisposta": "16881",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "5849",
      "DescrDomanda": "NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :",
      "ListaRisposte": [
        {
          "IDRisposta": "16882",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "16883",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "5850",
      "DescrDomanda": "Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2023/594?",
      "ListaRisposte": [
        {
          "IDRisposta": "16885",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "16884",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "5851",
      "DescrDomanda": "E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a IX dellallegato III Regolamento (UE) 2023/594?",
      "ListaRisposte": [
        {
          "IDRisposta": "16886",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        },
        {
          "IDRisposta": "16887",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        }
      ]
    },
    {
      "IDDomanda": "5852",
      "DescrDomanda": "Veterinario Ufficiale ispettore",
      "ListaRisposte": [
        {
          "IDRisposta": "16888",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "5938",
      "DescrDomanda": "Ndeg totale animali presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "17457",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Ndeg"
        }
      ]
    },
    {
      "IDDomanda": "5853",
      "DescrDomanda": "1. Lazienda e dotata di unarea apposita, posta prima della barriera di entrata per la sosta dei veicoli del personale dellallevamento e/o visitatori? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16892",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16891",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16890",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16889",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5854",
      "DescrDomanda": "2. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16893",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16894",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16895",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5855",
      "DescrDomanda": "3. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16898",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16897",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16896",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5857",
      "DescrDomanda": "4. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?",
      "ListaRisposte": [
        {
          "IDRisposta": "16903",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16904",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16905",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5858",
      "DescrDomanda": "5. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?",
      "ListaRisposte": [
        {
          "IDRisposta": "16908",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16907",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16906",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5859",
      "DescrDomanda": "6. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16909",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16910",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16911",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5860",
      "DescrDomanda": "7. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ",
      "ListaRisposte": [
        {
          "IDRisposta": "16914",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16913",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16912",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5861",
      "DescrDomanda": "8. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16915",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16916",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16917",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5862",
      "DescrDomanda": "9. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?",
      "ListaRisposte": [
        {
          "IDRisposta": "16919",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16920",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16918",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5863",
      "DescrDomanda": "10. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?",
      "ListaRisposte": [
        {
          "IDRisposta": "16923",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16922",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16921",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5864",
      "DescrDomanda": "11. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?",
      "ListaRisposte": [
        {
          "IDRisposta": "16924",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16925",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16926",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5865",
      "DescrDomanda": "12. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?",
      "ListaRisposte": [
        {
          "IDRisposta": "16929",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16928",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16927",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5866",
      "DescrDomanda": "13. Larea tutta intorno ai ricoveri degli animali e mantenuta pulita, coperta da ghiaia o con erba sfalciata, libera da ingombri, oggetti, attrezzature, macchinari, veicoli, ecc. estranei alla funzionalita e gestione dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "16930",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16931",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16933",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16932",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5867",
      "DescrDomanda": "14. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16936",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16935",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16934",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5868",
      "DescrDomanda": "15. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "16938",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16937",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16939",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5869",
      "DescrDomanda": "16. E previsto e documentato un piano di derattizzazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16942",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16943",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16940",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16941",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5871",
      "DescrDomanda": "18. E previsto e documentato un piano di disinfestazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16949",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16948",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16951",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5872",
      "DescrDomanda": "19. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "16955",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16954",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16952",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16953",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5873",
      "DescrDomanda": "20. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?",
      "ListaRisposte": [
        {
          "IDRisposta": "16957",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16956",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16958",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5896",
      "DescrDomanda": "43. Le aree sottostanti i silos dei mangimi consentono una efficace pulizia e il deflusso delle acque di lavaggio?",
      "ListaRisposte": [
        {
          "IDRisposta": "17038",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17036",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17039",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17037",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5874",
      "DescrDomanda": "21. Esiste un piano di profilassi vaccinale documentato?",
      "ListaRisposte": [
        {
          "IDRisposta": "16962",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16961",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16959",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16960",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5875",
      "DescrDomanda": "22. Esiste una prassi igienica e sanitaria di gestione delle attrezzature utilizzate per la profilassi vaccinale e i trattamenti terapeutici individuali o di gruppo?",
      "ListaRisposte": [
        {
          "IDRisposta": "16964",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16963",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16965",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16966",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5876",
      "DescrDomanda": "23. Sono presenti eventuali risultati delle analisi, ufficiali o effettuate in autocontrollo, su campioni prelevati da animali o da altre matrici che abbiano rilevanza per la salute umana e animale?",
      "ListaRisposte": [
        {
          "IDRisposta": "16970",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16969",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16967",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16968",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5877",
      "DescrDomanda": "24. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "16972",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16971",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16973",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16974",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5878",
      "DescrDomanda": "25. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?",
      "ListaRisposte": [
        {
          "IDRisposta": "16977",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16975",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16976",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5879",
      "DescrDomanda": "26. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?",
      "ListaRisposte": [
        {
          "IDRisposta": "16979",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16978",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16980",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5880",
      "DescrDomanda": "27. E presente una documentazione attestante lavvenuta disinfezione degli automezzi?",
      "ListaRisposte": [
        {
          "IDRisposta": "16984",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16983",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16981",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16982",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5881",
      "DescrDomanda": "28. Lallevamento dispone di una piazzola per la pulizia e la disinfezione degli automezzi localizzata in prossimita dellaccesso allallevamento o, in ogni caso, separata dallarea aziendale destinata alla stabulazione e al governo animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16986",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16985",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16987",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16988",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5882",
      "DescrDomanda": "29. Sono presenti apparecchiature fisse a pressione per la pulizia, il lavaggio e la disinfezione degli automezzi in entrata?",
      "ListaRisposte": [
        {
          "IDRisposta": "16992",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "16991",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "16989",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16990",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5883",
      "DescrDomanda": "30. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?",
      "ListaRisposte": [
        {
          "IDRisposta": "16994",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16993",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16995",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5884",
      "DescrDomanda": "31. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "16998",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "16996",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "16997",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5885",
      "DescrDomanda": "32. Esiste una rampa/corridoio di carico/scarico degli animali vivi, fissa o mobile?",
      "ListaRisposte": [
        {
          "IDRisposta": "17000",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "16999",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17002",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17001",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5886",
      "DescrDomanda": "33. Il carico/scarico dei suini vivi avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "17005",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17003",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17004",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5887",
      "DescrDomanda": "34. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17007",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17006",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17008",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5888",
      "DescrDomanda": "35. Il carico degli scarti avviene con monocarico?",
      "ListaRisposte": [
        {
          "IDRisposta": "17012",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17011",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17009",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17010",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5889",
      "DescrDomanda": "36. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17014",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17013",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17015",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17016",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5890",
      "DescrDomanda": "37. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17019",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17017",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17018",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5891",
      "DescrDomanda": "38.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17021",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17020",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17022",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5892",
      "DescrDomanda": "39. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?",
      "ListaRisposte": [
        {
          "IDRisposta": "17025",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17023",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17024",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5893",
      "DescrDomanda": "40. Qualora le carcasse dei suinetti siano temporaneamente immagazzinate nei locali di allevamento, in attesa del loro allontanamento, i contenitori utilizzati sono adeguatamente sigillati ed idonei alla conservazione?",
      "ListaRisposte": [
        {
          "IDRisposta": "17027",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17026",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17029",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17028",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5894",
      "DescrDomanda": "41. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17032",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17030",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17031",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5895",
      "DescrDomanda": "42. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?",
      "ListaRisposte": [
        {
          "IDRisposta": "17034",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17033",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17035",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5897",
      "DescrDomanda": "44. Sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17041",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17040",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17042",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17043",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        }
      ]
    },
    {
      "IDDomanda": "5898",
      "DescrDomanda": "45. Se sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte e presente il nulla-osta al loro utilizzo ed e garantita la loro tracciabilita?",
      "ListaRisposte": [
        {
          "IDRisposta": "17047",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17046",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17044",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17045",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5902",
      "DescrDomanda": "49. I terreni attigui allazienda sono utilizzati per lo spandimento di liquami provenienti da altre aziende?",
      "ListaRisposte": [
        {
          "IDRisposta": "17057",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17060",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo NA:"
        },
        {
          "IDRisposta": "17058",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17059",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5899",
      "DescrDomanda": "46. Il punto di pesa e di esclusivo utilizzo dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17049",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17048",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17050",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5900",
      "DescrDomanda": "47. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17051",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17053",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17052",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5901",
      "DescrDomanda": "48. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17056",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17054",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17055",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5903",
      "DescrDomanda": "50. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?",
      "ListaRisposte": [
        {
          "IDRisposta": "17063",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17061",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17062",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5905",
      "DescrDomanda": "51. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?",
      "ListaRisposte": [
        {
          "IDRisposta": "17067",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17069",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17068",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5906",
      "DescrDomanda": "52. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?",
      "ListaRisposte": [
        {
          "IDRisposta": "17071",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17072",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17070",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5907",
      "DescrDomanda": "53. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "17073",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17075",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17074",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5908",
      "DescrDomanda": "54. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "17077",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17078",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17076",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "6000",
      "DescrDomanda": "17. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?",
      "ListaRisposte": [
        {
          "IDRisposta": "17468",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17469",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17466",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17467",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5909",
      "DescrDomanda": "55. La rimonta viene effettuata ad opera di riproduttori esterni?",
      "ListaRisposte": [
        {
          "IDRisposta": "17080",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17079",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17082",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17431",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17081",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5917",
      "DescrDomanda": "63. E prevista lesecuzione pianificata di accertamenti diagnostici negli animali in quarantena? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17439",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17113",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17111",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17114",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17112",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5910",
      "DescrDomanda": "56. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17432",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17086",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17083",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17084",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5911",
      "DescrDomanda": "57. Viene praticato il tutto pieno/tutto vuoto e un idoneo periodo di vuoto sanitario?",
      "ListaRisposte": [
        {
          "IDRisposta": "17088",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17087",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17090",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17433",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17089",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5912",
      "DescrDomanda": "58. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "17434",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17094",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17091",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17092",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5913",
      "DescrDomanda": "59. I locali di quarantena dispongono di fossa/e separata/e?",
      "ListaRisposte": [
        {
          "IDRisposta": "17096",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17095",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17098",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17435",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17097",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5914",
      "DescrDomanda": "60. I locali di quarantena dispongono di ingresso/i separato/i?",
      "ListaRisposte": [
        {
          "IDRisposta": "17436",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17102",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17099",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17100",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5915",
      "DescrDomanda": "61. Sono disponibili attrezzature destinate esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "17104",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17103",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17106",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17437",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5916",
      "DescrDomanda": "62. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?",
      "ListaRisposte": [
        {
          "IDRisposta": "17438",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17110",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17107",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17108",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5918",
      "DescrDomanda": "64. E richiesta e disponibile alle aziende di provenienza una documentazione che attesti lo stato sanitario degli animali di nuova introduzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "17440",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17117",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17118",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17115",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17116",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5919",
      "DescrDomanda": "65. La rimonta dei riproduttori viene effettuata con cadenza superiore a 3 mesi?",
      "ListaRisposte": [
        {
          "IDRisposta": "17120",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17119",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17122",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17121",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17441",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5920",
      "DescrDomanda": "66.  Lesame ecografico viene effettuato da operatori esterni?",
      "ListaRisposte": [
        {
          "IDRisposta": "17442",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17125",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17126",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17123",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17124",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5921",
      "DescrDomanda": "67. Nel caso in cui si pratichi la fecondazione artificiale il materiale seminale questo proviene da centri di raccolta seme autorizzati?",
      "ListaRisposte": [
        {
          "IDRisposta": "17128",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17127",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17130",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17129",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17443",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5922",
      "DescrDomanda": "68. Nel caso in cui si pratichi la monta naturale i verri sono stati sottoposti agli accertamenti diagnostici previsti per i riproduttori maschi della specie suina?",
      "ListaRisposte": [
        {
          "IDRisposta": "17444",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17133",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17134",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17131",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17132",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5923",
      "DescrDomanda": "69. I suinetti in sala parto sono destinati a piu di due allevamenti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17136",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17135",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17138",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17137",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17445",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5924",
      "DescrDomanda": "70. I suini provengono da piu di un allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17446",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17141",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17142",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17139",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17140",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5925",
      "DescrDomanda": "71. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17144",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17143",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17146",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17145",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17447",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5926",
      "DescrDomanda": "72. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17448",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17149",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17150",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17147",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17148",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5927",
      "DescrDomanda": "73. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17152",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17151",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17154",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17397",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5928",
      "DescrDomanda": "75. I suini a fine ciclo sono destinati a piu di 1  allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17450",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17157",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17158",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17155",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17156",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5944",
      "DescrDomanda": "74. I capannoni sono suddivisi in settori da pareti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17210",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17449",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17209",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17208",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17211",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5929",
      "DescrDomanda": "76. I suini provengono da piu di un allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17161",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17451",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17162",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17160",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17159",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5930",
      "DescrDomanda": "77. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17163",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17164",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17166",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17452",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17165",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5931",
      "DescrDomanda": "78. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17453",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17169",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17170",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17168",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17167",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5932",
      "DescrDomanda": "79. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17171",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17172",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17174",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17173",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        }
      ]
    },
    {
      "IDDomanda": "5933",
      "DescrDomanda": "81. I suini a fine ciclo sono destinati a solo macelli industriali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17177",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17455",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17178",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17176",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17175",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5945",
      "DescrDomanda": "80. I capannoni sono suddivisi in settori da pareti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17454",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17214",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17213",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17215",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17212",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5934",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "17179",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        },
        {
          "IDRisposta": "17180",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "5935",
      "DescrDomanda": "ESITO DEL CONTROLLO",
      "ListaRisposte": [
        {
          "IDRisposta": "17182",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SFAVOREVOLE"
        },
        {
          "IDRisposta": "17181",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "FAVOREVOLE"
        }
      ]
    },
    {
      "IDDomanda": "5936",
      "DescrDomanda": "Sono state assegnate delle prescrizioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "17184",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17186",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Entro quale data dovranno essere eseguite?"
        },
        {
          "IDRisposta": "17185",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se si quali:"
        },
        {
          "IDRisposta": "17183",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5937",
      "DescrDomanda": "Sono state applicate delle sanzioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "17188",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "17189",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se altro specificare:"
        },
        {
          "IDRisposta": "17187",
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

-- creo le sezioni

insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('VALUTAZIONE FINALE E PROVVEDIMENTI', 5, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('DATI AGGIUNTIVI', 0, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO',4 , (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE', 1, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE RIPRODUZIONE E QUARANTENA', 2, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_alta-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO', 3, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_alta-01'));

-- creo le domande

insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 0),1,5847, 'Tipologia di suini presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 0),2,5848, 'Ndeg totale animali (capienza)');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 0),3,5849, 'NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 5),4,5850, 'Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2023/594?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 0),5,5851, 'E presente un piano di biosicurezza approvato dal Servizio veterinario che tenga conto del profilo dello stabilimento, che comprenda almeno i relativi punti del comma i) da I a IX dellallegato III Regolamento (UE) 2023/594?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 0),6,5852, 'Veterinario Ufficiale ispettore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 0),7,5938, 'Ndeg totale animali presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),8,5853, '1. Lazienda e dotata di unarea apposita, posta prima della barriera di entrata per la sosta dei veicoli del personale dellallevamento e/o visitatori? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),9,5854, '2. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),10,5855, '3. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),11,5857, '4. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),12,5858, '5. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),13,5859, '6. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),14,5860, '7. E vietato al personale/visitatori portare in azienda alimenti per uso personale? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),15,5861, '8. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),16,5862, '9. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),17,5863, '10. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),18,5864, '11. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzioni di continuita, pulibili e disinfettabili in modo efficace?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),19,5865, '12. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),20,5866, '13. Larea tutta intorno ai ricoveri degli animali e mantenuta pulita, coperta da ghiaia o con erba sfalciata, libera da ingombri, oggetti, attrezzature, macchinari, veicoli, ecc. estranei alla funzionalita e gestione dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),21,5867, '14. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),22,5868, '15. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),23,5869, '16. E previsto e documentato un piano di derattizzazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),24,6000, '17. La derattizzazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),25,5871, '18. E previsto e documentato un piano di disinfestazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),26,5872, '19. La disinfestazione viene effettuata ad opera di una ditta specializzata esterna?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),27,5873, '20. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),28,5874, '21. Esiste un piano di profilassi vaccinale documentato?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),29,5875, '22. Esiste una prassi igienica e sanitaria di gestione delle attrezzature utilizzate per la profilassi vaccinale e i trattamenti terapeutici individuali o di gruppo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),30,5876, '23. Sono presenti eventuali risultati delle analisi, ufficiali o effettuate in autocontrollo, su campioni prelevati da animali o da altre matrici che abbiano rilevanza per la salute umana e animale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),31,5877, '24. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),32,5878, '25. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),33,5879, '26. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),34,5880, '27. E presente una documentazione attestante lavvenuta disinfezione degli automezzi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),35,5881, '28. Lallevamento dispone di una piazzola per la pulizia e la disinfezione degli automezzi localizzata in prossimita dellaccesso allallevamento o, in ogni caso, separata dallarea aziendale destinata alla stabulazione e al governo animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),36,5882, '29. Sono presenti apparecchiature fisse a pressione per la pulizia, il lavaggio e la disinfezione degli automezzi in entrata?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),37,5883, '30. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),38,5884, '31. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),39,5885, '32. Esiste una rampa/corridoio di carico/scarico degli animali vivi, fissa o mobile?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),40,5886, '33. Il carico/scarico dei suini vivi avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),41,5887, '34. Il carico degli scarti avviene allesterno larea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),42,5888, '35. Il carico degli scarti avviene con monocarico?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),43,5889, '36. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),44,5890, '37. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),45,5891, '38.Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),46,5892, '39. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),47,5893, '40. Qualora le carcasse dei suinetti siano temporaneamente immagazzinate nei locali di allevamento, in attesa del loro allontanamento, i contenitori utilizzati sono adeguatamente sigillati ed idonei alla conservazione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),48,5894, '41. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),49,5895, '42. I locali, edifici o  le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),50,5896, '43. Le aree sottostanti i silos dei mangimi consentono una efficace pulizia e il deflusso delle acque di lavaggio?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),51,5897, '44. Sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),52,5898, '45. Se sono utilizzati per lalimentazione degli animali dei prodotti derivati dal latte e presente il nulla-osta al loro utilizzo ed e garantita la loro tracciabilita?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),53,5899, '46. Il punto di pesa e di esclusivo utilizzo dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),54,5900, '47. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),55,5901, '48. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),56,5902, '49. I terreni attigui allazienda sono utilizzati per lo spandimento di liquami provenienti da altre aziende?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),57,5903, '50. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),58,5905, '51. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),59,5906, '52. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),60,5907, '53. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 1),61,5908, '54. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),62,5909, '55. La rimonta viene effettuata ad opera di riproduttori esterni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),63,5910, '56. Lallevamento dispone di locali separati fisicamente e funzionalmente per la quarantena dei riproduttori di nuova introduzione? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),64,5911, '57. Viene praticato il tutto pieno/tutto vuoto e un idoneo periodo di vuoto sanitario?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),65,5912, '58. Il personale non accudisce altri animali oltre a quelli della quarantena, diversamente e presente una zona filtro specifica per la quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),66,5913, '59. I locali di quarantena dispongono di fossa/e separata/e?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),67,5914, '60. I locali di quarantena dispongono di ingresso/i separato/i?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),68,5915, '61. Sono disponibili attrezzature destinate esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),69,5916, '62. Sono disponibili indumenti per il personale o monouso (tute e calzari) destinati esclusivamente alla quarantena?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),70,5917, '63. E prevista lesecuzione pianificata di accertamenti diagnostici negli animali in quarantena? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),71,5918, '64. E richiesta e disponibile alle aziende di provenienza una documentazione che attesti lo stato sanitario degli animali di nuova introduzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),72,5919, '65. La rimonta dei riproduttori viene effettuata con cadenza superiore a 3 mesi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),73,5920, '66.  Lesame ecografico viene effettuato da operatori esterni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),74,5921, '67. Nel caso in cui si pratichi la fecondazione artificiale il materiale seminale questo proviene da centri di raccolta seme autorizzati?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),75,5922, '68. Nel caso in cui si pratichi la monta naturale i verri sono stati sottoposti agli accertamenti diagnostici previsti per i riproduttori maschi della specie suina?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 2),76,5923, '69. I suinetti in sala parto sono destinati a piu di due allevamenti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 3),77,5924, '70. I suini provengono da piu di un allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 3),78,5925, '71. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 3),79,5926, '72. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 3),80,5927, '73. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 3),81,5944, '74. I capannoni sono suddivisi in settori da pareti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 3),82,5928, '75. I suini a fine ciclo sono destinati a piu di 1  allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 4),83,5929, '76. I suini provengono da piu di un allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 4),84,5930, '77. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per allevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 4),85,5931, '78. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per capannone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 4),86,5932, '79. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 4),87,5945, '80. I capannoni sono suddivisi in settori da pareti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 4),88,5933, '81. I suini a fine ciclo sono destinati a solo macelli industriali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 5),89,5935, 'ESITO DEL CONTROLLO');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 5),90,5936, 'Sono state assegnate delle prescrizioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01221' and m.versione =2023 and s.ordine = 5),91,5937, 'Sono state applicate delle sanzioni?');

-- bonifico domande. OPERAZIONI AD HOC
delete from biosicurezza_domande where domanda ilike 'Documento 1';
update biosicurezza_domande set domanda = 'Numero totale degli animali (capienza)' where domanda ilike 'Ndeg totale animali (capienza)';
update biosicurezza_domande set domanda = 'Numero totale animali presenti' where domanda ilike 'Ndeg totale animali presenti';
update biosicurezza_domande set ordine=5, id_sezione=109 where id_classyfarm= 5849; -- spostamento di nome e cognome
update biosicurezza_domande set ordine=5, id_sezione=106 where id_classyfarm= 5849; -- spostamento di nome e cognome
update biosicurezza_domande set ordine=5, id_sezione=107 where id_classyfarm= 5850;

update biosicurezza_domande set domanda = replace(domanda, 'lallegato', 'l''allegato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lallegato%');
update biosicurezza_domande set domanda = replace(domanda, 'Lallevamento', 'L''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'Lazienda', 'L''azienda') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lazienda%');
update biosicurezza_domande set domanda = replace(domanda, 'e posto', 'e'' posto') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e posto%');
update biosicurezza_domande set domanda = replace(domanda, 'e dotata', 'e'' dotata') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e dotata%');
update biosicurezza_domande set domanda = replace(domanda, 'lingresso', 'l''ingresso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lingresso%');
update biosicurezza_domande set domanda = replace(domanda, 'E presente', 'E'' presente') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E presente%');
update biosicurezza_domande set domanda = replace(domanda, 'unarea', 'un''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%unarea%');
update biosicurezza_domande set domanda = replace(domanda, 'E vietato', 'E'' vietato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E vietato%');
update biosicurezza_domande set domanda = replace(domanda, 'Larea', 'L''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Larea%');
update biosicurezza_domande set domanda = replace(domanda, 'e mantenuta', 'e'' mantenuta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e mantenuta%');
update biosicurezza_domande set domanda = replace(domanda, 'dellaccesso', 'dell''accesso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellaccesso%');
update biosicurezza_domande set domanda = replace(domanda, 'allallevamento', 'all''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%allallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'lavvenuta', 'l''avvenuta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lavvenuta%');
update biosicurezza_domande set domanda = replace(domanda, 'allesterno', 'all''esterno') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%allesterno%');
update biosicurezza_domande set domanda = replace(domanda, 'dellarea', 'dell''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellarea%');
update biosicurezza_domande set domanda = replace(domanda, 'e idonea', 'e'' idonea') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e idonea%');
update biosicurezza_domande set domanda = replace(domanda, 'lalimentazione', 'l''alimentazione') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lalimentazione%');
update biosicurezza_domande set domanda = replace(domanda, 'e garantita', 'e'' garantita') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e garantita%');
update biosicurezza_domande set domanda = replace(domanda, ' piu ', ' piu'' ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '% piu %');
update biosicurezza_domande set domanda = replace(domanda, 'Lesame', 'L''esame') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lesame%');
update biosicurezza_domande set domanda = replace(domanda, 'E prevista', 'E'' prevista') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E prevista%');
update biosicurezza_domande set domanda = replace(domanda, 'lesecuzione', 'l''esecuzione') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lesecuzione%');
update biosicurezza_domande set domanda = replace(domanda, 'E richiesta', 'E'' richiesta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E richiesta%');
update biosicurezza_domande set domanda = replace(domanda, 'limpossibilita', 'l''impossibilita') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%limpossibilita%');
update biosicurezza_domande set domanda = replace(domanda, 'dellallevamento', 'dell''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'tracciabilita?', 'tracciabilita''?') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%tracciabilita?%');
update biosicurezza_domande set domanda = replace(domanda, 'E vietata', 'E'' vietata') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E vietata%');
update biosicurezza_domande set domanda = replace(domanda, 'E previsto', 'E'' previsto') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E previsto%');

update biosicurezza_domande set ordine = 1 where id_classyfarm = 5848;
update biosicurezza_domande set ordine = 2 where id_classyfarm = 5938;
update biosicurezza_domande set ordine = 3 where id_classyfarm = 5852;
update biosicurezza_domande set ordine = 4 where id_classyfarm = 5847;
update biosicurezza_domande set ordine = 5 where id_classyfarm = 5850;
update biosicurezza_domande set ordine = 6 where id_classyfarm = 5851;

-- creo risposte

insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5847 and c.cod_specie = '01221'),16880, 'CheckBoxList', ' Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1', 'Categorie presenti');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5847 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5847 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5847 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5847 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5848 and c.cod_specie = '01221'),16881, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5848 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5848 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5848 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5848 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5849 and c.cod_specie = '01221'),16882, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5849 and c.cod_specie = '01221'),16883, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5849 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5849 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5849 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5850 and c.cod_specie = '01221'),16885, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5850 and c.cod_specie = '01221'),16884, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5850 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5850 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5850 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5851 and c.cod_specie = '01221'),16886, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5851 and c.cod_specie = '01221'),16887, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5851 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5851 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5851 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5852 and c.cod_specie = '01221'),16888, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5852 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5852 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5852 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5852 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5938 and c.cod_specie = '01221'),17457, 'TextBox', '0', 'Ndeg');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5938 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5938 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5938 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5938 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5853 and c.cod_specie = '01221'),16892, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5853 and c.cod_specie = '01221'),16891, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5853 and c.cod_specie = '01221'),16890, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5853 and c.cod_specie = '01221'),16889, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5853 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5854 and c.cod_specie = '01221'),16893, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5854 and c.cod_specie = '01221'),16894, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5854 and c.cod_specie = '01221'),16895, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5854 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5854 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5855 and c.cod_specie = '01221'),16898, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5855 and c.cod_specie = '01221'),16897, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5855 and c.cod_specie = '01221'),16896, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5855 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5855 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5857 and c.cod_specie = '01221'),16903, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5857 and c.cod_specie = '01221'),16904, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5857 and c.cod_specie = '01221'),16905, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5857 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5857 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5858 and c.cod_specie = '01221'),16908, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5858 and c.cod_specie = '01221'),16907, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5858 and c.cod_specie = '01221'),16906, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5858 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5858 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5859 and c.cod_specie = '01221'),16909, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5859 and c.cod_specie = '01221'),16910, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5859 and c.cod_specie = '01221'),16911, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5859 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5859 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5860 and c.cod_specie = '01221'),16914, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5860 and c.cod_specie = '01221'),16913, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5860 and c.cod_specie = '01221'),16912, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5860 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5860 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5861 and c.cod_specie = '01221'),16915, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5861 and c.cod_specie = '01221'),16916, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5861 and c.cod_specie = '01221'),16917, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5861 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5861 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5862 and c.cod_specie = '01221'),16919, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5862 and c.cod_specie = '01221'),16920, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5862 and c.cod_specie = '01221'),16918, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5862 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5862 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5863 and c.cod_specie = '01221'),16923, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5863 and c.cod_specie = '01221'),16922, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5863 and c.cod_specie = '01221'),16921, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5863 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5863 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5864 and c.cod_specie = '01221'),16924, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5864 and c.cod_specie = '01221'),16925, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5864 and c.cod_specie = '01221'),16926, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5864 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5864 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5865 and c.cod_specie = '01221'),16929, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5865 and c.cod_specie = '01221'),16928, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5865 and c.cod_specie = '01221'),16927, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5865 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5865 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5866 and c.cod_specie = '01221'),16930, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5866 and c.cod_specie = '01221'),16931, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5866 and c.cod_specie = '01221'),16933, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5866 and c.cod_specie = '01221'),16932, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5866 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5867 and c.cod_specie = '01221'),16936, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5867 and c.cod_specie = '01221'),16935, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5867 and c.cod_specie = '01221'),16934, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5867 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5867 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5868 and c.cod_specie = '01221'),16938, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5868 and c.cod_specie = '01221'),16937, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5868 and c.cod_specie = '01221'),16939, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5868 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5868 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5869 and c.cod_specie = '01221'),16942, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5869 and c.cod_specie = '01221'),16943, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5869 and c.cod_specie = '01221'),16940, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5869 and c.cod_specie = '01221'),16941, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5869 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5871 and c.cod_specie = '01221'),16949, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5871 and c.cod_specie = '01221'),16948, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5871 and c.cod_specie = '01221'),16951, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5871 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5871 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5872 and c.cod_specie = '01221'),16955, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5872 and c.cod_specie = '01221'),16954, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5872 and c.cod_specie = '01221'),16952, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5872 and c.cod_specie = '01221'),16953, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5872 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5873 and c.cod_specie = '01221'),16957, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5873 and c.cod_specie = '01221'),16956, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5873 and c.cod_specie = '01221'),16958, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5873 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5873 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5896 and c.cod_specie = '01221'),17038, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5896 and c.cod_specie = '01221'),17036, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5896 and c.cod_specie = '01221'),17039, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5896 and c.cod_specie = '01221'),17037, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5896 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5874 and c.cod_specie = '01221'),16962, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5874 and c.cod_specie = '01221'),16961, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5874 and c.cod_specie = '01221'),16959, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5874 and c.cod_specie = '01221'),16960, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5874 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5875 and c.cod_specie = '01221'),16964, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5875 and c.cod_specie = '01221'),16963, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5875 and c.cod_specie = '01221'),16965, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5875 and c.cod_specie = '01221'),16966, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5875 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5876 and c.cod_specie = '01221'),16970, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5876 and c.cod_specie = '01221'),16969, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5876 and c.cod_specie = '01221'),16967, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5876 and c.cod_specie = '01221'),16968, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5876 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5877 and c.cod_specie = '01221'),16972, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5877 and c.cod_specie = '01221'),16971, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5877 and c.cod_specie = '01221'),16973, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5877 and c.cod_specie = '01221'),16974, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5877 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5878 and c.cod_specie = '01221'),16977, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5878 and c.cod_specie = '01221'),16975, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5878 and c.cod_specie = '01221'),16976, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5878 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5878 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5879 and c.cod_specie = '01221'),16979, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5879 and c.cod_specie = '01221'),16978, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5879 and c.cod_specie = '01221'),16980, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5879 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5879 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5880 and c.cod_specie = '01221'),16984, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5880 and c.cod_specie = '01221'),16983, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5880 and c.cod_specie = '01221'),16981, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5880 and c.cod_specie = '01221'),16982, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5880 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5881 and c.cod_specie = '01221'),16986, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5881 and c.cod_specie = '01221'),16985, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5881 and c.cod_specie = '01221'),16987, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5881 and c.cod_specie = '01221'),16988, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5881 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5882 and c.cod_specie = '01221'),16992, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5882 and c.cod_specie = '01221'),16991, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5882 and c.cod_specie = '01221'),16989, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5882 and c.cod_specie = '01221'),16990, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5882 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5883 and c.cod_specie = '01221'),16994, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5883 and c.cod_specie = '01221'),16993, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5883 and c.cod_specie = '01221'),16995, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5883 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5883 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5884 and c.cod_specie = '01221'),16998, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5884 and c.cod_specie = '01221'),16996, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5884 and c.cod_specie = '01221'),16997, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5884 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5884 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5885 and c.cod_specie = '01221'),17000, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5885 and c.cod_specie = '01221'),16999, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5885 and c.cod_specie = '01221'),17002, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5885 and c.cod_specie = '01221'),17001, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5885 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5886 and c.cod_specie = '01221'),17005, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5886 and c.cod_specie = '01221'),17003, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5886 and c.cod_specie = '01221'),17004, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5886 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5886 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5887 and c.cod_specie = '01221'),17007, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5887 and c.cod_specie = '01221'),17006, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5887 and c.cod_specie = '01221'),17008, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5887 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5887 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5888 and c.cod_specie = '01221'),17012, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5888 and c.cod_specie = '01221'),17011, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5888 and c.cod_specie = '01221'),17009, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5888 and c.cod_specie = '01221'),17010, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5888 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5889 and c.cod_specie = '01221'),17014, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5889 and c.cod_specie = '01221'),17013, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5889 and c.cod_specie = '01221'),17015, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5889 and c.cod_specie = '01221'),17016, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5889 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5890 and c.cod_specie = '01221'),17019, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5890 and c.cod_specie = '01221'),17017, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5890 and c.cod_specie = '01221'),17018, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5890 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5890 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5891 and c.cod_specie = '01221'),17021, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5891 and c.cod_specie = '01221'),17020, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5891 and c.cod_specie = '01221'),17022, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5891 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5891 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5892 and c.cod_specie = '01221'),17025, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5892 and c.cod_specie = '01221'),17023, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5892 and c.cod_specie = '01221'),17024, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5892 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5892 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5893 and c.cod_specie = '01221'),17027, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5893 and c.cod_specie = '01221'),17026, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5893 and c.cod_specie = '01221'),17029, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5893 and c.cod_specie = '01221'),17028, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5893 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5894 and c.cod_specie = '01221'),17032, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5894 and c.cod_specie = '01221'),17030, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5894 and c.cod_specie = '01221'),17031, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5894 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5894 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5895 and c.cod_specie = '01221'),17034, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5895 and c.cod_specie = '01221'),17033, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5895 and c.cod_specie = '01221'),17035, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5895 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5895 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5897 and c.cod_specie = '01221'),17041, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5897 and c.cod_specie = '01221'),17040, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5897 and c.cod_specie = '01221'),17042, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5897 and c.cod_specie = '01221'),17043, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5897 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5898 and c.cod_specie = '01221'),17047, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5898 and c.cod_specie = '01221'),17046, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5898 and c.cod_specie = '01221'),17044, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5898 and c.cod_specie = '01221'),17045, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5898 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5902 and c.cod_specie = '01221'),17057, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5902 and c.cod_specie = '01221'),17060, 'TextArea', '0', 'Note - Motivo NA:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5902 and c.cod_specie = '01221'),17058, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5902 and c.cod_specie = '01221'),17059, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5902 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5899 and c.cod_specie = '01221'),17049, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5899 and c.cod_specie = '01221'),17048, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5899 and c.cod_specie = '01221'),17050, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5899 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5899 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5900 and c.cod_specie = '01221'),17051, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5900 and c.cod_specie = '01221'),17053, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5900 and c.cod_specie = '01221'),17052, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5900 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5900 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5901 and c.cod_specie = '01221'),17056, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5901 and c.cod_specie = '01221'),17054, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5901 and c.cod_specie = '01221'),17055, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5901 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5901 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5903 and c.cod_specie = '01221'),17063, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5903 and c.cod_specie = '01221'),17061, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5903 and c.cod_specie = '01221'),17062, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5903 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5903 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5905 and c.cod_specie = '01221'),17067, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5905 and c.cod_specie = '01221'),17069, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5905 and c.cod_specie = '01221'),17068, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5905 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5905 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5906 and c.cod_specie = '01221'),17071, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5906 and c.cod_specie = '01221'),17072, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5906 and c.cod_specie = '01221'),17070, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5906 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5906 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5907 and c.cod_specie = '01221'),17073, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5907 and c.cod_specie = '01221'),17075, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5907 and c.cod_specie = '01221'),17074, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5907 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5907 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5908 and c.cod_specie = '01221'),17077, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5908 and c.cod_specie = '01221'),17078, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5908 and c.cod_specie = '01221'),17076, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5908 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5908 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6000 and c.cod_specie = '01221'),17468, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6000 and c.cod_specie = '01221'),17469, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6000 and c.cod_specie = '01221'),17466, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6000 and c.cod_specie = '01221'),17467, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6000 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5909 and c.cod_specie = '01221'),17080, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5909 and c.cod_specie = '01221'),17079, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5909 and c.cod_specie = '01221'),17082, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5909 and c.cod_specie = '01221'),17431, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5909 and c.cod_specie = '01221'),17081, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5917 and c.cod_specie = '01221'),17439, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5917 and c.cod_specie = '01221'),17113, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5917 and c.cod_specie = '01221'),17111, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5917 and c.cod_specie = '01221'),17114, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5917 and c.cod_specie = '01221'),17112, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5910 and c.cod_specie = '01221'),17432, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5910 and c.cod_specie = '01221'),17086, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5910 and c.cod_specie = '01221'),17083, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5910 and c.cod_specie = '01221'),17084, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5910 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5911 and c.cod_specie = '01221'),17088, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5911 and c.cod_specie = '01221'),17087, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5911 and c.cod_specie = '01221'),17090, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5911 and c.cod_specie = '01221'),17433, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5911 and c.cod_specie = '01221'),17089, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5912 and c.cod_specie = '01221'),17434, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5912 and c.cod_specie = '01221'),17094, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5912 and c.cod_specie = '01221'),17091, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5912 and c.cod_specie = '01221'),17092, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5912 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5913 and c.cod_specie = '01221'),17096, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5913 and c.cod_specie = '01221'),17095, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5913 and c.cod_specie = '01221'),17098, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5913 and c.cod_specie = '01221'),17435, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5913 and c.cod_specie = '01221'),17097, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5914 and c.cod_specie = '01221'),17436, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5914 and c.cod_specie = '01221'),17102, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5914 and c.cod_specie = '01221'),17099, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5914 and c.cod_specie = '01221'),17100, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5914 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5915 and c.cod_specie = '01221'),17104, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5915 and c.cod_specie = '01221'),17103, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5915 and c.cod_specie = '01221'),17106, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5915 and c.cod_specie = '01221'),17437, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5915 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5916 and c.cod_specie = '01221'),17438, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5916 and c.cod_specie = '01221'),17110, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5916 and c.cod_specie = '01221'),17107, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5916 and c.cod_specie = '01221'),17108, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5916 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5918 and c.cod_specie = '01221'),17440, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5918 and c.cod_specie = '01221'),17117, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5918 and c.cod_specie = '01221'),17118, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5918 and c.cod_specie = '01221'),17115, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5918 and c.cod_specie = '01221'),17116, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5919 and c.cod_specie = '01221'),17120, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5919 and c.cod_specie = '01221'),17119, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5919 and c.cod_specie = '01221'),17122, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5919 and c.cod_specie = '01221'),17121, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5919 and c.cod_specie = '01221'),17441, 'Button', '0', 'N/D');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5920 and c.cod_specie = '01221'),17442, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5920 and c.cod_specie = '01221'),17125, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5920 and c.cod_specie = '01221'),17126, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5920 and c.cod_specie = '01221'),17123, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5920 and c.cod_specie = '01221'),17124, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5921 and c.cod_specie = '01221'),17128, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5921 and c.cod_specie = '01221'),17127, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5921 and c.cod_specie = '01221'),17130, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5921 and c.cod_specie = '01221'),17129, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5921 and c.cod_specie = '01221'),17443, 'Button', '0', 'N/D');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5922 and c.cod_specie = '01221'),17444, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5922 and c.cod_specie = '01221'),17133, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5922 and c.cod_specie = '01221'),17134, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5922 and c.cod_specie = '01221'),17131, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5922 and c.cod_specie = '01221'),17132, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5923 and c.cod_specie = '01221'),17136, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5923 and c.cod_specie = '01221'),17135, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5923 and c.cod_specie = '01221'),17138, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5923 and c.cod_specie = '01221'),17137, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5923 and c.cod_specie = '01221'),17445, 'Button', '0', 'N/D');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5924 and c.cod_specie = '01221'),17446, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5924 and c.cod_specie = '01221'),17141, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5924 and c.cod_specie = '01221'),17142, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5924 and c.cod_specie = '01221'),17139, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5924 and c.cod_specie = '01221'),17140, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5925 and c.cod_specie = '01221'),17144, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5925 and c.cod_specie = '01221'),17143, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5925 and c.cod_specie = '01221'),17146, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5925 and c.cod_specie = '01221'),17145, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5925 and c.cod_specie = '01221'),17447, 'Button', '0', 'N/D');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5926 and c.cod_specie = '01221'),17448, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5926 and c.cod_specie = '01221'),17149, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5926 and c.cod_specie = '01221'),17150, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5926 and c.cod_specie = '01221'),17147, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5926 and c.cod_specie = '01221'),17148, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5927 and c.cod_specie = '01221'),17152, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5927 and c.cod_specie = '01221'),17151, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5927 and c.cod_specie = '01221'),17154, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5927 and c.cod_specie = '01221'),17397, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5927 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5928 and c.cod_specie = '01221'),17450, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5928 and c.cod_specie = '01221'),17157, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5928 and c.cod_specie = '01221'),17158, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5928 and c.cod_specie = '01221'),17155, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5928 and c.cod_specie = '01221'),17156, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5944 and c.cod_specie = '01221'),17210, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5944 and c.cod_specie = '01221'),17449, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5944 and c.cod_specie = '01221'),17209, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5944 and c.cod_specie = '01221'),17208, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5944 and c.cod_specie = '01221'),17211, 'TextArea', '0', 'Note - Motivo:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5929 and c.cod_specie = '01221'),17161, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5929 and c.cod_specie = '01221'),17451, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5929 and c.cod_specie = '01221'),17162, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5929 and c.cod_specie = '01221'),17160, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5929 and c.cod_specie = '01221'),17159, 'Button', '0', 'No');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5930 and c.cod_specie = '01221'),17163, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5930 and c.cod_specie = '01221'),17164, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5930 and c.cod_specie = '01221'),17166, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5930 and c.cod_specie = '01221'),17452, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5930 and c.cod_specie = '01221'),17165, 'Button', '0', 'N/A');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5931 and c.cod_specie = '01221'),17453, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5931 and c.cod_specie = '01221'),17169, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5931 and c.cod_specie = '01221'),17170, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5931 and c.cod_specie = '01221'),17168, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5931 and c.cod_specie = '01221'),17167, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5932 and c.cod_specie = '01221'),17171, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5932 and c.cod_specie = '01221'),17172, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5932 and c.cod_specie = '01221'),17174, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5932 and c.cod_specie = '01221'),17173, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5932 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5933 and c.cod_specie = '01221'),17177, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5933 and c.cod_specie = '01221'),17455, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5933 and c.cod_specie = '01221'),17178, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5933 and c.cod_specie = '01221'),17176, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5933 and c.cod_specie = '01221'),17175, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5945 and c.cod_specie = '01221'),17454, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5945 and c.cod_specie = '01221'),17214, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5945 and c.cod_specie = '01221'),17213, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5945 and c.cod_specie = '01221'),17215, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5945 and c.cod_specie = '01221'),17212, 'Button', '0', 'Si');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5934 and c.cod_specie = '01221'),17179, 'TextBox', '0', 'carica');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5934 and c.cod_specie = '01221'),17180, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5934 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5934 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5934 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5935 and c.cod_specie = '01221'),17182, 'Button', '0', 'SFAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5935 and c.cod_specie = '01221'),17181, 'Button', '0', 'FAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5935 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5935 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5935 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5936 and c.cod_specie = '01221'),17184, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5936 and c.cod_specie = '01221'),17186, 'TextBox', '0', 'Entro quale data dovranno essere eseguite?');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5936 and c.cod_specie = '01221'),17185, 'TextArea', '0', 'Se si quali:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5936 and c.cod_specie = '01221'),17183, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5936 and c.cod_specie = '01221'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5937 and c.cod_specie = '01221'),17188, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5937 and c.cod_specie = '01221'),17189, 'TextArea', '0', 'Se altro specificare:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5937 and c.cod_specie = '01221'),17187, 'CheckBoxList', ' Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5937 and c.cod_specie = '01221'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5937 and c.cod_specie = '01221'),0, '0', '0', '0');

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
(select id from biosicurezza_domande where domanda ilike '%Numero%' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_alta-01')))


select * from biosicurezza_risposte where risposta ilike '%ndeg%'
update biosicurezza_risposte set  risposta ilike 'si' and ordine is null;
update biosicurezza_risposte set ordine = 5 where id_classyfarm = 17189;
update biosicurezza_risposte set ordine = 4 where id_classyfarm = 17187;

-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------
-- CHECKLIST VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI SEMIBRADI A BASSA CAPACITA CONTROLLO UFFICIALE (109)
-----------------------------------------

-- 1: Eseguire la chiamata ai webservice di classyfarm per ottenere i template delle checklist

-- Chiamare il servizio login da postman per avere il token
https://cf-function02-test.azurewebsites.net/api/autenticazione/login

{"username": "regcampania_CF","password": "yrq5nKqSr8CdOPOLmMxi4h/HtPM="}

-- Usare il token su chrome (estensione MOD HEADER, parametro x-api-key)

-- Collegarsi a http://cf-function02-test.azurewebsites.net/api/swagger/ui e nella sezione /api/checklist/getTemplateCL fare "try it out" usando il codice classyfarm 109
{
  "ListaDomandeRisp": [
    {
      "IDDomanda": "5791",
      "DescrDomanda": "Ndeg animali presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "16713",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "5950",
      "DescrDomanda": "Tipologia di suini presenti",
      "ListaRisposte": [
        {
          "IDRisposta": "17231",
          "ControlType": "CheckBoxList",
          "ListItems": " Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1",
          "TemaplateName": "Categorie presenti"
        }
      ]
    },
    {
      "IDDomanda": "5951",
      "DescrDomanda": "Ndeg totale animali (capienza)",
      "ListaRisposte": [
        {
          "IDRisposta": "17232",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "ndeg:"
        }
      ]
    },
    {
      "IDDomanda": "5952",
      "DescrDomanda": "NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :",
      "ListaRisposte": [
        {
          "IDRisposta": "17233",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        },
        {
          "IDRisposta": "17234",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "5953",
      "DescrDomanda": "Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2023/594?",
      "ListaRisposte": [
        {
          "IDRisposta": "17236",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NO"
        },
        {
          "IDRisposta": "17235",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SI"
        }
      ]
    },
    {
      "IDDomanda": "5954",
      "DescrDomanda": "Veterinario Ufficiale ispettore",
      "ListaRisposte": [
        {
          "IDRisposta": "17237",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "5955",
      "DescrDomanda": "1. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17240",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17238",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17239",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5970",
      "DescrDomanda": "16. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?",
      "ListaRisposte": [
        {
          "IDRisposta": "17285",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17306",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17287",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17286",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5956",
      "DescrDomanda": "2. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17242",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17241",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17243",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5957",
      "DescrDomanda": "3. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17246",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17244",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17245",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5958",
      "DescrDomanda": "4. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17248",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17247",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17249",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5959",
      "DescrDomanda": "5. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17251",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17252",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17250",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5960",
      "DescrDomanda": "6. E vietato al personale/visitatori portare nellarea di allevamento alimenti per uso personale? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17305",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17255",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17253",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17254",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5961",
      "DescrDomanda": "7. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17257",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17256",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17258",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5962",
      "DescrDomanda": "8. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?",
      "ListaRisposte": [
        {
          "IDRisposta": "17261",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17259",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17260",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5963",
      "DescrDomanda": "9. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?",
      "ListaRisposte": [
        {
          "IDRisposta": "17263",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17262",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17265",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5964",
      "DescrDomanda": "10. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzione di continuita, pulibili e disinfettabili in modo efficace? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17268",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17267",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17266",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5965",
      "DescrDomanda": "11. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?",
      "ListaRisposte": [
        {
          "IDRisposta": "17271",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17269",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17270",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5966",
      "DescrDomanda": "12. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17273",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17272",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17274",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5967",
      "DescrDomanda": "13. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?",
      "ListaRisposte": [
        {
          "IDRisposta": "17277",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17276",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17275",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5968",
      "DescrDomanda": "14. E previsto e documentato un piano di disinfestazione? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17279",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17278",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17281",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5969",
      "DescrDomanda": "15. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?",
      "ListaRisposte": [
        {
          "IDRisposta": "17282",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17283",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17284",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5971",
      "DescrDomanda": "17. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?",
      "ListaRisposte": [
        {
          "IDRisposta": "17288",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17289",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17290",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5972",
      "DescrDomanda": "18. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?",
      "ListaRisposte": [
        {
          "IDRisposta": "17293",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17291",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17292",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5977",
      "DescrDomanda": "19. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?",
      "ListaRisposte": [
        {
          "IDRisposta": "17308",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17307",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17309",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5978",
      "DescrDomanda": "20. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17312",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17310",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17311",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5979",
      "DescrDomanda": "21. Il carico/scarico dei suini vivi avviene con monocarico? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17314",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17313",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17315",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo"
        }
      ]
    },
    {
      "IDDomanda": "5980",
      "DescrDomanda": "23. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per leliminazione delle stesse conformemente alle disposizioni sanitarie? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17319",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17316",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17317",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17318",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        }
      ]
    },
    {
      "IDDomanda": "5981",
      "DescrDomanda": "24. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17321",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17320",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17322",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5982",
      "DescrDomanda": "25. Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17325",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivi:"
        },
        {
          "IDRisposta": "17323",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17324",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5983",
      "DescrDomanda": "26. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?",
      "ListaRisposte": [
        {
          "IDRisposta": "17327",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17326",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17328",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5984",
      "DescrDomanda": "27. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17331",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17329",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17330",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5985",
      "DescrDomanda": "28. I locali, edifici o le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?",
      "ListaRisposte": [
        {
          "IDRisposta": "17333",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17332",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17334",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5986",
      "DescrDomanda": "29. Il punto di pesa e di esclusivo utilizzo dellallevamento?",
      "ListaRisposte": [
        {
          "IDRisposta": "17337",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17335",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17336",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5987",
      "DescrDomanda": "30. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17339",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17338",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17340",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5988",
      "DescrDomanda": "31. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali? ",
      "ListaRisposte": [
        {
          "IDRisposta": "17343",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17341",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17342",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5989",
      "DescrDomanda": "32. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?",
      "ListaRisposte": [
        {
          "IDRisposta": "17345",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17344",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17346",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5990",
      "DescrDomanda": "33. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?",
      "ListaRisposte": [
        {
          "IDRisposta": "17349",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17347",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17348",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5991",
      "DescrDomanda": "34. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?",
      "ListaRisposte": [
        {
          "IDRisposta": "17351",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17350",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17352",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5992",
      "DescrDomanda": "35. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "17355",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17353",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17354",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5993",
      "DescrDomanda": "36. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale",
      "ListaRisposte": [
        {
          "IDRisposta": "17357",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17356",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17358",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "6001",
      "DescrDomanda": "22. Il carico degli scarti avviene allesterno dellarea di stabulazione e di governo degli animali?",
      "ListaRisposte": [
        {
          "IDRisposta": "17472",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Note - Motivo:"
        },
        {
          "IDRisposta": "17470",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17471",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5973",
      "DescrDomanda": "Documento 1",
      "ListaRisposte": [
        {
          "IDRisposta": "17294",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "carica"
        },
        {
          "IDRisposta": "17295",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        }
      ]
    },
    {
      "IDDomanda": "5974",
      "DescrDomanda": "ESITO DEL CONTROLLO",
      "ListaRisposte": [
        {
          "IDRisposta": "17297",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "SFAVOREVOLE"
        },
        {
          "IDRisposta": "17296",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "FAVOREVOLE"
        }
      ]
    },
    {
      "IDDomanda": "5975",
      "DescrDomanda": "Sono state assegnate delle prescrizioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "17299",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17301",
          "ControlType": "TextBox",
          "ListItems": null,
          "TemaplateName": "Entro quale data dovranno essere eseguite?"
        },
        {
          "IDRisposta": "17300",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se si quali:"
        },
        {
          "IDRisposta": "17298",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        }
      ]
    },
    {
      "IDDomanda": "5976",
      "DescrDomanda": "Sono state applicate delle sanzioni?",
      "ListaRisposte": [
        {
          "IDRisposta": "17303",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "NA"
        },
        {
          "IDRisposta": "17304",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Se altro specificare:"
        },
        {
          "IDRisposta": "17302",
          "ControlType": "CheckBoxList",
          "ListItems": " Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6",
          "TemaplateName": ":"
        }
      ]
    },
    {
      "IDDomanda": "5994",
      "DescrDomanda": "37. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza?",
      "ListaRisposte": [
        {
          "IDRisposta": "17361",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17359",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17373",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17360",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5995",
      "DescrDomanda": "38. I capannoni sono suddivisi in settori da pareti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17363",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17404",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17364",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17362",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17365",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    },
    {
      "IDDomanda": "5996",
      "DescrDomanda": "39. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza?",
      "ListaRisposte": [
        {
          "IDRisposta": "17368",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        },
        {
          "IDRisposta": "17366",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17374",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17367",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        }
      ]
    },
    {
      "IDDomanda": "5997",
      "DescrDomanda": "40. I capannoni sono suddivisi in settori da pareti?",
      "ListaRisposte": [
        {
          "IDRisposta": "17370",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "No"
        },
        {
          "IDRisposta": "17371",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/A"
        },
        {
          "IDRisposta": "17405",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "N/D"
        },
        {
          "IDRisposta": "17369",
          "ControlType": "Button",
          "ListItems": null,
          "TemaplateName": "Si"
        },
        {
          "IDRisposta": "17372",
          "ControlType": "TextArea",
          "ListItems": null,
          "TemaplateName": "Motivo:"
        }
      ]
    }
  ],
  "message": null,
  "esito": 0
}

-- creo sezioni
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('VALUTAZIONE FINALE E PROVVEDIMENTI', 4, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('DATI AGGIUNTIVI', 0, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE INGRASSO',3 , (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE GENERALE', 1, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_bassa-01'));
insert into biosicurezza_sezioni(sezione, ordine, id_lookup_chk_classyfarm_mod) values ('QUESTIONARIO BIOSICUREZZA: SEZIONE SVEZZAMENTO', 2, (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_bassa-01'));

-- creo domande

insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 0),2,5791, 'Ndeg animali presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 0),4,5950, 'Tipologia di suini presenti');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 0),1,5951, 'Ndeg totale animali (capienza)');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 4),49,5952, 'NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALLISPEZIONE :');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 0),5,5953, 'Lallevamento e posto in un territorio dove si applicano le misure di biosicurezza di cui allallegato II del regolamento UE 2023/594?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 0),3,5954, 'Veterinario Ufficiale ispettore');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),6,5955, '1. Sono presenti e ben visibili allingresso cartelli di divieto di accesso per le persone non autorizzate? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),7,5956, '2. Lazienda dispone di cancelli o sbarre idonee ad evitare lingresso diretto e non controllato di automezzi e/o persone? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),8,5957, '3. Lazienda dispone di una zona filtro, con accesso obbligatorio, per il personale addetto al governo degli animali e dei visitatori? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),9,5958, '4. Nella zona filtro, esiste una netta separazione tra la zona sporca e la zona pulita? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),10,5959, '5. Il personale/visitatori utilizza vestiario o tute e calzari  monouso che viene utilizzato esclusivamente in azienda? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),11,5960, '6. E vietato al personale/visitatori portare nellarea di allevamento alimenti per uso personale? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),12,5961, '7. E presente una planimetria, con capannoni e box numerati univocamente, mediante la quale sia possibile verificare il flusso unidirezionale degli spostamenti degli animali nellazienda e identificare i gruppi di animali? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),13,5962, '8. I locali e gli edifici degli stabilimenti  sono costruiti in modo che nessun altro animale possa entrare in contatto con i suini detenuti o con il loro mangime e materiale da lettiera?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),14,5963, '9. I locali in cui sono detenuti i suini e gli edifici in cui sono tenuti mangime e lettiere sono delimitati da una recinzione a prova di bestiame?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),15,5964, '10. I locali di stabulazione hanno pareti, pavimenti e serramenti a tenuta e in buono stato di manutenzione, senza soluzione di continuita, pulibili e disinfettabili in modo efficace? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),16,5965, '11. Esiste una prassi di pulizia, lavaggio e disinfezione dei ricoveri, degli ambienti e delle attrezzature dellazienda e ove necessario, dopo la fine di ogni ciclo produttivo (anche per settori)?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),17,5966, '12. Lallevamento dispone di punti di cambio o disinfezione delle calzature tra i diversi capannoni? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),18,5967, '13. Lallevamento dispone di punti di disinfezione e lavaggio delle mani tra i diversi capannoni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),19,5968, '14. E previsto e documentato un piano di disinfestazione? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),20,5969, '15. Esiste documentazione relativa a corsi di formazione esterna o interna sulla biosicurezza e sui rischi di introduzione di malattie infettive e diffusive degli animali soggette a denuncia?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),21,5970, '16. Esiste un sistema di registrazione dei dati aziendali sanitari, di allevamento, di riproduzione e produzione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),22,5971, '17. Il personale addetto al governo degli animali ha contatti con altre aziende suinicole?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),23,5972, '18. E presente un registro dei visitatori con indicato almeno data, nome e cognome del visitatore, motivo della visita e targa dellautomezzo?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),24,5977, '19. Sono disponibili e utilizzati per la disinfezione dei veicoli prodotti di provata efficacia nei confronti delle malattie vescicolari del suino e PSA?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),25,5978, '20. Il carico/scarico dei suini vivi avviene allesterno dellarea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),26,5979, '21. Il carico/scarico dei suini vivi avviene con monocarico? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),27,6001, '22. Il carico degli scarti avviene allesterno dellarea di stabulazione e di governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),28,5980, '23. Le carcasse degli animali morti sono rimosse dai locali di allevamento entro 24 ore dal decesso, conservate in un contenitore coibentato o in una cella frigorifera a tenuta, idonei e funzionanti, posti allesterno dellarea di governo degli animali, per');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),29,5981, '24. Il carico dei suini morti avviene allesterno dellarea di stabulazione e governo degli animali? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),30,5982, '25. Il contenitore/cella frigorifera dove vengono conservati i morti ha un accesso e un percorso differenziato da quello dellarea di stabulazione e governo degli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),31,5983, '26. Larea sottostante il contenitore/cella frigorifera dei morti, e idonea sia alla raccolta di eventuali materiali o liquidi percolanti sia alla pulizia e disinfezione?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),32,5984, '27. Lo scarico del mangime avviene in modo da non permetterne il contatto con altri animali? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),33,5985, '28. I locali, edifici o le aree di stoccaggio dei mangimi e/o delle lettiere, sono coperti da griglie o sigillati per impedire lingresso di altri animali, ratti e insetti nocivi?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),34,5986, '29. Il punto di pesa e di esclusivo utilizzo dellallevamento?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),35,5987, '30. E vietata la somministrazione di rifiuti di ristorazione, mensa o avanzi casalinghi agli animali?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),36,5988, '31. Esistono ingressi per le operazioni di trasporto dei liquami differenziati da quelli dellarea di stabulazione e governo degli animali? ');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),37,5989, '32. Gli animali domestici/da compagnia non possono avere accesso ai locali dove sono stabulati i suini?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),38,5990, '33. Il personale che accudisce e/o puo venire a contatto con i suini non pratica attivita venatoria o altre attivita dove puo avere contatto con suidi selvatici nelle 48 precedenti lingresso in azienda?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),39,5991, '34. E presente una autodichiarazione da parte dei lavoratori dipendenti degli allevamenti suini intensivi di non detenzione di suini o cinghiali allevati a carattere rurale?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),40,5992, '35. Divieto di introduzione in allevamento di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 1),41,5993, '36. Divieto di somministrazione ai suini di alimenti a base di carne di suini o cinghiali provenienti dalla filiera rurale');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 2),42,5994, '37. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 2),43,5995, '38. I capannoni sono suddivisi in settori da pareti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 3),44,5996, '39. In allevamento viene applicato il sistema tutto pieno/tutto vuoto per stanza?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 3),45,5997, '40. I capannoni sono suddivisi in settori da pareti?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 4),46,5974, 'ESITO DEL CONTROLLO');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 4),47,5975, 'Sono state assegnate delle prescrizioni?');
insert into biosicurezza_domande (id_sezione, ordine, id_classyfarm, domanda) values ((select s.id from biosicurezza_sezioni s join lookup_chk_classyfarm_mod m on m.code = s.id_lookup_chk_classyfarm_mod where m.cod_specie = '01223' and m.versione =2023 and s.ordine = 4),48,5976, 'Sono state applicate delle sanzioni?');



update biosicurezza_domande set domanda = 'Numero totale degli animali (capienza)' where domanda ilike 'Ndeg totale animali (capienza)';
update biosicurezza_domande set domanda = 'Numero totale animali presenti' where domanda ilike 'Ndeg animali presenti';

update biosicurezza_domande set domanda = replace(domanda, 'lallegato', 'l''allegato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lallegato%');
update biosicurezza_domande set domanda = replace(domanda, 'Lallevamento', 'L''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'Lazienda', 'L''azienda') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lazienda%');
update biosicurezza_domande set domanda = replace(domanda, 'e posto', 'e'' posto') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e posto%');
update biosicurezza_domande set domanda = replace(domanda, 'e dotata', 'e'' dotata') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e dotata%');
update biosicurezza_domande set domanda = replace(domanda, 'lingresso', 'l''ingresso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lingresso%');
update biosicurezza_domande set domanda = replace(domanda, 'E presente', 'E'' presente') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E presente%');
update biosicurezza_domande set domanda = replace(domanda, 'unarea', 'un''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%unarea%');
update biosicurezza_domande set domanda = replace(domanda, 'E vietato', 'E'' vietato') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E vietato%');
update biosicurezza_domande set domanda = replace(domanda, 'Larea', 'L''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Larea%');
update biosicurezza_domande set domanda = replace(domanda, 'e mantenuta', 'e'' mantenuta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e mantenuta%');
update biosicurezza_domande set domanda = replace(domanda, 'dellaccesso', 'dell''accesso') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellaccesso%');
update biosicurezza_domande set domanda = replace(domanda, 'allallevamento', 'all''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%allallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'lavvenuta', 'l''avvenuta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lavvenuta%');
update biosicurezza_domande set domanda = replace(domanda, 'allesterno', 'all''esterno') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%allesterno%');
update biosicurezza_domande set domanda = replace(domanda, 'dellarea', 'dell''area') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellarea%');
update biosicurezza_domande set domanda = replace(domanda, 'e idonea', 'e'' idonea') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e idonea%');
update biosicurezza_domande set domanda = replace(domanda, 'lalimentazione', 'l''alimentazione') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lalimentazione%');
update biosicurezza_domande set domanda = replace(domanda, 'e garantita', 'e'' garantita') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%e garantita%');
update biosicurezza_domande set domanda = replace(domanda, ' piu ', ' piu'' ') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '% piu %');
update biosicurezza_domande set domanda = replace(domanda, 'Lesame', 'L''esame') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%Lesame%');
update biosicurezza_domande set domanda = replace(domanda, 'E prevista', 'E'' prevista') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E prevista%');
update biosicurezza_domande set domanda = replace(domanda, 'lesecuzione', 'l''esecuzione') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%lesecuzione%');
update biosicurezza_domande set domanda = replace(domanda, 'E richiesta', 'E'' richiesta') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E richiesta%');
update biosicurezza_domande set domanda = replace(domanda, 'limpossibilita', 'l''impossibilita') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%limpossibilita%');
update biosicurezza_domande set domanda = replace(domanda, 'dellallevamento', 'dell''allevamento') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%dellallevamento%');
update biosicurezza_domande set domanda = replace(domanda, 'tracciabilita?', 'tracciabilita''?') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%tracciabilita?%');
update biosicurezza_domande set domanda = replace(domanda, 'E vietata', 'E'' vietata') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E vietata%');
update biosicurezza_domande set domanda = replace(domanda, 'E previsto', 'E'' previsto') where id in (select id from biosicurezza_domande where id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa  ilike 'biosicurezza-2023%' )) and domanda like '%E previsto%');

-- creo risposte
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01223'),16713, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5791 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5950 and c.cod_specie = '01223'),17231, 'CheckBoxList', ' Scrofe, Verri e suinetti sottoscrofa - 3; Suini in svezzamento - 2; Suini allingrasso - 1', 'Categorie presenti');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5950 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5950 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5950 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5950 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5951 and c.cod_specie = '01223'),17232, 'TextBox', '0', 'ndeg:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5951 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5951 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5951 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5951 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5952 and c.cod_specie = '01223'),17233, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5952 and c.cod_specie = '01223'),17234, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5952 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5952 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5952 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5953 and c.cod_specie = '01223'),17236, 'Button', '0', 'NO');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5953 and c.cod_specie = '01223'),17235, 'Button', '0', 'SI');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5953 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5953 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5953 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5954 and c.cod_specie = '01223'),17237, 'TextArea', '0', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5954 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5954 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5954 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5954 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5955 and c.cod_specie = '01223'),17240, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5955 and c.cod_specie = '01223'),17238, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5955 and c.cod_specie = '01223'),17239, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5955 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5955 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5956 and c.cod_specie = '01223'),17242, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5956 and c.cod_specie = '01223'),17241, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5956 and c.cod_specie = '01223'),17243, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5956 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5956 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5957 and c.cod_specie = '01223'),17246, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5957 and c.cod_specie = '01223'),17244, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5957 and c.cod_specie = '01223'),17245, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5957 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5957 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5958 and c.cod_specie = '01223'),17248, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5958 and c.cod_specie = '01223'),17247, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5958 and c.cod_specie = '01223'),17249, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5958 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5958 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5959 and c.cod_specie = '01223'),17251, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5959 and c.cod_specie = '01223'),17252, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5959 and c.cod_specie = '01223'),17250, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5959 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5959 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5960 and c.cod_specie = '01223'),17305, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5960 and c.cod_specie = '01223'),17255, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5960 and c.cod_specie = '01223'),17253, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5960 and c.cod_specie = '01223'),17254, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5960 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5961 and c.cod_specie = '01223'),17257, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5961 and c.cod_specie = '01223'),17256, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5961 and c.cod_specie = '01223'),17258, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5961 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5961 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5962 and c.cod_specie = '01223'),17261, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5962 and c.cod_specie = '01223'),17259, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5962 and c.cod_specie = '01223'),17260, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5962 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5962 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5963 and c.cod_specie = '01223'),17263, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5963 and c.cod_specie = '01223'),17262, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5963 and c.cod_specie = '01223'),17265, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5963 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5963 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5964 and c.cod_specie = '01223'),17268, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5964 and c.cod_specie = '01223'),17267, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5964 and c.cod_specie = '01223'),17266, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5964 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5964 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5965 and c.cod_specie = '01223'),17271, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5965 and c.cod_specie = '01223'),17269, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5965 and c.cod_specie = '01223'),17270, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5965 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5965 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5966 and c.cod_specie = '01223'),17273, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5966 and c.cod_specie = '01223'),17272, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5966 and c.cod_specie = '01223'),17274, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5966 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5966 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5967 and c.cod_specie = '01223'),17277, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5967 and c.cod_specie = '01223'),17276, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5967 and c.cod_specie = '01223'),17275, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5967 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5967 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5968 and c.cod_specie = '01223'),17279, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5968 and c.cod_specie = '01223'),17278, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5968 and c.cod_specie = '01223'),17281, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5968 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5968 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5969 and c.cod_specie = '01223'),17282, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5969 and c.cod_specie = '01223'),17283, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5969 and c.cod_specie = '01223'),17284, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5969 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5969 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5970 and c.cod_specie = '01223'),17285, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5970 and c.cod_specie = '01223'),17306, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5970 and c.cod_specie = '01223'),17287, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5970 and c.cod_specie = '01223'),17286, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5970 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5971 and c.cod_specie = '01223'),17288, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5971 and c.cod_specie = '01223'),17289, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5971 and c.cod_specie = '01223'),17290, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5971 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5971 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5972 and c.cod_specie = '01223'),17293, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5972 and c.cod_specie = '01223'),17291, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5972 and c.cod_specie = '01223'),17292, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5972 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5972 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5977 and c.cod_specie = '01223'),17308, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5977 and c.cod_specie = '01223'),17307, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5977 and c.cod_specie = '01223'),17309, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5977 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5977 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5978 and c.cod_specie = '01223'),17312, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5978 and c.cod_specie = '01223'),17310, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5978 and c.cod_specie = '01223'),17311, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5978 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5978 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5979 and c.cod_specie = '01223'),17314, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5979 and c.cod_specie = '01223'),17313, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5979 and c.cod_specie = '01223'),17315, 'TextArea', '0', 'Motivo');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5979 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5979 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6001 and c.cod_specie = '01223'),17472, 'TextArea', '0', 'Note - Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6001 and c.cod_specie = '01223'),17470, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6001 and c.cod_specie = '01223'),17471, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6001 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =6001 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5980 and c.cod_specie = '01223'),17319, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5980 and c.cod_specie = '01223'),17316, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5980 and c.cod_specie = '01223'),17317, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5980 and c.cod_specie = '01223'),17318, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5980 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5981 and c.cod_specie = '01223'),17321, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5981 and c.cod_specie = '01223'),17320, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5981 and c.cod_specie = '01223'),17322, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5981 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5981 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5982 and c.cod_specie = '01223'),17325, 'TextArea', '0', 'Motivi:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5982 and c.cod_specie = '01223'),17323, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5982 and c.cod_specie = '01223'),17324, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5982 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5982 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5983 and c.cod_specie = '01223'),17327, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5983 and c.cod_specie = '01223'),17326, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5983 and c.cod_specie = '01223'),17328, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5983 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5983 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5984 and c.cod_specie = '01223'),17331, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5984 and c.cod_specie = '01223'),17329, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5984 and c.cod_specie = '01223'),17330, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5984 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5984 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5985 and c.cod_specie = '01223'),17333, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5985 and c.cod_specie = '01223'),17332, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5985 and c.cod_specie = '01223'),17334, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5985 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5985 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5986 and c.cod_specie = '01223'),17337, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5986 and c.cod_specie = '01223'),17335, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5986 and c.cod_specie = '01223'),17336, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5986 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5986 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5987 and c.cod_specie = '01223'),17339, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5987 and c.cod_specie = '01223'),17338, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5987 and c.cod_specie = '01223'),17340, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5987 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5987 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5988 and c.cod_specie = '01223'),17343, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5988 and c.cod_specie = '01223'),17341, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5988 and c.cod_specie = '01223'),17342, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5988 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5988 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5989 and c.cod_specie = '01223'),17345, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5989 and c.cod_specie = '01223'),17344, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5989 and c.cod_specie = '01223'),17346, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5989 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5989 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5990 and c.cod_specie = '01223'),17349, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5990 and c.cod_specie = '01223'),17347, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5990 and c.cod_specie = '01223'),17348, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5990 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5990 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5991 and c.cod_specie = '01223'),17351, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5991 and c.cod_specie = '01223'),17350, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5991 and c.cod_specie = '01223'),17352, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5991 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5991 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5992 and c.cod_specie = '01223'),17355, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5992 and c.cod_specie = '01223'),17353, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5992 and c.cod_specie = '01223'),17354, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5992 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5992 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5993 and c.cod_specie = '01223'),17357, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5993 and c.cod_specie = '01223'),17356, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5993 and c.cod_specie = '01223'),17358, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5993 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5993 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5994 and c.cod_specie = '01223'),17361, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5994 and c.cod_specie = '01223'),17359, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5994 and c.cod_specie = '01223'),17373, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5994 and c.cod_specie = '01223'),17360, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5994 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5995 and c.cod_specie = '01223'),17363, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5995 and c.cod_specie = '01223'),17404, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5995 and c.cod_specie = '01223'),17364, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5995 and c.cod_specie = '01223'),17362, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5995 and c.cod_specie = '01223'),17365, 'TextArea', '0', 'Motivo:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5996 and c.cod_specie = '01223'),17368, 'TextArea', '0', 'Motivo:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5996 and c.cod_specie = '01223'),17366, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5996 and c.cod_specie = '01223'),17374, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5996 and c.cod_specie = '01223'),17367, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5996 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5997 and c.cod_specie = '01223'),17370, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5997 and c.cod_specie = '01223'),17371, 'Button', '0', 'N/A');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5997 and c.cod_specie = '01223'),17405, 'Button', '0', 'N/D');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5997 and c.cod_specie = '01223'),17369, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5997 and c.cod_specie = '01223'),17372, 'TextArea', '0', 'Motivo:');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5974 and c.cod_specie = '01223'),17297, 'Button', '0', 'SFAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5974 and c.cod_specie = '01223'),17296, 'Button', '0', 'FAVOREVOLE');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5974 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5974 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5974 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5975 and c.cod_specie = '01223'),17299, 'Button', '0', 'No');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5975 and c.cod_specie = '01223'),17301, 'TextBox', '0', 'Entro quale data dovranno essere eseguite?');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5975 and c.cod_specie = '01223'),17300, 'TextArea', '0', 'Se si quali:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5975 and c.cod_specie = '01223'),17298, 'Button', '0', 'Si');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5975 and c.cod_specie = '01223'),0, '0', '0', '0');
insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5976 and c.cod_specie = '01223'),17303, 'Button', '0', 'NA');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5976 and c.cod_specie = '01223'),17304, 'TextArea', '0', 'Se altro specificare:');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5976 and c.cod_specie = '01223'),17302, 'CheckBoxList', ' Nessuna - 0; Blocco Movimentazioni - 1; Abbattimento capi - 2; Amministrativa/pecuniaria - 3; Sequestro Capi - 4; Informativa in procura - 5; Altro (specificare) - 6', ':');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5976 and c.cod_specie = '01223'),0, '0', '0', '0');insert into biosicurezza_risposte(id_domanda, id_classyfarm, tipo, lista, risposta) values ((select d.id from biosicurezza_domande d join biosicurezza_sezioni s on s.id = d.id_sezione join lookup_chk_classyfarm_mod c on c.code = s.id_lookup_chk_classyfarm_mod where d.id_classyfarm =5976 and c.cod_specie = '01223'),0, '0', '0', '0');

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
(select id from biosicurezza_domande where domanda ilike '%Numero%' and id_sezione in (select id from biosicurezza_sezioni where id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where codice_gisa = 'biosicurezza-2023-suini-semib_bassa-01')))

delete from biosicurezza_risposte where id_classyfarm=0;


--26/08/2022 -- gestione revisione verbali campionamento
alter table moduli_campioni_html_fields add column rev integer;
select tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo from moduli_campioni_html_fields  where tipo_modulo  =1 and enabled_campo order by ordine_campo
update moduli_campioni_html_fields set rev=8 where tipo_modulo  =1 and enabled_campo;

insert into moduli_campioni_html_fields (tipo_modulo, tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'text','cod_utente_sigla','COD UTENTE SIGLA', 0, 0, true,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, tipo_campo, nome_campo,  label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'text','mail_dipartimento','Mail Dipartimento',1, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'text','ora_controllo','Ora del controllo', 2, 0, true,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'text','nome_presente_ispezione','Nominativo presente all''ispezione', 3, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev)  
values (1, 'text','luogo_nascita_presente_ispezione','Luogo di nascita del presente all''ispezione', 4, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev)  
values (1, 'data','data_nascita_presente_ispezione','Data di nascita del presente all''ispezione', 5, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'comune_residenza_presente_ispezione','text','Comune di residenza del presente all''ispezione', 6, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo,  tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'text','indirizzo_residenza_presente_ispezione','Indirizzo di residenza del presente all''ispezione', 7, 0, false,true,9);
 
insert into moduli_campioni_html_fields (tipo_modulo,  tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'text','num_indirizzo_residenza_presente_ispezione','"Indirizzo di residenza (numero) del presente all''ispezione"', 8, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo,  tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'text','doc_ident_presente_ispezione','Documento di identita del presente all''ispezione', 9, 0, false,true,9); 

insert into moduli_campioni_html_fields(tipo_modulo,  tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'text','ausilio','Ausilio', 10, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1, 'campione_prelevato','text','Campione prelevato', 11, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'num_uc','text','Num. u.c.', 12, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'peso_aliquote','text','Del peso di kg. cadauna', 13, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'lettera','text','ognuna contrassegnata con lettere (da A ad E)', 14, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'dicitura','text','Dicitura buste contenitrici', 15, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'proveniente','text','Proveniente da', 16, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'temperatura_aria','text','Temperatura dell''aria', 17, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'temperatura_acqua','text','Temperatura dell''acqua in superficie', 18, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'temperatura_acqua_10m','text','Temperatura dell''acqua a 10 metri di profondita', 19, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'data_mareggiata','data','Data ultima mareggiata', 20, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'data_pioggia','data','Data ultima pioggia', 21, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'salinita','text','Salinita'' dell''acqua', 22, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'sezione','text','Campione inviato alla sezione di', 23, 0, false,true,9); 

insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (1,'corrente_proveniente','text','Corrente proveniente da', 24, 0, true,true,9); 

select 'insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'''||nome_campo||''', '''||tipo_campo||''','''||label_campo||''', '''||coalesce(tabella_lookup,'')||''','||ordine_campo||','||only_hd||', '||obbligatorio||', '||enabled_campo||', 9);',*
from moduli_campioni_html_fields where tipo_modulo  =2 and enabled_campo order by ordine_campo

update moduli_campioni_html_fields set rev=8 where tipo_modulo  =2 and enabled_campo;
insert into moduli_campioni_html_fields (tipo_modulo, tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2, 'text','cod_utente_sigla','COD UTENTE SIGLA', 0, 0, true,true,9); 
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'mail_dipartimento', 'text','PEC', '',1,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'ora_controllo', 'text','Ora del controllo', '',2,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'nome_presente_ispezione', 'text','Presente ad ispezione', '',3,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'rappresentativo_partita', 'text','Da una partita di', '',4,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'unita_partita', 'select','(kg/lt/unita)', 'lookup_moduli_campioni_unita_partita',5,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'detenuta_in', 'text','Detenuta nel', '',6,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'gradi', 'text','A (gradi)', '',7,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'contenitore_unita_partita', 'select','In (confezione)', 'lookup_moduli_campioni_contenitore_partita',8,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'indicazioni', 'text','Indicazioni', '',9,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'rte', 'select','Alimento RTE', 'lookup_moduli_campioni_rte',10,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'latte_pastorizzato', 'select','Il latte utilizzato come materia prima è stato pastorizzato?', 'lookup_moduli_campioni_latte_pastorizzato',11,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'nazione', 'text','Nazione stabilimento di produzione', '',12,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'fao', 'text','Zona FAO', '',13,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'trattamenti', 'text','Trattamenti subiti dalla merce', '',14,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'motivo_prelievo', 'select','Campione prelevato per la', 'lookup_moduli_campioni_motivo_prelievo',15,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'numerazione_descrizione', 'text','Numerazione (descrizione)', '',16,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'tipologia_prelievo', 'select','Quale', 'lookup_moduli_campioni_tipologia_prelievo',17,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'fase', 'text','Campione prelevato durante la fase', '',18,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'precetto', 'select','In applicazione del precetto ex art. 223 punto 1 D.L.vo 271/89', 'lookup_moduli_campioni_rte',19,0, true, true, 9);
--new
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'data', 'data','Si comunica che in data', '',20,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'ore', 'text','alle ore', '',21,0, true, true, 9);
--new
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'sicurezza_numero_uc', 'text','Campione costituito da 1 aliquota formata da n. unita', '',22,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'sicurezza_peso', 'text','Del peso di', '',23,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'uc_contenitore', 'select','Le unita'' campionarie sono', 'lookup_moduli_campioni_contenitori',24,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'dicitura', 'text','Aliquota sigillata con piombino o posta in busta antimanomissione, recante la dicitura', '',25,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'inviate', 'text','Aliquota conservata e inviata al laboratorio del', '',26,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'temperatura_aliq', 'text','Alla temperatura di', '',27,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'dichiarazione', 'text','Il presente al campionamento dichiara', '',28,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'proceduto_sequestro', 'select','Proceduto al sequestro', 'lookup_moduli_campioni_sequestro',29,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'verbale', 'text','Num. Verbale di sequestro', '',30,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (2,'note', 'text','Note', '',31,0, true, true, 9);

"COD UTENTE SIGLA"
"PEC"
"Ora del controllo"
"Presente ad ispezione"
"Da una partita di"
"(kg/lt/unita)"
"Detenuta nel"
"A (gradi)"
"In (confezione)"
"Indicazioni"
"Alimento RTE"
"Il latte utilizzato come materia prima è stato pastorizzato?”"
"Nazione stabilimento di produzione"
"Zona FAO"
"Trattamenti subiti dalla merce"
"Campione prelevato per la"
"Numerazione (descrizione)"
"Quale"
"Campione prelevato durante la fase"
" In applicazione del precetto ex art. 223 punto 1 D.L.vo 271/89"
"Si comunica che in data"
"alle ore"
"Campione costituito da 1 aliquota formata da n. unita"
"Del peso di"
"Le unita' campionarie sono:"
"Aliquota sigillata con piombino o posta in busta antimanomissione, recante la dicitura"
"Aliquota conservata e inviata al laboratorio del"
"Alla temperatura di"
"Il presente al campionamento dichiara"
"Proceduto al sequestro"
"Num. Verbale di sequestro"
"Note"



select 'insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'''||nome_campo||''', '''||tipo_campo||''','''||label_campo||''', '''||coalesce(tabella_lookup,'')||''','||ordine_campo||','||only_hd||', '||obbligatorio||', '||enabled_campo||', 9);',*
from moduli_campioni_html_fields where tipo_modulo  =3 and enabled_campo order by ordine_campo

update moduli_campioni_html_fields set rev=8 where tipo_modulo  =3 and enabled_campo;

insert into moduli_campioni_html_fields (tipo_modulo, tipo_campo, nome_campo, label_campo, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3, 'text','cod_utente_sigla','COD UTENTE SIGLA', 0, 0, true,true,9); 
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'mail_dipartimento', 'text','PEC', '',1,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'ora_controllo', 'text','Ora del controllo', '',2,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'nome_presente_ispezione', 'text','Presente ad ispezione', '',3,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'rappresentativo_partita', 'text','Da una partita di', '',4,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'unita_partita', 'select','(kg/lt/unita)', 'lookup_moduli_campioni_unita_partita',5,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'detenuta_in', 'text','Detenuta nel', '',6,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'gradi', 'text','A (gradi)', '',7,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'contenitore_unita_partita', 'select','In (confezione)', 'lookup_moduli_campioni_contenitore_partita',8,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'indicazioni', 'text','Indicazioni', '',9,0, true, true, 9);
-- new metodo di produzione
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'metodo_produzione', 'select','(biologica/integrata/non definita)', 'lookup_moduli_campioni_metodo_produzione',10,0, true, true, 9);
--
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'fao', 'text','Zona FAO', '',11,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'nazione', 'text','Nazione stabilimento di produzione', '',12,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'trattamenti', 'text','Trattamenti subiti dalla merce', '',13,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'fase', 'text','Campione effettuato durante la fase', '',14,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'rte', 'select','Alimento RTE', 'lookup_moduli_campioni_rte',15,0, true, true, 9);
-- new metodo di produzione con lookup
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'fattore_scelta', 'select','Ai sensi dell’art.2 del Reg (CE) n. 1881/06 il fattore di', 'lookup_moduli_campioni_fattore_scelta',16,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'fattore_trasformazione', 'select','Fattore di trasformazione', 'lookup_moduli_campioni_fattore_trasformazione',17,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'fattore_trasformazione_pari', 'text','Fattore di trasformazione - Se Pari a', '',18,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'num_aliquote', 'text','Campione costituito da num. aliquote', '',19,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'previste', 'select','aliquote previste', 'lookup_moduli_campioni_aliquote_previste',20,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'causa_mancanza_aliquote', 'select','Causa della eventuale mancata formazione di tutte le aliquote previste', 'lookup_moduli_campioni_causa_mancanza_aliquote',21,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'motivi_mancanza_aliquote', 'text','Se Seguenti Motivi - Motivi che ne escludono la pertinenza', '',22,0, true, true, 9);
-- new data e ora
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'data', 'data','Nel caso B, si comunica che in data', '',23,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'ore', 'text','alle ore', '',24,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'num_uc', 'text','Aliquota costituita da num unita', '',25,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'peso', 'text','Ciascuna del peso di', '',26,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'uc_contenitore', 'select','Unita poste in contenitori di', 'lookup_moduli_campioni_contenitori',27,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'dicitura', 'text','Aliquota sigillata con piombino o posta in busta antimanomissione, recante la dicitura', '',28,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'lasciata_aliquota', 'select','Lasciata aliquota al presente al campionamento', 'lookup_moduli_campioni_lasciata_aliquota',29,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'altre_num', 'text','Num. altre aliquote', '',30,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'inviate', 'text','Aliquote conservate e inviate al laboratorio del', '',31,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'temperatura_aliq', 'text','Alla temperatura di', '',32,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'imballaggio', 'text','Il materiale di confezionamento/imballaggio primario costituito da', '',33,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'dichiarazione', 'text','Il presente al campionamento dichiara', '',34,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'proceduto_sequestro', 'select','Proceduto al sequestro', 'lookup_moduli_campioni_sequestro',35,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'verbale', 'text','Num. Verbale di sequestro', '',36,0, true, true, 9);
insert into moduli_campioni_html_fields (tipo_modulo, nome_campo, tipo_campo, label_campo, tabella_lookup, ordine_campo, only_hd, obbligatorio, enabled_campo, rev) 
values (3,'note', 'text','Note', '',37,0, true, true, 9);




CREATE TABLE public.lookup_moduli_campioni_fattore_scelta
(
  code serial,
  description character varying(300) NOT NULL,
  short_description character varying(300),
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true

)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_moduli_campioni_fattore_scelta
  OWNER TO postgres;

insert into lookup_moduli_campioni_fattore_scelta(description, short_description, enabled) values('trasformazione','trasformazione',true);
insert into lookup_moduli_campioni_fattore_scelta(description, short_description, enabled) values('concentrazione','concentrazione',true);
insert into lookup_moduli_campioni_fattore_scelta(description, short_description, enabled) values('diluizione','diluizione',true);
insert into lookup_moduli_campioni_fattore_scelta(description, short_description, enabled) values('---','---',true);



CREATE TABLE public.lookup_moduli_campioni_metodo_produzione
(
  code serial,
  description character varying(300) NOT NULL,
  short_description character varying(300),
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true

)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_moduli_campioni_metodo_produzione
  OWNER TO postgres;

 insert into lookup_moduli_campioni_metodo_produzione(description, short_description, enabled) values('biologica','biologica',true);
insert into lookup_moduli_campioni_metodo_produzione(description, short_description, enabled) values('integrata','integrata',true);
insert into lookup_moduli_campioni_metodo_produzione(description, short_description, enabled) values('non definita','non definita',true);
insert into lookup_moduli_campioni_metodo_produzione(description, short_description, enabled) values('---','---',true);



CREATE TABLE public.lookup_moduli_campioni_aliquote_previste
(
  code serial,
  description character varying(300) NOT NULL,
  short_description character varying(300),
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true

)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_moduli_campioni_aliquote_previste
  OWNER TO postgres;

insert into lookup_moduli_campioni_aliquote_previste(description, short_description, enabled) values('4','4',true);
insert into lookup_moduli_campioni_aliquote_previste(description, short_description, enabled) values('5','5',true);
insert into lookup_moduli_campioni_aliquote_previste(description, short_description, enabled) values('---','---',true);

update moduli_campioni_html_fields set rev=8 where tipo_modulo  =14 and enabled_campo;
update moduli_campioni_html_fields set rev=8 where tipo_modulo  =4 and enabled_campo;
--update moduli_campioni_html_fields set enabled_campo =true where nome_campo='ora_controllo' and tipo_modulo=1
--query check per le revisioni
select distinct rev, tipo_modulo from moduli_campioni_html_fields where enabled_campo order by tipo_modulo

CREATE OR REPLACE FUNCTION public.get_elenco_campi_modulo(_id_campione integer,_id_tipo_modulo integer)
  RETURNS TABLE(id integer,
  tipo_modulo integer ,
  nome_campo character varying,
  tipo_campo character varying ,
  label_campo character varying ,
  tabella_lookup character varying,
  javascript_function character varying,
  javascript_function_evento character varying,
  link_value character varying,
  ordine_campo integer,
  valore_campo character varying,
  tipo_controlli_date character varying,
  label_campo_controlli_date character varying,
  maxlength integer,
  id_specie_only integer,
  only_hd integer,
  label_link character varying,
  multiple boolean,
  obbligatorio boolean,
  enabled_campo boolean,
  rev integer, 
  valore_campione text) AS
$BODY$
DECLARE
        data_campione timestamp without time zone;
        _revisione integer;
	r RECORD;	
BEGIN

	data_campione := (select t.assigned_date from ticket t where t.ticketid = _id_campione);
	raise info 'data_campione %', data_campione;
	if data_campione >= '2021-12-31' then
		_revisione = 9;
	else 
		_revisione = 8;
	end if;
	raise info 'rev %', _revisione;
FOR 	
	id ,
	tipo_modulo  ,
	nome_campo,
	tipo_campo  ,
	label_campo  ,
	tabella_lookup,
	javascript_function ,
	javascript_function_evento ,
	link_value,
	ordine_campo ,
	valore_campo,
	tipo_controlli_date ,
	label_campo_controlli_date ,
	maxlength ,
	id_specie_only ,
	only_hd ,
	label_link  ,
	multiple ,
	obbligatorio ,
	enabled_campo ,
	rev , 
	valore_campione 
in
	select 
		campi.*, 
		mod.valore_campione  
		from moduli_campioni_html_fields campi 
		LEFT JOIN moduli_campioni_fields_value mod on mod.id_moduli_campioni_html_fields = campi.id and mod.id_campione = _id_campione 
		LEFT JOIN ticket t on t.ticketid = mod.id_campione  
		where campi.tipo_modulo = _id_tipo_modulo and campi.enabled_campo  	
		and (enabled = true or enabled is null)  and campi.rev= 9
		order by ordine_campo asc 
LOOP
        RETURN NEXT;
END LOOP;
     RETURN;
 END;
$BODY$
  LANGUAGE plpgsql  
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_elenco_campi_modulo(integer, integer)
  OWNER TO postgres;

  -------------------------------------------------------------
  select * from moduli_campioni_html_fields  where  rev=9 and tipo_modulo=2


select * from lookup_moduli_campioni_contenitori

update lookup_moduli_campioni_contenitori set description='poste in contenitore di plastica' where code=2;
update lookup_moduli_campioni_contenitori set description='poste in contenitore di vetro' where code=3;
insert into lookup_moduli_campioni_contenitori (code, description) values (4,'lasciate nel proprio contenitore');



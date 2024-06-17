insert into m_lookup_patologie (code, description, level, enabled, bovini, ovicaprini) values 
(42,'Mancato rispetto dei tempi di sospensione', 42, true, true, false);
insert into m_lookup_patologie (code, description, level, enabled, bovini, ovicaprini) values 
(43,'Animale non identificato', 43, true, true, false);
insert into m_lookup_patologie (code,description, level, enabled, bovini, ovicaprini) values 
(44,'Trattamento con farmaci vietati', 44, true, true, false);
insert into m_lookup_patologie (code,description, level, enabled, bovini, ovicaprini) values 
(45,'Profilo genetico non corrispondente', 45, true, true, false);
insert into m_lookup_patologie(code,description, level, enabled, bovini, ovicaprini) values 
(46,'Superamento limite di farmaci', 46, true, true, false);
insert into m_lookup_patologie (code,description, level, enabled, bovini, ovicaprini) values 
(47,'Carni contaminate', 47, true, true, false);          
insert into m_lookup_patologie (code,description, level, enabled, bovini, ovicaprini) values 
(48,'Carni immature/idroemiche', 48, true, true, false);  
insert into m_lookup_patologie(code,description, level, enabled, bovini, ovicaprini) values 
(49,'Grave degenerazione delle carni', 49, true, true, false);  
insert into m_lookup_patologie(code,description, level, enabled, bovini, ovicaprini) values 
(50,'Insufficiente dissanguamento', 50, true, true, false);  
insert into m_lookup_patologie (code,description, level, enabled, bovini, ovicaprini) values 
(51,'Ittero', 51, true, true, false); 
insert into m_lookup_patologie(code,description, level, enabled, bovini, ovicaprini) values 
(52,'Mastite acuta', 52, true, true, false); 
insert into m_lookup_patologie (code,description, level, enabled, bovini, ovicaprini) values 
(53,'Gravi infiammazioni dell’apparato gastroenterico', 53, true, true, false);   

update m_lookup_patologie set enabled=false where code in(19,20);

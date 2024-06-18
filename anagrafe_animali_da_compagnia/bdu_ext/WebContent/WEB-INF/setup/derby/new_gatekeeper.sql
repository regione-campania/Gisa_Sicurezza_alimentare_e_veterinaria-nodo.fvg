-- ----------------------------------------------------------------------------
--  Apache Derby Table Creation
--
--  @author     Andrei I. Holub
--  @created    August 31, 2006
--  @version    $Id:$
-- ----------------------------------------------------------------------------

CREATE TABLE sites (
  site_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  sitecode VARCHAR(255) NOT NULL,				
  vhost VARCHAR(255) NOT NULL DEFAULT '',	
  dbhost VARCHAR(255) NOT NULL DEFAULT '',	
  dbname VARCHAR(255) NOT NULL DEFAULT '',	
  dbport INT NOT NULL DEFAULT 5432,	
  dbuser VARCHAR(255) NOT NULL DEFAULT '',
  dbpw VARCHAR(255) NOT NULL DEFAULT '',
  driver VARCHAR(255) NOT NULL DEFAULT '',
  code VARCHAR(255),
  enabled CHAR(1) NOT NULL DEFAULT '0',
  "language" VARCHAR(11)
);


CREATE TABLE events (
  event_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "second" VARCHAR(64) DEFAULT '0',
  "minute" VARCHAR(64) DEFAULT '*', 
  "hour" VARCHAR(64) DEFAULT '*',
  dayofmonth VARCHAR(64) DEFAULT '*',
  "month" VARCHAR(64) DEFAULT '*', 
  "dayofweek" VARCHAR(64) DEFAULT '*',
  "year" VARCHAR(64) DEFAULT '*',
  task VARCHAR(255),
  extrainfo VARCHAR(255),
  businessDays VARCHAR(6) DEFAULT 'true',
  enabled CHAR(1) DEFAULT '0',
  entered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE events_log (
  log_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  event_id INTEGER NOT NULL REFERENCES events(event_id),
  entered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status INT,
  "message" CLOB
);


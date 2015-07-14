-- This is the import table into which a single value will be pushed by socketimporter.

-- file -inlinebatch END_OF_BATCH

------- Socket Importer Table -------
CREATE TABLE importtable
     (
                  KEY   BIGINT NOT NULL ,
                  value BIGINT NOT NULL ,
                  insert_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                  CONSTRAINT pk_importtable PRIMARY KEY ( KEY )
     );
-- Partition on id
PARTITION TABLE importtable ON COLUMN KEY;

------- Kafka Importer Tables -------
CREATE TABLE kafkaimporttable1
     (
                  KEY   BIGINT NOT NULL,
                  value BIGINT NOT NULL,
                  insert_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                  CONSTRAINT pk_kafka_import_table1 PRIMARY KEY ( KEY )
     );
-- Partition on id
PARTITION TABLE kafkaimporttable1 ON COLUMN KEY;

CREATE TABLE kafkamirrortable1
     (
                  KEY   BIGINT NOT NULL ,
                  value BIGINT NOT NULL ,
                  insert_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                  CONSTRAINT pk_kafkamirrortable PRIMARY KEY ( KEY )
     );

-- Partition on id
PARTITION TABLE kafkamirrortable1 ON COLUMN KEY;

-- Export table
CREATE TABLE kafkaexporttable1
     (
                  KEY   BIGINT NOT NULL ,
                  value BIGINT NOT NULL
     );

EXPORT TABLE kafkaexporttable1;

-- Stored procedures

LOAD classes sp.jar;

CREATE PROCEDURE FROM class socketimporter.db.procedures.InsertExport;
CREATE PROCEDURE FROM class socketimporter.db.procedures.InsertImport;
CREATE PROCEDURE FROM class socketimporter.db.procedures.MatchRows;
CREATE PROCEDURE FROM class socketimporter.db.procedures.DeleteRows;

create procedure CountMirror as select count(*) from kafkamirrortable1;

-- END_OF_BATCH
           


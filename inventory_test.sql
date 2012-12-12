-- --------------------------------------------------------------------------------
--  Program Name:   inventory_test.sql
--  City of Rexburg: Inventory Database
--  Program Author: Alex Wilde
--  Creation Date:  12-Nov-2012
-- --------------------------------------------------------------------------------

-- Open log file.
TEE inventory_test.txt

-- This enables dropping tables with foreign key dependencies.
-- It is specific to the InnoDB Engine.
SET FOREIGN_KEY_CHECKS = 0; 

-- Conditionally drop objects.
SELECT 'SYSTEM_USER' AS "Drop Table";
DROP TABLE IF EXISTS system_user;

-- ------------------------------------------------------------------
-- Create SYSTEM_USER table.
-- ------------------------------------------------------------------
SELECT 'SYSTEM_USER' AS "Create Table";

CREATE TABLE system_user
( system_user_id              INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, system_user_name            CHAR(20)     NOT NULL
, system_user_group_id        INT UNSIGNED NOT NULL
, system_user_type            INT UNSIGNED NOT NULL
, first_name                  CHAR(20)
, middle_name                 CHAR(20)
, last_name                   CHAR(20)
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY system_user_fk1 (created_by)
, CONSTRAINT system_user_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY system_user_fk2 (last_updated_by)
, CONSTRAINT system_user_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO system_user
( system_user_name
, system_user_group_id
, system_user_type
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
('SYSADMIN', 1, 1, 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO system_user
( system_user_name
, system_user_group_id
, system_user_type
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
('SYSTEM_USER', 2, 2, 1, UTC_DATE(), 1, UTC_DATE());

-- Conditionally drop objects.
SELECT 'INV_ITEM' AS "Drop Table";
DROP TABLE IF EXISTS inv_item;

-- ------------------------------------------------------------------
-- Create INV_ITEM table.
-- ------------------------------------------------------------------
SELECT 'INV_ITEM' AS "Create Table";

CREATE TABLE inv_item
( created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, CONSTRAINT common_lookup_u1 UNIQUE INDEX (common_lookup_context, common_lookup_type)
, KEY common_lookup_fk1 (created_by)
, CONSTRAINT common_lookup_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY common_lookup_fk2 (last_updated_by)
, CONSTRAINT common_lookup_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Conditionally drop objects.
SELECT 'INV_STRUCT' AS "Drop Table";
DROP TABLE IF EXISTS inv_struct;

-- ------------------------------------------------------------------
-- Create INV_STRUCT table.
-- ------------------------------------------------------------------
SELECT 'INV_STRUCT' AS "Create Table";

-- --------------------------------------------------------------------------------
--  Program Name:   create_inventory.sql
--  Project: City of Rexburg IT Inventory Database
--  Program Author: Alex Wilde
--  Creation Date:  05-Dec-2012
-- --------------------------------------------------------------------------------

-- Open log file.
-- TEE create_inventory.txt

use thepeoq5_inventory;

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

-- Conditionally drop objects.
SELECT 'COMMON_LOOKUP' AS "Drop Table";
DROP TABLE IF EXISTS common_lookup;

-- ------------------------------------------------------------------
-- Create COMMON_LOOKUP table.
-- ------------------------------------------------------------------
SELECT 'COMMON_LOOKUP' AS "Create Table";

CREATE TABLE common_lookup
( common_lookup_id            INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, common_lookup_context       CHAR(30)     NOT NULL
, common_lookup_type          CHAR(30)     NOT NULL
, common_lookup_meaning       CHAR(30)     NOT NULL
, created_by                  INT UNSIGNED NOT NULL
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
DROP TABLE IF EXISTS inv_item;

-- ------------------------------------------------------------------
-- Create INV_ITEM table.
-- ------------------------------------------------------------------
SELECT 'INV_ITEM' AS "Create Table";

CREATE TABLE inv_item
( part_id                     INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, purchase_date  			  DATE
, purchase_price			  INT UNSIGNED
, install_date				  DATE
, uninstall_date			  DATE
, disposal_date				  DATE
, part_location				  INT UNSIGNED
, part_type					  INT UNSIGNED
, part_manufacturer			  INT UNSIGNED
, serial_number				  INT UNSIGNED
, manufacturer_part_number	  CHAR(12)
, vendor_part_number		  INT UNSIGNED
, on_domain					  CHAR(1)
, employee_assigned_to		  INT UNSIGNED
, department				  INT UNSIGNED
, division					  INT UNSIGNED
, hostname					  CHAR(30)
, operating_system			  CHAR(50)
, applications				  INT UNSIGNED
, description				  CHAR(250)
, item_color				  INT UNSIGNED
, speed						  INT UNSIGNED
, addressing				  CHAR(2)
, capacity					  INT UNSIGNED
, meid						  INT UNSIGNED
, logical_address			  CHAR(15)
, subnet_mask				  CHAR(15)
, physical_address			  CHAR(35)
, photo_path				  CHAR(120)
, msinfo32					  CHAR(10000)
, notes						  CHAR(10000)
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY inv_item_fk1 (created_by)
, CONSTRAINT inv_item_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY inv_item_fk2 (last_updated_by)
, CONSTRAINT inv_item_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
, KEY inv_item_fk3 (part_type)
, CONSTRAINT inv_item_fk1 FOREIGN KEY (part_type) REFERENCES common_lookup (common_lookup_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Conditionally drop objects.
SELECT 'INV_STRUCT' AS "Drop Table";
DROP TABLE IF EXISTS inv_struct;

-- ------------------------------------------------------------------
-- Create INV_STRUCT table.
-- ------------------------------------------------------------------
SELECT 'INV_STRUCT' AS "Create Table";

SCREATE TABLE inv_struct
( realtionship_id             INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, component_id				  INT UNSIGNED NOT NULL
, part_id		              INT UNSIGNED NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY inv_struct_fk1 (part_id)
, CONSTRAINT inv_struct_fk1 FOREIGN KEY (part_id) REFERENCES inv_item (part_id)
, KEY inv_struct_fk2 (created_by)
, CONSTRAINT inv_struct_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY inv_struct_fk3 (last_updated_by)
, CONSTRAINT inv_struct_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

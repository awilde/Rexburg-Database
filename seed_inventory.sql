-- --------------------------------------------------------------------------------
--  Program Name:   seed_inventory.sql
--  Project: City of Rexburg IT Inventory Database
--  Program Author: Alex Wilde
--  Creation Date:  05-Dec-2012
-- --------------------------------------------------------------------------------

-- Open log file.
-- TEE seed_inventory.txt

use thepeoq5_inventory;

-- Create Laptop Computer lookup id

INSERT INTO common_lookup
( common_lookup_context 
, common_lookup_type    
, common_lookup_meaning 
, created_by            
, creation_date         
, last_updated_by       
, last_update_date )     
VALUES
( 'DEVICE'
, 'LAPTOP_COMPUTER'
, 'Laptop Computer'
, 1
, UTC_DATE()
, 1
, UTC_DATE() );

-- Create City Hall location lookup id

INSERT INTO common_lookup
( common_lookup_context 
, common_lookup_type    
, common_lookup_meaning 
, created_by            
, creation_date         
, last_updated_by       
, last_update_date )     
VALUES
( 'Location'
, 'CITY_HALL'
, 'City Hall'
, 1
, UTC_DATE()
, 1
, UTC_DATE() );

-- Create HP Manufacturer lookup id

INSERT INTO common_lookup
( common_lookup_context 
, common_lookup_type    
, common_lookup_meaning 
, created_by            
, creation_date         
, last_updated_by       
, last_update_date )     
VALUES
( 'MANUFACTURER'
, 'HEWLETT_PACKARD'
, 'Hewlett Packard'
, 1
, UTC_DATE()
, 1
, UTC_DATE() );

-- Create HP Manufacturer lookup id

INSERT INTO common_lookup
( common_lookup_context 
, common_lookup_type    
, common_lookup_meaning 
, created_by            
, creation_date         
, last_updated_by       
, last_update_date )     
VALUES
( 'DEPARTMENT'
, 'TECHNOLOGY_COORDINATION_SERVICES'
, 'Technology Coordination Services'
, 1
, UTC_DATE()
, 1
, UTC_DATE() );


-- Create Alex's Laptop
INSERT INTO inv_item
( purchase_date
, purchase_price
, install_date
, part_location  			
, part_type					
, part_manufacturer			
, serial_number				
, manufacturer_part_number	
, employee_assigned_to			
, department				
, hostname					
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( UTC_DATE()
, 927.99
, UTC_DATE()
, 1
, (SELECT common_lookup_id FROM common_lookup WHERE common_lookup_meaning = 'Laptop')
, (SELECT common_lookup_id FROM common_lookup WHERE common_lookup_meaning = 'Hewlett Packard')
, '0987654321'
, 'HP Pavilion dm4'
, 'Alex Wilde'
, (SELECT common_lookup_id FROM common_lookup WHERE common_lookup_meaning = 'Technology Coordination Services')
, 'alexhpdm4'
, 1
, UTC_DATE()
, 1
, UTC_DATE() );

INSERT INTO common_lookup
( common_lookup_context 
, common_lookup_type    
, common_lookup_meaning 
, created_by            
, creation_date         
, last_updated_by       
, last_update_date )     
VALUES
( 'COMPUTER_PARTS'
, 'RAM'
, 'RAM'
, 1
, UTC_DATE()
, 1
, UTC_DATE() );

INSERT INTO common_lookup
( common_lookup_context 
, common_lookup_type    
, common_lookup_meaning 
, created_by            
, creation_date         
, last_updated_by       
, last_update_date )     
VALUES
( 'RAM'
, 'PC2-5200'
, 'PC2-5200'
, 1
, UTC_DATE()
, 1
, UTC_DATE() );

-- Create Memory
INSERT INTO inv_item
( purchase_date
, part_type					
, part_manufacturer			
, serial_number				
, manufacturer_part_number
, model
, speed
, capacity	
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( UTC_DATE()
, (SELECT common_lookup_id FROM common_lookup WHERE common_lookup_meaning = 'RAM')
, (SELECT common_lookup_id FROM common_lookup WHERE common_lookup_meaning = 'Hewlett Packard')
, '1234567890'
, '7567B'
, (SELECT common_lookup_id FROM common_lookup WHERE common_lookup_meaning = 'PC2-5200')
, 667
, 4
, UTC_DATE()
, 1
, UTC_DATE() );

-- Create Laptop/Part Relationship

INSERT INTO inv_struct
( component_id
, part_id 		   
, created_by       
, creation_date    
, last_updated_by  
, last_update_date )
VALUES
( (SELECT part_id FROM inv_item WHERE hostname = 'alexhpdm4')
, (SELECT part_id FROM inv_item WHERE serial_number = 

-- Joseph Tursi
-- Professor Labouseur
-- Database Management
-- 12/4/17
-- Resources -
-- https://www.quora.com/What-are-the-key-attributes-of-a-blockchain
-- https://medium.com/@ConsenSys/blockchain-underpinnings-hashing-7f4746cbd66b
-- https://en.bitcoin.it/wiki/Block_hashing_algorithm 
--https://en.bitcoin.it/wiki/Hashcash
-- https://en.bitcoin.it/wiki/Bitcoin_Core_0.11_(ch_6):_The_Blockchain 
-- https://blockgeeks.com/guides/what-is-hashing/
-- ==========================================================================
drop table if exists block;
drop table if exists branch;
drop table if exists transaction;
drop table if exists transactionInput;
drop table if exists transactionOutput;
drop table if exists address;





create table block(
blockID			int 	unique,
height			int,
bits			bigint,
prevhash		int,		
hash			int,		
branchID		int,
nonce			bigint,
timestamUTC		date,
timestamUnix	bigint,
merkleroot		int,			
transactioncount bigint,
primary key(blockID)
);



create table branch(
branchID		int 	unique,
parentbranch	int,
timestamUTC 	date,
primary key(branchID)
);



create table transaction(
transactionID		bigint	unique, 		-- this is the database id
blockID				int,
size 				bigint,
InputCount			bigint,
OutputCount			bigint,
TXID       			bigint,	--NEED TO CHANGE DATATYPE!!!!! -- THIS IS THE BLOCKCHAIN ID
index 				bigint,			
primary key(transactionID)
);

--transactionID> blockID, size, InputCount, OutputCount, TXID, index

-- Transaction Input --
-- id of the source of the transaction output

create table transactionInput(
transactionInputID			bigint  	unique, 
transactionID				bigint,
transactionOutputID 		bigint,
value 						bigint,
sequence					bigint,
index 						bigint,
primary key(transactionInputID)
);

--transactionInputID> transactionID, transactionInputID, value, sequence, index
-- Transaction Output --
-- id of the source of the transaction output 
-- you need the adressTXsource to send/receive and buy/sell
create table transactionOutput(
transactionOutputID		bigint 	unique,
transactionID			bigint,
value 					bigint,
toaddressType			int,
toaddress 				int,
index 					bigint,
primary key(transactionOutputID)
);

--transactionOutputID> transactionID, value, toaddressType, toaddress, index
/*
-- Asset --
-- this could be the transcript,records, bitcoin..?
-- be attached to the block or transaction?
create table asset(
assetID		int,
);*/

-- Address Maybe --


create table address(
addressID		bigint 		unique,
name			varchar(255),
description		varchar(255),
primary key(addressID)
);

--addressID> name, description

-- Loading Example Data --
-- Do I create a hash number? or do i need to calculate one/Algorithm needs string,counter, nonce
-- same thing for height or does it matter

-- block --
-- Do you want like actual hash, prevhash and merkle root values?
insert into block(blockID, height, bits, prevhash, hash, branchID, nonce, timestamUTC, timestamUnix, merkleroot, transactioncount)
	values(2, 0, 486604799, 00000, 00001, 1, 2083236893, '2017-10-30', 1231006505, 00001, 1);

insert into block(blockID, height, bits, prevhash, hash, branchID, nonce, timestamUTC, timestamUnix, merkleroot, transactioncount)
	values(3, 1, 486604799, 00001, 00002, 1, 2083236893, '2009-01-04' , 1231006505, 00002, 1);

-- branch --

insert into branch(branchID, parentbranch, timestamUTC)
	values(1, 0 , '2017-11-09');
insert into branch(branchID, parentbranch, timestamUTC)
	values(2, 1 , '2017-01-29');

-- transactions --
-- Index of metadata of the known transaction
-- Every transaction is linked to another transaction 

insert into transaction(transactionID, blockID, size, InputCount, OutputCount, TXID, index)
	values(43850, 43423, 134, 1, 1, 001, 0);

insert into transaction(transactionID, blockID, size, InputCount, OutputCount, TXID, index)
	values(43851, 43424, 134, 1, 1, 002, 0);

insert into transaction(transactionID, blockID, size, InputCount, OutputCount, TXID, index)
	values(43852, 43425, 135, 1, 1, 003, 0);

insert into transaction(transactionID, blockID, size, InputCount, OutputCount, TXID, index)
	values(43853, 43426, 135, 1, 1, 004, 0);

insert into transaction(transactionID, blockID, size, InputCount, OutputCount, TXID, index)
	values(43854, 43427, 134, 1, 1, 005, 0);

insert into transaction(transactionID, blockID, size, InputCount, OutputCount, TXID, index)
	values(43855, 43428, 135, 1, 1, 006, 0);



-- transaction inputs --

insert into transactionInput(transactionInputID, transactionID, transactionOutputID, value, sequence, index)
	values(2, 2, 200 , 500000, 7025013096, 0);

insert into transactionInput(transactionInputID, transactionID, transactionOutputID, value, sequence, index)
	values(3, 3, 300 , 500000, 7025013096, 0);

insert into transactionInput(transactionInputID, transactionID, transactionOutputID, value, sequence, index)
	values(4, 4, 400 , 500000, 7025013096, 0);

insert into transactionInput(transactionInputID, transactionID, transactionOutputID, value, sequence, index)
	values(5, 5, 500 , 500000, 7025013096, 0);

insert into transactionInput(transactionInputID, transactionID, transactionOutputID, value, sequence, index)
	values(6, 6, 600 , 500000, 7025013096, 0);

insert into transactionInput(transactionInputID, transactionID, transactionOutputID, value, sequence, index)
	values(7, 7, 700 , 500000, 7025013096, 0);



-- transactions outputs --

insert into transactionOutput(transactionOutputID, transactionID, value, toaddressType, toaddress, index)
	values(2, 2, 500000, 1, 112114, 0); -- CONVERT 112114 from the alphabet spells ALAN

insert into transactionOutput(transactionOutputID, transactionID, value, toaddressType, toaddress, index)
	values(3, 3, 500000, 1,112115 , 0);

insert into transactionOutput(transactionOutputID, transactionID, value, toaddressType, toaddress, index)
	values(4, 4, 500000, 1, 112116, 0);

insert into transactionOutput(transactionOutputID, transactionID, value, toaddressType, toaddress, index)
	values(5, 5, 500000, 1, 112117, 0);

insert into transactionOutput(transactionOutputID, transactionID, value, toaddressType, toaddress, index)
	values(6, 6, 500000, 1, 112118, 0);

insert into transactionOutput(transactionOutputID, transactionID, value, toaddressType, toaddress, index)
	values(7, 7, 500000, 1, 112119, 0);




-- address  --


insert into address(addressID, name, description)
	values(1, 'PublicKey', 'addresstype_publickey');

insert into address(addressID, name, description)
	values(2, 'BitcoinTest', 'BitcoinTest');

insert into address(addressID, name, description)
	values(3, 'NAVcoinTest', 'addresstype_NAVcoin');

insert into address(adressID, name, description)
	values(4, 'PrivateKey', 'addresstype_privatekey');

insert into address(addressID, name, description)
	values(5, 'None', 'addresstype_None');



-- ==========================================================================
-- SECURITY

-- 
CREATE ROLE ADMIN;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC 
TO ADMIN;

CREATE ROLE P_USER;
REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC
FROM P_USER;
GRANT SELECT ON BlockchainFile, Block, BitcoinTransaction,
TransactionInput, TransactionInputSource, TransactionOutput
TO P_USER;


 /*CREATE ROLE BUYER
 REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC
 FROM BUYER;
 GRANT 
*/
-- ==========================================================================
-- VIEWS
-- use this view to retrieve aggregated data for a transaction including total input, output and transaction fees
-- \.
-- Example:
    -- SELECT * from view_transactionAggregated WHERE BitcoinTransactionId= 25
CREATE VIEW View_TransactionAggregated AS 
SELECT 
blockID	,		
height	,	
bits	,		
prevhash,				
hash	,				
branchID,	
nonce,			
timestamUTC,		
timestamUnix,	
merkleroot,					
transactioncount bigint,
FROM (
    SELECT 
        BitcoinTransaction.BitcoinTransactionId,
        BitcoinTransaction.BlockId,
        BitcoinTransaction.TransactionHash,
        BitcoinTransaction.TransactionVersion,
        BitcoinTransaction.TransactionLockTime,
        (   SELECT COUNT(1) 
            FROM TransactionInput
            WHERE BitcoinTransaction.BitcoinTransactionId = TransactionInput.BitcoinTransactionId 
        ) AS TransactionInputCount,
        (   SELECT SUM(TransactionOutput.OutputValueBtc)
            FROM TransactionInput 
            INNER JOIN TransactionOutput ON TransactionOutput.TransactionOutputId = TransactionInput.SourceTransactionOutputId
            WHERE TransactionInput.BitcoinTransactionId = BitcoinTransaction.BitcoinTransactionId
        ) AS TotalInputBtc,
        (   SELECT COUNT(1) 
            FROM TransactionOutput
            WHERE BitcoinTransaction.BitcoinTransactionId = TransactionOutput.BitcoinTransactionId 
        ) AS TransactionOutputCount,
        (   SELECT SUM(TransactionOutput.OutputValueBtc)
            FROM TransactionOutput
            WHERE TransactionOutput.BitcoinTransactionId = BitcoinTransaction.BitcoinTransactionId
        ) AS TotalOutputBtc,
        (   SELECT SUM(TransactionOutput.OutputValueBtc)
            FROM TransactionOutput
            LEFT OUTER JOIN TransactionInput ON TransactionInput.SourceTransactionOutputId = TransactionOutput.TransactionOutputId
            WHERE 
                TransactionOutput.BitcoinTransactionId = BitcoinTransaction.BitcoinTransactionId
                AND TransactionInput.TransactionInputId IS NULL
        ) AS TotalUnspentOutputBtc
    FROM BitcoinTransaction) AS TransactionAggregated

--View_BlockAggregated
-- Use this view retrieve aggregated data for a block including the 
-- total input, output and transaction fees. 
-- Example: 
--      SELECT * FROM View_BlockAggregated WHERE BlockId = 100
DROP VIEW IF EXISTS View_BlockAggregated;
CREATE VIEW View_BlockAggregated AS 
SELECT 
    Block.BlockId,
    Block.BlockchainFileId,
    Block.BlockVersion,
    Block.BlockHash,
    Block.PreviousBlockHash,
    Block.BlockTimestamp,
    BlockAggregated.TransactionCount,
    BlockAggregated.TransactionInputCount,
    BlockAggregated.TransactionOutputCount,
    BlockAggregated.TotalOutputBtc,
   -- BlockAggregated.TransactionFeeBtc, This is = (TotalInputBtc - TotalOutputBtc) How do I like do that...
    BlockAggregated.TotalUnspentOutputBtc
From Block
INNER JOIN (
    selectT 
        Block.BlockId,
        SUM(1) AS TransactionCount,
        SUM(TransactionInputCount) AS TransactionInputCount,
        SUM(TotalInputBtc) AS TotalInputBtc,
        SUM(TransactionOutputCount) AS TransactionOutputCount,
        SUM(TotalOutputBtc) AS TotalOutputBtc,
        --SUM(TransactionFeeBtc) AS TransactionFeeBtc,
        SUM(TotalUnspentOutputBtc) AS TotalUnspentOutputBtc
    from Block
    INNER join View_TransactionAggregated ON Block.BlockId = View_TransactionAggregated.BlockId
    GROUP BY Block.BlockId
    ) AS BlockAggregated ON BlockAggregated.BlockId = Block.BlockId




-- ==========================================================================
-- TRIGGERS -- 
/* Every time we get a new input we link an existing output to it */
CREATE OR REPLACE FUNCTION link_txs() RETURNS TRIGGER AS $$
BEGIN
  UPDATE TransactionOutput
  SET InputHash = (SELECT TransactionHash FROM BitcoinTransaction WHERE BlockId = NEW.BitcoinTransactionId)
     ,InputIndex = NEW.index
  WHERE BitcoinTransactionId = (SELECT BlockId FROM BitcoinTransaction WHERE BlockHash = NEW.OutputHash)
    AND index = NEW.OutputIndex;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_input_linkoutput BEFORE INSERT ON TransactionInput
  FOR EACH ROW EXECUTE PROCEDURE link_txs();

/* Update existing Transactions */
CREATE TRIGGER link_input_output_
UPDATE TransactionOutput
SET InputHash = data.InputHash,
 InputIndex = data.InputIndex
FROM (SELECT TransactionHash AS InputHash, index AS InputIndex, OutputIndex, OutputHash
      FROM TransactionInput LEFT JOIN BitcoinTransaction
      ON TransactionInput.BitcoinTransactionId = BitcoinTransaction.BlockId) data
WHERE TransactionOutput.BitcoinTransactionId = (SELECT BlockId FROM BitcoinTransaction WHERE TransactionHash = data.OutputHash)
AND TransactionOutput.index = data.OutputIndex;



CREATE OR REPLACE FUNCTION update_Blockchain_status()
RETURNS TRIGGER AS
$$
BEGIN
IF NEW.BlockchainFileId  is NOT NULL THEN
UPDATE BlockchainFile
SET available = FALSE
WHERE NEW.BlockchainFileId  = BlockchainFile.BlockchainFileId;
END IF;
RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


-- ==========================================================================

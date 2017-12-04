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
drop table if exists BlockchainFile;
drop table if exists Branch;
drop table if exists Block;
drop table if exists BitcoinTransaction;
drop table if exists TransactionInput;
drop table if exists TransactionInputSource;
drop table if exists TransactionOutput;
drop table if exists BtcDbSettings;
drop table if exists address;
-- TABLE: BlockchainFile
-- Contains information about the blockchain files 

CREATE TABLE BlockchainFile (
    BlockchainFileId                     INT PRIMARY KEY            NOT NULL,
    BlockchainFileName                   VARCHAR (300)             NOT NULL
);

create table Branch(
branchID        int,
parentbranch    int,
BlockTimeStamp  date,
primary key(branchID)
);

-- TABLE: Block
-- Contains information about the Bitcoin blocks.
CREATE TABLE Block (
    BlockId                         BIGINT PRIMARY KEY              NOT NULL,
    branchID                        INT,
    BlockchainFileId                INT                             NOT NULL,
    BitcoinTransactionId            BIGINT             NOT NULL,
    BlockVersion                    INT                             NOT NULL,
    BlockHash                       VARCHAR (200)                  NOT NULL,
    PreviousBlockHash               VARCHAR (200)                  NOT NULL,
    BlockTimestamp                  DATE                           NOT NULL,
    TransactionHash                 VARCHAR (32)                    NOT NULL
);

/*
create table Block_next(
BlockId
nextBlockId
)

*/

-- TABLE: BitcoinTransaction
-- Contains information about the Bitcoin transactions.
CREATE TABLE BitcoinTransaction (
    BitcoinTransactionId            BIGINT PRIMARY KEY              NOT NULL,
    BlockId                         BIGINT                          NOT NULL,
    TXID                            bigint                          NOT NULL,
    TransactionHash                 VARCHAR (32)                    NOT NULL,
    TransactionVersion              INT                             NOT NULL,
    TransactionLockTime             INT                             NOT NULL
);


-- TABLE: TransactionInput
-- Contains information about the Bitcoin transaction inputs.
CREATE TABLE TransactionInput (
    TransactionInputId              BIGINT PRIMARY KEY              NOT NULL,                         
    SourceTransactionOutputId       BIGINT                          NULL,
    
    -- This column is provided as a way to optimize queries where a join is
    -- required between an input and its corresponding output. 
    TransactionOutputId             BIGINT                          NULL,
    OutputHash                      TEXT                            NOT NULL,
    OutputIndex                     INT                             NOT NULL,
    index                           INT                             NOT NULL,
    BitcoinTransactionId            BIGINT                          NOT NULL
                         
);



-- TABLE: TransactionInputSource
-- Contains information about the source of the Bitcoin transaction inputs.
-- This table contains links between transaction inputs and their
-- corresponding source outputs. 
-- a stage where data from this table is processed and a more direct link is 
-- calculated and saved in TransactionInput.SourceTransactionOutputId. Any 
-- queries where a join is required between an input and its corresponding 
-- output should use TransactionInput.SourceTransactionOutputId.
CREATE TABLE TransactionInputSource (
    TransactionInputId              BIGINT PRIMARY KEY              NOT NULL,

    -- The hash of the transaction that contains the output that is the source
    -- of this input.
    -- Note: hash is in reverse order.
    SourceTransactionHash           VARCHAR (32)                  NOT NULL,

    -- The index of the output that will be consumed by this input.
    -- The index is a zero based index in the list of outputs of the 
    -- transaction that it belongs to.
    SourceTransactionOutputIndex    INT                             NULL
);


-- TABLE: TransactionOutput
-- Contains information about the Bitcoin transaction outputs.

CREATE TABLE TransactionOutput (
    TransactionOutputId             BIGINT PRIMARY KEY              NOT NULL,
    BitcoinTransactionId            BIGINT                          NOT NULL,
    OutputIndex                     INT                             NOT NULL,
    OutputValueBtc                  NUMERIC(20,8)                   NOT NULL,
    OutputScript                    VARCHAR (300)                   NOT NULL,
    index                           INT                             NOT NULL,
    InputHash                       VARCHAR(64),
    InputIndex                      INT              
);

-- TABLE: BtcDbSettings
--  Key-value pairs containing system data.
CREATE TABLE BtcDbSettings (
    PropertyName                    VARCHAR (32) PRIMARY KEY       NOT NULL,
    PropertyValue                   VARCHAR (500)                  NOT NULL
);

create table address(
addressID       bigint,
name            varchar(255),
description     varchar(255),
primary key(addressID)
);

-- ==========================================================================
-- iNSERT DATA IN THIS ISH

insert into BlockchainFile(BlockchainFileId, BlockchainFileName)
    values(2, 'AlanLabouseur');



--
insert into Block(BlockId, branchID, BlockchainFileId, BitcoinTransactionId, BlockVersion, BlockHash, PreviousBlockHash,BlockTimestamp, TransactionHash)
    values(100, 1, 1, 25, 1, 'ab', 'aabc', '2017-07-19', 'cb');

insert into Block(BlockId, branchID, BlockchainFileId, BitcoinTransactionId, BlockVersion, BlockHash, PreviousBlockHash,BlockTimestamp, TransactionHash)
    values(101, 1, 2, 26, 1, 'abc', 'abcd', '2017-12-05', 'ca');
insert into Block(BlockId, branchID, BlockchainFileId, BitcoinTransactionId, BlockVersion, BlockHash, PreviousBlockHash,BlockTimestamp, TransactionHash)
    values(102, 1, 3, 27, 1, 'abd', 'abde', '2017-02-22', 'cd');
insert into Block(BlockId, branchID, BlockchainFileId, BitcoinTransactionId, BlockVersion, BlockHash, PreviousBlockHash,BlockTimestamp, TransactionHash)
    values(103, 1, 4, 28, 1, 'abe', 'aabef', '2017-05-12', 'ce');
insert into Block(BlockId, branchID, BlockchainFileId, BitcoinTransactionId, BlockVersion, BlockHash, PreviousBlockHash,BlockTimestamp, TransactionHash)
    values(104, 1, 5, 29, 1, 'abf', 'abg', '2017-07-19', 'cf');


insert into BitcoinTransaction(BitcoinTransactionId, BlockId, TXID, TransactionHash, TransactionVersion, TransactionLockTime)
    values(25, 100, 50, 'a', 1, 419382);
insert into BitcoinTransaction(BitcoinTransactionId, BlockId, TXID, TransactionHash, TransactionVersion, TransactionLockTime)
    values(26, 101, 51, 'ab', 1, 419382);
insert into BitcoinTransaction(BitcoinTransactionId, BlockId, TXID, TransactionHash, TransactionVersion, TransactionLockTime)
    values(27, 102, 52, 'abc', 1, 419382);
insert into BitcoinTransaction(BitcoinTransactionId, BlockId, TXID, TransactionHash, TransactionVersion, TransactionLockTime)
    values(28, 103, 53, 'abcd', 1, 419382);
insert into BitcoinTransaction(BitcoinTransactionId, BlockId, TXID, TransactionHash, TransactionVersion, TransactionLockTime)
    values(29, 104, 54, 'abcde', 1, 419382);



--
insert into TransactionInput(TransactionInputId,  SourceTransactionOutputId, TransactionOutputId, OutputHash, OutputIndex, index, BitcoinTransactionId)
    values(335, 25, 100, 'zzzf', 0, 0, 25);
insert into TransactionInput(TransactionInputId,  SourceTransactionOutputId, TransactionOutputId, OutputHash, OutputIndex, index, BitcoinTransactionId)
    values(336, 26, 101, 'abcd', 0, 0, 26);
insert into TransactionInput(TransactionInputId,  SourceTransactionOutputId, TransactionOutputId, OutputHash, OutputIndex, index, BitcoinTransactionId)
    values(337, 27, 102, 'dcba', 0, 0, 27);
insert into TransactionInput(TransactionInputId,  SourceTransactionOutputId, TransactionOutputId, OutputHash, OutputIndex, index, BitcoinTransactionId)
    values(338, 28, 103, 'badd', 0, 0, 28);
insert into TransactionInput(TransactionInputId,  SourceTransactionOutputId, TransactionOutputId, OutputHash, OutputIndex, index, BitcoinTransactionId)
    values(339, 29, 104, 'badc', 0, 0, 29);
--
insert into TransactionInputSource(TransactionInputId, SourceTransactionHash, SourceTransactionOutputIndex)
    values(335, 'a', 400 );
insert into TransactionInputSource(TransactionInputId, SourceTransactionHash, SourceTransactionOutputIndex)
    values(336, 'a', 401);
insert into TransactionInputSource(TransactionInputId, SourceTransactionHash, SourceTransactionOutputIndex)
    values(337, 'a', 402);
insert into TransactionInputSource(TransactionInputId, SourceTransactionHash, SourceTransactionOutputIndex)
    values(338, 'a', 403);
insert into TransactionInputSource(TransactionInputId, SourceTransactionHash, SourceTransactionOutputIndex)
    values(339, 'a', 404);
--
insert into TransactionOutput(TransactionOutputId, BitcoinTransactionId, OutputIndex, OutputValueBtc, OutputScript, index, InputHash, InputIndex)
    values(7, 25, 0, 5.6, 'Complete', 0, 'a', 0);
insert into TransactionOutput(TransactionOutputId, BitcoinTransactionId, OutputIndex, OutputValueBtc, OutputScript, index, InputHash, InputIndex)
    values(8, 26, 0, 14.2, 'Complete', 0, 'a', 0);
insert into TransactionOutput(TransactionOutputId, BitcoinTransactionId, OutputIndex, OutputValueBtc, OutputScript, index, InputHash, InputIndex)
    values(9, 27, 0, 201.3, 'Complete', 0, 'a', 0);
insert into TransactionOutput(TransactionOutputId, BitcoinTransactionId, OutputIndex, OutputValueBtc, OutputScript, index, InputHash, InputIndex)
    values(10, 28, 0, 32.0, 'Complete', 0, 'a', 0);
insert into TransactionOutput(TransactionOutputId, BitcoinTransactionId, OutputIndex, OutputValueBtc, OutputScript, index, InputHash, InputIndex)
    values(11, 29, 0, 8.2, 'Complete', 0, 'a', 0);

--
insert into BtcDbSettings(PropertyName, PropertyValue)
    values('ALAN', 'Backup');


insert into branch(branchID, parentbranch, BlockTimestamp)
    values(12, 11, '2017-01-01');

insert into address(addressID, name, description)
    values(12, 'Depression', 'So much time invested, so much to do still')

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
    BitcoinTransactionId,
    BlockId,
    TransactionHash,
    TransactionVersion,
    TransactionLockTime,
    TransactionInputCount,
    TransactionOutputCount,
    TotalOutputBtc,
    TotalUnspentOutputBtc
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
FROM Block
INNER JOIN (
    SELECT 
        Block.BlockId,
        SUM(1) AS TransactionCount,
        SUM(TransactionInputCount) AS TransactionInputCount,
        SUM(TotalInputBtc) AS TotalInputBtc,
        SUM(TransactionOutputCount) AS TransactionOutputCount,
        SUM(TotalOutputBtc) AS TotalOutputBtc,
        --SUM(TransactionFeeBtc) AS TransactionFeeBtc,
        SUM(TotalUnspentOutputBtc) AS TotalUnspentOutputBtc
    FROM Block
    INNER JOIN View_TransactionAggregated ON Block.BlockId = View_TransactionAggregated.BlockId
    GROUP BY Block.BlockId
    ) AS BlockAggregated ON BlockAggregated.BlockId = Block.BlockId

-- VIEW View_BlockchainFileCounts
-- Use this view retrieve data about a blockchain file.
-- Example: 
--      SELECT * FROM View_BlockchainFileCounts WHERE BlockchainFileId = 100

DROP VIEW IF EXISTS View_BlockchainFileCounts;
CREATE VIEW View_BlockchainFileCounts AS 
SELECT 
    BlockchainFile.BlockchainFileId,
    BlockchainFileName,
    ( SELECT COUNT(1) FROM Block WHERE Block.BlockchainFileId = BlockchainFile.BlockchainFileId ) AS BlockCount,
    ( SELECT COUNT(1) 
      FROM BitcoinTransaction 
      INNER JOIN Block ON Block.BlockId = BitcoinTransaction.BlockId
      WHERE Block.BlockchainFileId = BlockchainFile.BlockchainFileId 
    ) AS TransactionCount,
    ( SELECT COUNT(1) 
      FROM TransactionInput
      INNER JOIN BitcoinTransaction ON BitcoinTransaction.BitcoinTransactionId = TransactionInput.BitcoinTransactionId
      INNER JOIN Block ON Block.BlockId = BitcoinTransaction.BlockId
      WHERE Block.BlockchainFileId = BlockchainFile.BlockchainFileId 
    ) AS TransactionInputCount,
    ( SELECT COUNT(1) 
      FROM TransactionOutput
      INNER JOIN BitcoinTransaction ON BitcoinTransaction.BitcoinTransactionId = TransactionOutput.BitcoinTransactionId
      INNER JOIN Block ON Block.BlockId = BitcoinTransaction.BlockId
      WHERE Block.BlockchainFileId = BlockchainFile.BlockchainFileId 
    ) AS TransactionOutputCount
FROM BlockchainFile





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

CREATE TRIGGER update_Blockchain_status_trigger
BEFORE INSERT ON BlockchainFile
FOR EACH ROW 
EXECUTE PROCEDURE update_Blockchain_status();

-- ==========================================================================
-- STORE PROCEDURES --
 --Size of blocks for a given time period 


/* Distribution of UTXOs.  This is h
CREATE OR REPLACE FUNCTION utxo_distribution(DATE) RETURNS TABLE(num BIGINT[], value BIGINT[]) AS $$
  BEGIN
    RETURN QUERY WITH utxo AS (SELECT * FROM TransactionOutput WHERE InputHash IS NULL)
    SELECT (num) AS num, (value) AS value
    FROM (SELECT num, value::BIGINT FROM (SELECT 'satoshi' AS  range
                                            ,1 AS rangenum
                                            ,COUNT(1) AS num
                                            ,COALESCE(SUM(value), 0) AS value
                                      FROM t_utxo
                                      WHERE value >= 0 AND value < 100
                                      UNION
                                      SELECT 'uBTC' AS range
                                            ,2 AS rangenum
                                            ,COUNT(1) AS num
                                            ,COALESCE(SUM(value), 0) AS _value
  



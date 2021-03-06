SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;


CREATE SCHEMA DealDone;


SET search_path = DealDone;


CREATE TABLE Customer (
   custID char(9) NOT NULL,
   fname Varchar(15),
    lname Varchar(15),
    Contact Varchar(13),
    Email_id Varchar(20),
    PRIMARY KEY (custID)
);


CREATE TABLE CustomerAddress (
   custID char(9) NOT NULL,
   Address Varchar(30),
    PRIMARY KEY (custID,Address),
    FOREIGN KEY (custID) REFERENCES Customer(custID)
           ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Category(
      catID char(9),
      catName Varchar(20),
      PRIMARY KEY (catID)
);


CREATE TABLE Items (
    itemCode Varchar(5) NOT NULL,
    Name Varchar(20),
    catID char(9),
    Stock integer,
    Brand Varchar(20),
    Discount numeric(3,1),
    Price Decimal(8,2),
    Rating numeric(2,1),
    Description Varchar(30),
    PRIMARY KEY (itemCode),
    FOREIGN KEY (catID) REFERENCES Category(catID) 
              ON DELETE SET NULL ON UPDATE CASCADE
 
);


CREATE TABLE DeliveryService (
delivery_address Varchar(30),
delivery_charge numeric(5,2),
contact_no Varchar(13),
PRIMARY KEY (delivery_address)    
);


CREATE TABLE purchased(
      itemCode Varchar(5),
      custID char(9),
      Quantity integer,
         purchased_date date,
      PRIMARY KEY (itemCode, custID, purchased_date),
      FOREIGN KEY (itemCode) REFERENCES Items(itemCode) 
             ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (custID) REFERENCES Customer(custID)
             ON DELETE CASCADE ON UPDATE CASCADE


);


CREATE TABLE Bills(
        Bill_no Varchar(5) NOT NULL,
        custID char(9),
        itemCode Varchar(5),
        delivery_address Varchar(30),
        bill_date date,
        Mode_of_Payment Varchar(15),
expected_delivery_date Date,
        PRIMARY KEY(bill_no,itemCode),
        FOREIGN KEY (custID,itemCode, bill_date) REFERENCES purchased(custID,itemCode, purchased_date) 
             ON DELETE SET NULL ON UPDATE CASCADE, 
        FOREIGN KEY (delivery_address) REFERENCES                                DeliveryService(delivery_address) 
             ON DELETE SET NULL ON UPDATE CASCADE
);
 


CREATE TABLE wishes_to_buy(
      custID char(9),
      itemCode Varchar(5),
      PRIMARY KEY (itemCode, custID),
      FOREIGN KEY (itemCode) REFERENCES Items(itemCode) 
              ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (custID) REFERENCES Customer(custID) 
              ON DELETE CASCADE ON UPDATE CASCADE
);
-- drop tables in the opposite order that you create them
drop table if exists [line_item]
drop table if exists [request]
drop table if exists [product]
drop table if exists [vendor]
drop table if exists [user]
go

create table [user] (
	ID int identity(1,1) primary key,
	-- nvarchar supports unicode
	-- you always want to use nvarchar instead of varchar (where it makes sense)
	UserName nvarchar(15) not null,
	[Password] nvarchar(10) not null, -- varbinary(128)
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Phone varchar(12), -- example: nnn-nnn-nnnn
	Email nvarchar(75) not null,
	IsManager bit not null default 0 -- default: false
)
go
create unique index idx_user_username
	on [user](UserName asc)
go
insert into [user] 
	(UserName, [Password], FirstName, LastName, Email)
Values
	('normaluser', 'password', 'Steven', 'Spaghetti', 'sspaghetti@aol.com')
go
-- Vendor table
create table [vendor] (
	ID int identity(1,1) primary key,
	Code varchar(10) not null,
	[Name] nvarchar(255) not null,
	[Address] varchar(255) not null,
	City varchar(255) not null,
	[State] char(2) not null,
	[Zip] varchar(5) not null,
	Phone varchar(12),
	Email varchar(255),
	IsPreapproved bit not null default 0
)
go
create unique index idx_vendor_code
	on [vendor](Code asc)
go
insert into [vendor]
	(Code, [Name], [Address], City, [State], [Zip])
values
	('WAL0001', 'Walmart', '123 Any St', 'Little Rock', 'AR', '72002')
go
create table [product] (
	ID int identity(1,1) primary key,
	VendorID int not null foreign key references [vendor](ID),
	[Name] varchar(150) not null,
	PartNumber varchar(50) not null,
	Price decimal(12,2) not null default 0.00,
	Unit varchar(20) not null default 'Each',
	PhotoPath varchar(255)
)
go
create unique index idx_product_vendorid_partnumber
	on [product](VendorID, PartNumber)
go
insert into [product]
	(VendorID, [Name], PartNumber, Price)
values
	(1, 'Ball', 'BALL001', 5.99)
go
create table [request] (
	ID int identity(1,1) primary key,
	UserID int not null foreign key references [user](ID),
	[Description] varchar(100) not null,
	Justification varchar(255),
	DateNeeded datetime,
	DeliveryMode varchar(25),
	DocsAttached bit not null default 1,
	[Status] varchar(10),
	Total decimal(12,2) default 0.00,
	SubmittedDate datetime not null default GETDATE()
)
go
insert into [request]
	(UserID, [Description], [Status])
values
	(1, 'My first request', 'NEW')
go
create table [line_item](
	ID int identity(1,1) not null primary key,
	Quantity int not null,
	RequestID int not null foreign key references [request](ID),
	ProductID int not null foreign key references [product](ID)
)
go
create unique index idx_requestid_productid
	on [line_item](RequestID, ProductID)
go
insert into [line_item]
	(RequestID, ProductID, Quantity)
Values
	(1, 1, 10)
go

/*use master
go
drop database if exists prs
go
create database prs
go
use prs
go

drop table if exists [line_item]
drop table if exists [request]
drop table if exists [product]
drop table if exists [vendor]
drop table if exists [user]
go

create table [user] (
	ID int identity(1,1) primary key,
	UserName varchar(20) not null,
	Password varchar(10) not null,
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	Phone varchar(12),
	Email varchar(75) not null,
	IsManager bit not null default 0
)

create unique index idx_user_username
	on [user] (UserName asc) 

create table [vendor] (
	ID int identity(1,1) primary key,
	Code varchar(10) not null,
	Name varchar(255) not null,
	Address varchar(255) not null,
	City varchar(255) not null,
	State varchar(2) not null,
	Zip varchar(5) not null,
	Phone varchar(12),
	Email varchar(255),
	IsPreApproved bit default 0
)

create unique index idx_vendor_code
	on [vendor] (Code asc)

create table [product] (
	ID int identity(1,1) primary key,
	VendorId int foreign key references [vendor](ID),
	Name varchar(150) not null,
	PartNumber varchar(50) not null,
	Price decimal(10,2) not null default(0.0),
	Unit varchar(10) not null default 'Each',
	PhotoPath varchar(255)
)

create unique index idx_product_vendorid_partnumber
	on [product] (VendorId asc, PartNumber asc)

create table [request] (
	ID int identity(1,1) primary key,
	UserID int foreign key references [user](ID),
	Description varchar(100),
	Justification varchar(255),
	DateNeeded DateTime,
	DeliveryMode varchar(25),
	DocsAttached bit not null default 0,
	Status varchar(10),
	Total decimal(10,2) not null default 0.0,
	SubmittedDate DateTime not null default getdate()
)

create table [line_item] (
	ID int identity(1,1) primary key,
	RequestID int foreign key references [request](ID),
	ProductID int foreign key references [product](ID),
	Quantity int not null default 1
)

create unique index idx_line_item_requestid_productid
	on [line_item] (RequestId asc, ProductId asc)
go*/
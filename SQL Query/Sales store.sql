
create database POINTOFSALE
USE POINTOFSALE

go

use POINTOFSALE

go

create table Menu(
[idMenu] int primary key identity(1,1),
[description] varchar(30),
[icon] varchar(30),
[controller] varchar(30),
[pageAction] varchar(30),
[isActive] bit,
[registrationDate] datetime default getdate(),
[idMenuParent] int references Menu(idMenu)
)
SELECT * FROM mENU

go


create table Rol(
[idRol] int primary key identity(1,1),
[description] varchar(30),
[isActive] bit,
[registrationDate] datetime default getdate()
)
 go

 
 create table RolMenu(
 [idRolMenu] int primary key identity(1,1),
  [isActive] bit,
 [registrationDate] datetime default getdate(),
 [idRol] int references Rol(idRol),
 [idMenu] int references Menu(idMenu)
 )

 go


create table Users(
[idUsers] int primary key identity(1,1),
[name] varchar(50),
[email] varchar(50),
[phone] varchar(50),
[idRol] int references Rol(idRol),
[password] varchar(100),
[photo] varbinary(max),
[isActive] bit,
[registrationDate] datetime default getdate()
)

go

create table Category(
[idCategory] int primary key identity(1,1),
[description] varchar(50),
[isActive] bit,
[registrationDate] datetime default getdate()
)

go

create table Product(
[idProduct] int primary key identity(1,1),
[barCode] varchar(50),
[brand] varchar(50),
[description] varchar(100),
[quantity] int,
[price] decimal(10,2),
[photo] varbinary(max),
[isActive] bit,
[registrationDate] datetime default getdate(),
[idCategory] int references Category(idCategory)
)

go

create table CorrelativeNumber(
[idCorrelativeNumber] int primary key identity(1,1),
[lastNumber] int,
[quantityDigits] int,
[management] varchar(100),
[dateUpdate] datetime
)

go


create table TypeDocumentSale(
[idTypeDocumentSale] int primary key identity(1,1),
[description] varchar(50),
[isActive] bit,
[registrationDate] datetime default getdate()
)

go

create table Sale(
[idSale] int primary key identity(1,1),
[saleNumber] varchar(6),
[idTypeDocumentSale] int references TypeDocumentSale(idTypeDocumentSale),
[idUsers] int references Users(idUsers),
[customerDocument] varchar(10),
[clientName] varchar(20),
[Subtotal] decimal(10,2),
[totalTaxes] decimal(10,2),
[total] decimal(10,2),
[registrationDate] datetime default getdate()
)

go


create table DetailSale(
[idDetailSale] int primary key identity(1,1),
[idSale] int references Sale(idSale),
[idProduct] int,
[brandProduct] varchar(100),
[descriptionProduct] varchar(100),
[categoryProducty] varchar(100),
[quantity] int,
[price] decimal(10,2),
[total] decimal(10,2)
)

go

create table Negocio(
idNegocio int primary key,
urlLogo varchar(500),
nombreLogo varchar(100),
numeroDocumento varchar(50),
nombre varchar(50),
correo varchar(50),
direccion varchar(50),
telefono varchar(50),
porcentajeImpuesto decimal(10,2),
simboloMoneda varchar(5)
)



use POINTOFSALE

--________________________________ INSERT ROL ________________________________
insert into rol([description],isActive) values
('Admin',1),
('Employee',1),
('Inspector',1)

go


--________________________________ INSERT USER DEFAULT ________________________________

insert into Users(name,email,phone,idRol,[password],photo,isActive) values
('codeStudent','codeStudent@example.com','909090',1,'123',null,1)

go
insert into Users(name,email,phone,idRol,[password],photo,isActive) values
('John Doe','john.doe@example.com','123-456-7890',1,'hashed_password_1',null,1)



select * from users
delete from users

-- Reseed the identity column to start from 1
DBCC CHECKIDENT ('users', RESEED, 0);

-- Assuming you have the image file "john_doe_photo.jpg" stored in a directory
-- where the SQL Server has read access.
-- Read the image data and convert it to binary.
DECLARE @imageData varbinary(max)
SELECT @imageData = BulkColumn FROM OPENROWSET(BULK 'C:\Users\Srimathi Page\OneDrive - Softpath System LLC\Pictures\rose.jpg', SINGLE_BLOB) as img;
insert into Users(name,email,phone,idRol,[password],photo,isActive) values
('Srimathipage','sri@gmail.com','1234560890',1,'1566',@imageData,1)

-- Now, insert the data into the "Users" table:
INSERT INTO Users ([name], [email], [phone], [idRol], [password], [photo], [isActive])
VALUES
    ('John Doe', 'john.doe@example.com', '123-456-7890', 1, 'hashed_password_1', @imageData, 1);




--________________________________ INSERT CATEGORIES ________________________________

INSERT INTO Category([description],isActive) values
('Computers',1),
('Laptops',1),
('Keyboards',1),
('Monitors',1),
('Microphones',1)

go

--________________________________ INSERT TYPEDOCUMENTSALE ________________________________

insert into TypeDocumentSale([description],isActive) values
('Ticket',1),
('invoice',1)
select * from TypeDocumentSale

go
--________________________________ INSERT CORRELATIVE NUMBER ________________________________

--000001
insert into CorrelativeNumber(lastNumber,quantityDigits,management,dateUpdate) values
(0,6,'Sale',getdate())


go
--________________________________ INSERT MENUS ________________________________

--*menu parent

insert into Menu([description],icon,isActive) values
('Admin','mdi mdi-view-dashboard-outline',1),
('Inventory','mdi mdi-package-variant-closed',1),
('Sales','mdi mdi-shopping',1),
('Reports','mdi mdi-chart-bar',1)


--*menu child - Admin
insert into Menu([description],idMenuParent,controller,pageAction,isActive) values
('DashBoard',1,'Admin','DashBoard',1),
('Users',1,'Admin','Users',1)


--*menu child - Inventory
insert into Menu([description],idMenuParent,controller,pageAction,isActive) values
('Categories',2,'Inventory','Categories',1),
('Products',2,'Inventory','Products',1)

--*menu child - Sales
insert into Menu([description],idMenuParent,controller,pageAction,isActive) values
('New sale',3,'Sales','NewSale',1),
('Sales history',3,'Sales','SalesHistory',1)

--*menu hijos - Reports
insert into Menu([description],idMenuParent,controller,pageAction,isActive) values
('Sales report',4,'Reports','SalesReport',1)


UPDATE Menu SET idMenuParent = idMenu where idMenuParent is null


go
--________________________________ INSERT MENU ROLE ________________________________


--*Admin
INSERT INTO RolMenu(idRol,idMenu,isActive) values
(1,5,1),
(1,6,1),
(1,7,1),
(1,8,1),
(1,9,1),
(1,10,1),
(1,11,1)

--*Employee
INSERT INTO RolMenu(idRol,idMenu,isActive) values
(2,9,1),
(2,10,1)

--*Inspector
INSERT INTO RolMenu(idRol,idMenu,isActive) values
(3,7,1),
(3,8,1),
(3,9,1),
(3,10,1)
--CREACION DE LA BASE DE DATOS DB_VETERINARIO
CREATE DATABASE DB_VETERINARIA
GO

--USAR LA BASE DE DATOS
USE DB_VETERINARIA

GO
--CREACION DE TABLA CLIENTE 
CREATE TABLE CLIENTE(
ID_CLIENTE        INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
NOMBRES           VARCHAR(100) NOT NULL,
APELLIDOS         VARCHAR(100) NOT NULL,
CEDULA            VARCHAR(11) NOT NULL,
EMAIL             VARCHAR(100) NOT NULL,
DIRECCION         VARCHAR(500) NOT NULL,
TELEFONO          INT NOT NULL,
TIPO_NUMERO       VARCHAR(3) NOT NULL,
FECHA_REGISTRO    DATE NOT NULL,
CONSTRAINT CK_TIPONUMERO CHECK(TIPO_NUMERO IN ('CEL', 'TEL'))
);
GO
--CREACION DE LA TABLA ESPECIES
CREATE TABLE ESPECIES(
ID_ESPECIE        INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
DESCRIPCION       VARCHAR(100) NOT NULL
);
GO
--CREACION DE LA TABLA RAZA 
CREATE TABLE RAZAS(
ID_RAZA           INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_ESPECIE        INT NOT NULL,
NOMBRE_RAZA       VARCHAR(100) NOT NULL,
CONSTRAINT FK_ESP_RAZ FOREIGN KEY(ID_ESPECIE) REFERENCES ESPECIES(ID_ESPECIE)
);
GO
/*Tabla Historia de vacuna
Nombre de la vacuna, Fecha de aplicacion, Fecha de siguiente vacuna*/
--SIGVACUNA ----> SIGUIENTE VACUNA--
CREATE TABLE HISTORIA_VACUNA(
ID_VACUNA           INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
NOMBRE_DE_VACUNA    VARCHAR(100) NOT NULL,
FECHA_APLICACION    DATE NOT NULL,
FECHA_SIGVACUNA     DATE NOT NULL    
);
GO
--CREACION DE LA TABLA MASCOTAS
CREATE TABLE MASCOTAS(
ID_MASCOTA        INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_CLIENTE        INT NOT NULL,
ID_ESPECIE        INT NOT NULL,
ID_RAZA           INT NOT NULL,
ID_VACUNA         INT NOT NULL,
NOMBRE            VARCHAR(100) NOT NULL,
EDAD              INT NOT NULL,
SEXO              VARCHAR(1) NOT NULL,
PESO              DECIMAL(12,2) NOT NULL,
FECHA_NACIMIENTO  DATE NOT NULL,
CONSTRAINT CK_SEXO CHECK (SEXO IN ('F','M')),
CONSTRAINT FK_MAS_CLI FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
CONSTRAINT FK_MAS_ESP FOREIGN KEY(ID_ESPECIE) REFERENCES ESPECIES(ID_ESPECIE),
CONSTRAINT FK_MAS_RAZ FOREIGN KEY(ID_RAZA) REFERENCES RAZAS(ID_RAZA),
CONSTRAINT FK_MAS_HIS FOREIGN KEY(ID_VACUNA) REFERENCES HISTORIA_VACUNA(ID_VACUNA)
);
GO

/*Tabla Especialidad
*/
CREATE TABLE ESPECIALIDAD(
ID_ESPECIALIDAD    INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
DESCRIPCION        VARCHAR(50) NOT NULL
)
GO

/*Tabla veterinario
nombre,Especialidad,Telefono,Email,Fecha_Contratacion,Fecha_Nacimiento,Cedula*/
CREATE TABLE VETERINARIO(
ID_VETERINARIO     INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
NOMBRE             VARCHAR(100) NOT NULL,
CEDULA             VARCHAR(11) NOT NULL, 
TELEFONO           INT NOT NULL,
EMAIL              VARCHAR(100) NOT NULL,
FECHA_CONTRATACION DATE NOT NULL,
FECHA_NACIMIENTO   DATE NOT NULL

);
GO

CREATE TABLE VETERINARIO_ESPECIALIDAD(
    ID_VETERINARIO   INT NOT NULL,
    ID_ESPECIALIDAD  INT NOT NULL,
    CONSTRAINT PK_VET_ESP PRIMARY KEY (ID_VETERINARIO, ID_ESPECIALIDAD), -- Clave compuesta
    CONSTRAINT FK_VET FOREIGN KEY (ID_VETERINARIO) REFERENCES VETERINARIO(ID_VETERINARIO),
    CONSTRAINT FK_ESP FOREIGN KEY (ID_ESPECIALIDAD) REFERENCES ESPECIALIDAD(ID_ESPECIALIDAD)
);
GO

/*Tabla Pagos
Monto,Fecha de pago ,Metodo de pago*/
CREATE TABLE PAGOS(
ID_PAGO             INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
MONTO               DECIMAL(10,2) NOT NULL,
FECHA_DE_PAGO       DATE NOT NULL,
METODO_DE_PAGO      VARCHAR(3) NOT NULL
CONSTRAINT CK_METODO_PAGO CHECK (METODO_DE_PAGO IN('EFE','TRA','TAR'))
);
GO

/*Tabla consulta
Sintomas,Diagnostico,Tratamiento,Fecha de consulta Y algunas relaciones, Estado, Comentario*/
CREATE TABLE CONSULTA(
ID_CONSULTA       INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_MASCOTA        INT NOT NULL,
ID_PAGO           INT NOT NULL,
SINTOMAS          VARCHAR(500) NOT NULL,
DIAGNOSTICO       VARCHAR(500) NOT NULL,
TRATAMIENTO       VARCHAR(100) NOT NULL,
FECHA_CONSULTA    DATE NOT NULL,
ESTADO            VARCHAR(100) NOT NULL,
COMENTARIO        VARCHAR(500) NOT NULL,
CONSTRAINT FK_MAS_PAG FOREIGN KEY(ID_PAGO) REFERENCES PAGOS(ID_PAGO),
CONSTRAINT FK_CON_MAS FOREIGN KEY(ID_MASCOTA) REFERENCES MASCOTAS(ID_MASCOTA)

);
GO
/*Tabla receta
Dosis, Duracion, Fecha de inicio, Instrucciones*/
CREATE TABLE RECETA(
ID_RECETA          INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
DOSIS              INT NOT NULL,
DURACION           VARCHAR(100) NOT NULL,
FECHA_INICIO       DATE NOT NULL,
INSTRUCCIONES      VARCHAR(500) NOT NULL
);
GO

/*Tabla de medicamento
Nombre del medicamento, Descripcion y dosis, Fecha de cadusidad, Cantidad de medicamento*/
CREATE TABLE MEDICAMENTO(
ID_MEDICAMENTO     INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_RECETA          INT NOT NULL,
NOMBRE_MEDICAMENTO VARCHAR(100) NOT NULL,
DESCRIPCION        VARCHAR(500) NOT NULL,
DOSIS              DECIMAL(12,2) NOT NULL,
FECHA_CADUSIDAD    DATE NOT NULL,
CANTIDAD           INT NOT NULL,
CONSTRAINT FK_MED_REC FOREIGN KEY(ID_RECETA) REFERENCES RECETA(ID_RECETA)
);
GO




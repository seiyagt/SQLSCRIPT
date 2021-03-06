USE [DB_A0B9DD_linknred]
GO
/****** Object:  FullTextCatalog [LinknRed01]    Script Date: 08/12/2021 08:40:01 a. m. ******/
CREATE FULLTEXT CATALOG [LinknRed01] AS DEFAULT
GO
/****** Object:  UserDefinedTableType [dbo].[TBLcanasta]    Script Date: 08/12/2021 08:40:01 a. m. ******/
CREATE TYPE [dbo].[TBLcanasta] AS TABLE(
	[Id_Proveedor] [int] NULL,
	[id] [int] NULL,
	[Carrier] [varchar](max) NULL,
	[Service] [varchar](max) NULL,
	[CostoEnvio] [decimal](12, 2) NULL,
	[enviodomicilio] [varchar](max) NULL,
	[NumeroPaquete] [varchar](max) NULL,
	[uuID] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TBLRangoruta]    Script Date: 08/12/2021 08:40:01 a. m. ******/
CREATE TYPE [dbo].[TBLRangoruta] AS TABLE(
	[Latitud] [numeric](18, 6) NULL,
	[Longuitud] [numeric](18, 6) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[typeCoberturaProducto]    Script Date: 08/12/2021 08:40:01 a. m. ******/
CREATE TYPE [dbo].[typeCoberturaProducto] AS TABLE(
	[idCobertura] [int] NULL,
	[Nombre] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TypeGuiaEstatus]    Script Date: 08/12/2021 08:40:01 a. m. ******/
CREATE TYPE [dbo].[TypeGuiaEstatus] AS TABLE(
	[guia] [varchar](max) NULL,
	[estatus] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TypePaqueteCanasta]    Script Date: 08/12/2021 08:40:01 a. m. ******/
CREATE TYPE [dbo].[TypePaqueteCanasta] AS TABLE(
	[NumeroPaquete] [varchar](max) NULL,
	[Id_Producto] [int] NULL,
	[Cantidad] [int] NULL,
	[Peso] [decimal](16, 2) NULL,
	[Valida] [nvarchar](max) NULL,
	[Id_Proveedor] [int] NOT NULL,
	[id] [int] NOT NULL,
	[origen] [varchar](max) NOT NULL,
	[uuID] [varchar](max) NULL,
	[TipoEnvio] [int] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TypePaqueteConfiguracion]    Script Date: 08/12/2021 08:40:01 a. m. ******/
CREATE TYPE [dbo].[TypePaqueteConfiguracion] AS TABLE(
	[Id_Proveedor] [int] NULL,
	[id] [int] NULL,
	[Carrier] [nvarchar](max) NULL,
	[Service] [nvarchar](max) NULL,
	[CostoEnvio] [decimal](6, 2) NULL,
	[enviodomicilio] [nvarchar](max) NULL,
	[NumeroPaquete] [nvarchar](max) NULL,
	[uuID] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TypePaqueteConfiguracionDirecto]    Script Date: 08/12/2021 08:40:01 a. m. ******/
CREATE TYPE [dbo].[TypePaqueteConfiguracionDirecto] AS TABLE(
	[Id_Proveedor] [int] NULL,
	[id] [int] NULL,
	[Carrier] [nvarchar](max) NULL,
	[Service] [nvarchar](max) NULL,
	[CostoEnvio] [decimal](6, 2) NULL,
	[Efectivo] [nvarchar](max) NULL,
	[Terminal] [nvarchar](max) NULL,
	[NumeroPaquete] [nvarchar](max) NULL,
	[uuID] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[f_promedio]    Script Date: 08/12/2021 08:40:01 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
									   create function [dbo].[f_promedio]
 (@valor1 decimal(4,2),
  @valor2 decimal(4,2)
 )
 returns decimal (6,2)
 as
 begin 
   declare @resultado decimal(6,2)
   set @resultado=(@valor1+@valor2)/2
   return @resultado
 end;
GO
/****** Object:  UserDefinedFunction [dbo].[ValorTipoPaquete]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
							CREATE function [dbo].[ValorTipoPaquete]
									 (@PesoMayor decimal(16,2)
									 )
									 returns INT 
									 as
									 begin 
									   declare @resultado int, @intVariable int
									   SET @resultado = 1
									   SET @intVariable = 1
											WHILE (@intVariable <=5)
											BEGIN
											   IF((SELECT CONVERT(decimal(16,2),Weight_) FROM TblTipoPaquete WHERE idTipoPaquete=@intVariable) >= @PesoMayor)

											   BEGIN
											      --set @intVariable = 6
												  set @resultado = @resultado
												  set @intVariable = 6
											   END
											   ELSE BEGIN  
											   set @resultado = @resultado + 1
											   set @intVariable = @intVariable + 1
											   END
											   --set @resultado = @intVariable
											   
											END

									   return @resultado
									 end;
GO
/****** Object:  Table [dbo].[Accesos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accesos](
	[Id_Acceso] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Id_Sesion] [nvarchar](max) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Accesos] PRIMARY KEY CLUSTERED 
(
	[Id_Acceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdministrarLinknRed]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdministrarLinknRed](
	[Id_AdministrarLinknRed] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Administracion] [varchar](max) NULL,
	[Fecha_creacion] [datetime] NOT NULL,
	[Usuario] [varchar](max) NULL,
	[Fecha_Modificacion] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[alertas]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alertas](
	[Id_Mensaje] [int] IDENTITY(1,1) NOT NULL,
	[Correo_Proveedor] [nvarchar](50) NOT NULL,
	[Correo_Cliente] [nvarchar](50) NOT NULL,
	[Mensaje] [nvarchar](max) NOT NULL,
	[Estatus] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_alertas] PRIMARY KEY CLUSTERED 
(
	[Id_Mensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Articles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BannerMovil]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BannerMovil](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](40) NULL,
	[RutaImagen] [varchar](150) NULL,
	[Liga] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Calificacion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calificacion](
	[Id_Calificacion] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[CalificacionP1] [decimal](10, 2) NULL,
	[CalificacionP2] [decimal](10, 2) NULL,
	[NumeroPaquete] [varchar](max) NOT NULL,
	[Comentarios] [varchar](max) NOT NULL,
	[Fecha] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Canasta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Canasta](
	[Id_Canasta] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Precio] [decimal](18, 2) NULL,
	[Cantidad] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Total_Unitario] [decimal](18, 2) NULL,
	[Descuento] [int] NOT NULL,
	[Id_Servicio] [int] NOT NULL,
	[Puntos] [int] NULL,
	[entregadomicilio] [varchar](max) NULL,
	[uuID] [varchar](max) NULL,
	[NumeroPaquete] [varchar](max) NULL,
	[Paqueteria] [varchar](max) NULL,
	[servicio] [varchar](max) NULL,
	[CostoEnvio] [decimal](18, 2) NULL,
	[TipoEnvioLogico] [int] NULL,
	[TipoIdioma] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Canasta] ASC,
	[Id_Producto] ASC,
	[Id_Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CanastaLog]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CanastaLog](
	[Id_Canastalog] [int] IDENTITY(1,1) NOT NULL,
	[Id_Canasta] [int] NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Precio] [decimal](18, 2) NULL,
	[Cantidad] [int] NOT NULL,
	[Fecha_creacion] [datetime] NOT NULL,
	[Total_Unitario] [decimal](18, 2) NULL,
	[Descuento] [int] NOT NULL,
	[Id_Servicio] [int] NOT NULL,
	[Puntos] [int] NULL,
	[IPMaquina] [varchar](max) NULL,
	[Tipo_Movimiento] [varchar](max) NULL,
	[Tipo_Dispositivo] [varchar](max) NULL,
	[Ubicacion] [varchar](max) NULL,
	[MAC] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatCodigoPostal]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatCodigoPostal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_CP] [int] NULL,
	[Colonia] [varchar](max) NULL,
	[Municipio] [varchar](max) NULL,
	[Estado] [varchar](max) NULL,
	[c_Municipio] [int] NULL,
	[Pais] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categoria_Active]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria_Active](
	[id_cat] [int] IDENTITY(1,1) NOT NULL,
	[Id_Categoria] [int] NOT NULL,
	[Categoria] [varchar](max) NOT NULL,
	[Active_WPS] [int] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[Id_Categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorias_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias_Productos](
	[Id_Categoria] [int] IDENTITY(1,1) NOT NULL,
	[Categoria] [nvarchar](100) NULL,
	[Descripcion_Categoria] [nvarchar](max) NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Estatus_Categoria] [int] NULL,
	[FILE_PATH] [varchar](max) NULL,
	[imagenIndex] [varchar](30) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatsDudas]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatsDudas](
	[IDDuda] [int] IDENTITY(1,1) NOT NULL,
	[FechaDuda] [datetime] NULL,
	[NombreUser] [varchar](50) NULL,
	[EmailUser] [varchar](50) NULL,
	[GiroUser] [varchar](50) NULL,
	[IDChat] [int] NULL,
	[NumFrom] [varchar](50) NULL,
	[EmailReceptor] [varchar](50) NULL,
	[Duda] [varchar](max) NULL,
	[FechaRespuesta] [datetime] NULL,
	[Respuesta] [varchar](max) NULL,
 CONSTRAINT [PK_ChatsDudas] PRIMARY KEY CLUSTERED 
(
	[IDDuda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatsProspectos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatsProspectos](
	[IdChat] [int] IDENTITY(1,1) NOT NULL,
	[ProfName] [varchar](50) NULL,
	[FechaIni] [datetime] NULL,
	[FechaFin] [datetime] NULL,
	[FromNum] [varchar](50) NULL,
	[ToNum] [varchar](50) NULL,
	[Etapa] [varchar](30) NULL,
	[NombreReq] [varchar](max) NULL,
	[CorreoReq] [varchar](max) NULL,
	[GiroComReq] [varchar](50) NULL,
	[Source] [varchar](30) NULL,
	[FechaSalu] [datetime] NULL,
	[FechaMenu] [datetime] NULL,
	[FechaDuda] [datetime] NULL,
	[FechaReg] [datetime] NULL,
	[FechaTermin] [datetime] NULL,
	[Estatuss] [int] NULL,
	[Direccion] [nvarchar](max) NULL,
	[Ciudad] [nvarchar](50) NULL,
	[Estado] [nvarchar](50) NULL,
	[Pais] [nvarchar](50) NULL,
	[ValRef] [int] NULL,
 CONSTRAINT [PK_ChatsProspectosLnknrd_1] PRIMARY KEY CLUSTERED 
(
	[IdChat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ciudad]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ciudad](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombreCiudad] [varchar](50) NOT NULL,
	[cve_cab] [varchar](4) NOT NULL,
	[num_ciudad] [varchar](4) NOT NULL,
	[nom_cab] [varchar](50) NOT NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[IdEstado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id_Cliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellidos] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Direccion] [varchar](100) NULL,
	[Colonia] [varchar](100) NULL,
	[Ciudad] [varchar](100) NULL,
	[Estado] [varchar](100) NULL,
	[Pais] [varchar](100) NULL,
	[Codigo_Postal] [varchar](100) NULL,
	[Sexo] [varchar](10) NOT NULL,
	[Fecha_Nacimiento] [datetime] NOT NULL,
	[Img_Nombre] [varchar](max) NULL,
	[Img_Ruta] [varchar](max) NULL,
	[Estatus] [int] NULL,
	[Fecha_Registro] [datetime] NULL,
	[Ultima_Actualizacion] [datetime] NULL,
	[Fecha_Baja] [datetime] NULL,
	[Recibir_Notificaciones] [int] NULL,
	[Perfil] [varchar](100) NULL,
	[Id_Perfil] [int] NULL,
	[LastLoginDate] [datetime] NULL,
	[Avatar] [varchar](500) NULL,
	[Tel_Celular] [varchar](50) NULL,
	[Tel_Casa] [varchar](50) NULL,
	[Tel_Oficina] [varchar](50) NULL,
	[Latitud] [numeric](18, 6) NULL,
	[Longuitud] [numeric](18, 6) NULL,
	[PasswordNvo] [nvarchar](50) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[Id_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Tel_Casa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Tel_Celular] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes_Activacion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes_Activacion](
	[ActivationCode] [uniqueidentifier] NOT NULL,
	[Id_Cliente] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ActivationCode] ASC,
	[Id_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientesDirecciones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientesDirecciones](
	[ClientesDirecciones] [int] IDENTITY(12,1) NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Calle] [varchar](100) NULL,
	[Numero] [varchar](100) NULL,
	[Colonia] [varchar](100) NULL,
	[Ciudad] [varchar](100) NULL,
	[Estado] [varchar](100) NULL,
	[Pais] [varchar](100) NULL,
	[Codigo_Postal] [varchar](100) NULL,
	[Referencia] [varchar](300) NULL,
	[Predeterminada] [int] NULL,
	[Fecha_Registro] [datetime] NULL,
	[Ultima_Actualizacion] [datetime] NULL,
	[Fecha_Baja] [datetime] NULL,
	[Latitud] [numeric](18, 6) NULL,
	[Longitud] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cobertura]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cobertura](
	[idCobertura] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Cobertura] [varchar](max) NOT NULL,
	[Descripcion_Cobertura] [varchar](max) NOT NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[fechaBaja] [datetime] NULL,
UNIQUE NONCLUSTERED 
(
	[idCobertura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conversaciones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversaciones](
	[Id_Conversacion] [int] IDENTITY(1,1) NOT NULL,
	[Mailto] [nvarchar](100) NOT NULL,
	[MailFrom] [nvarchar](100) NOT NULL,
	[Subject] [nvarchar](100) NOT NULL,
	[Date] [nvarchar](max) NOT NULL,
	[Time] [nvarchar](max) NOT NULL,
	[Is_up] [bit] NOT NULL,
 CONSTRAINT [PK_Conversaciones] PRIMARY KEY CLUSTERED 
(
	[Id_Conversacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country_States_Code]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country_States_Code](
	[id_State] [int] IDENTITY(1,1) NOT NULL,
	[State_Desc] [varchar](max) NOT NULL,
	[State_Code] [varchar](50) NOT NULL,
	[Id_Country] [varchar](10) NULL,
	[idPais] [int] NULL,
 CONSTRAINT [PK_Table_1_1] PRIMARY KEY CLUSTERED 
(
	[id_State] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Descuento_Venta_Compuesta_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Descuento_Venta_Compuesta_Productos](
	[Id_Venta] [int] IDENTITY(1,1) NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Nombre_Proveedor] [nvarchar](100) NOT NULL,
	[Nombre_Producto] [nvarchar](100) NOT NULL,
	[Unidad_Inicial] [nvarchar](100) NOT NULL,
	[Unidad_Final] [nvarchar](100) NOT NULL,
	[Descuento] [decimal](18, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Usuario] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Descuento_Venta_Compuesta_Productos] PRIMARY KEY CLUSTERED 
(
	[Id_Venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Descuento_Venta_Compuesta_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Descuento_Venta_Compuesta_Proveedores](
	[Id_Venta] [int] IDENTITY(1,1) NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Nombre_Proveedor] [nvarchar](100) NOT NULL,
	[Unidad_Inicial] [nvarchar](100) NOT NULL,
	[Unidad_Final] [nvarchar](100) NOT NULL,
	[Descuento] [decimal](18, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Usuario] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Descuento_Venta_Compuesta_Proveedores] PRIMARY KEY CLUSTERED 
(
	[Id_Venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleProductosProduccion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleProductosProduccion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Productos_en_Produccion_Id] [int] NOT NULL,
	[estado] [nvarchar](max) NOT NULL,
	[Ruta_Carpeta] [nvarchar](max) NOT NULL,
	[nombre_Imagen] [nvarchar](200) NOT NULL,
	[Usuario_Alta] [nvarchar](200) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Ultima_Modificacion] [datetime] NULL,
	[ValGaleriaS] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DireccionPedido]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DireccionPedido](
	[Id_DireccionPedido] [int] IDENTITY(1,1) NOT NULL,
	[Id_Pedido] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Direccion] [varchar](100) NULL,
	[Colonia] [varchar](100) NULL,
	[Ciudad] [varchar](100) NULL,
	[Estado] [varchar](100) NULL,
	[Pais] [varchar](100) NULL,
	[Codigo_Postal] [varchar](100) NULL,
	[Tel_Casa] [varchar](50) NULL,
	[trackingUrl] [varchar](max) NULL,
	[guia] [varchar](max) NULL,
	[Paqueteria] [varchar](max) NULL,
	[servicio] [varchar](max) NULL,
	[CostoEnvio] [decimal](6, 2) NULL,
	[Estatus] [int] NULL,
	[Fecha_Registro] [datetime] NULL,
	[Fecha_Baja] [datetime] NULL,
	[uuID] [varchar](max) NULL,
	[GuiaBytes] [varchar](max) NULL,
	[EstatusGuia] [varchar](max) NULL,
	[Latitud] [decimal](18, 6) NULL,
	[Longitud] [decimal](18, 6) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DireccionServicio]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DireccionServicio](
	[Id_DireccionServicio] [int] IDENTITY(1,1) NOT NULL,
	[Id_PedidoServicio] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Direccion] [varchar](100) NULL,
	[Colonia] [varchar](100) NULL,
	[Ciudad] [varchar](100) NULL,
	[Estado] [varchar](100) NULL,
	[Pais] [varchar](100) NULL,
	[Codigo_Postal] [varchar](100) NULL,
	[Tel_Casa] [varchar](50) NULL,
	[Estatus] [int] NULL,
	[Fecha_Registro] [datetime] NULL,
	[Fecha_Baja] [datetime] NULL,
	[uuID] [varchar](max) NULL,
	[Latitud] [decimal](18, 6) NULL,
	[Longitud] [decimal](18, 6) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombreEstado] [varchar](50) NOT NULL,
	[abreviacion] [varchar](10) NOT NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[id_pais] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estatus]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estatus](
	[Id_Estatus] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Img_Path] [nvarchar](max) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Autor] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Estatus] PRIMARY KEY CLUSTERED 
(
	[Id_Estatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GCM_Usuarios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GCM_Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Gcm_Regid] [varchar](max) NULL,
	[Plataforma] [varchar](50) NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[id_Idioma] [int] IDENTITY(1,1) NOT NULL,
	[M_Idioma] [nvarchar](max) NOT NULL,
	[M_Bandera] [nvarchar](max) NOT NULL,
	[M_VarIdioma] [nvarchar](max) NOT NULL,
	[M_Moneda] [varchar](20) NULL,
	[M_Estatus] [int] NULL,
	[M_Zona] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImagenALT]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImagenALT](
	[Id_ImagenALT] [int] IDENTITY(1,1) NOT NULL,
	[RutaImagen] [nvarchar](max) NOT NULL,
	[ALT] [nvarchar](max) NOT NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Estatus] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImagenGaleria]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImagenGaleria](
	[Id_Imagen] [int] IDENTITY(1,1) NOT NULL,
	[Imagen_Titulo] [nvarchar](50) NOT NULL,
	[Imagen_Descripcion] [nvarchar](50) NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Imagen_Estatus] [int] NOT NULL,
	[FechaPublicacion] [datetime] NULL,
	[RutaImagenNGal] [char](70) NULL,
	[ValGaleria] [int] NULL,
	[ComentarioVal] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Imagen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IPNs]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IPNs](
	[ID_IPN] [int] IDENTITY(1,1) NOT NULL,
	[actionipn] [varchar](max) NULL,
	[IDaction] [varchar](max) NULL,
	[fecha] [datetime] NULL,
	[Sender] [varchar](max) NULL,
	[SenderURL] [varchar](max) NULL,
 CONSTRAINT [PK_IPNs_1_2] PRIMARY KEY CLUSTERED 
(
	[ID_IPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemPromocion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemPromocion](
	[Id_ItemPromocion] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Id_Promocion] [int] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_ItemPromocion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logos](
	[Id_Logo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Ruta] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Logos] PRIMARY KEY CLUSTERED 
(
	[Id_Logo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogsError]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogsError](
	[Id_LogsError] [int] IDENTITY(1,1) NOT NULL,
	[lastErrorTypeName] [nvarchar](max) NULL,
	[lastErrorMessage] [nvarchar](max) NULL,
	[lastErrorStackTrace] [nvarchar](max) NULL,
	[URL] [nvarchar](max) NULL,
	[FECHA] [datetime] NOT NULL,
	[SessionCliente] [varchar](max) NULL,
	[SessionProveedor] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marcas]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marcas](
	[Id_Marca] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[Descripcion] [nvarchar](max) NOT NULL,
	[Fecha_Creacion] [datetime] NOT NULL,
	[Observaciones] [nchar](10) NULL,
	[Usuario_Registro] [nvarchar](50) NULL,
 CONSTRAINT [PK_Marcas] PRIMARY KEY CLUSTERED 
(
	[Id_Marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mensajes]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mensajes](
	[Id_Mensaje] [int] IDENTITY(1,1) NOT NULL,
	[Id_Conversacion] [int] NULL,
	[MailTo] [nvarchar](50) NOT NULL,
	[MailFrom] [nvarchar](100) NOT NULL,
	[Subject] [nvarchar](50) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Date] [nvarchar](max) NULL,
	[Time] [nvarchar](max) NULL,
	[Is_up] [bit] NULL,
	[Filename] [nvarchar](50) NULL,
	[Fecha] [datetime] NULL,
	[Id_Cliente] [int] NULL,
	[Id_Proveedor] [int] NULL,
	[Estatus] [int] NULL,
	[Baja] [int] NULL,
	[Estatus_Cliente] [int] NULL,
	[Id_Producto] [int] NULL,
	[Id_Servicio] [int] NULL,
 CONSTRAINT [PK_Mensajes] PRIMARY KEY CLUSTERED 
(
	[Id_Mensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Noticias]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Noticias](
	[Id_Noticia] [int] IDENTITY(1,1) NOT NULL,
	[Not_Titulo] [nvarchar](500) NOT NULL,
	[Not_Cuerpo] [nvarchar](500) NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Not_Estatus] [int] NOT NULL,
	[FechaPublicacion] [datetime] NULL,
	[RutaImagenNot] [nvarchar](70) NULL,
	[ValNoticias] [int] NULL,
	[ComentarioVal] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Noticia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagar_Servicios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagar_Servicios](
	[ServicioID] [int] IDENTITY(1,1) NOT NULL,
	[ServicioPagarNombre] [varchar](50) NOT NULL,
	[ProductDescription] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[ServicioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageWeb]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageWeb](
	[Id_PageWeb] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Pagina] [varchar](100) NULL,
	[URL] [varchar](max) NULL,
	[Meta_Tittle] [varchar](60) NULL,
	[Meta_Description] [varchar](150) NULL,
	[Focus_Keyphrase] [varchar](max) NULL,
	[Fecha] [datetime] NOT NULL,
	[Estatus] [nvarchar](50) NOT NULL,
	[Id_Categoria] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PaypalPaymentId] [varchar](max) NOT NULL,
	[Create_time] [varchar](max) NOT NULL,
	[Update_time] [varchar](max) NULL,
	[State] [varchar](50) NOT NULL,
	[Amount] [decimal](6, 2) NOT NULL,
	[Currency] [varchar](3) NOT NULL,
	[Created_at] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pais]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pais](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](64) NOT NULL,
	[fechaModificacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaqueteCanasta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaqueteCanasta](
	[Id_PaquetePedido] [int] IDENTITY(1,1) NOT NULL,
	[uuID] [varchar](max) NOT NULL,
	[NumeroPaquete] [varchar](max) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Peso] [int] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[idOrigen] [int] NOT NULL,
	[origen] [varchar](max) NOT NULL,
	[Fecha] [datetime] NULL,
	[Id_Cliente] [int] NOT NULL,
	[idCanasta] [int] NULL,
	[entregadomicilio] [varchar](max) NULL,
	[Paqueteria] [varchar](max) NULL,
	[servicio] [varchar](max) NULL,
	[CostoEnvio] [decimal](6, 2) NULL,
	[tipoEnvio] [int] NULL,
	[PEfectivo] [varchar](20) NULL,
	[PTerminal] [varchar](20) NULL,
	[PagoEntrega] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaqueteNuevo]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaqueteNuevo](
	[Id_Paquete] [int] IDENTITY(1000,1) NOT NULL,
	[uuID] [varchar](max) NULL,
	[NumeroPaquete] [varchar](max) NULL,
	[Tipo] [varchar](20) NULL,
UNIQUE NONCLUSTERED 
(
	[Id_Paquete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[Id_Pedido] [int] IDENTITY(1,1) NOT NULL,
	[Id_Sesion] [nvarchar](max) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Nombre_Producto] [nvarchar](100) NOT NULL,
	[Precio] [decimal](18, 0) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Img_Path] [nvarchar](max) NOT NULL,
	[Total_Unitario] [decimal](18, 0) NOT NULL,
	[Nombre_Proveedor] [nvarchar](100) NOT NULL,
	[Estatus] [nvarchar](50) NOT NULL,
	[Cliente] [nvarchar](100) NULL,
	[Num_Orden] [int] NULL,
	[Forma_Pago] [nvarchar](100) NULL,
	[Comentarios] [nvarchar](max) NULL,
	[Img] [nvarchar](max) NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[Id_Pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PedidosCab]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidosCab](
	[Id_Pedido] [int] IDENTITY(1,1) NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Cliente] [varchar](max) NULL,
	[Direccion1] [varchar](max) NULL,
	[Direccion2] [varchar](max) NULL,
	[Ciudad] [varchar](max) NULL,
	[Estado] [varchar](max) NULL,
	[Zip] [varchar](max) NULL,
	[Telefono] [varchar](max) NULL,
	[CostoEnvio] [decimal](9, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PedidoServicio]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidoServicio](
	[Id_PedidoServicio] [int] IDENTITY(1,1) NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Id_Canasta] [int] NOT NULL,
	[Id_Servicio] [int] NOT NULL,
	[Precio] [decimal](18, 0) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Descuento] [int] NOT NULL,
	[Puntos] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Estatus_Cliente] [nvarchar](50) NOT NULL,
	[FormaDePago] [nvarchar](50) NOT NULL,
	[Comentarios] [nvarchar](50) NULL,
	[Id_Proveedor] [int] NULL,
	[Estatus_Proveedor] [nvarchar](50) NULL,
	[PuntosUsados] [int] NULL,
	[baja] [int] NULL,
	[idOrigen] [int] NULL,
	[uuID] [varchar](max) NULL,
	[NumeroPaquete] [varchar](max) NULL,
	[PagoEntrega] [varchar](20) NULL,
	[IdIdiomaP] [int] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[Id_PedidoServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PedidosHeader]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidosHeader](
	[ID_Pedido] [int] IDENTITY(1,1) NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Id_Canasta] [int] NOT NULL,
	[Cantidad_Articulos] [int] NOT NULL,
	[Descuento] [int] NOT NULL,
	[Total_Puntos] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FormaDePago] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PedidosNuevo]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidosNuevo](
	[Id_Pedido] [int] IDENTITY(1,1) NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Id_Canasta] [int] NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Precio] [decimal](18, 2) NULL,
	[Cantidad] [int] NOT NULL,
	[Descuento] [int] NOT NULL,
	[Puntos] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Estatus_Cliente] [nvarchar](50) NOT NULL,
	[FormaDePago] [nvarchar](50) NOT NULL,
	[Comentarios] [nvarchar](50) NULL,
	[Id_Proveedor] [int] NULL,
	[Estatus_Proveedor] [nvarchar](50) NULL,
	[PuntosUsados] [int] NULL,
	[baja] [int] NULL,
	[tipoenvio] [int] NULL,
	[entregadomicilio] [varchar](max) NULL,
	[idOrigen] [int] NULL,
	[uuID] [varchar](max) NULL,
	[NumeroPaquete] [varchar](max) NULL,
	[TipoEnvioAmbos] [int] NULL,
	[PagoEntrega] [varchar](20) NULL,
	[status] [varchar](max) NULL,
	[IDPAGO] [varchar](max) NULL,
	[tipopago] [varchar](max) NULL,
	[idordentienda] [varchar](max) NULL,
	[IDpreferencia] [varchar](max) NULL,
	[IdIdiomaP] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Id_Pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[perfiles]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[perfiles](
	[Id_Perfil] [int] IDENTITY(1,1) NOT NULL,
	[Perfil] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Fecha_Alta] [datetime] NOT NULL,
	[Usuario_Alta] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_perfiles] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Portal_Gratuito]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Portal_Gratuito](
	[Id_Proveedor] [int] NOT NULL,
	[Opcion_1] [int] NULL,
	[Opcion_2] [int] NULL,
	[Opcion_3] [int] NULL,
	[Valor_1] [nvarchar](255) NULL,
	[Valor_2] [nvarchar](255) NULL,
	[Valor_3] [nvarchar](255) NULL,
	[Informacion_Lateral] [nvarchar](255) NULL,
 CONSTRAINT [PK_Portal_Gratuito] PRIMARY KEY CLUSTERED 
(
	[Id_Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos_Cotizados]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos_Cotizados](
	[Id] [int] NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[Categoria] [nvarchar](200) NOT NULL,
	[Tipo] [nvarchar](200) NOT NULL,
	[Subtipo] [nvarchar](200) NOT NULL,
	[clave] [nvarchar](200) NULL,
	[Precio] [decimal](18, 0) NOT NULL,
	[Marca] [nvarchar](200) NULL,
	[Proveedor] [nvarchar](200) NULL,
	[Descripcion] [nvarchar](max) NOT NULL,
	[Usuario_Alta] [nvarchar](200) NULL,
	[Fecha_Alta] [datetime] NOT NULL,
	[Ultima_Modificacion] [datetime] NULL,
	[Nom_Img_Principal] [nvarchar](200) NOT NULL,
	[Ruta_Img_Principal] [nvarchar](max) NOT NULL,
	[Estatus] [int] NOT NULL,
	[Id_Categoria] [int] NOT NULL,
	[Id_Tipo] [int] NOT NULL,
	[Id_Subtipo] [int] NOT NULL,
	[Url_QRcode] [nvarchar](max) NULL,
	[Ruta_Carpeta] [nvarchar](max) NULL,
	[Existencia] [int] NOT NULL,
	[Descuento] [int] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Id_Marca] [int] NULL,
	[Puntos] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos_en_Produccion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos_en_Produccion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[clave] [nvarchar](200) NULL,
	[Marca] [nvarchar](200) NULL,
	[Usuario_Alta] [nvarchar](200) NOT NULL,
	[Fecha_Alta] [datetime] NOT NULL,
	[Ultima_Modificacion] [datetime] NULL,
	[Nom_Img_Principal] [nvarchar](200) NOT NULL,
	[Ruta_Img_Principal] [nvarchar](max) NOT NULL,
	[Estatus] [int] NOT NULL,
	[Id_Categoria] [int] NOT NULL,
	[Id_Tipo] [int] NOT NULL,
	[Id_Subtipo] [int] NOT NULL,
	[Url_QRcode] [nvarchar](max) NULL,
	[Ruta_Carpeta] [nvarchar](max) NULL,
	[Existencia] [int] NOT NULL,
	[Descuento] [int] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Id_Marca] [int] NULL,
	[Puntos] [int] NULL,
	[Destacado] [int] NULL,
	[Weight_] [varchar](50) NULL,
	[Largo] [varchar](50) NULL,
	[Width] [varchar](50) NULL,
	[Height] [varchar](50) NULL,
	[tipoEnvio] [int] NULL,
	[ETA] [int] NULL,
	[idOrigen] [int] NULL,
	[RecogerTienda] [int] NULL,
	[ValProductonvo] [int] NULL,
 CONSTRAINT [PK_Productos_en_Produccion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos_en_ProduccionTem]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos_en_ProduccionTem](
	[Id_ProductoTem] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[Descripcion] [nvarchar](max) NOT NULL,
	[Fecha_Alta] [datetime] NOT NULL,
	[Nom_Img_Principal] [nvarchar](200) NOT NULL,
	[Ruta_Img_Principal] [nvarchar](max) NOT NULL,
	[ValGaleria] [int] NULL,
	[ComentarioVal] [nvarchar](max) NULL,
	[idIdioma] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos_Index]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos_Index](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Identificador] [int] NOT NULL,
	[Fecha_Guardado] [datetime] NOT NULL,
	[Nombre_Producto] [nvarchar](200) NULL,
	[Precio_Producto] [decimal](18, 0) NULL,
	[Ruta_Imagen] [nvarchar](max) NULL,
 CONSTRAINT [PK_Productos_Index] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos_Index2]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos_Index2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Identificador] [int] NOT NULL,
	[Fecha_Guardado] [datetime] NOT NULL,
	[Nombre_Producto] [nvarchar](200) NULL,
	[Precio_Producto] [decimal](18, 0) NULL,
	[Ruta_Imagen] [nvarchar](max) NULL,
 CONSTRAINT [PK_Productos_Index2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos_Slider]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos_Slider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Identificador] [int] NOT NULL,
	[Fecha_Guardado] [datetime] NOT NULL,
	[Nombre_Producto] [nvarchar](200) NULL,
	[Precio_Producto] [decimal](18, 0) NULL,
	[Ruta_Imagen] [nvarchar](max) NULL,
 CONSTRAINT [PK_Productos_Slider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promociones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promociones](
	[Id_Promocion] [int] IDENTITY(1,1) NOT NULL,
	[Pro_Titulo] [nvarchar](250) NOT NULL,
	[Pro_Cuerpo] [nvarchar](250) NOT NULL,
	[Pro_Descripcion] [nvarchar](250) NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Pro_Estatus] [int] NOT NULL,
	[Pro_Imagen] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Promocion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promociones_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promociones_Proveedores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](200) NOT NULL,
	[Descripcion] [nvarchar](max) NOT NULL,
	[Img] [nvarchar](max) NOT NULL,
	[Proveedor] [nvarchar](100) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Estatus] [int] NOT NULL,
	[Img_Name] [nvarchar](max) NULL,
	[Id_Proveedor] [int] NULL,
 CONSTRAINT [PK_Promociones_Proveedores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Propiedades]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Propiedades](
	[Id_Propiedad] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [nvarchar](50) NOT NULL,
	[SubTipo] [nvarchar](50) NULL,
	[Operacion] [nvarchar](50) NOT NULL,
	[Clave] [nvarchar](50) NOT NULL,
	[Asesor] [nvarchar](50) NULL,
	[Calle] [nvarchar](50) NOT NULL,
	[Numero] [int] NOT NULL,
	[Zona] [nvarchar](50) NULL,
	[Colonia] [nvarchar](50) NOT NULL,
	[Entre_Calles] [nvarchar](100) NULL,
	[Pais] [nvarchar](50) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[Ciudad] [nvarchar](50) NOT NULL,
	[Valor_Propiedad] [decimal](10, 2) NOT NULL,
	[Terreno] [int] NULL,
	[Tipo_Captacion] [nvarchar](50) NULL,
	[Fondo] [nvarchar](50) NULL,
	[Topografia] [nvarchar](max) NULL,
	[Frente] [nvarchar](50) NULL,
	[Comision] [decimal](18, 0) NULL,
	[Construccion] [nvarchar](50) NULL,
	[Recamaras] [nvarchar](50) NOT NULL,
	[Inodoros] [nvarchar](50) NOT NULL,
	[Antiguedad] [nvarchar](50) NULL,
	[Recibidor] [nvarchar](50) NULL,
	[com1] [nvarchar](max) NULL,
	[Sala] [nvarchar](50) NULL,
	[com2] [nvarchar](max) NULL,
	[Comedor] [nvarchar](50) NULL,
	[com3] [nvarchar](max) NULL,
	[Antecomedor] [nvarchar](50) NULL,
	[com4] [nvarchar](max) NULL,
	[Cocina] [nvarchar](50) NULL,
	[com5] [nvarchar](max) NULL,
	[Lavanderia] [nvarchar](50) NULL,
	[com6] [nvarchar](max) NULL,
	[Cuarto_Servicio] [nvarchar](50) NULL,
	[com7] [nvarchar](max) NULL,
	[Cuarto_TV] [nvarchar](50) NULL,
	[com8] [nvarchar](max) NULL,
	[Cochera] [nvarchar](50) NULL,
	[com9] [nvarchar](max) NULL,
	[Jardin] [nvarchar](50) NULL,
	[com10] [nvarchar](max) NULL,
	[Alberca] [nvarchar](50) NULL,
	[com11] [nvarchar](max) NULL,
	[Terraza] [nvarchar](50) NULL,
	[com12] [nvarchar](max) NULL,
	[Boiler] [nvarchar](50) NULL,
	[com13] [nvarchar](max) NULL,
	[Estufa] [nvarchar](50) NULL,
	[com14] [nvarchar](max) NULL,
	[Cuarto_Juegos] [nvarchar](50) NULL,
	[com15] [nvarchar](max) NULL,
	[Biblioteca] [nvarchar](50) NULL,
	[com16] [nvarchar](max) NULL,
	[Clima] [nvarchar](50) NULL,
	[com17] [nvarchar](max) NULL,
	[Calefaccion] [nvarchar](50) NULL,
	[com18] [nvarchar](max) NULL,
	[Alarma] [nvarchar](50) NULL,
	[com19] [nvarchar](max) NULL,
	[Sonido_Interior] [nvarchar](50) NULL,
	[com20] [nvarchar](max) NULL,
	[Alfombra] [nvarchar](50) NULL,
	[com21] [nvarchar](max) NULL,
	[Piso] [nvarchar](50) NULL,
	[com22] [nvarchar](max) NULL,
	[Tv_Paga] [nvarchar](50) NULL,
	[com23] [nvarchar](max) NULL,
	[Ventaneria] [nvarchar](50) NULL,
	[com24] [nvarchar](max) NULL,
	[Fachada] [nvarchar](50) NULL,
	[com25] [nvarchar](max) NULL,
	[Amueblado] [nvarchar](50) NULL,
	[com26] [nvarchar](max) NULL,
	[Luz] [nvarchar](50) NULL,
	[com27] [nvarchar](max) NULL,
	[Agua] [nvarchar](50) NULL,
	[com28] [nvarchar](max) NULL,
	[Gas] [nvarchar](50) NULL,
	[com29] [nvarchar](max) NULL,
	[Cuotas] [nvarchar](max) NULL,
	[com30] [nvarchar](max) NULL,
	[Niveles] [int] NULL,
	[Horario_Visita] [nvarchar](50) NULL,
	[Fecha_Visitas] [nvarchar](50) NULL,
	[Otros_Servicios] [nvarchar](max) NULL,
	[Img_Nombre] [nvarchar](max) NOT NULL,
	[Img_Ruta] [nvarchar](max) NOT NULL,
	[Publicar] [int] NULL,
	[Autorizado] [int] NULL,
	[Estatus] [int] NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Propiedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedor_Info]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedor_Info](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Origen_Empresa] [nvarchar](max) NOT NULL,
	[Mision] [nvarchar](max) NOT NULL,
	[Vision] [nvarchar](max) NOT NULL,
	[Contacto] [nvarchar](max) NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Estatus] [int] NULL,
	[ImgPortada] [nvarchar](max) NULL,
	[PagoEfectivo] [int] NULL,
	[PagoTerminal] [int] NULL,
 CONSTRAINT [PK_Proveedor_Info] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedor_InfoTem]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedor_InfoTem](
	[Id_Proveedor_InfoTem] [int] IDENTITY(1,1) NOT NULL,
	[Origen_Empresa] [nvarchar](max) NOT NULL,
	[Mision] [nvarchar](max) NOT NULL,
	[Vision] [nvarchar](max) NOT NULL,
	[Contacto] [nvarchar](max) NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Estatus] [int] NULL,
	[ImgPortada] [nvarchar](max) NULL,
	[ValGaleria] [int] NULL,
	[ComentarioVal] [varchar](200) NULL,
	[FilePath] [varchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[Id_Proveedor] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Proveedor] [nvarchar](50) NULL,
	[Correo] [nvarchar](50) NULL,
	[Direccion] [nvarchar](50) NULL,
	[Ciudad] [nvarchar](50) NULL,
	[Estado] [nvarchar](50) NULL,
	[Pais] [nvarchar](50) NULL,
	[Tipo_Proveedor] [nvarchar](100) NULL,
	[Cuota_Proveedor] [int] NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Estatus_Proveedor] [int] NULL,
	[Descuento] [decimal](18, 0) NULL,
	[FileName] [nvarchar](max) NULL,
	[FilePath] [nvarchar](max) NULL,
	[Password] [nvarchar](50) NULL,
	[LastLoginDate] [datetime] NULL,
	[FolderPath] [nvarchar](max) NULL,
	[Id_Categoria] [int] NULL,
	[Latitud] [decimal](9, 6) NULL,
	[Longitud] [decimal](9, 6) NULL,
	[Website] [varchar](250) NULL,
	[Telefono] [varchar](100) NULL,
	[Premium] [int] NULL,
	[Recomendado] [varchar](max) NULL,
	[Destacado] [int] NULL,
	[WebStatus] [varchar](max) NULL,
	[FilePathTem] [varchar](200) NULL,
	[FilePathFecha] [datetime] NULL,
	[ProveedorNvo] [int] NULL,
	[ValidarCuenta] [int] NULL,
	[uuidEmail] [varchar](100) NULL,
	[uuidCelular] [varchar](100) NULL,
	[MedioAct] [varchar](100) NULL,
	[PasswordNvo] [nvarchar](50) NULL,
UNIQUE NONCLUSTERED 
(
	[Id_Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre_Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores_Activacion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores_Activacion](
	[Id_Proveedor] [int] NOT NULL,
	[ActivationCode] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Proveedores_Activacion] PRIMARY KEY CLUSTERED 
(
	[Id_Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores_Sucursales]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores_Sucursales](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sucursal] [nvarchar](200) NOT NULL,
	[Latitud] [numeric](18, 6) NOT NULL,
	[Longuitud] [numeric](18, 6) NOT NULL,
	[Descripcion] [varchar](max) NULL,
	[Fecha] [datetime] NOT NULL,
	[Estatus] [int] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[Nombre_Sucursal] [nvarchar](200) NULL,
	[Calle] [varchar](100) NULL,
	[Numero] [varchar](100) NULL,
	[Colonia] [varchar](100) NULL,
	[Ciudad] [varchar](100) NULL,
	[Estado] [varchar](100) NULL,
	[Pais] [varchar](100) NULL,
	[Codigo_Postal] [varchar](100) NULL,
	[Referencia] [varchar](300) NULL,
	[Predeterminada] [int] NULL,
	[idNombreDataRango] [int] NULL,
 CONSTRAINT [PK_Proveedores_Sucursales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puntos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puntos](
	[Id_Record] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Cantidad_Producto] [int] NOT NULL,
	[PuntosUnitario] [int] NOT NULL,
	[Id_Cliente] [int] NOT NULL,
	[Id_Proveedor] [int] NOT NULL,
	[TipodePuntos] [int] NOT NULL,
	[Id_Pedido] [int] NULL,
	[Id_Canasta] [int] NULL,
	[PuntosUnitarioOriginal] [int] NULL,
	[IdIdioma] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Record] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recibos_A_Pagar]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recibos_A_Pagar](
	[IDrecibo] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Monto] [decimal](18, 2) NULL,
	[Imagen] [varbinary](max) NULL,
	[IDusuario] [int] NULL,
	[ServicioID] [int] NULL,
	[FolderPath] [varchar](100) NULL,
	[Estatus] [int] NULL,
	[Puntos_Usados] [int] NULL,
	[Total_Pago] [int] NULL,
	[Nom_Servicio] [varchar](20) NULL,
	[User_Email] [varchar](30) NULL,
	[NombreCompañia] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDrecibo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecibosPremium]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecibosPremium](
	[ID_ReciboPremium] [int] IDENTITY(1,1) NOT NULL,
	[FolderRecibo] [varchar](255) NULL,
	[Id_Pro] [int] NOT NULL,
	[Estatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_ReciboPremium] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servicios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicios](
	[Id_Servicios] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Servicio] [nvarchar](50) NULL,
	[Descripcion_Servicio] [nvarchar](50) NULL,
	[Tipo_Servicio] [nvarchar](50) NULL,
	[Nombre_Proveedor] [nvarchar](50) NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Estatus_Servicio] [int] NULL,
	[Correo_Proveedor] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Servicios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servicios_Cotizacion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicios_Cotizacion](
	[Id_Servicio] [int] IDENTITY(1,1) NOT NULL,
	[Proveedor] [nvarchar](100) NOT NULL,
	[Categoria] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](max) NOT NULL,
	[Precio] [decimal](18, 0) NOT NULL,
	[Area_Covertura] [nvarchar](200) NULL,
	[Horarios] [datetime] NULL,
	[Fecha_Creacion] [datetime] NULL,
	[Estatus] [int] NULL,
	[Nombre_Servicio] [nvarchar](160) NOT NULL,
	[Correo] [nvarchar](100) NOT NULL,
	[Img] [nvarchar](max) NULL,
	[Id_Categoria] [int] NULL,
	[Folder_Path] [nvarchar](max) NULL,
	[Contraseña] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[servicios_nuevos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[servicios_nuevos](
	[Id_Servicio] [int] IDENTITY(1,1) NOT NULL,
	[Proveedor] [nvarchar](100) NOT NULL,
	[Area_Covertura] [nvarchar](200) NULL,
	[Horarios] [datetime] NULL,
	[Fecha_Creacion] [datetime] NULL,
	[Estatus] [int] NULL,
	[Nombre_Servicio] [nvarchar](160) NOT NULL,
	[Correo] [nvarchar](100) NOT NULL,
	[Img] [nvarchar](max) NULL,
	[Id_Categoria] [int] NULL,
	[Folder_Path] [nvarchar](max) NULL,
	[Puntos] [int] NULL,
	[Descuento] [int] NULL,
	[Destacado] [int] NULL,
	[ValServicionvo] [int] NULL,
 CONSTRAINT [PK_servicios_nuevos] PRIMARY KEY CLUSTERED 
(
	[Id_Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Id_Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[servicios_nuevostem]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[servicios_nuevostem](
	[Id_Serviciotem] [int] IDENTITY(1,1) NOT NULL,
	[Id_Servicio] [int] NOT NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Fecha_Creacion] [datetime] NULL,
	[Nombre_Servicio] [nvarchar](160) NULL,
	[Img] [nvarchar](max) NULL,
	[Folder_Path] [nvarchar](max) NULL,
	[ValGaleria] [int] NULL,
	[ComentarioVal] [nvarchar](max) NULL,
	[idIdioma] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubTipo_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubTipo_Productos](
	[Id_SubTipo_Producto] [int] IDENTITY(1,1) NOT NULL,
	[SubTipo_Producto] [nvarchar](100) NULL,
	[Categoria] [nvarchar](100) NULL,
	[Tipo_Producto] [nvarchar](100) NULL,
	[Descripcion_SubTipo_Producto] [nvarchar](100) NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Estatus_SuTipo_Producto] [int] NULL,
	[Id_Categoria] [int] NULL,
	[Id_Tipo_Producto] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_SubTipo_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Id_SubTipo_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TablaIdioma]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablaIdioma](
	[Tbl_id_Idioma] [int] IDENTITY(1,1) NOT NULL,
	[id_Idioma] [int] NOT NULL,
	[Tabla] [nvarchar](max) NOT NULL,
	[Descripcion] [nvarchar](max) NOT NULL,
	[Bandera] [nvarchar](max) NOT NULL,
	[VarIdioma] [nvarchar](max) NOT NULL,
	[Moneda] [varchar](20) NULL,
	[idPadre] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAdminFlete]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAdminFlete](
	[idAdminFlete] [int] IDENTITY(1,1) NOT NULL,
	[idCobertura] [int] NOT NULL,
	[idTipoPaquete] [int] NOT NULL,
	[Id_Proveedor] [int] NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[fechaBaja] [datetime] NULL,
	[costo] [decimal](18, 2) NULL,
	[idNombreDataRango] [int] NULL,
	[idIdioma] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBLCoberturaProducto]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBLCoberturaProducto](
	[idCoberturaProductoo] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NULL,
	[idCobertura] [int] NULL,
	[idNombreDataRango] [int] NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[fechaBaja] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCodigosPostalesMxLatLog]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCodigosPostalesMxLatLog](
	[Pais] [nvarchar](50) NOT NULL,
	[CodigoPostal] [int] NOT NULL,
	[Colonia] [nvarchar](100) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[column5] [int] NOT NULL,
	[Municipio] [nvarchar](50) NOT NULL,
	[column7] [int] NOT NULL,
	[Municipio02] [nvarchar](50) NULL,
	[column9] [int] NULL,
	[Latitud] [float] NOT NULL,
	[Longitud] [float] NOT NULL,
	[column12] [int] NOT NULL,
	[Clave] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblIdioma]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblIdioma](
	[id_TblIdioma] [int] IDENTITY(1,1) NOT NULL,
	[id_Idioma] [int] NOT NULL,
	[id_Tbl] [int] NOT NULL,
	[Tabla] [nvarchar](max) NOT NULL,
	[IdiomaDescripcion] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblIdiomaProductos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblIdiomaProductos](
	[id_TblIdiomaProductos] [int] IDENTITY(1,1) NOT NULL,
	[id_Idioma] [int] NOT NULL,
	[id_Tbl] [int] NOT NULL,
	[Tabla] [nvarchar](max) NOT NULL,
	[IdiomaNombre] [nvarchar](max) NOT NULL,
	[IdiomaDescripcion] [nvarchar](max) NOT NULL,
	[M_Precio] [decimal](18, 2) NULL,
	[M_Puntos] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblNombreDataRango]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblNombreDataRango](
	[idNombreDataRango] [int] IDENTITY(1,1) NOT NULL,
	[NombreDataRango] [varchar](200) NOT NULL,
	[Id_Proveedor] [int] NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[fechaBaja] [datetime] NULL,
UNIQUE NONCLUSTERED 
(
	[idNombreDataRango] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblpais]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblpais](
	[Id_Pais] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Pais] [varchar](max) NOT NULL,
	[Cont] [varchar](max) NOT NULL,
	[Clave] [varchar](max) NULL,
	[IdEstado] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblRangoMapa]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRangoMapa](
	[idRangoMapa] [int] IDENTITY(1,1) NOT NULL,
	[idCobertura] [int] NOT NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[fechaBaja] [datetime] NULL,
	[Id_Proveedor] [int] NOT NULL,
	[idNombreDataRango] [int] NULL,
	[NombreRutaMap] [varchar](max) NULL,
	[NombreRutaMapSub] [varchar](max) NULL,
UNIQUE NONCLUSTERED 
(
	[idRangoMapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblRangoMapaid]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRangoMapaid](
	[idRangoMapaid] [int] IDENTITY(1,1) NOT NULL,
	[idRangoMapa] [int] NOT NULL,
	[Latitud] [numeric](18, 6) NOT NULL,
	[Longuitud] [numeric](18, 6) NOT NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[fechaBaja] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTipoPaquete]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTipoPaquete](
	[idTipoPaquete] [int] IDENTITY(1,1) NOT NULL,
	[TipoPaquete] [varchar](50) NOT NULL,
	[Largo] [varchar](50) NOT NULL,
	[Width] [varchar](50) NOT NULL,
	[Height] [varchar](50) NOT NULL,
	[Weight_] [varchar](10) NOT NULL,
	[fechaModificacion] [datetime] NOT NULL,
	[RangoPesoV] [varchar](50) NULL,
UNIQUE NONCLUSTERED 
(
	[idTipoPaquete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Productos](
	[Id_Tipo_Producto] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Producto] [nvarchar](50) NULL,
	[Categoria] [nvarchar](100) NULL,
	[Descripcion_Producto] [nvarchar](50) NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Estatus_Tipo_Producto] [int] NULL,
	[Id_Categoria] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Tipo_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Id_Tipo_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Promociones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Promociones](
	[Id_Tipo_Promociones] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Promocion] [nvarchar](50) NULL,
	[Descripcion_Promocion] [nvarchar](50) NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Estatus_Tipo_Promocion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Tipo_Promociones] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Proveedores](
	[Id_Tipo_Proveedores] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Proveedor] [nvarchar](50) NULL,
	[Descripcion_Proveedor] [nvarchar](50) NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Estatus_Tipo_Proveedor] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Tipo_Proveedores] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Servicios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Servicios](
	[Id_Tipo_Servicios] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Servicio] [nvarchar](50) NULL,
	[Descripcion_Servicio] [nvarchar](50) NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Estatus_Tipo_Servicio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Tipo_Servicios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoProducto_Active]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoProducto_Active](
	[Id_tipo] [int] IDENTITY(1,1) NOT NULL,
	[Id_Categoria] [int] NOT NULL,
	[Categoria] [varchar](max) NOT NULL,
	[Id_Tipo_Producto] [int] NOT NULL,
	[Tipo_Producto] [varchar](max) NOT NULL,
	[Active] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Apellido_P] [nvarchar](50) NOT NULL,
	[Apellido_M] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Direccion] [nvarchar](50) NOT NULL,
	[Ciudad] [nvarchar](50) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[Pais] [nvarchar](50) NOT NULL,
	[Codigo_P] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Perfil] [nvarchar](50) NOT NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Estatus_U] [int] NOT NULL,
	[LastLoginDate] [datetime] NULL,
	[Id_Perfil] [int] NULL,
	[Img] [nvarchar](max) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersSEO]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersSEO](
	[Id_UsuarioSEO] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Apellido_P] [nvarchar](50) NOT NULL,
	[Apellido_M] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Direccion] [nvarchar](50) NOT NULL,
	[Ciudad] [nvarchar](50) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[Pais] [nvarchar](50) NOT NULL,
	[Codigo_P] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Perfil] [nvarchar](50) NOT NULL,
	[Fecha_Alta] [datetime] NULL,
	[Usuario_Alta] [nvarchar](50) NULL,
	[Fecha_Act] [datetime] NULL,
	[Usuario_Act] [nvarchar](50) NULL,
	[Fecha_Baja] [datetime] NULL,
	[Usuario_Baja] [nvarchar](50) NULL,
	[Estatus_U] [int] NOT NULL,
	[LastLoginDate] [datetime] NULL,
	[Id_Perfil] [int] NULL,
	[Img] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PaymentId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[State] [varchar](15) NOT NULL,
	[SalePrice] [decimal](6, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PaymentId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VideosProveedor]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideosProveedor](
	[ID_VideoPremium] [int] IDENTITY(1,1) NOT NULL,
	[FolderVideo] [varchar](255) NULL,
	[titulo] [varchar](50) NULL,
	[Descripcion] [varchar](250) NULL,
	[Id_Pro] [int] NOT NULL,
	[Estatus] [int] NOT NULL,
	[ValVideos] [int] NULL,
	[FechaPublicacion] [datetime] NULL,
	[ComentarioVal] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_VideoPremium] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ciudad] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Estado] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[ImagenGaleria] ADD  DEFAULT (getdate()) FOR [FechaPublicacion]
GO
ALTER TABLE [dbo].[Noticias] ADD  DEFAULT (getdate()) FOR [FechaPublicacion]
GO
ALTER TABLE [dbo].[pais] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[PedidoServicio] ADD  DEFAULT ('1') FOR [IdIdiomaP]
GO
ALTER TABLE [dbo].[PedidosNuevo] ADD  DEFAULT ('1') FOR [IdIdiomaP]
GO
ALTER TABLE [dbo].[Proveedores] ADD  CONSTRAINT [DefaultProv]  DEFAULT ((1)) FOR [Estatus_Proveedor]
GO
ALTER TABLE [dbo].[Puntos] ADD  DEFAULT ('1') FOR [IdIdioma]
GO
ALTER TABLE [dbo].[RecibosPremium] ADD  DEFAULT ((0)) FOR [Estatus]
GO
ALTER TABLE [dbo].[TblIdiomaProductos] ADD  DEFAULT ('0') FOR [M_Puntos]
GO
ALTER TABLE [dbo].[VideosProveedor] ADD  DEFAULT ((0)) FOR [Estatus]
GO
ALTER TABLE [dbo].[Canasta]  WITH CHECK ADD  CONSTRAINT [FK_CanastaClientes] FOREIGN KEY([Id_Cliente])
REFERENCES [dbo].[Clientes] ([Id_Cliente])
GO
ALTER TABLE [dbo].[Canasta] CHECK CONSTRAINT [FK_CanastaClientes]
GO
ALTER TABLE [dbo].[Canasta]  WITH CHECK ADD  CONSTRAINT [FK_CanastaProveedor] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[Canasta] CHECK CONSTRAINT [FK_CanastaProveedor]
GO
ALTER TABLE [dbo].[ciudad]  WITH CHECK ADD FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estado] ([Id])
GO
ALTER TABLE [dbo].[ciudad]  WITH CHECK ADD FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estado] ([Id])
GO
ALTER TABLE [dbo].[ClientesDirecciones]  WITH CHECK ADD  CONSTRAINT [FK_ClientesDireccionesClientes] FOREIGN KEY([Id_Cliente])
REFERENCES [dbo].[Clientes] ([Id_Cliente])
GO
ALTER TABLE [dbo].[ClientesDirecciones] CHECK CONSTRAINT [FK_ClientesDireccionesClientes]
GO
ALTER TABLE [dbo].[ImagenGaleria]  WITH CHECK ADD  CONSTRAINT [FK_ImagenGaleriaProveedor] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[ImagenGaleria] CHECK CONSTRAINT [FK_ImagenGaleriaProveedor]
GO
ALTER TABLE [dbo].[Noticias]  WITH CHECK ADD  CONSTRAINT [FK_NoticiasProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[Noticias] CHECK CONSTRAINT [FK_NoticiasProveedores]
GO
ALTER TABLE [dbo].[PaqueteCanasta]  WITH CHECK ADD  CONSTRAINT [FK_PaqueteCanastaClientes] FOREIGN KEY([Id_Cliente])
REFERENCES [dbo].[Clientes] ([Id_Cliente])
GO
ALTER TABLE [dbo].[PaqueteCanasta] CHECK CONSTRAINT [FK_PaqueteCanastaClientes]
GO
ALTER TABLE [dbo].[PaqueteCanasta]  WITH CHECK ADD  CONSTRAINT [FK_PaqueteCanastaProductos_en_Produccion] FOREIGN KEY([Id_Producto])
REFERENCES [dbo].[Productos_en_Produccion] ([Id])
GO
ALTER TABLE [dbo].[PaqueteCanasta] CHECK CONSTRAINT [FK_PaqueteCanastaProductos_en_Produccion]
GO
ALTER TABLE [dbo].[PaqueteCanasta]  WITH CHECK ADD  CONSTRAINT [FK_PaqueteCanastaProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[PaqueteCanasta] CHECK CONSTRAINT [FK_PaqueteCanastaProveedores]
GO
ALTER TABLE [dbo].[PaqueteCanasta]  WITH CHECK ADD  CONSTRAINT [FK_PaqueteCanastaProveedores_Sucursales] FOREIGN KEY([idOrigen])
REFERENCES [dbo].[Proveedores_Sucursales] ([Id])
GO
ALTER TABLE [dbo].[PaqueteCanasta] CHECK CONSTRAINT [FK_PaqueteCanastaProveedores_Sucursales]
GO
ALTER TABLE [dbo].[PedidoServicio]  WITH CHECK ADD  CONSTRAINT [FK_PedidoServicioClientes] FOREIGN KEY([Id_Cliente])
REFERENCES [dbo].[Clientes] ([Id_Cliente])
GO
ALTER TABLE [dbo].[PedidoServicio] CHECK CONSTRAINT [FK_PedidoServicioClientes]
GO
ALTER TABLE [dbo].[PedidoServicio]  WITH CHECK ADD  CONSTRAINT [FK_PedidoServicioProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[PedidoServicio] CHECK CONSTRAINT [FK_PedidoServicioProveedores]
GO
ALTER TABLE [dbo].[PedidoServicio]  WITH CHECK ADD  CONSTRAINT [FK_PedidoServicioProveedores_Sucursales] FOREIGN KEY([idOrigen])
REFERENCES [dbo].[Proveedores_Sucursales] ([Id])
GO
ALTER TABLE [dbo].[PedidoServicio] CHECK CONSTRAINT [FK_PedidoServicioProveedores_Sucursales]
GO
ALTER TABLE [dbo].[PedidoServicio]  WITH CHECK ADD  CONSTRAINT [FK_PedidoServicioservicios_nuevos] FOREIGN KEY([Id_Servicio])
REFERENCES [dbo].[servicios_nuevos] ([Id_Servicio])
GO
ALTER TABLE [dbo].[PedidoServicio] CHECK CONSTRAINT [FK_PedidoServicioservicios_nuevos]
GO
ALTER TABLE [dbo].[PedidosNuevo]  WITH CHECK ADD  CONSTRAINT [FK_PedidosNuevoClientes] FOREIGN KEY([Id_Cliente])
REFERENCES [dbo].[Clientes] ([Id_Cliente])
GO
ALTER TABLE [dbo].[PedidosNuevo] CHECK CONSTRAINT [FK_PedidosNuevoClientes]
GO
ALTER TABLE [dbo].[PedidosNuevo]  WITH CHECK ADD  CONSTRAINT [FK_PedidosNuevoProductos_en_Produccion] FOREIGN KEY([Id_Producto])
REFERENCES [dbo].[Productos_en_Produccion] ([Id])
GO
ALTER TABLE [dbo].[PedidosNuevo] CHECK CONSTRAINT [FK_PedidosNuevoProductos_en_Produccion]
GO
ALTER TABLE [dbo].[PedidosNuevo]  WITH CHECK ADD  CONSTRAINT [FK_PedidosNuevoProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[PedidosNuevo] CHECK CONSTRAINT [FK_PedidosNuevoProveedores]
GO
ALTER TABLE [dbo].[PedidosNuevo]  WITH CHECK ADD  CONSTRAINT [FK_PedidosNuevoProveedores_Sucursales] FOREIGN KEY([idOrigen])
REFERENCES [dbo].[Proveedores_Sucursales] ([Id])
GO
ALTER TABLE [dbo].[PedidosNuevo] CHECK CONSTRAINT [FK_PedidosNuevoProveedores_Sucursales]
GO
ALTER TABLE [dbo].[Productos_en_Produccion]  WITH CHECK ADD  CONSTRAINT [FK_Productos_en_ProduccionCategoria_Active] FOREIGN KEY([Id_Categoria])
REFERENCES [dbo].[Categoria_Active] ([Id_Categoria])
GO
ALTER TABLE [dbo].[Productos_en_Produccion] CHECK CONSTRAINT [FK_Productos_en_ProduccionCategoria_Active]
GO
ALTER TABLE [dbo].[Productos_en_Produccion]  WITH CHECK ADD  CONSTRAINT [FK_Productos_en_ProduccionProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[Productos_en_Produccion] CHECK CONSTRAINT [FK_Productos_en_ProduccionProveedores]
GO
ALTER TABLE [dbo].[Productos_en_Produccion]  WITH CHECK ADD  CONSTRAINT [FK_Productos_en_ProduccionProveedores_Sucursales] FOREIGN KEY([idOrigen])
REFERENCES [dbo].[Proveedores_Sucursales] ([Id])
GO
ALTER TABLE [dbo].[Productos_en_Produccion] CHECK CONSTRAINT [FK_Productos_en_ProduccionProveedores_Sucursales]
GO
ALTER TABLE [dbo].[Proveedores_Sucursales]  WITH CHECK ADD  CONSTRAINT [FK_Proveedores_SucursalesProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[Proveedores_Sucursales] CHECK CONSTRAINT [FK_Proveedores_SucursalesProveedores]
GO
ALTER TABLE [dbo].[Puntos]  WITH CHECK ADD  CONSTRAINT [FK_PuntosClientes] FOREIGN KEY([Id_Cliente])
REFERENCES [dbo].[Clientes] ([Id_Cliente])
GO
ALTER TABLE [dbo].[Puntos] CHECK CONSTRAINT [FK_PuntosClientes]
GO
ALTER TABLE [dbo].[Puntos]  WITH CHECK ADD  CONSTRAINT [FK_PuntosProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[Puntos] CHECK CONSTRAINT [FK_PuntosProveedores]
GO
ALTER TABLE [dbo].[Servicios]  WITH CHECK ADD  CONSTRAINT [FK_ServiciosProveedores] FOREIGN KEY([Nombre_Proveedor])
REFERENCES [dbo].[Proveedores] ([Nombre_Proveedor])
GO
ALTER TABLE [dbo].[Servicios] CHECK CONSTRAINT [FK_ServiciosProveedores]
GO
ALTER TABLE [dbo].[SubTipo_Productos]  WITH CHECK ADD  CONSTRAINT [FK_SubTipo_ProductosCategoria_Active] FOREIGN KEY([Id_Categoria])
REFERENCES [dbo].[Categoria_Active] ([Id_Categoria])
GO
ALTER TABLE [dbo].[SubTipo_Productos] CHECK CONSTRAINT [FK_SubTipo_ProductosCategoria_Active]
GO
ALTER TABLE [dbo].[SubTipo_Productos]  WITH CHECK ADD  CONSTRAINT [FK_SubTipo_ProductosTipo_Productos] FOREIGN KEY([Id_Tipo_Producto])
REFERENCES [dbo].[Tipo_Productos] ([Id_Tipo_Producto])
GO
ALTER TABLE [dbo].[SubTipo_Productos] CHECK CONSTRAINT [FK_SubTipo_ProductosTipo_Productos]
GO
ALTER TABLE [dbo].[TblAdminFlete]  WITH CHECK ADD  CONSTRAINT [FK_TblAdminFleteCobertura] FOREIGN KEY([idCobertura])
REFERENCES [dbo].[Cobertura] ([idCobertura])
GO
ALTER TABLE [dbo].[TblAdminFlete] CHECK CONSTRAINT [FK_TblAdminFleteCobertura]
GO
ALTER TABLE [dbo].[TblAdminFlete]  WITH CHECK ADD  CONSTRAINT [FK_TblAdminFleteProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[TblAdminFlete] CHECK CONSTRAINT [FK_TblAdminFleteProveedores]
GO
ALTER TABLE [dbo].[TblAdminFlete]  WITH CHECK ADD  CONSTRAINT [FK_TblAdminFleteTblNombreDataRango] FOREIGN KEY([idNombreDataRango])
REFERENCES [dbo].[TblNombreDataRango] ([idNombreDataRango])
GO
ALTER TABLE [dbo].[TblAdminFlete] CHECK CONSTRAINT [FK_TblAdminFleteTblNombreDataRango]
GO
ALTER TABLE [dbo].[TblAdminFlete]  WITH CHECK ADD  CONSTRAINT [FK_TblAdminFleteTblTipoPaquete] FOREIGN KEY([idTipoPaquete])
REFERENCES [dbo].[TblTipoPaquete] ([idTipoPaquete])
GO
ALTER TABLE [dbo].[TblAdminFlete] CHECK CONSTRAINT [FK_TblAdminFleteTblTipoPaquete]
GO
ALTER TABLE [dbo].[TBLCoberturaProducto]  WITH CHECK ADD  CONSTRAINT [FK_TBLCoberturaProductoCobertura] FOREIGN KEY([idCobertura])
REFERENCES [dbo].[Cobertura] ([idCobertura])
GO
ALTER TABLE [dbo].[TBLCoberturaProducto] CHECK CONSTRAINT [FK_TBLCoberturaProductoCobertura]
GO
ALTER TABLE [dbo].[TBLCoberturaProducto]  WITH CHECK ADD  CONSTRAINT [FK_TBLCoberturaProductoTblNombreDataRango] FOREIGN KEY([idNombreDataRango])
REFERENCES [dbo].[TblNombreDataRango] ([idNombreDataRango])
GO
ALTER TABLE [dbo].[TBLCoberturaProducto] CHECK CONSTRAINT [FK_TBLCoberturaProductoTblNombreDataRango]
GO
ALTER TABLE [dbo].[TblNombreDataRango]  WITH CHECK ADD  CONSTRAINT [FK_TblNombreDataRangoProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[TblNombreDataRango] CHECK CONSTRAINT [FK_TblNombreDataRangoProveedores]
GO
ALTER TABLE [dbo].[TblRangoMapa]  WITH CHECK ADD  CONSTRAINT [FK_TblRangoMapaCobertura] FOREIGN KEY([idCobertura])
REFERENCES [dbo].[Cobertura] ([idCobertura])
GO
ALTER TABLE [dbo].[TblRangoMapa] CHECK CONSTRAINT [FK_TblRangoMapaCobertura]
GO
ALTER TABLE [dbo].[TblRangoMapa]  WITH CHECK ADD  CONSTRAINT [FK_TblRangoMapaProveedores] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[TblRangoMapa] CHECK CONSTRAINT [FK_TblRangoMapaProveedores]
GO
ALTER TABLE [dbo].[TblRangoMapa]  WITH CHECK ADD  CONSTRAINT [FK_TblRangoMapaTblNombreDataRango] FOREIGN KEY([idNombreDataRango])
REFERENCES [dbo].[TblNombreDataRango] ([idNombreDataRango])
GO
ALTER TABLE [dbo].[TblRangoMapa] CHECK CONSTRAINT [FK_TblRangoMapaTblNombreDataRango]
GO
ALTER TABLE [dbo].[TblRangoMapaid]  WITH CHECK ADD  CONSTRAINT [FK_TblRangoMapaidTblRangoMapa] FOREIGN KEY([idRangoMapa])
REFERENCES [dbo].[TblRangoMapa] ([idRangoMapa])
GO
ALTER TABLE [dbo].[TblRangoMapaid] CHECK CONSTRAINT [FK_TblRangoMapaidTblRangoMapa]
GO
ALTER TABLE [dbo].[Tipo_Productos]  WITH CHECK ADD  CONSTRAINT [FK_Categoria_ActiveTipo_Productos] FOREIGN KEY([Id_Categoria])
REFERENCES [dbo].[Categoria_Active] ([Id_Categoria])
GO
ALTER TABLE [dbo].[Tipo_Productos] CHECK CONSTRAINT [FK_Categoria_ActiveTipo_Productos]
GO
ALTER TABLE [dbo].[VideosProveedor]  WITH CHECK ADD  CONSTRAINT [FK_VideosProveedorProveedores] FOREIGN KEY([Id_Pro])
REFERENCES [dbo].[Proveedores] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[VideosProveedor] CHECK CONSTRAINT [FK_VideosProveedorProveedores]
GO
/****** Object:  StoredProcedure [dbo].[ChatsCubo]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ChatsCubo]
AS
	SET NOCOUNT ON;
	select  NombreReq,YEAR(FechaIni) AS añoo,FechaIni,FechaFin,FromNum,Etapa,CorreoReq,GiroComReq,Source,FechaSalu,FechaMenu,FechaDuda,FechaReg, 100 as porcentaje FROM ChatsProspectos
iF (select FechaReg from ChatsProspectos) != null
	select  NombreReq,YEAR(FechaIni) AS añoo,FechaIni,FechaFin,FromNum,Etapa,CorreoReq,GiroComReq,Source,FechaSalu,FechaMenu,FechaDuda,FechaReg, 100 as porcentaje FROM ChatsProspectos
ELSE
iF (select FechaMenu from ChatsProspectos) != null
	select  NombreReq,YEAR(FechaIni) AS añoo,FechaIni,FechaFin,FromNum,Etapa,CorreoReq,GiroComReq,Source,FechaSalu,FechaMenu,FechaDuda,FechaReg, 66 as porcentaje FROM ChatsProspectos
ELSE
iF (select FechaSalu from ChatsProspectos) != null
	select  NombreReq,YEAR(FechaIni) AS añoo,FechaIni,FechaFin,FromNum,Etapa,CorreoReq,GiroComReq,Source,FechaSalu,FechaMenu,FechaDuda,FechaReg, 33 as porcentaje FROM ChatsProspectos

GO
/****** Object:  StoredProcedure [dbo].[ChatsDudasDelete]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChatsDudasDelete]
(
	@Original_IDDuda int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [CHATSDUDAS] WHERE (([IDDuda] = @Original_IDDuda))
GO
/****** Object:  StoredProcedure [dbo].[ChatsDudasInsert]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChatsDudasInsert]
(
	@FechaDuda datetime = NULL,
	@NombreUser varchar(50) = NULL,
	@EmailUser varchar(50) = NULL,
	@GiroUser varchar(50) = NULL,
	@IDChat int = NULL,
	@NumFrom varchar(50) = NULL,
	@EmailReceptor varchar(50) = NULL,
	@Duda varchar(MAX) = NULL,
	@FechaRespuesta datetime = NULL,
	@Respuesta varchar(MAX) = NULL
)
AS
	SET NOCOUNT OFF;
INSERT INTO [CHATSDUDAS] ([FechaDuda], [NombreUser], [EmailUser], [GiroUser], [IDChat], [NumFrom], [EmailReceptor], [Duda], [FechaRespuesta], [Respuesta]) VALUES (@FechaDuda, @NombreUser, @EmailUser, @GiroUser, @IDChat, @NumFrom, @EmailReceptor, @Duda, @FechaRespuesta, @Respuesta);
	
SELECT IDDuda, FechaDuda, NombreUser, EmailUser, GiroUser, IDChat, NumFrom, EmailReceptor, Duda, FechaRespuesta, Respuesta FROM ChatsDudas WHERE (IDDuda = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[ChatsDudasSelect]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChatsDudasSelect]
AS
	SET NOCOUNT ON;
SELECT  *  FROM CHATSDUDAS
GO
/****** Object:  StoredProcedure [dbo].[ChatsDudasUpdate]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChatsDudasUpdate]
(
	@FechaDuda datetime,
	@NombreUser varchar(50),
	@EmailUser varchar(50),
	@GiroUser varchar(50),
	@IDChat int,
	@NumFrom varchar(50),
	@EmailReceptor varchar(50),
	@Duda varchar(MAX),
	@FechaRespuesta datetime,
	@Respuesta varchar(MAX),
	@Original_IDDuda int,
	@IDDuda int
)
AS
	SET NOCOUNT OFF;
UPDATE [CHATSDUDAS] SET [FechaDuda] = @FechaDuda, [NombreUser] = @NombreUser, [EmailUser] = @EmailUser, [GiroUser] = @GiroUser, [IDChat] = @IDChat, [NumFrom] = @NumFrom, [EmailReceptor] = @EmailReceptor, [Duda] = @Duda, [FechaRespuesta] = @FechaRespuesta, [Respuesta] = @Respuesta WHERE (([IDDuda] = @Original_IDDuda));
	
SELECT IDDuda, FechaDuda, NombreUser, EmailUser, GiroUser, IDChat, NumFrom, EmailReceptor, Duda, FechaRespuesta, Respuesta FROM ChatsDudas WHERE (IDDuda = @IDDuda)
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosDelete]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChatsProspectosDelete]
(
	@Original_IdChat int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [ChatsProspectos] WHERE (([IdChat] = @Original_IdChat))
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosInsert]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChatsProspectosInsert]
(
	@ProfName varchar(50)= NULL,
	@FechaIni datetime= NULL,
	@FechaFin datetime= NULL,
	@FromNum varchar(50)= NULL,
	@ToNum varchar(50)= NULL,
	@Etapa varchar(30)= NULL,
	@NombreReq varchar(50)= NULL,
	@CorreoReq varchar(30)= NULL,
	@GiroComReq varchar(50)= NULL,
	@Source varchar(30)= NULL,
	@FechaSalu datetime= NULL,
	@FechaMenu datetime= NULL,
	@FechaDuda datetime= NULL,
	@FechaReg datetime= NULL,
	@FechaTermin datetime= NULL,
	@Estatuss int = NULL
)
AS
	SET NOCOUNT OFF;
INSERT INTO [ChatsProspectos] ([ProfName], [FechaIni], [FechaFin], [FromNum], [ToNum], [Etapa], [NombreReq], [CorreoReq], [GiroComReq], [Source], [FechaSalu], [FechaMenu], [FechaDuda], [FechaReg], [FechaTermin], [Estatuss]) VALUES (@ProfName, @FechaIni, @FechaFin, @FromNum, @ToNum, @Etapa, @NombreReq, @CorreoReq, @GiroComReq, @Source, @FechaSalu, @FechaMenu, @FechaDuda, @FechaReg, @FechaTermin, @Estatuss);
	
SELECT IdChat FROM ChatsProspectos WHERE (IdChat = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosSelect]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChatsProspectosSelect]
@NAMEE varchar(50) = NULL,
@FROMM varchar(50) = NULL
AS
	SET NOCOUNT ON;
SELECT * FROM ChatsProspectos WHERE ProfName = @NAMEE AND FromNum = @FROMM
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosUpdate]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChatsProspectosUpdate]
(
	@ProfName varchar(50),
	@FechaIni datetime,
	@FechaFin datetime,
	@FromNum varchar(50),
	@ToNum varchar(50),
	@Etapa varchar(30),
	@NombreReq varchar(50),
	@CorreoReq varchar(30),
	@GiroComReq varchar(50),
	@Source varchar(30),
	@FechaSalu datetime,
	@FechaMenu datetime,
	@FechaDuda datetime,
	@FechaReg datetime,
	@FechaTermin datetime,
	@Estatuss int,
	@Original_IdChat int,
	@IdChat int
)
AS
	SET NOCOUNT OFF;
UPDATE [ChatsProspectos] SET [ProfName] = @ProfName, [FechaIni] = @FechaIni, [FechaFin] = @FechaFin, [FromNum] = @FromNum, [ToNum] = @ToNum, [Etapa] = @Etapa, [NombreReq] = @NombreReq, [CorreoReq] = @CorreoReq, [GiroComReq] = @GiroComReq, [Source] = @Source, [FechaSalu] = @FechaSalu, [FechaMenu] = @FechaMenu, [FechaDuda] = @FechaDuda, [FechaReg] = @FechaReg, [FechaTermin] = @FechaTermin, [Estatuss] = @Estatuss WHERE (([IdChat] = @Original_IdChat));
	
SELECT IdChat, ProfName, FechaIni, FechaFin, FromNum, ToNum, Etapa, NombreReq, CorreoReq, GiroComReq, Source, FechaSalu, FechaMenu, FechaDuda, FechaReg, FechaTermin, Estatuss FROM ChatsProspectos WHERE (IdChat = @IdChat)
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosUpdateDuda]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChatsProspectosUpdateDuda]
(
	@Etapa varchar(30),
	@FechaDuda datetime,
	@IdChat int
)
AS
	SET NOCOUNT OFF;
UPDATE [ChatsProspectos] SET 
[Etapa] = @Etapa, 
[FechaDuda]=@FechaDuda
WHERE (([IdChat] = @IdChat));
	
SELECT IdChat FROM ChatsProspectos WHERE (IdChat = @IdChat)
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosUpdateRegistro]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChatsProspectosUpdateRegistro]
(
	@Etapa varchar(30),
	@FechaReg datetime,
	@FechaTermin datetime = NULL,
	@Estatuss int,
	@IdChat int
)
AS
	SET NOCOUNT OFF;
UPDATE [ChatsProspectos] SET 
[Etapa] = @Etapa, 
[FechaReg] = @FechaReg, 
[FechaTermin] = @FechaTermin, 
[Estatuss] = @Estatuss 
WHERE (([IdChat] = @IdChat));
	
SELECT IdChat FROM ChatsProspectos WHERE (IdChat = @IdChat)
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosUpdateSOLDATOS]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ChatsProspectosUpdateSOLDATOS]
(
	@Etapa varchar(30),
	@NombreReq varchar(50),
	@CorreoReq varchar(30),
	@GiroComReq varchar(50),
	@FechaMenu datetime,
	@IdChat int
)
AS
	SET NOCOUNT OFF;
UPDATE [ChatsProspectos] SET 
[Etapa] = @Etapa, 
[NombreReq] = @NombreReq, 
[CorreoReq] = @CorreoReq, 
[GiroComReq] = @GiroComReq, 
[FechaMenu] = @FechaMenu
WHERE (([IdChat] = @IdChat));
	
SELECT IdChat FROM ChatsProspectos WHERE (IdChat = @IdChat)
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosUpdateSOLDATOSemail]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ChatsProspectosUpdateSOLDATOSemail]
(
	@Etapa varchar(30),
	@CorreoReq varchar(30),
	@FechaMenu datetime,
	@IdChat int
)
AS
	SET NOCOUNT OFF;
UPDATE [ChatsProspectos] SET 
[Etapa] = @Etapa, 
[CorreoReq] = @CorreoReq, 
[FechaMenu] = @FechaMenu
WHERE (([IdChat] = @IdChat));
	
SELECT IdChat FROM ChatsProspectos WHERE (IdChat = @IdChat)
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosUpdateSOLDATOSgiro]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ChatsProspectosUpdateSOLDATOSgiro]
(
	@Etapa varchar(30),
	@GiroComReq varchar(50),
	@FechaMenu datetime,
	@IdChat int
)
AS
	SET NOCOUNT OFF;
UPDATE [ChatsProspectos] SET 
[Etapa] = @Etapa, 
[GiroComReq] = @GiroComReq, 
[FechaMenu] = @FechaMenu
WHERE (([IdChat] = @IdChat));
	
SELECT IdChat FROM ChatsProspectos WHERE (IdChat = @IdChat)
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosUpdateSOLDATOSrazonsoc]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[ChatsProspectosUpdateSOLDATOSrazonsoc]
(
	@Etapa varchar(30),
	@NombreReq varchar(50),
	@FechaMenu datetime,
	@IdChat int
)
AS
	SET NOCOUNT OFF;
UPDATE [ChatsProspectos] SET 
[Etapa] = @Etapa, 
[NombreReq] = @NombreReq, 
[FechaMenu] = @FechaMenu
WHERE (([IdChat] = @IdChat));
	
SELECT IdChat FROM ChatsProspectos WHERE (IdChat = @IdChat)
GO
/****** Object:  StoredProcedure [dbo].[ChatsProspectosUpdateSOLICITEnombre]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChatsProspectosUpdateSOLICITEnombre]
(
	@Etapa varchar(30),
	@FechaMenu datetime,
	@IdChat int
)
AS
	SET NOCOUNT OFF;
UPDATE [ChatsProspectos] SET 
[Etapa] = @Etapa, 
[FechaMenu] = @FechaMenu
WHERE (([IdChat] = @IdChat));
	
SELECT IdChat FROM ChatsProspectos WHERE (IdChat = @IdChat)
GO
/****** Object:  StoredProcedure [dbo].[CheckCanasta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckCanasta]
	@Id_Cte int = 0,
	@Id_Idioma int = 0
AS
BEGIN


--declare 	@Id_Cte int = 2,
--	@Id_Idioma int = 2

	SET NOCOUNT ON;
	SELECT Canasta.Id_Canasta, 
	Productos_En_Produccion.Ruta_Img_Principal as Img, 
	M_precio Precio, Canasta.Id_Producto,  
	Canasta.Cantidad, Productos_en_Produccion.clave, 
	Productos_en_Produccion.Descuento, 
	Productos_en_Produccion.Ruta_Img_Principal, 
	 IdiomaNombre Nombre, 
	Proveedores.Nombre_Proveedor 
	, '' + left((REPLACE(.Productos_En_Produccion.Nombre,'/','')),20) +'-'+ convert(nvarchar(max),Productos_En_Produccion.Id)  as urlPage
	FROM canasta 
	left join Productos_En_Produccion on Id_Producto = Id
	INNER JOIN (select id_Tbl, IdiomaNombre,IdiomaDescripcion,M_precio from TblIdiomaProductos  
                         where Tabla = 'Productos_en_Produccion' and id_Idioma = @Id_Idioma) as idiomatbl on idiomatbl.id_Tbl = Productos_en_Produccion.Id
	left join Proveedores on Canasta.Id_Proveedor = Proveedores.Id_Proveedor
	WHERE Id_Cliente = @Id_Cte AND Id_Servicio = 0 and tipoidioma = @Id_Idioma


	END
GO
/****** Object:  StoredProcedure [dbo].[CheckCelprov]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckCelprov]
	@cel varchar (max) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * From Clientes where Tel_Celular = @cel
	END
GO
/****** Object:  StoredProcedure [dbo].[CheckCelRegprov]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckCelRegprov]
	@cel varchar (max) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * From proveedores where Telefono = @cel
	END
GO
/****** Object:  StoredProcedure [dbo].[CheckEmailCelRegprov]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckEmailCelRegprov]
	@emmmail varchar (max) = NULL,
	@celular varchar (max) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * From proveedores where correo = @emmmail AND Telefono = @celular
	END
GO
/****** Object:  StoredProcedure [dbo].[CheckEmailReg]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckEmailReg]
	@emmmail varchar (max) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * From Clientes where email = @emmmail
	END
GO
/****** Object:  StoredProcedure [dbo].[CheckEmailRegprov]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckEmailRegprov]
	@emmmail varchar (max) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * From proveedores where correo = @emmmail
	END
GO
/****** Object:  StoredProcedure [dbo].[existe]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[existe]

@Accion as nchar(20)=''
,@ID_Usuario as int=0 Output
,@Email as nvarchar(50)=''
,@session as nvarchar(50)=''	

AS
BEGIN
If @Accion='Buscar_Correo'
		Begin
			Select Id_Acceso,Correo,Id_Sesion
			from Accesos
			where Correo=@Email AND Id_Sesion=@session 
		END
END
GO
/****** Object:  StoredProcedure [dbo].[FillCanasta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FillCanasta]
	@Id_Cte int = 0,
	@Id_Idioma int = 0
AS
BEGIN
SET NOCOUNT ON;
SELECT Canasta.Precio, servicios_nuevos.img, 
                 IdiomaNombre Nombre_Servicio, 
                IdiomaDescripcion Descripcion, 
                servicios_nuevos.Proveedor 
                FROM Canasta 
				inner join Servicios_Nuevos ON Canasta.Id_Servicio = servicios_nuevos.Id_Servicio
				INNER JOIN (select id_Tbl, IdiomaNombre,IdiomaDescripcion,M_precio from TblIdiomaProductos  
                where Tabla = 'servicios_nuevos' and id_Idioma = @Id_Idioma) as idiomatbl on idiomatbl.id_Tbl = Servicios_Nuevos.Id_Servicio
	                    left join Proveedores on Canasta.Id_Proveedor = Proveedores.Id_Proveedor
                where Id_Cliente = @Id_Cte and tipoidioma = @Id_Idioma

END
GO
/****** Object:  StoredProcedure [dbo].[Getcategoria]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date: 12052016
-- Description:	GETCATEGORIA
-- =============================================
CREATE PROCEDURE [dbo].[Getcategoria]
@id_Idioma int = 1
AS
BEGIN
	SET NOCOUNT ON;
	--SELECT DISTINCT categoria_active.Id_Categoria,categoria_active.Categoria FROM categoria_active 
	--INNER JOIN SubTipo_Productos ON SubTipo_Productos.id_categoria = categoria_active.id_categoria AND SubTipo_Productos.Estatus_SuTipo_Producto = 1
	--WHERE ACTIVE_WPS = 1 order by categoria_active.Id_Categoria

		SELECT DISTINCT categoria_active.Id_Categoria,tblidioma.IdiomaDescripcion as Categoria FROM categoria_active 
	inner join (select id_Tbl,Tabla,IdiomaDescripcion from TblIdioma inner join Idioma on Idioma.id_Idioma = TblIdioma.id_Idioma where Tabla = 'Categoria_Active' and Idioma.id_Idioma = @id_Idioma) tblidioma  on tblidioma.id_Tbl = categoria_active.Id_Categoria
	INNER JOIN SubTipo_Productos ON SubTipo_Productos.id_categoria = categoria_active.id_categoria AND SubTipo_Productos.Estatus_SuTipo_Producto = 1
	WHERE ACTIVE_WPS = 1 order by categoria_active.Id_Categoria

END
GO
/****** Object:  StoredProcedure [dbo].[GetCategoriaProduccion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date:12052016
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCategoriaProduccion]
	@Id_Categoria int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id FROM Productos_En_Produccion WHERE Id_Categoria = @Id_Categoria
END
GO
/****** Object:  StoredProcedure [dbo].[getPedidodetalle]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date:11052016
-- =============================================
CREATE PROCEDURE [dbo].[getPedidodetalle]
	@id_paquete int = 0
AS
BEGIN
SET NOCOUNT ON;
SELECT Productos_En_Produccion.Ruta_Img_Principal, pnvo.Id_Paquete,Productos_En_Produccion.Nombre,PedidosNuevo.Precio,
                                  PedidosNuevo.Cantidad, PedidosNuevo.Precio * PedidosNuevo.Cantidad AS total , PedidosNuevo.Id_Producto,PedidosNuevo.NumeroPaquete
                                  --,CASE WHEN ISNULL(pack.estatusguia,0) = 'CONFIRMADO' THEN (CASE WHEN ISNULL(Calificacion.NumeroPaquete,0) = '0' THEN pack.estatusguia ELSE 'Oculta' END) ELSE 'Oculta' END  AS estatusguia3
								  ,ISNULL('<div class="rateit" data-rateit-value="'+Convert(Varchar(max),(Calificacion.CalificacionP1)/2)+'" data-rateit-ispreset="true" data-rateit-readonly="true"></div>','Sin Evaluar') as estatusguia3
                                  FROM PedidosNuevo 
                                  LEFT JOIN Productos_En_Produccion ON Productos_En_Produccion.Id = Id_Producto 
                                  LEFT JOIN PaqueteNuevo pnvo ON pnvo.NumeroPaquete = PedidosNuevo.NumeroPaquete  
                                  left JOIN DireccionPedido pack ON pack.Id_Pedido = PedidosNuevo.Id_Pedido
                                  left JOIN Calificacion ON Calificacion.NumeroPaquete = PedidosNuevo.NumeroPaquete AND Calificacion.Id_Producto = PedidosNuevo.Id_Producto
                                  WHERE pnvo.Id_Paquete = @id_paquete

END
GO
/****** Object:  StoredProcedure [dbo].[GetProdDestacado]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProdDestacado]
-- Parameters
@id_Idioma int = 1
AS
BEGIN
	SET NOCOUNT ON;
	--declare @id_Idioma int = 2
	SELECT TOP 12 Id,Ruta_Img_Principal,
	M_Puntos Puntos,
	Productos_en_Produccion.Descuento,
	ISNULL(IdiomaNombre,Nombre) as Nombre,
	IdiomaDescripcion as Descripcion,
	Proveedores.Nombre_Proveedor Proveedor,
	M_Precio as Precio,
	Alt,
	ISNULL(cantidad,0) AS cantidad,
	 CASE when ISNULL(Fecha_Modificacion,0) = 0 then '/previewdetails_Prod.aspx?Id=' + convert(nvarchar(max),Id) else 
left(REPLACE(REPLACE(REPLACE(Nombre,'/',''),' ','_'),'+',''),20)+'-'+ convert(nvarchar(max),Id) END  as urlPage
		FROM Productos_en_Produccion-- WHERE destacado = 1 
		LEFT JOIN (select id_producto, sum(cantidad) cantidad from [dbo].[PedidosNuevo] group by id_producto) tct ON Productos_en_Produccion.Id = tct.Id_Producto
		INNER JOIN Proveedores ON Proveedores.Id_Proveedor = Productos_en_Produccion.Id_Proveedor AND Proveedores.Premium = 1 AND Proveedores.Usuario_Baja is null
		LEFT JOIN ImagenALT on ImagenALT.RutaImagen = Ruta_Img_Principal
		LEFT JOIN AdministrarLinknRed on Productos_en_Produccion.Fecha_Alta <= AdministrarLinknRed.Fecha_Modificacion
		INNER JOIN (select id_Tbl, IdiomaNombre,IdiomaDescripcion,M_precio,M_Puntos from TblIdiomaProductos  where Tabla = 'Productos_en_Produccion' and id_Idioma = @id_Idioma) as idiomatbl on idiomatbl.id_Tbl = Productos_en_Produccion.Id
		WHERE Productos_en_Produccion.Estatus = 1 and Productos_en_Produccion.ValProductonvo = 1
		Order By cantidad DESC, NEWID()

END
GO
/****** Object:  StoredProcedure [dbo].[GetProdDestacados]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProdDestacados]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id,Nombre,
	Puntos,
	Descripcion,
	Ruta_Img_Principal,
	Precio,
	Descuento,
	Proveedor 
	FROM productos_en_produccion where Estatus = 1 order by puntos desc
END
GO
/****** Object:  StoredProcedure [dbo].[GetProductsPager]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[GetProductsPager]
      @PageIndex INT = 1
      ,@PageSize INT = 12
      ,@RecordCount INT OUTPUT
AS
BEGIN
      SET NOCOUNT ON;
      SELECT ROW_NUMBER() OVER
      (ORDER BY [Id] ASC)AS RowNumber,
      Puntos,
      Id,
      Ruta_Img_Principal,
      Descuento,
      Nombre,
      Descripcion,
      Proveedor,
      Precio
      INTO #Results
      FROM [Productos_En_Produccion]
     
      SELECT @RecordCount = COUNT(*)
      FROM #Results
           
      SELECT * FROM #Results
      WHERE RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
     
      DROP TABLE #Results
END
GO
/****** Object:  StoredProcedure [dbo].[GetProvDestacado]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date:15072016
-- Description:SP
-- =============================================
CREATE PROCEDURE [dbo].[GetProvDestacado]
@id_Idioma int = 1
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 12 Proveedores.Id_Proveedor, FilePath, ISNULL(cantidad,0) AS cantidad 
	, CASE WHEN ISNULL(Proveedores.Website,0) = '0' THEN '/preview_prov.aspx?Id_P=' + convert(nvarchar(max),Proveedores.Id_Proveedor) ELSE '/'+Proveedores.Website END AS URLProv
	FROM Proveedores 
	LEFT JOIN (select Id_Proveedor, sum(cantidad) cantidad from [dbo].[PedidosNuevo] group by Id_Proveedor) tct ON Proveedores.Id_Proveedor = tct.Id_Proveedor
	inner join Productos_en_Produccion pp on pp.Id_Proveedor = Proveedores.Id_Proveedor AND Proveedores.Premium = 1 AND Proveedores.Usuario_Baja is null
	INNER JOIN (select id_Tbl from TblIdiomaProductos  where Tabla = 'Productos_en_Produccion' and id_Idioma = @id_Idioma) as idiomatbl on idiomatbl.id_Tbl = pp.Id
	WHERE pp.estatus = 1 
	group by Proveedores.Id_Proveedor, FilePath,tct.cantidad,Proveedores.Website
	ORDER BY cantidad DESC,NEWID() 
END

GO
/****** Object:  StoredProcedure [dbo].[GetProveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProveedores]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id_Proveedor,Nombre_Proveedor,Tipo_Proveedor,Direccion,FilePath from proveedores
END
GO
/****** Object:  StoredProcedure [dbo].[GetProveedores2]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProveedores2]
@idprov int
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id_Proveedor,Nombre_Proveedor,Website from proveedores
    WHERE Id_Proveedor = @idprov
END
GO
/****** Object:  StoredProcedure [dbo].[Getpuntos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date: 12/05/2016
-- =============================================
CREATE PROCEDURE [dbo].[Getpuntos]
	@Id_Cte int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT cantidad_Producto,
	       PuntosUnitario 
	       FROM Puntos 
	       WHERE Id_Cliente = @Id_Cte

END
GO
/****** Object:  StoredProcedure [dbo].[GetRandom]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date: 19-05-2016
-- Description:	DOB sp
-- =============================================
CREATE PROCEDURE [dbo].[GetRandom]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id_Categoria, Categoria FROM Productos_en_produccion GROUP BY Id_Categoria, Categoria
END
GO
/****** Object:  StoredProcedure [dbo].[GETRANDOM2]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date: 24/05/2016
-- Description:	GETRANDOM_SUBSECUENT
-- =============================================
CREATE PROCEDURE [dbo].[GETRANDOM2]
@Id_Categoria INT = 0
	AS
BEGIN
	SET NOCOUNT ON;
	SELECT Puntos,Descuento,Nombre,Id,Descripcion,Ruta_Img_Principal,Precio,Proveedor 
	FROM productos_en_produccion where Estatus = 1 and Id_Categoria = @Id_Categoria
END
GO
/****** Object:  StoredProcedure [dbo].[GetServiciosProduccion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date:12052016
-- Description:	GetServiciosProduccion
-- =============================================
CREATE PROCEDURE [dbo].[GetServiciosProduccion]
   @Id_Categoria int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id_Servicio
	FROM 
	servicios_nuevos
	WHERE 
	Id_Categoria = @Id_Categoria
END
GO
/****** Object:  StoredProcedure [dbo].[GetStatesCodes]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<OC>
-- Create date: <15062016>
-- Description:	<FEDEXSTATECODES>
-- =============================================
CREATE PROCEDURE [dbo].[GetStatesCodes]
@Id_Country varchar(50) = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [State_Desc], [State_Code] FROM Country_States_Code WHERE [Id_Country] = @Id_Country
	--SELECT distinct Estado as [State_Desc], Estado [State_Code] FROM TblCodigosPostalesMxLatLog WHERE Pais = @Id_Country

	END
GO
/****** Object:  StoredProcedure [dbo].[GetSubtipoProduccion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date:12052016
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[GetSubtipoProduccion]
	@Id_SubTipo int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id FROM Productos_En_Produccion WHERE Id_SubTipo = @Id_SubTipo
END
GO
/****** Object:  StoredProcedure [dbo].[GetSubtipoProducto]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date: 12052016
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSubtipoProducto]
@Id_Tipo_Producto int = 0,
@id_Idioma int = 1
AS
BEGIN
	SET NOCOUNT ON;
	--SELECT 
	--Id_Categoria,
	--Categoria,
	--Id_Tipo_Producto,
	--Id_SubTipo_Producto,
	--SubTipo_Producto,
	--Tipo_Producto
	--FROM 
	--subtipo_productos 
	--WHERE 
	--Id_Tipo_Producto = @Id_Tipo_Producto
	--AND Estatus_SuTipo_Producto = 1
	SELECT 
	Id_Categoria,
	Id_Tipo_Producto,
	Id_SubTipo_Producto,
	tblidioma.IdiomaDescripcion as Categoria,
	tblidiomaTipo.IdiomaDescripcion as Tipo_Producto,
	tblidiomaSubtipo.IdiomaDescripcion as SubTipo_Producto
	FROM 
	subtipo_productos 

	inner join (select id_Tbl,Tabla,IdiomaDescripcion from TblIdioma 
	            inner join Idioma on Idioma.id_Idioma = TblIdioma.id_Idioma 
				where Tabla = 'TipoProducto_Active' and Idioma.id_Idioma = @id_Idioma) tblidiomaTipo  on tblidiomaTipo.id_Tbl = subtipo_productos.Id_Tipo_Producto
    inner join (select id_Tbl,Tabla,IdiomaDescripcion from TblIdioma 
	            inner join Idioma on Idioma.id_Idioma = TblIdioma.id_Idioma 
				where Tabla = 'Categoria_Active' and Idioma.id_Idioma = @id_Idioma) tblidioma  on tblidioma.id_Tbl = subtipo_productos.Id_Categoria
	inner join (select id_Tbl,Tabla,IdiomaDescripcion from TblIdioma 
	            inner join Idioma on Idioma.id_Idioma = TblIdioma.id_Idioma 
				where Tabla = 'SubTipo_Productos' and Idioma.id_Idioma = @id_Idioma) tblidiomaSubtipo  on tblidiomaSubtipo.id_Tbl = subtipo_productos.Id_SubTipo_Producto
	WHERE 
	Id_Tipo_Producto = @Id_Tipo_Producto
	AND Estatus_SuTipo_Producto = 1
END



GO
/****** Object:  StoredProcedure [dbo].[GetTipoProduccion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date:12052016
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetTipoProduccion]
@Id_Tipo int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id FROM Productos_En_Produccion WHERE Id_Tipo= @Id_Tipo
END
GO
/****** Object:  StoredProcedure [dbo].[GetTipoProducto]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:OC
-- Create date: 12052016
-- Description:	GetTipoProducto
-- =============================================
CREATE PROCEDURE [dbo].[GetTipoProducto]
@Id_Categoria int = 0,
@id_Idioma int = 1
AS
BEGIN
	SET NOCOUNT ON;
	--SELECT DISTINCT
	--		TipoProducto_Active.Id_Categoria,
	--		categoria_active.Categoria,
	--		TipoProducto_Active.Id_Tipo_Producto,
	--		TipoProducto_Active.Tipo_Producto 
	--FROM 
	--TipoProducto_Active
	--INNER JOIN SubTipo_Productos ON SubTipo_Productos.Id_Tipo_Producto = TipoProducto_Active.Id_Tipo_Producto AND SubTipo_Productos.Estatus_SuTipo_Producto = 1
	--INNER JOIN categoria_active ON categoria_active.Id_Categoria = TipoProducto_Active.Id_Categoria
	--WHERE
	--		TipoProducto_Active.Active = 1 AND
	--		TipoProducto_Active.Id_Categoria = @Id_Categoria
	--END

		SELECT DISTINCT
			TipoProducto_Active.Id_Categoria,
			TipoProducto_Active.Id_Tipo_Producto,
			tblidiomaTipo.IdiomaDescripcion as Tipo_Producto,
			tblidioma.IdiomaDescripcion as Categoria
	FROM 
	TipoProducto_Active
	INNER JOIN SubTipo_Productos ON SubTipo_Productos.Id_Tipo_Producto = TipoProducto_Active.Id_Tipo_Producto AND SubTipo_Productos.Estatus_SuTipo_Producto = 1
	INNER JOIN categoria_active ON categoria_active.Id_Categoria = TipoProducto_Active.Id_Categoria
	inner join (select id_Tbl,Tabla,IdiomaDescripcion from TblIdioma 
	            inner join Idioma on Idioma.id_Idioma = TblIdioma.id_Idioma 
				where Tabla = 'TipoProducto_Active' and Idioma.id_Idioma = @id_Idioma) tblidiomaTipo  on tblidiomaTipo.id_Tbl = TipoProducto_Active.Id_Tipo_Producto
    inner join (select id_Tbl,Tabla,IdiomaDescripcion from TblIdioma 
	            inner join Idioma on Idioma.id_Idioma = TblIdioma.id_Idioma 
				where Tabla = 'Categoria_Active' and Idioma.id_Idioma = @id_Idioma) tblidioma  on tblidioma.id_Tbl = categoria_active.Id_Categoria
	WHERE
			TipoProducto_Active.Active = 1 AND
			TipoProducto_Active.Id_Categoria = @Id_Categoria

			END

GO
/****** Object:  StoredProcedure [dbo].[Insert_User]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_User]
	@Email NVARCHAR(50),
	@Password NVARCHAR(50),
	@Nombre NVARCHAR(50),
	@Apellidos NVARCHAR(50),
	@Estatus_U int
	
AS
SET NOCOUNT ON;
	IF EXISTS(SELECT Id_Usuario FROM Usuarios_Clientes WHERE Email = @Email)
		BEGIN
			SELECT -2 -- Email exists.
		END
			ELSE
				BEGIN
					INSERT INTO [Usuarios_Clientes]
                     ([Nombre]
                     ,[Apellidos]
                     ,[Email]
                     ,[Password]
					 ,[Estatus_U]
					 ,[Fecha_Creacion])

            VALUES
                     (@Nombre
                     ,@Apellidos
                     ,@Email
					 ,@Password
					 ,@Estatus_U
                     ,GETDATE())
            
            SELECT SCOPE_IDENTITY() -- UserId                  
     END
GO
/****** Object:  StoredProcedure [dbo].[Link_Valida_Clientes]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Link_Valida_Clientes]
      @Email varchar(100),
      @Password varchar(100)
AS
BEGIN
      SET NOCOUNT ON;
      DECLARE @Id_Cliente INT, @LastLoginDate datetime

	  SELECT @Id_Cliente = Id_Cliente, @LastLoginDate = LastLoginDate
      FROM Clientes WHERE Email = @Email AND [PasswordNvo] = @Password

	  --si existe usuario con la contraseña nueva se cambia password 
	   IF @Id_Cliente IS NOT NULL
	    BEGIN
		update Clientes set Password = @Password where Id_Cliente = @Id_Cliente
	    END
		 --si no existe usuario con la contraseña nueva se consulta la otra contraseña vieja
	  IF @Id_Cliente IS NULL
      BEGIN
     
      SELECT @Id_Cliente = Id_Cliente, @LastLoginDate = LastLoginDate
      FROM Clientes WHERE Email = @Email AND [Password] = @Password
		 
	  END



     
      IF @Id_Cliente IS NOT NULL
      BEGIN
            IF NOT EXISTS(SELECT Id_Cliente FROM Clientes_Activacion WHERE Id_Cliente = @Id_Cliente)
            BEGIN
                  UPDATE Clientes
                  SET LastLoginDate = GETDATE()
                  WHERE Id_Cliente = @Id_Cliente
                  SELECT @Id_Cliente [Id_Cliente] -- User Valid
            END
            ELSE
            BEGIN
                  SELECT -2 -- User not activated.
            END
      END
      ELSE
      BEGIN
            SELECT -1 -- User invalid.
      END
END



GO
/****** Object:  StoredProcedure [dbo].[Link_Valida_ClientesNvaContraseña]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Link_Valida_ClientesNvaContraseña]
      @Email varchar(100),
      @Password varchar(100),
	  @Telefono nvarchar(50)
AS
BEGIN
      SET NOCOUNT ON;
      DECLARE @Id_Cliente INT, @LastLoginDate datetime
    
      SELECT @Id_Cliente = Id_Cliente, @LastLoginDate = LastLoginDate
      FROM Clientes WHERE Email = @Email AND Tel_Celular = @Telefono

     
      IF @Id_Cliente IS NOT NULL
      BEGIN
            IF NOT EXISTS(SELECT Id_Cliente FROM Clientes_Activacion WHERE Id_Cliente = @Id_Cliente)
            BEGIN
                  UPDATE Clientes
                  SET LastLoginDate = GETDATE(), PasswordNvo = @Password
                  WHERE Id_Cliente = @Id_Cliente
                  SELECT -4 -- User Valid
            END
            ELSE
            BEGIN
                  SELECT -2 -- User not activated.
            END
      END
      ELSE
      BEGIN
            SELECT -1 -- User invalid.
      END
END



GO
/****** Object:  StoredProcedure [dbo].[Link_Valida_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Link_Valida_Proveedores]
      @Correo nvarchar(50),
      @Password nvarchar(50)
AS
BEGIN
SET NOCOUNT ON;
      DECLARE @Id_Proveedor INT, @LastLoginDate datetime, @Id_ConfirmadoLink int, @Id_CorreoExist int
     

	 SELECT @Id_Proveedor = Id_Proveedor, @LastLoginDate = LastLoginDate,  @Id_ConfirmadoLink = ProveedorNvo , @Id_CorreoExist = ValidarCuenta
      FROM Proveedores WHERE Correo = @Correo AND [PasswordNvo] = @Password

	  --si existe usuario con la contraseña nueva se cambia password 
	   IF @Id_Proveedor IS NOT NULL
	    BEGIN
		update Proveedores set Password = @Password where Id_Proveedor = @Id_Proveedor
	    END
		 --si no existe usuario con la contraseña nueva se consulta la otra contraseña vieja
	  IF @Id_Proveedor IS NULL
      BEGIN
		  SELECT @Id_Proveedor = Id_Proveedor, @LastLoginDate = LastLoginDate,  @Id_ConfirmadoLink = ProveedorNvo , @Id_CorreoExist = ValidarCuenta
		  FROM Proveedores WHERE Correo = @Correo AND [Password] = @Password
		 
	  END

      IF @Id_Proveedor IS NOT NULL
      BEGIN
	   IF(@Id_CorreoExist IS NOT NULL)
	   BEGIN
					--IF NOT EXISTS(SELECT Id_Proveedor FROM Proveedores_Activacion WHERE Id_Proveedor = @Id_Proveedor)
					IF(@Id_ConfirmadoLink IS NOT NULL)
					BEGIN
						  UPDATE Proveedores
						  SET LastLoginDate = GETDATE()
						  WHERE Id_Proveedor = @Id_Proveedor
						  SELECT @Id_Proveedor [Id_Proveedor] -- User Valid
					END
					ELSE
					BEGIN
						  SELECT -2 -- Por autorizar Link
					END
		END
		ELSE
			BEGIN
			   --     UPDATE Proveedores SET ValidarCuenta = 1
					 --WHERE Id_Proveedor = @Id_Proveedor
						  SELECT -3 -- User not activated.
		     END
      END
      ELSE
      BEGIN
            SELECT -1 -- User invalid.
      END
END

GO
/****** Object:  StoredProcedure [dbo].[Link_Valida_ProveedoresACT]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Link_Valida_ProveedoresACT]
      @Correo nvarchar(50),
      @Password nvarchar(50),
	   @medio nvarchar(50)
AS
BEGIN
SET NOCOUNT ON;
      DECLARE @Id_Proveedor INT, @LastLoginDate datetime, @Id_ConfirmadoLink int, @Id_CorreoExist int
     
      SELECT @Id_Proveedor = Id_Proveedor, @LastLoginDate = LastLoginDate,  @Id_ConfirmadoLink = ProveedorNvo , @Id_CorreoExist = ValidarCuenta
      FROM Proveedores WHERE Correo = @Correo AND [Password] = @Password


      IF @Id_Proveedor IS NOT NULL
      BEGIN
	   IF(@Id_CorreoExist IS NOT NULL)
	   BEGIN
					--IF NOT EXISTS(SELECT Id_Proveedor FROM Proveedores_Activacion WHERE Id_Proveedor = @Id_Proveedor)
					IF(@Id_ConfirmadoLink IS NOT NULL)
					BEGIN
						  UPDATE Proveedores
						  SET LastLoginDate = GETDATE()
						  WHERE Id_Proveedor = @Id_Proveedor
						  SELECT @Id_Proveedor [Id_Proveedor] -- User Valid
					END
					ELSE
					BEGIN
						  SELECT -2 -- Por autorizar Link
					END
		END
		ELSE
			BEGIN
			        UPDATE Proveedores SET ValidarCuenta = 1, Fecha_Act =  GETDATE(), MedioAct = @medio
					 WHERE Id_Proveedor = @Id_Proveedor
						  SELECT -3 -- User not activated.
		     END
      END
      ELSE
      BEGIN
            SELECT -1 -- User invalid.
      END
END
GO
/****** Object:  StoredProcedure [dbo].[Link_Valida_ProveedoresNvaContraseña]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Link_Valida_ProveedoresNvaContraseña]
      @Correo nvarchar(50),
	  @Telefono nvarchar(50),
	  @contraseña nvarchar(50)
AS
BEGIN
SET NOCOUNT ON;
      DECLARE @Id_Proveedor INT, @LastLoginDate datetime, @Id_ConfirmadoLink int, @Id_CorreoExist int
     
      SELECT @Id_Proveedor = Id_Proveedor, @LastLoginDate = LastLoginDate,  @Id_ConfirmadoLink = ProveedorNvo , @Id_CorreoExist = ValidarCuenta
      FROM Proveedores WHERE Correo = @Correo AND Telefono = @Telefono


      IF @Id_Proveedor IS NOT NULL
      BEGIN
	   IF(@Id_CorreoExist IS NOT NULL)
	   BEGIN
					--IF NOT EXISTS(SELECT Id_Proveedor FROM Proveedores_Activacion WHERE Id_Proveedor = @Id_Proveedor)
					IF(@Id_ConfirmadoLink IS NOT NULL)
					BEGIN
						  UPDATE Proveedores
						  SET LastLoginDate = GETDATE(), PasswordNvo = @contraseña
						  WHERE Id_Proveedor = @Id_Proveedor
						  SELECT -4 -- User Valid
					END
					ELSE
					BEGIN
						  SELECT -2 -- Por autorizar Link
					END
		END
		ELSE
			BEGIN
			   --     UPDATE Proveedores SET ValidarCuenta = 1
					 --WHERE Id_Proveedor = @Id_Proveedor
						  SELECT -3 -- User not activated.
		     END
      END
      ELSE
      BEGIN
            SELECT -1 -- User invalid.
      END
END



GO
/****** Object:  StoredProcedure [dbo].[Login_Check_Admin_SP]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Login_Check_Admin_SP] 
                @username varchar(50),
                @pwd    varchar(50)
AS
BEGIN
                select * from Usuarios
                where [Email] COLLATE Latin1_general_CS_AS=@username 
                and [Contrasena] COLLATE Latin1_general_CS_AS=@pwd
END
GO
/****** Object:  StoredProcedure [dbo].[Login_Check_Sp]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Login_Check_Sp] 

@username varchar(50),
@pwd varchar(50)

AS
	BEGIN
		select * from [Users]
		where [Email] COLLATE Latin1_general_CS_AS=@username 
		and [Password] COLLATE Latin1_general_CS_AS=@pwd
	END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerProveedorSucursal]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerProveedorSucursal]
@Id_pvd INT 
AS
BEGIN


SELECT [Id]
      ,[Sucursal]
      ,[Latitud]
      ,[Longuitud]
      ,[Descripcion]
      ,[Fecha]
      ,[Estatus]
      ,[Id_Proveedor]
      ,[Nombre_Sucursal]
  FROM [dbo].[Proveedores_Sucursales]
  WHERE Id_Proveedor = @Id_pvd
  UNION 
  SELECT Id_Proveedor AS Id, Direccion AS Sucursal, Latitud, Longitud,'' AS Descripcion, Fecha_Alta AS Fecha, Estatus_Proveedor As Estatus, Id_Proveedor, Nombre_Proveedor AS Nombre_Sucursal  FROM PROVEEDORES
  WHERE Id_Proveedor = @Id_pvd
END
GO
/****** Object:  StoredProcedure [dbo].[ProveedoresCheck]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProveedoresCheck]
@tipoarg varchar(50) = NULL,
@valoor varchar(50) = NULL
AS
	SET NOCOUNT ON;

	IF @tipoarg = 'email'
       SELECT Id_Proveedor,Nombre_Proveedor,Correo FROM Proveedores WHERE Correo = @valoor
ELSE 
       SELECT Id_Proveedor,Nombre_Proveedor,Correo FROM Proveedores WHERE Nombre_Proveedor like @valoor

GO
/****** Object:  StoredProcedure [dbo].[Registrar_Clientes]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Registrar_Clientes]
	-- Add the parameters for the stored procedure here
	@Nombre VARCHAR(100),
	@Apellidos VARCHAR(100), 
	@Email VARCHAR(100),
	@Password VARCHAR(100),
	@sexo VARCHAR(100) = NULL, 
	@Fecha_Nacimiento DATETIME,
	@Recibir_Notificaciones INT,
        @Perfil VARCHAR(100),
        @Id_Perfil Int   ,
		@Celular VARCHAR(100)
AS
BEGIN
SET NOCOUNT ON;
	IF EXISTS(SELECT Id_Cliente FROM Clientes WHERE Email = @Email)
		BEGIN
			SELECT -1 -- Username exists.
		END
	ELSE
		BEGIN
			INSERT INTO [Clientes]
						(
							[Nombre],
							[Apellidos],
							[Email],
							[Password],
							[Tel_Celular],
							[Tel_Casa],
							[Fecha_Nacimiento],
							[Estatus],
							[Fecha_Registro],
							[Recibir_Notificaciones],
                            [Perfil],
                            [Id_Perfil],
							[sexo]
						)VALUES
						(
                             @Nombre,
		                     @Apellidos,
						     @Email,
						     @Password,
						     @Celular,
							  @Celular,
					         @Fecha_Nacimiento,
						     1,
					             GETDATE(),
						     @Recibir_Notificaciones,
                             @Perfil,
                             @Id_Perfil,
							 'S/G'
						)
           
            SELECT SCOPE_IDENTITY() -- UserId                 
     END
END
GO
/****** Object:  StoredProcedure [dbo].[Registrar_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Registrar_Proveedores]
	-- Add the parameters for the stored procedure here
	
	@Nombre_Proveedor NVARCHAR(50),
	@Correo NVARCHAR(50), 
	@Direccion NVARCHAR(50),
	@Ciudad NVARCHAR(50),
	@Estado NVARCHAR(50), 
	@Pais NVARCHAR(50),
	@Tipo_Proveedor NVARCHAR(50),	
	@Password NVARCHAR(50),
	@FilePath NVARCHAR(MAX),
	@Id_Categoria INT,
	@Recomendado NVARCHAR(100),
	@celular VARCHAR(100),
	@Webstatus varchar(10) = 'Pendiente',
	@uuidEmail NVARCHAR(100),
	@uuidCelular NVARCHAR(100)
	
AS
BEGIN
SET NOCOUNT ON;
	SET NOCOUNT ON;
	IF EXISTS(SELECT Id_Proveedor FROM Proveedores WHERE Correo = @Correo and Telefono =@celular )
	BEGIN
		SELECT -1 -- Username exists.
	END
	ELSE
	BEGIN
		INSERT INTO [Proveedores]
						(
							[Nombre_Proveedor],
							[Correo],
							[Direccion],
							[Ciudad],
							[Estado],
							[Pais],
							[Tipo_Proveedor],
							[Fecha_Alta],
							[Password],
							[FilePath],
							[Id_Categoria],
							[Recomendado],
							[WebStatus],
							[Telefono],
							Premium,
							uuidEmail,
							uuidCelular
						)VALUES
						(
							@Nombre_Proveedor,
							@Correo, 
							@Direccion,
							@Ciudad,
							@Estado, 
							@Pais,
							@Tipo_Proveedor,
							GETDATE(),
							@Password,
							@FilePath,
							@Id_Categoria,
							@Recomendado,
							@Webstatus,
							@celular,
							1,
							@uuidEmail,
							@uuidCelular
						)


						update ChatsProspectos set ValRef = SCOPE_IDENTITY()
						where CorreoReq = @Correo AND RIGHT(FromNum, 10) =  @celular

           
            SELECT SCOPE_IDENTITY() -- UserId                 
     END
END
GO
/****** Object:  StoredProcedure [dbo].[RegistrarCompra]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RegistrarCompra]
	
	@Id_Venta as int=0 Output
	,@valorsesion as nvarchar(max) =''
	,@Nombre as nvarchar(50)
	,@Precio as int
	,@Cantidad as int
	,@Accion as nchar(20)=''
	,@Total as int
	

as
begin
IF @Accion='RegistrarCompra'
	BEGIN
		INSERT INTO dbo.Ventas(Id_Sesion,Nombre,Precio,Cantidad,Total) 
		VALUES(@valorsesion,@Nombre,@Precio,@Cantidad,@Total)
		
		Select @Id_Venta = @@IDENTITY
		end
end
GO
/****** Object:  StoredProcedure [dbo].[Sp_ActualizaStatusPedido]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ActualizaStatusPedido]
@id varchar(max) = null
AS
BEGIN
  IF(NOT EXISTS(SELECT * FROM PedidosNuevo WHERE IDPAGO = @id AND status = 'approved'))
  BEGIN

     update PedidosNuevo set status = 'approved' where IDPAGO = @id

	 update PedidosNuevo set FormaDePago = 'MP' where IDPAGO = @id AND FormaDePago = 'MP|PENDIENTE'

     select TOP 1 uuID from PedidosNuevo where IDPAGO = @id
  END
  ELSE
  BEGIN
   SELECT 1 uuID
  END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Admin]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Admin]
		
	@Accion2 as nchar(20)=''
	,@ID_Usuario as int=0 Output
	,@Nombre as nvarchar(50)=''
	,@Email as nvarchar(50)=''
	,@Usuario2 as nvarchar(50)=''
	,@Contrasena2 as nvarchar(50)=''
	,@Estatus_U as int=0
	
AS
BEGIN

If @Accion2='Buscar_Admin'
		Begin
			Select ID_Usuarios,Usuario,Contrasena,Nombre,Email,Estatus_U
			from Usuarios
			where Email=@Usuario2 AND Contrasena=@Contrasena2 
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Bind]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery2.sql|0|0|C:\Users\orlando\AppData\Local\Temp\~vsCA40.sql
CREATE PROCEDURE [dbo].[SP_Bind]
      @IdSesion varchar(max)
AS
BEGIN
      SET NOCOUNT ON;
      SELECT Id_Venta,Id_Sesion,Nombre,Precio,Cantidad
      FROM Ventas WHERE Id_Sesion = @IdSesion
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Categorias_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Categorias_Productos]
	@Categoria			   NVARCHAR(100),
	@Descripcion_Categoria    NVARCHAR(100),
        @Estatus_Categoria          INT,
        @Accion                             NVARCHAR(20)=''

	AS
           BEGIN
              IF @Accion='REGISTRA' 
	         INSERT INTO Categorias_Productos( Categoria,Descripcion_Categoria,Usuario_Alta,Fecha_Alta,Estatus_Categoria )VALUES( @Categoria,@Descripcion_Categoria,'Admin',GETDATE(),@Estatus_Categoria)
	      END
GO
/****** Object:  StoredProcedure [dbo].[SP_Direcciones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_Direcciones]
		
	 @Accion as nvarchar(20)=''
	,@Id_Cliente as int=0 
	,@Calle as nvarchar(50)=''
	,@Numero as nvarchar(50)=''
	,@Colonia as nvarchar(50)=''
	,@Ciudad as nvarchar(50)=''
	,@Estado as nvarchar(50)=''
	,@Pais as nvarchar(50)='Mexico'
	,@Codigo_Postal as nvarchar(50)=''
	,@Referencia as nvarchar(MAX)=''
	,@check as int= NULL
	,@ClientesDirecciones AS INT = NULL
	,@Latitud numeric(18,6) = NULL,
	 @Longitud numeric(18,6) = NULL
	
AS
BEGIN

--declare  @Accion as nvarchar(20)='ALTAS'
--	,@ID_Usuario as int=0
--	,@Id_Cliente as int=2
--	,@Calle as nvarchar(50)='palermo'
--	,@Numero as nvarchar(50)='421'
--	,@Colonia as nvarchar(50)='rincon de las mitras'
--	,@Ciudad as nvarchar(50)='santa catrina'
--	,@Estado as nvarchar(50)='nuevo leon'
--	,@Pais as nvarchar(50)='Mexico'
--	,@Codigo_Postal as nvarchar(50)='66139'
--	,@Referencia as nvarchar(MAX)='xxx'
--	,@check as int= 1
--	,@ClientesDirecciones AS INT = 0

		IF @Accion='ALTAS'
		BEGIN

		IF(@check = 1)
		BEGIN
		   UPDATE ClientesDirecciones SET Predeterminada = 0
		   WHERE Id_Cliente = @Id_Cliente
		END
		IF(ISNULL(@ClientesDirecciones,0) = 0)
		BEGIN
			INSERT INTO ClientesDirecciones
			([Id_Cliente],
				[Calle],
				[Numero],
				[Colonia],
				[Ciudad],
				[Estado],
				[Pais],
				[Codigo_Postal],
				[Referencia],
				[Predeterminada],
				[Fecha_Registro],
				Latitud,
				Longitud)
			Values
			(@Id_Cliente
			,@Calle
			,@Numero
			,@Colonia
			,@Ciudad
			,@Estado
			,@Pais
			,@Codigo_Postal
			,@Referencia
			,@check
			,GETDATE()
			,@Latitud
			,@Longitud)

			SELECT @ClientesDirecciones = SCOPE_IDENTITY()
			END
			ELSE
			   UPDATE ClientesDirecciones SET 	[Calle]= @Calle,
												[Numero]= @Numero,
												[Colonia]= @Colonia,
												[Ciudad]= @Ciudad,
												[Estado]=@Estado,
												[Pais]=@Pais,
												[Codigo_Postal]=@Codigo_Postal,
												[Referencia]=@Referencia,
												[Predeterminada]=@check,
												[Ultima_Actualizacion] = GETDATE(),
												Latitud = @Latitud,
												Longitud = @Longitud
						WHERE ClientesDirecciones = @ClientesDirecciones
			IF(NOT EXISTS(SELECT 1 FROM ClientesDirecciones WHERE Id_Cliente = @Id_Cliente AND Predeterminada = 1))
			BEGIN
			   UPDATE ClientesDirecciones SET Predeterminada = 1
		       WHERE ClientesDirecciones = @ClientesDirecciones
			END
		END
				
		IF @Accion='BAJA'
		BEGIN	
			UPDATE ClientesDirecciones
			SET
			     Fecha_Baja=getdate()				
			WHERE
				 ClientesDirecciones = @ClientesDirecciones
		END
		
		IF @Accion='SELECCIONA'
		BEGIN
			SELECT
					[ClientesDirecciones],
					[Id_Cliente],
					[Calle],
					[Numero],
					[Colonia],
					[Ciudad],
					[Estado],
					[Pais],
					[Codigo_Postal],
					[Referencia],
					ISNULL([Predeterminada],0) AS Predeterminada,
					[Fecha_Registro],
					[Ultima_Actualizacion]
							FROM ClientesDirecciones
							WHERE ClientesDirecciones = @ClientesDirecciones
			
		END

	IF @Accion='LISTA'
		BEGIN
			SELECT
			[ClientesDirecciones],
	[Id_Cliente],
	[Calle],
	[Numero],
	[Colonia],
	[Ciudad],
	[Estado],
	[Pais],
	[Codigo_Postal],
	[Referencia],
	[Predeterminada] = CASE WHEN  (ISNULL(Predeterminada,0)=0) THEN 'NO' ELSE 'SI' END,
	[Fecha_Registro],
	[Ultima_Actualizacion]
			FROM ClientesDirecciones
			WHERE Id_Cliente = @Id_Cliente
			AND Fecha_Baja IS NULL
			
		END
		IF @Accion='Predeterminada'
		BEGIN
			SELECT
			[ClientesDirecciones],
				[Id_Cliente],
				[Calle],
				[Numero],
				[Colonia],
				[Ciudad],
				[Estado],
				[Pais],
				[Codigo_Postal],
				[Referencia],
				[Predeterminada],
				[Fecha_Registro],
				[Ultima_Actualizacion]
				,cc.Id_Country
				,cc.State_Code
				,ISNULL(Latitud,0) as Latitud,
				ISNULL(Longitud,0) as Longitud
			FROM ClientesDirecciones cv
			INNER JOIN Country_States_Code cc ON cv.estado = cc.state_desc
			WHERE Id_Cliente = @Id_Cliente
			AND Fecha_Baja IS NULL
			AND Predeterminada = 1



			
		END


		IF @Accion='Predeterminada2'
		BEGIN

		DECLARE @base int = 0;
			IF(EXISTS(SELECT * FROM Clientes WHERE (Direccion IS NULL OR Colonia IS NULL OR Ciudad IS NULL OR Estado IS NULL OR
			Pais IS NULL OR Codigo_Postal IS NULL) AND Id_Cliente = @Id_Cliente))
			BEGIN
			  SELECT @base = 1
			END

			SELECT @base AS VALIDA


			
		END
						
		

END


GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar_Img_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Eliminar_Img_Productos]

	@Accion as nchar(20)=''
	,@Id_Imagen as int = 0


as
IF @Accion='BAJA'
		BEGIN	
			delete from Rutas_Productos
			WHERE
				Id_Imagen=@Id_Imagen
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar_Img_Promociones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Eliminar_Img_Promociones]

	@Accion as nchar(20)=''
	,@Id_Imagen as int = 0


as
IF @Accion='BAJA'
		BEGIN	
			delete from Rutas_Promociones
			WHERE
				Id_Imagen=@Id_Imagen
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar_Img_Propiedades]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Eliminar_Img_Propiedades]
	@Accion as nchar(20)=''
	,@Id_Imagen as int = 0


as
IF @Accion='BAJA'
		BEGIN	
			delete from Rutas_Propiedades
			WHERE
				Id_Imagen=@Id_Imagen
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar_Img_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Eliminar_Img_Proveedores]
	@Accion as nchar(20)=''
	,@Id_Imagen as int = 0


as
IF @Accion='BAJA'
		BEGIN	
			delete from Rutas_Proveedores
			WHERE
				Id_Imagen=@Id_Imagen
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_Eliminar_Img_Servicios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Eliminar_Img_Servicios]
	@Accion as nchar(20)=''
	,@Id_Imagen as int = 0


as
IF @Accion='BAJA'
		BEGIN	
			delete from Rutas_Servicios
			WHERE
				Id_Imagen=@Id_Imagen
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_ELiminarItemsCanasta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_ELiminarItemsCanasta]
	@Accion as nchar(20)=''
	,@Id_Venta as int = 0


as
IF @Accion='BAJA'
		BEGIN	
			delete from Ventas
			WHERE
				Id_Venta=@Id_Venta
		END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Inserta_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Inserta_Productos]
              
              @Nombre_Producto NVARCHAR(50),
              @Categoria NVARCHAR(50),
              @Tipo_Producto NVARCHAR(50),
              @SubTipo_Producto NVARCHAR(50),
              @Clave_Producto NVARCHAR(50),
              @Precio_Producto INT,
              @Marca NVARCHAR(50),
              @Nombre_Proveedor NVARCHAR(50),
              @Descripcion NVARCHAR(MAX),
              @Estatus_Producto INT,
              @Id_Categoria INT,
              @Id_Tipo_Producto INT,
              @Id_SubTipo_Producto INT,
              @Nombre_Imagen NVARCHAR(100),
              @Ruta_Imagen NVARCHAR(MAX)
AS
BEGIN 
                SET NOCOUNT ON;      
                INSERT INTO Productos(
                                                         Nombre_Producto,
                                                         Categoria,
                                                         Tipo_Producto,
                                                         SubTipo_Producto,
                                                         Clave_Producto,
                                                         Precio_Producto,
                                                         Marca,
                                                         Nombre_Proveedor,
                                                         Descripcion,
                                                         Usuario_Alta,
                                                         Fecha_Alta,
                                                         Estatus_Producto,
                                                         Nombre_Imagen,
                                                         Ruta_Imagen,
                                                         Id_Categoria,
                                                         Id_Tipo_Producto,
                                                         Id_SubTipo_Producto)
                                                         VALUES (
                                                                         @Nombre_Producto,
                                                                         @Categoria,
                                                                         @Tipo_Producto,
                                                                         @SubTipo_Producto,
                                                                         @Clave_Producto,
                                                                         @Precio_Producto,
                                                                         @Marca,
                                                                         @Nombre_Proveedor,
                                                                         @Descripcion,
                                                                         'Admin',
                                                                         GETDATE(),
                                                                         @Estatus_Producto,
                                                                         @Nombre_Imagen,
                                                                         @Ruta_Imagen,
                                                                         @Id_Categoria,
                                                                         @Id_Tipo_Producto,
                                                                         @Id_SubTipo_Producto)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertConfigCanasta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_InsertConfigCanasta]
		

	@Id_Cliente as int=0
	,@TypeConfigCanasta TBLcanasta READONLY
	
AS
BEGIN
 	IF OBJECT_ID('tempdb..#tblTypeConfigCanasta') IS NOT NULL
		DROP TABLE #tblTypeConfigCanasta

  CREATE TABLE #tblTypeConfigCanasta
					(  Id_Proveedor INT,
					   id INT,
					   Carrier VARCHAR(MAX),
					   Service VARCHAR(MAX),
					   CostoEnvio decimal(12,2),
					   enviodomicilio VARCHAR(MAX),
					   NumeroPaquete VARCHAR(MAX),
					   uuID VARCHAR(MAX)
					);  
					INSERT INTO #tblTypeConfigCanasta 
				SELECT  Id_Proveedor,
						   id,
						   Carrier,
						   Service,
						   CostoEnvio,
						   enviodomicilio ,
						   NumeroPaquete ,
						   uuID
			   FROM @TypeConfigCanasta;




			   MERGE canasta AS c
					USING #tblTypeConfigCanasta AS tc
					ON (c.uuID COLLATE SQL_Latin1_General_CP1_CI_AS = tc.uuID COLLATE SQL_Latin1_General_CP1_CI_AS 
					AND c.NumeroPaquete COLLATE SQL_Latin1_General_CP1_CI_AS = tc.NumeroPaquete COLLATE SQL_Latin1_General_CP1_CI_AS)
					WHEN MATCHED THEN
					UPDATE SET c.entregaDomicilio = tc.enviodomicilio,
					           c.Paqueteria = tc.Carrier,
							   c.servicio = tc.Service,
							   c.CostoEnvio = tc.CostoEnvio;
					

END


GO
/****** Object:  StoredProcedure [dbo].[SP_InsertDistribucionCanasta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_InsertDistribucionCanasta]
	@Id_Cliente as int=0
	,@tblPaqueteCanasta TypePaqueteCanasta READONLY
	,@uuID as VARCHAR(MAX)=0
	
AS
BEGIN
 	IF OBJECT_ID('tempdb..#tblTypeConfigCanasta') IS NOT NULL
		DROP TABLE #tblTypeConfigCanasta

  CREATE TABLE #tblTypeConfigCanasta
					(  [uuID] [varchar](max)  NULL,
						[NumeroPaquete] [varchar](max)  NULL,
						[Id_Producto] [int]  NULL,
						[Cantidad] [int]  NULL,
						[Peso] decimal(16,2) NULL,
						[Valida] [nvarchar](max) NULL,
						[Id_Proveedor] [int] NOT NULL,
						[id] [int] NOT NULL,
						[origen] [varchar](max) NOT NULL,
						[TipoEnvio] [int] NOT NULL
					);  
					INSERT INTO #tblTypeConfigCanasta 
				SELECT  [uuID],
						[NumeroPaquete],
						[Id_Producto],
						[Cantidad],
						[Peso],
						[Valida],
						[Id_Proveedor],
						[id],
						[origen],
						[TipoEnvio]
			   FROM @tblPaqueteCanasta
			   order by Id_Proveedor , id, Id_Producto


			   DELETE PaqueteCanasta WHERE Id_Cliente = @Id_Cliente

			   INSERT  INTO PaqueteCanasta ([uuID] ,
											[NumeroPaquete],
											[Id_Producto],
											[Cantidad],
											[Peso],
											[Id_Proveedor],
											[idOrigen],
											[origen],
											[Fecha],
											[Id_Cliente],
											tipoEnvio
											)
											SELECT [uuID] ,
											[NumeroPaquete],
											[Id_Producto],
											[Cantidad] = SUM([Cantidad]),
											[Peso],
											[Id_Proveedor],
											[id],
											[origen],
											GETDATE(),
											@Id_Cliente,
											TipoEnvio
											FROM #tblTypeConfigCanasta
											GROUP BY  [uuID] ,[NumeroPaquete],[Id_Producto],
											[Peso],[Id_Proveedor],[id],[origen],TipoEnvio
											order by Id_Proveedor , id, Id_Producto

											select PaqueteCanasta.NumeroPaquete,
												   PaqueteCanasta.Id_Proveedor,
												   PaqueteCanasta.idOrigen,
												   MIN([origen]) as origen,
												   Id_Cliente,
												   Proveedores_Sucursales.Latitud, 
												   Proveedores_Sucursales.Longuitud,
												   PaqueteCanasta.tipoEnvio,
												   CASE WHEN MIN(ISNULL(Productos_en_Produccion.RecogerTienda,0)) = 0 THEN 'SinTienda' ELSE '' END AS RecogerTienda
											from PaqueteCanasta
											INNER JOIN Proveedores_Sucursales ON PaqueteCanasta.idOrigen = Proveedores_Sucursales.Id
											INNER JOIN Productos_en_Produccion ON Productos_en_Produccion.Id = PaqueteCanasta.Id_Producto
											WHERE PaqueteCanasta.uuID = @uuID --AND tipoEnvio = 2
											GROUP BY [NumeroPaquete],PaqueteCanasta.Id_Proveedor,PaqueteCanasta.idOrigen,Id_Cliente, Proveedores_Sucursales.Latitud, 
												   Proveedores_Sucursales.Longuitud,PaqueteCanasta.tipoEnvio
											ORDER BY Id_Proveedor , PaqueteCanasta.idOrigen




END


GO
/****** Object:  StoredProcedure [dbo].[SP_InsertDistribucionCanastaFuentedirecta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_InsertDistribucionCanastaFuentedirecta]
	@Id_Cliente as int=0
	,@tblPaqueteCanasta TypePaqueteCanasta READONLY
	,@uuID as VARCHAR(MAX)=0
	
AS
BEGIN
 	IF OBJECT_ID('tempdb..#tblTypeConfigCanasta') IS NOT NULL
		DROP TABLE #tblTypeConfigCanasta

  CREATE TABLE #tblTypeConfigCanasta
					(  [uuID] [varchar](max)  NULL,
						[NumeroPaquete] [varchar](max)  NULL,
						[Id_Producto] [int]  NULL,
						[Cantidad] [int]  NULL,
						[Peso] decimal(16,2) NULL,
						[Valida] [nvarchar](max) NULL,
						[Id_Proveedor] [int] NOT NULL,
						[id] [int] NOT NULL,
						[origen] [varchar](max) NOT NULL,
						[TipoEnvio] [int] NOT NULL
					);  
					INSERT INTO #tblTypeConfigCanasta 
				SELECT  [uuID],
						[NumeroPaquete],
						[Id_Producto],
						[Cantidad],
						[Peso],
						[Valida],
						[Id_Proveedor],
						[id],
						[origen],
						[TipoEnvio]
			   FROM @tblPaqueteCanasta
			   order by Id_Proveedor , id, Id_Producto


			   DELETE PaqueteCanasta WHERE Id_Cliente = @Id_Cliente
			   and tipoenvio = 1

			   INSERT  INTO PaqueteCanasta ([uuID] ,
											[NumeroPaquete],
											[Id_Producto],
											[Cantidad],
											[Peso],
											[Id_Proveedor],
											[idOrigen],
											[origen],
											[Fecha],
											[Id_Cliente],
											tipoEnvio
											)
											SELECT [uuID] ,
											[NumeroPaquete],
											[Id_Producto],
											[Cantidad] = SUM([Cantidad]),
											[Peso],
											[Id_Proveedor],
											[id],
											[origen],
											GETDATE(),
											@Id_Cliente,
											TipoEnvio
											FROM #tblTypeConfigCanasta
											GROUP BY  [uuID] ,[NumeroPaquete],[Id_Producto],
											[Peso],[Id_Proveedor],[id],[origen],TipoEnvio
											order by Id_Proveedor , id, Id_Producto

											select PaqueteCanasta.NumeroPaquete,
												   PaqueteCanasta.Id_Proveedor,
												   PaqueteCanasta.idOrigen,
												   MIN([origen]) as origen,
												   Id_Cliente,
												   Proveedores_Sucursales.Latitud, 
												   Proveedores_Sucursales.Longuitud,
												   PaqueteCanasta.tipoEnvio,
												   CASE WHEN MIN(ISNULL(Productos_en_Produccion.RecogerTienda,0)) = 0 THEN 'SinTienda' ELSE '' END AS RecogerTienda
												   ,sum(Cantidad) as Cantidad
												  ,dbo.ValorTipoPaquete(
														CASE WHEN SUM(((CONVERT(decimal(16,2),Productos_en_Produccion.Weight_)) * (PaqueteCanasta.Cantidad))) > SUM((CONVERT(decimal(16,2),Productos_en_Produccion.Largo) * (CONVERT(decimal(16,2),Productos_en_Produccion.Width) * CONVERT(decimal(16,2),Productos_en_Produccion.Height)*PaqueteCanasta.Cantidad)) /5000) THEN
														SUM(((CONVERT(decimal(16,2),Productos_en_Produccion.Weight_)) * (PaqueteCanasta.Cantidad))) ELSE SUM(((CONVERT(decimal(16,2),Productos_en_Produccion.Largo) * CONVERT(decimal(16,2),Productos_en_Produccion.Width) * CONVERT(decimal(16,2),Productos_en_Produccion.Height)*PaqueteCanasta.Cantidad)) /5000) END )
														AS idTipoPaquete
											from PaqueteCanasta
											INNER JOIN Proveedores_Sucursales ON PaqueteCanasta.idOrigen = Proveedores_Sucursales.Id
											INNER JOIN Productos_en_Produccion ON Productos_en_Produccion.Id = PaqueteCanasta.Id_Producto
											WHERE PaqueteCanasta.uuID = @uuID AND PaqueteCanasta.tipoEnvio = 1
											GROUP BY [NumeroPaquete],PaqueteCanasta.Id_Proveedor,PaqueteCanasta.idOrigen,Id_Cliente, Proveedores_Sucursales.Latitud, 
												   Proveedores_Sucursales.Longuitud,PaqueteCanasta.tipoEnvio
											ORDER BY Id_Proveedor , PaqueteCanasta.idOrigen




END




GO
/****** Object:  StoredProcedure [dbo].[SP_InsertDistribucionConfiguracion]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_InsertDistribucionConfiguracion]
	@tbltablaconfig TypePaqueteConfiguracion READONLY

AS
BEGIN
 	IF OBJECT_ID('tempdb..#tblTypeConfigCanasta') IS NOT NULL
		DROP TABLE #tblTypeConfigCanasta

  CREATE TABLE #tblTypeConfigCanasta
					(   [Id_Proveedor] [int] NULL,
					    [id] [int] NULL,
						[Carrier] [nvarchar](max) NULL,
						[Service] [nvarchar](max) NULL,
						[CostoEnvio] decimal(6,2) NULL,
						[enviodomicilio] [nvarchar](max) NULL,
						[NumeroPaquete] [nvarchar](max) NULL,
					    [uuID] [varchar](max)  NULL
					);  
				INSERT INTO #tblTypeConfigCanasta 
				SELECT  [Id_Proveedor],
					    [id],
						[Carrier],
						[Service],
						[CostoEnvio],
						[enviodomicilio],
						[NumeroPaquete],
					    [uuID]
			   FROM @tbltablaconfig

			   UPDATE PaqueteCanasta SET PaqueteCanasta.entregadomicilio = #tblTypeConfigCanasta.enviodomicilio,
			                             PaqueteCanasta.Paqueteria = #tblTypeConfigCanasta.Carrier,
										 PaqueteCanasta.servicio = #tblTypeConfigCanasta.Service,
										 PaqueteCanasta.CostoEnvio = #tblTypeConfigCanasta.CostoEnvio
			   FROM PaqueteCanasta 
			   INNER JOIN #tblTypeConfigCanasta ON #tblTypeConfigCanasta.NumeroPaquete COLLATE SQL_Latin1_General_CP1_CI_AS = PaqueteCanasta.NumeroPaquete COLLATE SQL_Latin1_General_CP1_CI_AS

END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertDistribucionConfiguracionDirecta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_InsertDistribucionConfiguracionDirecta]
	@tbltablaconfig TypePaqueteConfiguracionDirecto READONLY

AS
BEGIN
 	IF OBJECT_ID('tempdb..#tblTypeConfigCanastad') IS NOT NULL
		DROP TABLE #tblTypeConfigCanastad

  CREATE TABLE #tblTypeConfigCanastad
					(   [Id_Proveedor] [int] NULL,
					    [id] [int] NULL,
						[Carrier] [nvarchar](max) NULL,
						[Service] [nvarchar](max) NULL,
						[CostoEnvio] decimal(6,2) NULL,
						[Efectivo] [nvarchar](max) NULL,
	                    [Terminal] [nvarchar](max) NULL,
						[NumeroPaquete] [nvarchar](max) NULL,
					    [uuID] [varchar](max)  NULL
					);  
				INSERT INTO #tblTypeConfigCanastad 
				SELECT  [Id_Proveedor],
					    [id],
						[Carrier],
						[Service],
						[CostoEnvio],
						[Efectivo],
						[Terminal],
						[NumeroPaquete],
					    [uuID]
			   FROM @tbltablaconfig

			   UPDATE PaqueteCanasta SET PaqueteCanasta.entregadomicilio = 'false',
			                             PaqueteCanasta.Paqueteria = #tblTypeConfigCanastad.Carrier,
										 PaqueteCanasta.servicio = #tblTypeConfigCanastad.Service,
										 PaqueteCanasta.CostoEnvio = #tblTypeConfigCanastad.CostoEnvio,
										 PaqueteCanasta.PEfectivo = #tblTypeConfigCanastad.Efectivo,
										 PaqueteCanasta.PTerminal = #tblTypeConfigCanastad.Terminal
			   FROM PaqueteCanasta 
			   INNER JOIN #tblTypeConfigCanastad ON #tblTypeConfigCanastad.NumeroPaquete COLLATE SQL_Latin1_General_CP1_CI_AS = PaqueteCanasta.NumeroPaquete COLLATE SQL_Latin1_General_CP1_CI_AS

END


GO
/****** Object:  StoredProcedure [dbo].[SP_InsertEstatusguia]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_InsertEstatusguia]
	@tblestatusguia TypeGuiaEstatus READONLY

AS
BEGIN
 	IF OBJECT_ID('tempdb..#tblestatusguia') IS NOT NULL
		DROP TABLE #tblestatusguia

  CREATE TABLE #tblestatusguia
					(   [guia] VARCHAR (MAX) NULL,
					    [estatus] VARCHAR (MAX) NULL
					);  
				INSERT INTO #tblestatusguia
				SELECT  [guia],
					    [estatus]
			   FROM @tblestatusguia

			   UPDATE DireccionPedido SET DireccionPedido.estatusguia = #tblestatusguia.estatus
			   FROM DireccionPedido 
			   INNER JOIN #tblestatusguia ON #tblestatusguia.guia COLLATE SQL_Latin1_General_CP1_CI_AS = DireccionPedido.guia COLLATE SQL_Latin1_General_CP1_CI_AS
			   --WHERE ISNULL(DireccionPedido.EstatusGuia,0) NOT IN ('CONFIRMADO') 

END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertLogError]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertLogError] 
@lastErrorTypeName nvarchar (max),
@lastErrorMessage nvarchar (max),
@lastErrorStackTrace nvarchar (max),
@URL nvarchar (max),
@SessionCliente nvarchar (max) = null,
@SessionProveedor nvarchar (max)= null
AS

BEGIN   
					INSERT LogsError (lastErrorTypeName,lastErrorMessage, lastErrorStackTrace, URL, fecha,SessionCliente,SessionProveedor)
	              VALUES (@lastErrorTypeName,@lastErrorMessage, @lastErrorStackTrace, @URL, GETDATE(),@SessionCliente,@SessionProveedor)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPedido]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_InsertPedido]
	@Id_Cliente as int=0,
	@FormaDePago VARCHAR(MAX) = NULL,
    @PuntosUsados INT = 0,
	@uuID VARCHAR(MAX) = NULL,
	@status VARCHAR(MAX) = NULL,
	@IDPAGO VARCHAR(MAX) = NULL,
	@tipopago VARCHAR(MAX) = NULL,
	@idordentienda VARCHAR(MAX) = NULL,
	@IDpreferencia VARCHAR(MAX) = NULL,

    @IP VARCHAR(MAX) = NULL,
	@Dispositivo VARCHAR(MAX) = NULL,
	@Tipo_Movimiento VARCHAR(MAX) = NULL,
	@IP2 VARCHAR(MAX) = NULL,
	@macAddr VARCHAR(MAX) = NULL
AS
BEGIN

--declare 	@Id_Cliente as int=2,
--	@FormaDePago VARCHAR(MAX) = 'PP',
--    @PuntosUsados INT = 0,
--	@uuID VARCHAR(MAX) = '98b9b0d2-a563-435b-bf45-44a4a6bdfefa'

     --INSERTAR PEDIDO
      IF(not exists(select 1 from PedidosNuevo where uuID=@uuID))
	  Begin

			  INSERT INTO [dbo].[PedidosNuevo]
                ([Id_Cliente]
                ,[Id_Canasta]
                ,[Id_Producto]
                ,[Precio]
                ,[Cantidad]
                ,[Descuento]
                ,[Puntos]
                ,[Fecha]
                ,[Estatus_Cliente]
                ,[FormaDePago]
                ,[Comentarios]
                ,[Id_Proveedor]
                ,[Estatus_Proveedor]
                ,[PuntosUsados]
				,[tipoenvio]
				,[entregadomicilio]
				,[idOrigen]
				,[uuID]
                ,NumeroPaquete
				,TipoEnvioAmbos
				,PagoEntrega
				,status,
				IDPAGO,
				tipopago,
				idordentienda,
				IDpreferencia,
				IdIdiomaP
				) 

				SELECT c.id_Cliente,c.id_Canasta,c.Id_Producto,c.Precio,pc.Cantidad,c.Descuento,ISNULL(tblproduc.M_Puntos,0),GETDATE(),
                'Sin Confirmar',  CASE WHEN ISNULL(pc.PagoEntrega,0) = 1 THEN 'DD' ELSE @FormaDePago END  ,'',c.Id_Proveedor,'Sin Confirmar',@PuntosUsados,
				pp.tipoenvio tipoenvio,
				pc.entregadomicilio,
				pp.idOrigen,
				pc.uuID,
                pc.NumeroPaquete,
				pc.tipoenvio,
				case when pc.PTerminal = 'true' then 'Terminal' ELSE 'Efectivo' end as pago,
				@status,
				@IDPAGO,
				@tipopago,
				@idordentienda,
				@IDpreferencia,
				c.tipoidioma
				FROM PaqueteCanasta pc 
				INNER JOIN CANASTA c ON pc.uuID = c.uuID AND  pc.Id_Producto = c.Id_Producto
				INNER JOIN Productos_en_Produccion pp ON pp.Id = c.Id_Producto
				INNER JOIN (SELECT id_Tbl,IdiomaNombre,IdiomaDescripcion,M_Precio,M_Puntos,Idioma.id_Idioma FROM TblIdiomaProductos INNER JOIN Idioma ON Idioma.id_Idioma = TblIdiomaProductos.id_Idioma WHERE Tabla = 'Productos_en_Produccion'  ) tblproduc ON tblproduc.id_Tbl = pp.Id  and tblproduc.id_Idioma = c.tipoidioma

				WHERE pc.uuID = @uuID

				  IF(NOT EXISTS(select 1 from PaqueteNuevo where uuID=@uuID))
	              Begin
				        INSERT INTO PaqueteNuevo
                                   ([uuID],
									[NumeroPaquete])
				        SELECT distinct pc.uuID,
								pc.NumeroPaquete
								FROM PaqueteCanasta pc
								WHERE pc.uuID = @uuID
				  END

                --DECLARE @ID_Pedido INT = @@IDENTITY
				 INSERT INTO [dbo].[DireccionPedido]
                (	[Id_Pedido],
				    [uuID],
					[Nombre],
					[Email],
					[Direccion],
					[Colonia],
					[Ciudad],
					[Estado],
					[Pais],
					[Codigo_Postal],
					[Tel_Casa],
					[Paqueteria],
					[servicio],
                    CostoEnvio,
					[Fecha_Registro],
					Latitud,
				    Longitud)
					SELECT p.Id_Pedido, p.uuID, c.Nombre,
					c.Email,
					c.Direccion,
					c.Colonia,
					c.Ciudad,
					c.Estado,
					c.Pais,
					c.Codigo_Postal,
					c.Tel_Casa,
					cc.Paqueteria,
					cc.servicio,
					cc.CostoEnvio,
					GETDATE(),
					c.Latitud,
					c.Longuitud
					FROM PedidosNuevo p
					INNER JOIN Clientes c ON c.Id_Cliente = p.Id_Cliente
					INNER JOIN PaqueteCanasta cc ON cc.Id_Producto = p.Id_Producto AND cc.NumeroPaquete = p.NumeroPaquete
					WHERE p.uuID = @uuID --AND p.entregadomicilio = 'false'  
	END
	--INSERTAR SERVICIO
 IF(not exists(select 1 from PedidoServicio where uuID=@uuID))
	  Begin

			  INSERT INTO [dbo].[PedidoServicio]
                ([Id_Cliente]
                ,[Id_Canasta]
                ,[Id_Servicio]
                ,[Precio]
                ,[Cantidad]
                ,[Descuento]
                ,[Puntos]
                ,[Fecha]
                ,[Estatus_Cliente]
                ,[FormaDePago]
                ,[Comentarios]
                ,[Id_Proveedor]
                ,[Estatus_Proveedor]
                ,[PuntosUsados]
				--,[idOrigen]
				,[uuID]
                ,NumeroPaquete
				,IdIdiomaP
				) 
				SELECT c.id_Cliente,c.id_Canasta,c.Id_Servicio,c.Precio,c.Cantidad,c.Descuento,ISNULL(tblserv.M_Puntos,0),GETDATE(),
                'Sin Confirmar',@FormaDePago,'',c.Id_Proveedor,'Sin Confirmar',@PuntosUsados,
				--pp.idOrigen,
				c.uuID,
                c.NumeroPaquete
				,c.tipoidioma
				FROM CANASTA c
				INNER JOIN servicios_nuevos pp ON pp.Id_Servicio = c.Id_Servicio
				INNER JOIN (SELECT id_Tbl,IdiomaNombre,IdiomaDescripcion,M_Precio,M_Puntos,Idioma.id_Idioma FROM TblIdiomaProductos INNER JOIN Idioma ON Idioma.id_Idioma = TblIdiomaProductos.id_Idioma WHERE Tabla = 'servicios_nuevos'  ) tblserv ON tblserv.id_Tbl = pp.Id_Servicio  and tblserv.id_Idioma = c.tipoidioma
				WHERE c.uuID = @uuID

			IF(NOT EXISTS(select 1 from PaqueteNuevo where uuID=@uuID AND Tipo = '1'))
	          Begin
				        INSERT INTO PaqueteNuevo
                                   ([uuID],
									[NumeroPaquete],Tipo)
				        SELECT distinct pc.uuID,
								pc.NumeroPaquete, '1'
								FROM PedidoServicio pc
								WHERE pc.uuID = @uuID
			END  
			

				 INSERT INTO [dbo].[DireccionServicio]
                (	[Id_PedidoServicio],
				    [uuID],
					[Nombre],
					[Email],
					[Direccion],
					[Colonia],
					[Ciudad],
					[Estado],
					[Pais],
					[Codigo_Postal],
					[Tel_Casa],
					[Fecha_Registro],
					Latitud,
					Longitud
					)
					SELECT p.Id_PedidoServicio, p.uuID, c.Nombre,
					c.Email,
					c.Direccion,
					c.Colonia,
					c.Ciudad,
					c.Estado,
					c.Pais,
					c.Codigo_Postal,
					c.Tel_Casa,
					GETDATE(),
					c.Latitud,
					c.Longuitud
					FROM PedidoServicio p
					INNER JOIN Clientes c ON c.Id_Cliente = p.Id_Cliente
					WHERE p.uuID = @uuID
	END
	Insert Into CanastaLog(Id_Canasta,Id_Producto,Id_Proveedor,Id_Cliente,Id_Servicio,Precio,Cantidad,Fecha_creacion,Total_Unitario,Descuento,IPMaquina,Tipo_Movimiento,Tipo_Dispositivo,Ubicacion,MAC) 
    SELECT Id_Canasta,Id_Producto,Id_Proveedor,Id_Cliente,Id_Servicio,Precio,Cantidad,GETDATE(),Total_Unitario,Descuento,@IP,@Tipo_Movimiento,@Dispositivo,@IP2 ,@macAddr
	from Canasta WHERE uuID = @uuID

				delete Canasta WHERE uuID = @uuID
				delete PaqueteCanasta WHERE uuID = @uuID

END


GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPedidoDirecto]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_InsertPedidoDirecto]
	@Id_Cliente as int=0,
	@FormaDePago VARCHAR(MAX) = NULL,
    @PuntosUsados INT = 0,
	@uuID VARCHAR(MAX) = NULL
	
AS
BEGIN

     --INSERTAR PEDIDO
      IF(not exists(select 1 from PedidosNuevo where uuID=@uuID))
	  Begin

			  INSERT INTO [dbo].[PedidosNuevo]
                ([Id_Cliente]
                ,[Id_Canasta]
                ,[Id_Producto]
                ,[Precio]
                ,[Cantidad]
                ,[Descuento]
                ,[Puntos]
                ,[Fecha]
                ,[Estatus_Cliente]
                ,[FormaDePago]
                ,[Comentarios]
                ,[Id_Proveedor]
                ,[Estatus_Proveedor]
                ,[PuntosUsados]
				,[tipoenvio]
				,[entregadomicilio]
				,[idOrigen]
				,[uuID]
                ,NumeroPaquete
				,TipoEnvioAmbos
				,PagoEntrega) 
				SELECT c.id_Cliente,c.id_Canasta,c.Id_Producto,c.Precio,pc.Cantidad,c.Descuento,ISNULL(pp.Puntos,0),GETDATE(),
                'Sin Confirmar',@FormaDePago,'',c.Id_Proveedor,'Sin Confirmar',@PuntosUsados,
				pp.tipoenvio tipoenvio,
				pc.entregadomicilio,
				pp.idOrigen,
				pc.uuID,
                pc.NumeroPaquete,
				pc.tipoenvio,
				case when pc.PTerminal = 'true' then 'Terminal' ELSE 'Efectivo' end as pago
				FROM PaqueteCanasta pc 
				INNER JOIN CANASTA c ON pc.uuID = c.uuID AND  pc.Id_Producto = c.Id_Producto
				INNER JOIN Productos_en_Produccion pp ON pp.Id = c.Id_Producto
				WHERE pc.uuID = @uuID

				  IF(NOT EXISTS(select 1 from PaqueteNuevo where uuID=@uuID))
	              Begin
				        INSERT INTO PaqueteNuevo
                                   ([uuID],
									[NumeroPaquete])
				        SELECT distinct pc.uuID,
								pc.NumeroPaquete
								FROM PaqueteCanasta pc
								WHERE pc.uuID = @uuID
				  END

                --DECLARE @ID_Pedido INT = @@IDENTITY
				 INSERT INTO [dbo].[DireccionPedido]
                (	[Id_Pedido],
				    [uuID],
					[Nombre],
					[Email],
					[Direccion],
					[Colonia],
					[Ciudad],
					[Estado],
					[Pais],
					[Codigo_Postal],
					[Tel_Casa],
					[Paqueteria],
					[servicio],
                    CostoEnvio,
					[Fecha_Registro],
					Latitud,
				    Longitud)
					SELECT p.Id_Pedido, p.uuID, c.Nombre,
					c.Email,
					c.Direccion,
					c.Colonia,
					c.Ciudad,
					c.Estado,
					c.Pais,
					c.Codigo_Postal,
					c.Tel_Casa,
					cc.Paqueteria,
					cc.servicio,
					cc.CostoEnvio,
					GETDATE(),
					c.Latitud,
					c.Longuitud
					FROM PedidosNuevo p
					INNER JOIN Clientes c ON c.Id_Cliente = p.Id_Cliente
					INNER JOIN PaqueteCanasta cc ON cc.Id_Producto = p.Id_Producto AND cc.NumeroPaquete = p.NumeroPaquete
					WHERE p.uuID = @uuID --AND p.entregadomicilio = 'false'  
	END
	--INSERTAR SERVICIO
 IF(not exists(select 1 from PedidoServicio where uuID=@uuID))
	  Begin

			  INSERT INTO [dbo].[PedidoServicio]
                ([Id_Cliente]
                ,[Id_Canasta]
                ,[Id_Servicio]
                ,[Precio]
                ,[Cantidad]
                ,[Descuento]
                ,[Puntos]
                ,[Fecha]
                ,[Estatus_Cliente]
                ,[FormaDePago]
                ,[Comentarios]
                ,[Id_Proveedor]
                ,[Estatus_Proveedor]
                ,[PuntosUsados]
				--,[idOrigen]
				,[uuID]
                ,NumeroPaquete
				--,PagoEntrega
				) 
				SELECT c.id_Cliente,c.id_Canasta,c.Id_Servicio,c.Precio,c.Cantidad,c.Descuento,ISNULL(pp.Puntos,0),GETDATE(),
                'Sin Confirmar',@FormaDePago,'',c.Id_Proveedor,'Sin Confirmar',@PuntosUsados,
				--pp.idOrigen,
				c.uuID,
                c.NumeroPaquete
				--,case when pp.PTerminal = 'true' then 'Terminal' ELSE 'Efectivo' end as pago
				FROM CANASTA c
				INNER JOIN servicios_nuevos pp ON pp.Id_Servicio = c.Id_Servicio
				WHERE c.uuID = @uuID

			IF(NOT EXISTS(select 1 from PaqueteNuevo where uuID=@uuID AND Tipo = '1'))
	          Begin
				        INSERT INTO PaqueteNuevo
                                   ([uuID],
									[NumeroPaquete],Tipo)
				        SELECT distinct pc.uuID,
								pc.NumeroPaquete, '1'
								FROM PedidoServicio pc
								WHERE pc.uuID = @uuID
			END  
			

				 INSERT INTO [dbo].[DireccionServicio]
                (	[Id_PedidoServicio],
				    [uuID],
					[Nombre],
					[Email],
					[Direccion],
					[Colonia],
					[Ciudad],
					[Estado],
					[Pais],
					[Codigo_Postal],
					[Tel_Casa],
					[Fecha_Registro],
					Latitud,
					Longitud
					)
					SELECT p.Id_PedidoServicio, p.uuID, c.Nombre,
					c.Email,
					c.Direccion,
					c.Colonia,
					c.Ciudad,
					c.Estado,
					c.Pais,
					c.Codigo_Postal,
					c.Tel_Casa,
					GETDATE(),
					c.Latitud,
					c.Longuitud
					FROM PedidoServicio p
					INNER JOIN Clientes c ON c.Id_Cliente = p.Id_Cliente
					WHERE p.uuID = @uuID
	END
				delete Canasta
					from Canasta 
					inner join PaqueteCanasta on PaqueteCanasta.uuID = Canasta.uuID and PaqueteCanasta.Id_Producto = Canasta.Id_Producto
					 WHERE Canasta.uuID = @uuID
				delete PaqueteCanasta WHERE uuID = @uuID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_Muestra_Propiedades]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Hugo C.>
-- Create date: <Create Date,27 de Marzo del 2014,>
-- Description:	<Description,,Muestra Todas Las Propiedades en la Tabla Propiedades_Reg3>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Muestra_Propiedades]        
AS
BEGIN
	SET NOCOUNT ON;
    SELECT * FROM Propiedades   
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ObtenerProv]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ObtenerProv]
@uuID VARCHAR (100)
AS BEGIN


IF(EXISTS(SELECT 1 FROM Proveedores WHERE uuidEmail = @uuID) )
BEGIN
SELECT *, 'Email' as Activacion FROM Proveedores WHERE uuidEmail = @uuID
END
ELSE IF(EXISTS(SELECT 1 FROM Proveedores WHERE uuidCelular = @uuID ))
BEGIN
SELECT *, 'Celular' as Activacion FROM Proveedores WHERE uuidCelular = @uuID
END



END
GO
/****** Object:  StoredProcedure [dbo].[SP_Paquetes_UUID]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Paquetes_UUID]
	@uuID VARCHAR(MAX) = NULL
	
AS
BEGIN

SELECT 
                                  t.uuid, t.NumeroPaquete
                                  ,STUFF(
                                        (
                                            SELECT  u.Nombre + ', ' AS [text()]
                                                FROM PedidosNuevo AS tt
				                                INNER JOIN Productos_en_Produccion u  ON u.Id = tt.Id_Producto
                                                WHERE tt.NumeroPaquete=t.NumeroPaquete
                                                ORDER BY u.Nombre
                                            FOR XML PATH('')
                                        ), 1, 0, '') AS Nombre
                                    FROM (Select PedidosNuevo.uuid,NumeroPaquete
				                                From PedidosNuevo 
                                                where entregadomicilio='false' AND tipoenvio=2 AND uuID = @uuID
                                                GROUP BY PedidosNuevo.uuid,NumeroPaquete
												UNION
												Select PedidosNuevo.uuid,NumeroPaquete
				                                From PedidosNuevo 
                                                where entregadomicilio='false' AND tipoenvio=3 AND TipoEnvioAmbos in (2,3) AND uuID = @uuID
                                                GROUP BY PedidosNuevo.uuid,NumeroPaquete
												) As t

END

GO
/****** Object:  StoredProcedure [dbo].[SP_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Productos] 
		
	 @Accion as nchar(20)=''
	,@ID_Productos as int=0 Output
	,@Nombre_Producto as nvarchar(50)=''
	,@Tipo_Producto as nvarchar(50)=''
	,@Clave_Producto as nvarchar(50)=''
	,@Precio_Producto as nvarchar(50)=''
	,@Nombre_Proveedor as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
	,@Estatus_Producto as int=0
	
	
AS
	BEGIN
		IF @Accion='ALTAS'
		BEGIN
			INSERT INTO Productos
			(Nombre_Producto
			,Tipo_Producto
			,Clave_Producto
			,Precio_Producto
			,Nombre_Proveedor
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Producto)
			Values
			(@Nombre_Producto
			,@Tipo_Producto
			,@Clave_Producto
			,@Precio_Producto
			,@Nombre_Proveedor
			,@Usuario_Alta
			,GETDATE()
			,1)
		
		Select @ID_Productos = @@IDENTITY
		END
		
		IF @Accion ='ACTUALIZA'
		BEGIN
			UPDATE Productos
			SET
				Nombre_Producto=@Nombre_Producto
				,Tipo_Producto=@Tipo_Producto
				,Clave_Producto=@Clave_Producto
				,Precio_Producto=@Precio_Producto
				,Nombre_Proveedor=@Nombre_Proveedor
				,Usuario_Act=@Usuario_Alta
				,Fecha_Act=GETDATE()
				,Estatus_Producto=1
			WHERE
			 Id_Producto=@ID_Productos
		END
		
		IF @Accion='BAJA'
		BEGIN	
			UPDATE Productos
			SET		
				Usuario_Baja=@Usuario_Alta
				,Fecha_Baja=getdate()
				,Estatus_Producto=0
			WHERE
				Id_Producto=@ID_Productos
		END
		
		IF @Accion='COMBO'
	BEGIN
		SELECT (rtrim(Tipo_Producto)) as Producto
		FROM Tipo_Productos
		WHERE Estatus_Tipo_Producto=1 
		ORDER BY Tipo_Producto
	END
		
		IF @Accion='COMBOPROVEEDOR'
	BEGIN
		SELECT (rtrim(Nombre_Proveedor)) as Proveedor
		FROM Proveedores
		WHERE Estatus_Proveedor=1 
		ORDER BY Nombre_Proveedor
	END
	
		IF @Accion='CARGARIMAGENES'
	BEGIN
		SELECT (rtrim(Nombre_Producto)) as Producto
		FROM Productos
		WHERE Estatus_Producto=1 
		ORDER BY Nombre_Producto
	END
	
	
						
		IF @Accion='SELECCIONACARGA'
		
		BEGIN	
			
			SELECT Id_Producto, Nombre_Producto, Tipo_Producto, Clave_Producto	
			FROM Productos
			WHERE Estatus_Producto=1 AND(Nombre_Producto LIKE '%' + LTRIM(RTRIM(@Nombre_Producto))+ '%');
			
		END		
		
		IF @Accion='ExisteProducto'
		BEGIN
		Select count(*)
		From Productos
		where Estatus_Producto=1  and (Nombre_Producto Like ltrim(rtrim(@Nombre_Producto)));
	END
		
		IF @Accion='Registro'
		BEGIN
			INSERT INTO Productos
			(Nombre_Producto
			,Tipo_Producto
			,Clave_Producto
			,Precio_Producto
			,Nombre_Proveedor
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Producto)
			Values
			(@Nombre_Producto
			,@Tipo_Producto
			,@Clave_Producto
			,@Precio_Producto
			,@Nombre_Proveedor
			,@Usuario_Alta
			,GETDATE()
			,1)
		Select @ID_Productos = @@IDENTITY
		END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_Propiedades]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Hugo Contreras
-- Create date: 30/Abril/2014
-- Description: Procedimiento para Insertar registros en una Tabla con transacción y control de errores.
-- =============================================

CREATE PROCEDURE [dbo].[SP_Propiedades]
         
         @Accion as nchar (20) =''
	,@Id_Propiedad as int = 0  Output	
	,@Tipo as nvarchar(50)=''
	,@SubTipo as nvarchar(50)=''
	,@Operacion as nvarchar(50)=''
	,@Clave as nvarchar(50)=''
	,@Asesor as nvarchar(50)=''
	,@Tipo_Captacion as nvarchar(50)=''
	,@Comision as decimal=0
	,@Valor as int
	,@Calle as nvarchar(50)=''
	,@Numero as nvarchar(50) = ''
	,@Zona as nvarchar(50)=''
	,@Colonia as nvarchar(50)=''
	,@Estado as nvarchar(50)=''
	,@Ciudad as nvarchar(50)=''
	,@Pais as nvarchar(50)=''
	,@Entre_Calles as nvarchar(50)=''
	,@Terreno as nvarchar(50) = ''
	,@Construccion as nvarchar(20)=''
	,@Frente as nvarchar(20)=''
	,@Fondo as nvarchar(20)=''
	,@Recamaras as nvarchar(20)=''
	,@Inodoros as nvarchar(20)=''
	,@Recibidor as int=0
	,@com1 as nvarchar(max)=''
	,@Sala as int=0
	,@com2 as nvarchar(max)=''
	,@Comedor as int=0
	,@com3 as nvarchar(max)=''
	,@Antecomedor as int=0
	,@com4 as nvarchar(max)=''
	,@Cocina as int=0
	,@com5 as nvarchar(max)=''
	,@Lavanderia as int=0
	,@com6 as nvarchar(max)=''
	,@Cuarto_Servicio as int=0
	,@com7 as nvarchar(max)=''
	,@Cuarto_TV as int=0
	,@com8 as nvarchar(max)=''
	,@Cochera as int=0
	,@com9 as nvarchar(max)=''
	,@Jardin as int=0
	,@com10 as nvarchar(max)=''
	,@Alberca as int=0
	,@com11 as nvarchar(max)=''
	,@Terraza as int=0
	,@com12 as nvarchar(max)=''
	,@Boiler as int=0
	,@com13 as nvarchar(max)=''
	,@Estufa as int=0
	,@com14 as nvarchar(max)=''
	,@Cuarto_Juegos as int=0
	,@com15 as nvarchar(max)=''
	,@Biblioteca as int=0
	,@com16 as nvarchar(max)=''
	,@Clima as int=0
	,@com17 as nvarchar(max)=''
	,@Calefaccion as int=0
	,@com18 as nvarchar(max)=''
	,@Alarma as int=0
	,@com19 as nvarchar(max)=''
	,@Sonido_Interior as int=0
	,@com20 as nvarchar(max)=''
	,@Antiguedad as nvarchar(50)=''
	,@Alfombra as int=0
	,@com21 as nvarchar(max)=''
	,@Piso as int=0
	,@com22 as nvarchar(max)=''
	,@Tv_Paga as int=0
	,@com23 as nvarchar(max)=''
	,@Ventaneria as int=0
	,@com24 as nvarchar(max)=''
	,@Fachada as int=0
	,@com25 as nvarchar(max)=''
	,@Topografia as nvarchar(max) =''
	,@Niveles as nvarchar(20)=''
	,@Amueblado as int=0
	,@com26 as nvarchar(max)=''
	,@Luz as int=0
	,@com27 as nvarchar(max)=''
	,@Agua as int=0
	,@com28 as nvarchar(max)=''
	,@Gas as int=0
	,@com29 as nvarchar(max)=''
	,@Otros_Servicios as nvarchar(max)=''
	,@Cuotas as int=0
	,@com30 as nvarchar(max)=''
	,@Horario_Visita as nvarchar(max)=''
	,@Fecha_Visitas as nvarchar(50)=''
	,@Publicar as int=0
	,@Autorizado as bit=0
	,@Estatus as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
        ,@Img_Nombre as nvarchar(max)=''
        ,@Img_Ruta as nvarchar(max)='' 
        ,@msg AS VARCHAR(100) OUTPUT

AS
   BEGIN
      IF @Accion='SELECCIONA'
           BEGIN
              SELECT * FROM Propiedades WHERE Id_Propiedad=@Id_Propiedad
	   END

      IF @Accion='REGISTRA'
         BEGIN
              INSERT INTO  Propiedades(Tipo,Operacion,Clave,Calle,Numero,Colonia,Pais,Estado,Ciudad,Valor_Propiedad,Recamaras,Inodoros,Img_Nombre,Img_Ruta)			
	      VALUES (@Tipo,@Operacion,@Clave,@Calle,@Numero,@Colonia,@Pais,@Estado,@Ciudad,@Valor,@Recamaras,@Inodoros,@Img_Nombre, @Img_Ruta)
		
END


END
GO
/****** Object:  StoredProcedure [dbo].[SP_Propiedades_2]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[NewStoredProcedure]    Script Date: 05/15/2014 09:53:30 ******/
CREATE PROCEDURE [dbo].[SP_Propiedades_2]
     @Tipo                       NVARCHAR(50),
     @Operacion             NVARCHAR(50),
     @Clave                    NVARCHAR(50),
     @Calle                     NVARCHAR(50),              
     @Numero                INT, 
     @Colonia                 VARCHAR(50)=NULL,
     @Pais                      NVARCHAR(50),
     @Estado                 NVARCHAR(50),
     @Ciudad                 NVARCHAR(50),
     @Valor                    DECIMAL(18,2),
     @Recamaras          NVARCHAR(50),
     @Inodoros             NVARCHAR(50),
     @Img_Nombre       NVARCHAR(MAX),
     @Img_Ruta           NVARCHAR(MAX),
     @Accion                NVARCHAR(20)=''
AS
BEGIN

IF @Accion='REGISTRA'
     INSERT INTO Propiedades(Tipo,
                                                Operacion,
                                                Clave,
                                                Calle,
                                                Numero,
                                                Colonia,
                                                Pais,
                                                Estado,
                                                Ciudad, 
                                                Valor_Propiedad,
                                                Recamaras,
                                                Inodoros,
                                                Img_Nombre,
                                                Img_Ruta,
                                                Publicar,
                                                Autorizado,
                                                Estatus,
                                                Usuario_Alta,
                                                Fecha_Alta)			
	                                        VALUES (@Tipo,
                                                               @Operacion,
                                                               @Clave,
                                                               @Calle,
                                                               @Numero, 
                                                               @Colonia,
                                                               @Pais,
                                                               @Estado,
                                                               @Ciudad,
                                                               @Valor,
                                                               @Recamaras,
                                                               @Inodoros,
                                                               @Img_Nombre,
                                                               @Img_Ruta,1,1,1,'Admin',GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_Proveedores]
		
	@Accion as nchar(20)=''
	,@Id_Proveedor as int=0 Output
	,@Nombre_Proveedor as nvarchar(50)=''
	,@Correo as nvarchar(50)=''
	,@Direccion as nvarchar(50)=''
	,@Estado as nvarchar(50)=''
	,@Ciudad as nvarchar(50)=''
	,@Pais as nvarchar(50)=''
	,@Tipo_Proveedor as nvarchar(50)=''
	,@Cuota_Proveedor as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
	,@Estatus_Proveedor as int=0
	
AS
BEGIN
		IF @Accion='ALTAS'
		BEGIN
			INSERT INTO Proveedores
			(Nombre_Proveedor
			,Correo
			,Direccion
			,Estado
			,Ciudad
			,Pais
			,Tipo_Proveedor
			,Cuota_Proveedor
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Proveedor)
			Values
			(@Nombre_Proveedor
			,@Correo
			,@Direccion
			,@Estado
			,@Ciudad
			,@Pais
			,@Tipo_Proveedor
			,@Cuota_Proveedor
			,@Usuario_Alta
			,GETDATE()
			,1)
		
		Select @Id_Proveedor = @@IDENTITY
		END
		
		IF @Accion ='ACTUALIZA'
		BEGIN
			UPDATE Proveedores
			SET
				Nombre_Proveedor=@Nombre_Proveedor
				,Correo=@Correo
				,Direccion=@Direccion
				,Estado=@Estado
				,Ciudad=@Ciudad
				,Pais=@Pais
				,Tipo_Proveedor=@Tipo_Proveedor
				,Cuota_Proveedor=@Cuota_Proveedor
				,Usuario_Act=@Usuario_Alta
				,Fecha_Act=GETDATE()
				,Estatus_Proveedor=1
			WHERE
				Id_Proveedor=@Id_Proveedor
		END
		
		IF @Accion='BAJA'
		BEGIN	
			UPDATE Proveedores
			SET				
				Usuario_Baja=@Usuario_Alta
				,Fecha_Baja=GETDATE()
				,Estatus_Proveedor=0
			WHERE
				Id_Proveedor=@Id_Proveedor
		END
		
		IF @Accion='SELECCIONA'
		BEGIN
			SELECT
				*
			FROM Proveedores
			WHERE Id_Proveedor=@Id_Proveedor
			
		END
		
		IF @Accion='COMBO'
	BEGIN
		SELECT (rtrim(Tipo_Proveedor)) as Proveedor
		FROM Tipo_Proveedores
		WHERE Estatus_Tipo_Proveedor=1 
		ORDER BY Tipo_Proveedor
	END
						
		IF @Accion='SELECCIONACARGA'
		
		BEGIN	
			
			SELECT Id_Proveedor, Nombre_Proveedor, Correo, Cuota_Proveedor	
			FROM Proveedores
			WHERE Estatus_Proveedor=1 AND(Nombre_Proveedor LIKE '%' + LTRIM(RTRIM(@Nombre_Proveedor))+ '%')
			Order By ID_Proveedor
		END		
		
		IF @Accion='Registro'
		BEGIN
			INSERT INTO Proveedores
			(Nombre_Proveedor
			,Correo
			,Direccion
			,Estado
			,Ciudad
			,Pais
			,Tipo_Proveedor
			,Cuota_Proveedor
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Proveedor)
			Values
			(@Nombre_Proveedor
			,@Correo
			,@Direccion
			,@Estado
			,@Ciudad
			,@Pais
			,@Tipo_Proveedor
			,@Cuota_Proveedor
			,@Usuario_Alta
			,GETDATE()
			,1)
		Select @Id_Proveedor = @@IDENTITY
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Rutas_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Rutas_Productos]

@productoseleccionado as int = 0
,@ruta as nvarchar(max) =''
,@img_data as Image
,@Id_Imagen as int=0 Output
,@Accion as nchar(20)=''
,@Nombre as nvarchar(50)	

as
begin
		IF @Accion='BUSCAID'
			BEGIN	
				INSERT INTO dbo.Rutas_Productos(Id_Producto,Nombre,Ruta,Imagen) 
				VALUES(@productoseleccionado,@Nombre, @ruta,@img_data)
				
				Select @Id_Imagen = @@IDENTITY
			end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Rutas_Promociones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Rutas_Promociones]
@promselec as int = 0
,@ruta as nvarchar(max) =''
,@img_data as Image
,@Id_Imagen as int=0 Output
,@Accion as nchar(20)=''
,@Nombre as nvarchar(50)	

as
begin
		IF @Accion='BUSCAID'
			BEGIN	
				INSERT INTO dbo.Rutas_Promociones(Id_Promocion,Nombre,Ruta,Imagen) 
				VALUES(@promselec,@Nombre,@ruta,@img_data)
				
				Select @Id_Imagen = @@IDENTITY
			end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Rutas_Propiedades]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Rutas_Propiedades]

@propiedadseleccionado as int = 0
,@ruta as nvarchar(max) =''
,@img_data as Image
,@Id_Imagen as int=0 Output
,@Accion as nchar(20)=''
,@Nombre as nvarchar(50)


as
begin
		IF @Accion='BUSCAID'
			BEGIN	
				INSERT INTO dbo.Rutas_Propiedades(Id_Propiedad,Nombre,Ruta,Imagen) 
				VALUES(@propiedadseleccionado,@Nombre, @ruta,@img_data)
				
				Select @Id_Imagen = @@IDENTITY
			end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Rutas_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Rutas_Proveedores]

@proveedorseleccionado as int = 0
,@ruta as nvarchar(max) =''
,@img_data as Image
,@Id_Imagen as int=0 Output
,@Accion as nchar(20)=''
,@Nombre as nvarchar(50)	

as
begin
		IF @Accion='BUSCAID'
			BEGIN	
				INSERT INTO dbo.Rutas_Proveedores(Id_Proveedor,Nombre,Ruta,Imagen) 
				VALUES(@proveedorseleccionado,@Nombre, @ruta,@img_data)
				
				Select @Id_Imagen = @@IDENTITY
			end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Rutas_Servicios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Rutas_Servicios]
 
@servicioseleccionado as int = 0
,@ruta as nvarchar(max) =''
,@img_data as Image
,@Id_Imagen as int=0 Output
,@Accion as nchar(20)=''
,@Nombre as nvarchar(50)	

as
begin
		IF @Accion='BUSCAID'
			BEGIN	
				INSERT INTO dbo.Rutas_Servicios(Id_Servicio,Nombre,Ruta,Imagen) 
				VALUES(@servicioseleccionado,@Nombre, @ruta,@img_data)
				
				Select @Id_Imagen = @@IDENTITY
			end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Servicios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Servicios] 
		
	@Accion as nchar(20)=''
	,@ID_Servicios as int=0 Output
	,@Nombre_Servicio as nvarchar(50)=''
	,@Tipo_Servicio as nvarchar(50)=''
	,@Descripcion_Servicio as nvarchar(50)=''
	,@Nombre_Proveedor as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
	,@Estatus_Servicio as int=0
	
AS
BEGIN
		IF @Accion='ALTAS'
		BEGIN
			INSERT INTO Servicios
			(Nombre_Servicio
			,Tipo_Servicio
			,Descripcion_Servicio
			,Nombre_Proveedor
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Servicio)
			Values
			(@Nombre_Servicio
			,@Tipo_Servicio
			,@Descripcion_Servicio
			,@Nombre_Proveedor
			,@Usuario_Alta
			,GETDATE()
			,1)
		
		Select @ID_Servicios = @@IDENTITY
		END
		
		IF @Accion ='ACTUALIZA'
		BEGIN
			UPDATE Servicios
			SET
				Nombre_Servicio=@Nombre_Servicio
				,Tipo_Servicio=@Tipo_Servicio
				,Descripcion_Servicio=@Descripcion_Servicio
				,Nombre_Proveedor=@Nombre_Proveedor
				,Usuario_Act=@Usuario_Alta
				,Fecha_Act=GETDATE()
				,Estatus_Servicio=1
			WHERE
			 Id_Servicios=@ID_Servicios
		END
		
		IF @Accion='BAJA'
		BEGIN	
			UPDATE Servicios
			SET			
				Usuario_Baja=@Usuario_Alta
				,Fecha_Baja=GETDATE()	
				,Estatus_Servicio=0
			WHERE
				Id_Servicios=@ID_Servicios
		END
		
		IF @Accion='SELECCIONA'
		BEGIN
			SELECT
				*
			FROM Servicios
			WHERE Id_Servicios=@ID_Servicios
			
		END
		
		IF @Accion='COMBO'
	BEGIN
		SELECT (rtrim(Tipo_Servicio)) as Servicio
		FROM Tipo_Servicios
		WHERE Estatus_Tipo_Servicio=1 
		ORDER BY Tipo_Servicio
	END
	
		IF @Accion='COMBOPROVEEDOR'
	BEGIN
		SELECT (rtrim(Nombre_Proveedor)) as Proveedor
		FROM Proveedores
		WHERE Estatus_Proveedor=1 
		ORDER BY Nombre_Proveedor
	END
						
		IF @Accion='SELECCIONACARGA'
		
		BEGIN	
			
			SELECT Id_Servicios, Nombre_Servicio, Tipo_Servicio, Descripcion_Servicio	
			FROM Servicios
			WHERE Estatus_Servicio=1 AND(Nombre_Servicio LIKE '%' + LTRIM(RTRIM(@Nombre_Servicio))+ '%');
			
		END	
		
		IF @Accion='ExisteServicio'
		BEGIN
		Select count(*)
		From Servicios
		where Estatus_Servicio=1  and (Nombre_Servicio Like ltrim(rtrim(@Nombre_Servicio)));
	END	
		
		IF @Accion='Registro'
		BEGIN
			INSERT INTO Servicios
			(Nombre_Servicio
			,Tipo_Servicio
			,Descripcion_Servicio
			,Nombre_Proveedor
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Servicio)
			Values
			(@Nombre_Servicio
			,@Tipo_Servicio
			,@Descripcion_Servicio
			,@Nombre_Proveedor
			,@Usuario_Alta
			,GETDATE()
			,1)
		Select @ID_Servicios = @@IDENTITY
		END
		
		
					IF @Accion='CARGARIMAGENESSER'
			BEGIN
				SELECT (rtrim(Nombre_Servicio)) as servicio
				FROM Servicios
				WHERE Estatus_Servicio=1 
				ORDER BY Nombre_Servicio
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_Tipo_Productos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Tipo_Productos] 
		
	@Accion as nchar(20)=''
	,@ID_Tipo_Productos as int=0 Output
	,@Tipo_Producto as nvarchar(50)=''
	,@Descripcion_Producto as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
	,@Estatus_Tipo_Producto as int=0
	,@Id_Imagen as int = 0
AS
BEGIN
		IF @Accion='ALTAS'
		BEGIN
			INSERT INTO Tipo_Productos
			(Tipo_Producto
			,Descripcion_Producto
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Tipo_Producto)
			Values
			(@Tipo_Producto
			,@Descripcion_Producto
			,@Usuario_Alta
			,GETDATE()
			,1)
		
		Select @ID_Tipo_Productos = @@IDENTITY
		END
		
		IF @Accion ='ACTUALIZA'
		BEGIN
			UPDATE tipo_Productos
			SET
				 Tipo_Producto=@Tipo_Producto
				,Descripcion_Producto=@Descripcion_Producto
				,Usuario_Act=@Usuario_Alta
				,Fecha_Act=GETDATE()
				,Estatus_Tipo_Producto=1
			WHERE
			 Id_Tipo_Productos=@ID_Tipo_Productos
		END
		
		IF @Accion='BAJA'
		BEGIN	
			UPDATE Tipo_Productos
			SET			
				Usuario_Baja=@Usuario_Alta
				,Fecha_Baja=GETDATE()	
				,Estatus_Tipo_Producto=0
			WHERE
				Id_Tipo_Productos=@ID_Tipo_Productos
		END
		
		IF @Accion='SELECCIONA'
		BEGIN
			SELECT
				*
			FROM Tipo_Productos
			WHERE Id_Tipo_Productos=@ID_Tipo_Productos
			
		END
						
		IF @Accion='SELECCIONACARGA'
		
		BEGIN	
			
			SELECT Id_Tipo_Productos, Tipo_Producto, Descripcion_Producto	
			FROM Tipo_Productos
			WHERE Estatus_Tipo_Producto=1 AND(Tipo_Producto LIKE '%' + LTRIM(RTRIM(@Tipo_Producto))+ '%');
			
		END	
		
		IF @Accion='ExisteProducto'
		BEGIN
		Select count(*)
		From Tipo_Productos
		where Estatus_Tipo_Producto=1  and (Tipo_Producto Like ltrim(rtrim(@Tipo_Producto)));
	END		
		
		IF @Accion='Registro'
		BEGIN
			INSERT INTO Tipo_Productos
			(Tipo_Producto
			,Descripcion_Producto
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Tipo_Producto)
			Values
			(@Tipo_Producto
			,@Descripcion_Producto
			,@Usuario_Alta
			,GETDATE()
			,1)
		Select @ID_Tipo_Productos = @@IDENTITY
		END
	
	
				
	END
GO
/****** Object:  StoredProcedure [dbo].[SP_Tipo_Promociones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Tipo_Promociones] 
		
	@Accion as nchar(20)=''
	,@ID_Tipo_Promociones as int=0 Output
	,@Tipo_Promocion as nvarchar(50)=''
	,@Descripcion_Promocion as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
	,@Estatus_Tipo_Promocion as int=0
	
AS
BEGIN
		IF @Accion='ALTAS'
		BEGIN
			INSERT INTO Tipo_Promociones
			(Tipo_Promocion
			,Descripcion_Promocion
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Tipo_Promocion)
			Values
			(@Tipo_Promocion
			,@Descripcion_Promocion
			,@Usuario_Alta
			,GETDATE()
			,1)
		
		Select @ID_Tipo_Promociones = @@IDENTITY
		END
		
		IF @Accion ='ACTUALIZA'
		BEGIN
			UPDATE Tipo_Promociones
			SET
				 Tipo_Promocion=@Tipo_Promocion
				,Descripcion_Promocion=@Descripcion_Promocion
				,Usuario_Act=@Usuario_Alta
				,Fecha_Act=GETDATE()
				,Estatus_Tipo_Promocion=1
			WHERE
			 Id_Tipo_Promociones=@ID_Tipo_Promociones
		END
		
		IF @Accion='BAJA'
		BEGIN	
			UPDATE Tipo_Promociones
			SET			
				Usuario_Baja=@Usuario_Alta
				,Fecha_Baja=GETDATE()	
				,Estatus_Tipo_Promocion=0
			WHERE
				Id_Tipo_Promociones=@ID_Tipo_Promociones
		END
		
		IF @Accion='SELECCIONA'
		BEGIN
			SELECT
				*
			FROM Tipo_Promociones
			WHERE Id_Tipo_Promociones=@ID_Tipo_Promociones
			
		END
						
		IF @Accion='SELECCIONACARGA'
		
		BEGIN	
			
			SELECT Id_Tipo_Promociones, Tipo_Promocion, Descripcion_Promocion	
			FROM Tipo_Promociones
			WHERE Estatus_Tipo_Promocion=1 AND(Tipo_Promocion LIKE '%' + LTRIM(RTRIM(@Tipo_Promocion))+ '%');
			
		END	
		
		IF @Accion='ExistePromocion'
		BEGIN
		Select count(*)
		From Tipo_Promociones
		where Estatus_Tipo_Promocion=1  and (Tipo_Promocion Like ltrim(rtrim(@Tipo_Promocion)));
	END		
		
		IF @Accion='Registro'
		BEGIN
			INSERT INTO Tipo_Promociones
			(Tipo_Promocion
			,Descripcion_Promocion
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Tipo_Promocion)
			Values
			(@Tipo_Promocion
			,@Descripcion_Promocion
			,@Usuario_Alta
			,GETDATE()
			,1)
		Select @ID_Tipo_Promociones = @@IDENTITY
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Tipo_Proveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Tipo_Proveedores] 
		
	@Accion as nchar(20)=''
	,@ID_Tipo_Proveedores as int=0 Output
	,@Tipo_Proveedor as nvarchar(50)=''
	,@Descripcion_Proveedor as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
	,@Estatus_Tipo_Proveedor as int=0
	
AS
BEGIN
		IF @Accion='ALTAS'
		BEGIN
			INSERT INTO Tipo_Proveedores
			(Tipo_Proveedor
			,Descripcion_Proveedor
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Tipo_Proveedor)
			Values
			(@Tipo_Proveedor
			,@Descripcion_Proveedor
			,@Usuario_Alta
			,GETDATE()
			,1)
		
		Select @ID_Tipo_Proveedores = @@IDENTITY
		END
		
		IF @Accion ='ACTUALIZA'
		BEGIN
			UPDATE tipo_Proveedores
			SET
				 Tipo_Proveedor=@Tipo_Proveedor
				,Descripcion_Proveedor=@Descripcion_Proveedor
				,Usuario_Act=@Usuario_Alta
				,Fecha_Act=GETDATE()
				,Estatus_Tipo_Proveedor=1
			WHERE
			 Id_Tipo_Proveedores=@ID_Tipo_Proveedores
		END
		
		IF @Accion='BAJA'
		BEGIN	
			UPDATE Tipo_Proveedores
			SET			
				Usuario_Baja=@Usuario_Alta
				,Fecha_Baja=GETDATE()	
				,Estatus_Tipo_Proveedor=0
			WHERE
				Id_Tipo_Proveedores=@ID_Tipo_Proveedores
		END
		
		IF @Accion='SELECCIONA'
		BEGIN
			SELECT
				*
			FROM Tipo_Proveedores
			WHERE Id_Tipo_Proveedores=@ID_Tipo_Proveedores
			
		END
						
		IF @Accion='SELECCIONACARGA'
		
		BEGIN	
			
			SELECT Id_Tipo_Proveedores, Tipo_Proveedor, Descripcion_Proveedor	
			FROM Tipo_Proveedores
			WHERE Estatus_Tipo_Proveedor=1 AND(Tipo_Proveedor LIKE '%' + LTRIM(RTRIM(@Tipo_Proveedor))+ '%');
			
		END	
		
		IF @Accion='ExisteProveedor'
		BEGIN
		Select count(*)
		From Tipo_Proveedores
		where Estatus_Tipo_Proveedor=1  and (Tipo_Proveedor Like ltrim(rtrim(@Tipo_Proveedor)));
	END		
		
		IF @Accion='Registro'
		BEGIN
			INSERT INTO Tipo_Proveedores
			(Tipo_Proveedor
			,Descripcion_Proveedor
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Tipo_Proveedor)
			Values
			(@Tipo_Proveedor
			,@Descripcion_Proveedor
			,@Usuario_Alta
			,GETDATE()
			,1)
		Select @ID_Tipo_Proveedores = @@IDENTITY
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Tipo_Servicios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Tipo_Servicios] 
		
	@Accion as nchar(20)=''
	,@ID_Tipo_Servicios as int=0 Output
	,@Tipo_Servicio as nvarchar(50)=''
	,@Descripcion_Servicio as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
	,@Estatus_Tipo_Servicio as int=0
	
AS
BEGIN
		IF @Accion='ALTAS'
		BEGIN
			INSERT INTO Tipo_Servicios
			(Tipo_Servicio
			,Descripcion_Servicio
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Tipo_Servicio)
			Values
			(@Tipo_Servicio
			,@Descripcion_Servicio
			,@Usuario_Alta
			,GETDATE()
			,1)
		
		Select @ID_Tipo_Servicios = @@IDENTITY
		END
		
		IF @Accion ='ACTUALIZA'
		BEGIN
			UPDATE Tipo_Servicios
			SET
				 Tipo_Servicio=@Tipo_Servicio
				,Descripcion_Servicio=@Descripcion_Servicio
				,Usuario_Act=@Usuario_Alta
				,Fecha_Act=GETDATE()
				,Estatus_Tipo_Servicio=1
			WHERE
			 Id_Tipo_Servicios=@ID_Tipo_Servicios
		END
		
		IF @Accion='BAJA'
		BEGIN	
			UPDATE Tipo_Servicios
			SET			
				Usuario_Baja=@Usuario_Alta
				,Fecha_Baja=GETDATE()	
				,Estatus_Tipo_Servicio=0
			WHERE
				Id_Tipo_Servicios=@ID_Tipo_Servicios
		END
		
		IF @Accion='SELECCIONA'
		BEGIN
			SELECT
				*
			FROM Tipo_Servicios
			WHERE Id_Tipo_Servicios=@ID_Tipo_Servicios
			
		END
						
		IF @Accion='SELECCIONACARGA'
		
		BEGIN	
		 
			SELECT Id_Tipo_Servicios, Tipo_Servicio, Descripcion_Servicio	
			FROM Tipo_Servicios
			WHERE Estatus_Tipo_Servicio=1 AND(Tipo_Servicio LIKE '%' + LTRIM(RTRIM(@Tipo_Servicio))+ '%');
			
		END
		
		IF @Accion='ExisteServicio'
		BEGIN
		Select count(*)
		From Tipo_Servicios
		where Estatus_Tipo_Servicio=1  and (Tipo_Servicio Like ltrim(rtrim(@Tipo_Servicio)));
	END			
		
		IF @Accion='Registro'
		BEGIN
			INSERT INTO Tipo_Servicios
			(Tipo_Servicio
			,Descripcion_Servicio
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_Tipo_Servicio)
			Values
			(@Tipo_Servicio
			,@Descripcion_Servicio
			,@Usuario_Alta
			,GETDATE()
			,1)
		Select @ID_Tipo_Servicios = @@IDENTITY
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Total]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Total]

@Id_Venta as int=0 Output
,@total as int
,@comp as int
,@Accion as nchar(20)=''

as
begin
		IF @Accion='totaliza'
			BEGIN
			update Ventas set Total=@total where Id_Venta=@comp
				
			end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCostoEntrega]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_UpdateCostoEntrega]
	@Id_Cliente INT 

AS
BEGIN
--declare 	@Id_Cliente INT = 2 
		 	IF OBJECT_ID('tempdb..#tblsumacostoTT') IS NOT NULL
		DROP TABLE #tblsumacostoTT


		    select distinct PaqueteCanasta.NumeroPaquete, PaqueteCanasta.CostoEnvio Envio 
			INTO #tblsumacostoTT
			from PaqueteCanasta
			INNER JOIN proveedor_info ON PaqueteCanasta.Id_Proveedor = proveedor_info.Id_Proveedor
			where Id_Cliente = @Id_Cliente AND PaqueteCanasta.PagoEntrega is null

			SELECT SUM(ENVIO) TT FROM #tblsumacostoTT


END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateEntregaAct]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_UpdateEntregaAct]
	@Id_Cliente INT 

AS
BEGIN

 	IF OBJECT_ID('tempdb..#tblsumacosto') IS NOT NULL
		DROP TABLE #tblsumacosto
		 	IF OBJECT_ID('tempdb..#tblsumacostoT') IS NOT NULL
		DROP TABLE #tblsumacostoT

 UPDATE PaqueteCanasta SET PagoEntrega = 1 , 
        PEfectivo = CASE WHEN PagoEfectivo = 1 THEN 'true' ELSE 'false' END, 
		PTerminal = CASE WHEN PagoEfectivo = 1 THEN 'false' ELSE (CASE WHEN PagoTerminal = 1 THEN 'true' ELSE 'false' END) END 
            from PaqueteCanasta
            left join Proveedores on PaqueteCanasta.Id_Proveedor = Proveedores.Id_Proveedor
            INNER JOIN proveedor_info ON Proveedores.Id_Proveedor = proveedor_info.Id_Proveedor
            where Id_Cliente = @Id_Cliente AND (PagoEfectivo = 1 or PagoTerminal = 1) and PaqueteCanasta.tipoEnvio = 1


            select SUM(PaqueteCanasta.Cantidad * (Canasta.Precio * ((100 - Productos_en_Produccion.Descuento)) / 100)) TT 
			INTO #tblsumacosto
			from PaqueteCanasta
            INNER JOIN Productos_en_Produccion ON Productos_en_Produccion.Id = PaqueteCanasta.Id_Producto
            INNER JOIN proveedor_info ON PaqueteCanasta.Id_Proveedor = proveedor_info.Id_Proveedor
			INNER JOIN Canasta on Canasta.Id_Cliente = @Id_Cliente and Canasta.Id_Producto = PaqueteCanasta.Id_Producto
            where PaqueteCanasta.Id_Cliente = @Id_Cliente AND (PagoEfectivo = 1 or PagoTerminal = 1) and PaqueteCanasta.tipoEnvio = 1

		    select distinct PaqueteCanasta.NumeroPaquete, PaqueteCanasta.CostoEnvio Envio 
			INTO #tblsumacostoT
			from PaqueteCanasta
			INNER JOIN proveedor_info ON PaqueteCanasta.Id_Proveedor = proveedor_info.Id_Proveedor
			where Id_Cliente = @Id_Cliente AND (PagoEfectivo = 1 or PagoTerminal = 1) and PaqueteCanasta.tipoEnvio = 1

			SELECT SUM(ENVIO)+ MAX(TT) TT, (SELECT COUNT(Id_Cliente) FROM PaqueteCanasta where Id_Cliente = 2 and pagoentrega is null) AS SN  FROM #tblsumacostoT,#tblsumacosto


END


GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateEntregaDec]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_UpdateEntregaDec]
	@Id_Cliente INT 

AS
BEGIN

 	IF OBJECT_ID('tempdb..#tblsumacosto') IS NOT NULL
		DROP TABLE #tblsumacosto
		 	IF OBJECT_ID('tempdb..#tblsumacostoT') IS NOT NULL
		DROP TABLE #tblsumacostoT


		UPDATE PaqueteCanasta SET PagoEntrega = null , PEfectivo = NULL , PTerminal = NULL 
            from PaqueteCanasta
            left join Proveedores on PaqueteCanasta.Id_Proveedor = Proveedores.Id_Proveedor
            INNER JOIN proveedor_info ON Proveedores.Id_Proveedor = proveedor_info.Id_Proveedor
            where Id_Cliente = @Id_Cliente AND (PagoEfectivo = 1 or PagoTerminal = 1) and PaqueteCanasta.tipoEnvio = 1


            select SUM(PaqueteCanasta.Cantidad * (Canasta.Precio * ((100 - Productos_en_Produccion.Descuento)) / 100)) TT 
			INTO #tblsumacosto
			from PaqueteCanasta
            INNER JOIN Productos_en_Produccion ON Productos_en_Produccion.Id = PaqueteCanasta.Id_Producto
            INNER JOIN proveedor_info ON PaqueteCanasta.Id_Proveedor = proveedor_info.Id_Proveedor
						INNER JOIN Canasta on Canasta.Id_Cliente = @Id_Cliente and Canasta.Id_Producto = PaqueteCanasta.Id_Producto
            where PaqueteCanasta.Id_Cliente = @Id_Cliente AND (PagoEfectivo = 1 or PagoTerminal = 1) and PaqueteCanasta.tipoEnvio = 1

		    select distinct PaqueteCanasta.NumeroPaquete, PaqueteCanasta.CostoEnvio Envio 
			INTO #tblsumacostoT
			from PaqueteCanasta
			INNER JOIN proveedor_info ON PaqueteCanasta.Id_Proveedor = proveedor_info.Id_Proveedor
			where Id_Cliente = @Id_Cliente AND (PagoEfectivo = 1 or PagoTerminal = 1) and PaqueteCanasta.tipoEnvio = 1

			SELECT SUM(ENVIO)+ MAX(TT) TT, (SELECT COUNT(Id_Cliente) FROM PaqueteCanasta where Id_Cliente = 2 and pagoentrega is null) AS SN  FROM #tblsumacostoT,#tblsumacosto


END
GO
/****** Object:  StoredProcedure [dbo].[SP_Usuarios]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SP_Usuarios]
		
	@Accion as nchar(20)=''
	,@ID_Usuario as int=0 Output
	,@Nombre as nvarchar(50)=''
	,@Apellido_P as nvarchar(50)=''
	,@Apellido_M as nvarchar(50)=''
	,@Email as nvarchar(50)=''
	,@Direccion as nvarchar(50)=''
	,@Estado as nvarchar(50)=''
	,@Ciudad as nvarchar(50)=''
	,@Pais as nvarchar(50)=''
	,@Codigo_P as nvarchar(50)=''
	,@Usuario as nvarchar(50)=''
	,@Contrasena as nvarchar(50)=''
	,@Perfil as int=0
	,@Usuario_Alta as nvarchar(50)=''
	,@Estatus_U as int=0
	
AS
BEGIN
		IF @Accion='ALTAS'
		BEGIN
			INSERT INTO Usuarios
			(Nombre
			,Apellido_P
			,Apellido_M
			,Email
			,Direccion
			,Estado
			,Ciudad
			,Pais
			,Codigo_P
			,Usuario
			,Contrasena
			,Perfil
			,Usuario_Alta
			,Fecha_Alta
			,Estatus_U)
			Values
			(@Nombre
			,@Apellido_P
			,@Apellido_M
			,@Email
			,@Direccion
			,@Estado
			,@Ciudad
			,@Pais
			,@Codigo_P
			,@Usuario
			,@Contrasena
			,@Perfil
			,@Usuario_Alta
			,getdate()
			,1)
		
		Select @ID_Usuario = @@IDENTITY
		END
		
		IF @Accion ='ACTUALIZA'
		BEGIN
			UPDATE Usuarios
			SET
				 Nombre=@Nombre
				,Apellido_P=@Apellido_P
				,Apellido_M=@Apellido_M
				,Email=@Email
				,Direccion=@Direccion
				,Estado=@Estado
				,Ciudad=@Ciudad
				,Pais=@Pais
				,Codigo_P=@Codigo_P
				,Usuario=@Usuario
				,Contrasena=@Contrasena
				,Perfil=@Perfil
				,Usuario_Act=@Usuario_Alta
			    ,Fecha_Act=getdate()
				,Estatus_U=1
			WHERE
				ID_Usuarios=@ID_Usuario
		END
		
		IF @Accion='BAJA'
		BEGIN	
			UPDATE Usuarios
			SET
				Usuario_Baja=@Usuario_Alta
			    ,Fecha_Baja=getdate()				
				,Estatus_U=0
			WHERE
				ID_Usuarios=@ID_Usuario
		END
		
		IF @Accion='SELECCIONA'
		BEGIN
			SELECT
				*
			FROM Usuarios
			WHERE ID_Usuarios=@ID_Usuario
			
		END
						
		IF @Accion='SELECCIONACARGA'
		
		BEGIN	
			
			SELECT ID_Usuarios, Usuario, Nombre, Apellido_P	
			FROM Usuarios
			WHERE Estatus_U=1 AND(Nombre LIKE '%' + LTRIM(RTRIM(@Nombre))+ '%');
			
		END		
		
		IF @Accion='Registro'
		BEGIN
			INSERT INTO Usuarios
			(Nombre
			,Apellido_P
			,Apellido_M
			,Email
			,Direccion
			,Estado
			,Ciudad
			,Pais
			,Codigo_P
			,Usuario
			,Contrasena
			,Perfil 
			,Usuario_Alta
	        ,Fecha_Alta
			,Estatus_U)
			Values
			(@Nombre
			,@Apellido_P
			,@Apellido_M
			,@Email
			,@Direccion
			,@Estado
			,@Ciudad
			,@Pais
			,@Codigo_P
			,@Usuario
			,@Contrasena
			,@Perfil
			,@Usuario_Alta
	        ,getdate()
			,1)
		Select @ID_Usuario = @@IDENTITY
		END
		
If @Accion='Buscar_User'
		Begin
			Select Id_Usuario,Nombre,Email,Estatus_U
			from Usuarios_Clientes
			where Email=@Usuario AND Password=@Contrasena 
		END

END
GO
/****** Object:  StoredProcedure [dbo].[spAgregaUsuario]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Ivan Rangel Cuadros.
-- Create date: 22/Ene/2009
-- Description:    Procedimiento para Insertar registros en una Tabla con transacción y control de errores.
-- =============================================
CREATE PROCEDURE [dbo].[spAgregaUsuario]

         @Accion as nchar (20) =''
	,@Id_Propiedad as int = 0  Output	
	,@Tipo as nvarchar(50)=''
	,@SubTipo as nvarchar(50)=''
	,@Operacion as nvarchar(50)=''
	,@Clave as nvarchar(50)=''
	,@Asesor as nvarchar(50)=''
	,@Tipo_Captacion as nvarchar(50)=''
	,@Comision as decimal=0
	,@Valor_Propiedad as nvarchar(50) = ''
	,@Calle as nvarchar(50)=''
	,@Numero as nvarchar(50) = ''
	,@Zona as nvarchar(50)=''
	,@Colonia as nvarchar(50)=''
	,@Estado as nvarchar(50)=''
	,@Ciudad as nvarchar(50)=''
	,@Pais as nvarchar(50)=''
	,@Entre_Calles as nvarchar(50)=''
	,@Terreno as nvarchar(50) = ''
	,@Construccion as nvarchar(20)=''
	,@Frente as nvarchar(20)=''
	,@Fondo as nvarchar(20)=''
	,@Recamaras as nvarchar(20)=''
	,@Inodoros as nvarchar(20)=''
	,@Recibidor as int=0
	,@com1 as nvarchar(max)=''
	,@Sala as int=0
	,@com2 as nvarchar(max)=''
	,@Comedor as int=0
	,@com3 as nvarchar(max)=''
	,@Antecomedor as int=0
	,@com4 as nvarchar(max)=''
	,@Cocina as int=0
	,@com5 as nvarchar(max)=''
	,@Lavanderia as int=0
	,@com6 as nvarchar(max)=''
	,@Cuarto_Servicio as int=0
	,@com7 as nvarchar(max)=''
	,@Cuarto_TV as int=0
	,@com8 as nvarchar(max)=''
	,@Cochera as int=0
	,@com9 as nvarchar(max)=''
	,@Jardin as int=0
	,@com10 as nvarchar(max)=''
	,@Alberca as int=0
	,@com11 as nvarchar(max)=''
	,@Terraza as int=0
	,@com12 as nvarchar(max)=''
	,@Boiler as int=0
	,@com13 as nvarchar(max)=''
	,@Estufa as int=0
	,@com14 as nvarchar(max)=''
	,@Cuarto_Juegos as int=0
	,@com15 as nvarchar(max)=''
	,@Biblioteca as int=0
	,@com16 as nvarchar(max)=''
	,@Clima as int=0
	,@com17 as nvarchar(max)=''
	,@Calefaccion as int=0
	,@com18 as nvarchar(max)=''
	,@Alarma as int=0
	,@com19 as nvarchar(max)=''
	,@Sonido_Interior as int=0
	,@com20 as nvarchar(max)=''
	,@Antiguedad as nvarchar(50)=''
	,@Alfombra as int=0
	,@com21 as nvarchar(max)=''
	,@Piso as int=0
	,@com22 as nvarchar(max)=''
	,@Tv_Paga as int=0
	,@com23 as nvarchar(max)=''
	,@Ventaneria as int=0
	,@com24 as nvarchar(max)=''
	,@Fachada as int=0
	,@com25 as nvarchar(max)=''
	,@Topografia as nvarchar(max) =''
	,@Niveles as nvarchar(20)=''
	,@Amueblado as int=0
	,@com26 as nvarchar(max)=''
	,@Luz as int=0
	,@com27 as nvarchar(max)=''
	,@Agua as int=0
	,@com28 as nvarchar(max)=''
	,@Gas as int=0
	,@com29 as nvarchar(max)=''
	,@Otros_Servicios as nvarchar(max)=''
	,@Cuotas as int=0
	,@com30 as nvarchar(max)=''
	,@Horario_Visita as nvarchar(max)=''
	,@Fecha_Visitas as nvarchar(50)=''
	,@Publicar as int=0
	,@Autorizado as bit=0
	,@Estatus as nvarchar(50)=''
	,@Usuario_Alta as nvarchar(50)=''
        ,@msg AS VARCHAR(100) OUTPUT

AS
BEGIN

    SET NOCOUNT ON;

    Begin Tran Tadd

    Begin Try

        IF @Accion='SELECCIONA'
	BEGIN
		SELECT * FROM Propiedades WHERE ID_Propiedad=@ID_Propiedad
	END
        
        SET @msg = 'El Usuario se registro correctamente.'

        COMMIT TRAN Tadd

    End try
    Begin Catch

        SET @msg = 'Ocurrio un Error: ' + ERROR_MESSAGE() + ' en la línea ' + CONVERT(NVARCHAR(255), ERROR_LINE() ) + '.'
        Rollback TRAN Tadd

    End Catch

END
GO
/****** Object:  StoredProcedure [dbo].[SpBusqueda]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SpBusqueda 'vaso'

CREATE PROCEDURE [dbo].[SpBusqueda]  
@Palabra Varchar(max) = ''
AS
BEGIN
 
 select  top 8 * from(
	select 1 AS Id_tipo, P.id_proveedor AS Id, P.Nombre_Proveedor AS Nombre, P.FilePath AS  Ruta_Img_Principal, CP.Categoria from Proveedores P
	INNER JOIN Categorias_Productos CP ON P.Id_Categoria = CP.Id_Categoria
	UNION 
	select 2 AS Id_tipo, Id, Nombre,  Ruta_Img_Principal, Categoria  from Productos_en_Produccion
	UNION 

	SELECT 2 AS Id_tipo, S.Id_Servicio AS Id, S.Nombre_Servicio AS Nombre,  S.Img AS Ruta_Img_Principal, S.Categoria   FROM [dbo].[Servicios_nuevos] S
	
	UNION
	select 3 AS Id_tipo, Id_Servicio AS Id, Nombre_Servicio AS Nombre,  Img AS  Ruta_Img_Principal, Categoria from servicios_nuevos 
	) AS A

	WHERE Nombre like  '%'+ @Palabra+'%'


END
GO
/****** Object:  StoredProcedure [dbo].[SpBusquedaProveedor]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SpBusqueda 'vaso'
--SpBusquedaProveedor 41, 'HOS'
CREATE PROCEDURE [dbo].[SpBusquedaProveedor]  
@Id_Pvd int = 0,
@Palabra Varchar(max) = ''
AS
BEGIN
   DECLARE @NAME VARCHAR(MAX)

SELECT @NAME = Nombre_Proveedor FROM PROVEEDORES WHERE ID_PROVEEDOR  = @Id_Pvd
 select  top 8 * from(
	
	select 2 AS Id_tipo, P.Id, Nombre,  P.Ruta_Img_Principal, CP.Categoria, P.Id_Proveedor  from Productos_en_Produccion P
	INNER JOIN Categorias_Productos CP ON P.Id_Categoria = CP.Id_Categoria
	UNION 

	SELECT 2 AS Id_tipo, S.Id_Servicio AS Id, S.Nombre_Servicio AS Nombre,  S.Img AS Ruta_Img_Principal, S.Categoria, @Id_Pvd AS Id_Proveedor  FROM [dbo].[Servicios_nuevos] S
	WHERE S.Proveedor = @NAME
	
	) AS A

	WHERE Nombre like  '%'+ @Palabra+'%' AND Id_Proveedor = @Id_Pvd


END
GO
/****** Object:  StoredProcedure [dbo].[SPCanasta_Insertar]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPCanasta_Insertar]
 @Id_Producto int
,@Id_Proveedor int
,@Id_Cliente int
,@Precio decimal(18,0)
,@Cantidad int
,@Total_Unitario decimal(18,0)
,@Descuento int
,@Id_Servicio int
,@Puntos int

AS
BEGIN


INSERT INTO [dbo].[Canasta]
           ([Id_Producto]
           ,[Id_Proveedor]
           ,[Id_Cliente]
           ,[Precio]
           ,[Cantidad]
           ,[Fecha]
           ,[Total_Unitario]
           ,[Descuento]
           ,[Id_Servicio]
           ,[Puntos])
     VALUES
           (@Id_Producto
           ,@Id_Proveedor
           ,@Id_Cliente
           ,@Precio
           ,@Cantidad
           ,GETDATE()
           ,@Total_Unitario
           ,@Descuento
           ,@Id_Servicio
           ,@Puntos)
		  SELECT SCOPE_IDENTITY() 
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteData]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteData]
   
   @Id_Categoria int

AS

BEGIN
 
BEGIN TRANSACTION 
 
BEGIN TRY
   
Delete from Categorias_Productos Where Id_Categoria=@Id_Categoria; 

IF @@TRANCOUNT > 0

 BEGIN commit TRANSACTION;
 
END

END TRY

BEGIN CATCH

IF @@TRANCOUNT > 0

BEGIN rollback TRANSACTION; 

END

END CATCH 

END
GO
/****** Object:  StoredProcedure [dbo].[SpInsertCostoRuta]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpInsertCostoRuta] 
@id_proveedor INT = 0,
@idCobertura INT = 0,
@idTipoPaquete INT = 0,
@Costo decimal(16,2) = 0,
@idNombreDataRango int = 0,
@idIdioma int = 1
AS

BEGIN   
				IF(EXISTS(select * from TblAdminFlete WHERE id_proveedor = @id_proveedor AND idCobertura = @idCobertura AND idTipoPaquete =@idTipoPaquete AND idNombreDataRango = @idNombreDataRango and idIdioma = @idIdioma))	  
				BEGIN
				    UPDATE TblAdminFlete set costo = @Costo
					WHERE id_proveedor = @id_proveedor AND idCobertura = @idCobertura AND idTipoPaquete =@idTipoPaquete AND idNombreDataRango = @idNombreDataRango and idIdioma = @idIdioma
				END
				ELSE
				BEGIN
				   insert TblAdminFlete (idCobertura, idTipoPaquete, id_proveedor,fechaModificacion,costo,idNombreDataRango, idIdioma)
				   VALUES (@idCobertura, @idTipoPaquete, @id_proveedor, getdate(),@Costo,@idNombreDataRango, @idIdioma)
				END
END
GO
/****** Object:  StoredProcedure [dbo].[SpListafletes]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpListafletes] 
@Id INT = 0,
@idNombreDataRango INT = 0,
@idIdioma int = 1
AS

BEGIN
			IF OBJECT_ID('tempdb..#tpTblTipoPaquete') IS NOT NULL
		     DROP TABLE #tpTblTipoPaquete

              CREATE TABLE #tpTblTipoPaquete
					   ([idTipoPaquete] [int] null,
						[TipoPaquete] [varchar](max)  NULL,
						[Largo] [varchar](max)  NULL,
						[Width] [varchar](max)  NULL,
						[Height] [varchar](max)  NULL,
						[Weight_] [varchar](max)  NULL,
						[RangoPesoV] [varchar](max)  NULL,
						[idCobertura] [int]  NULL,
						[Nombre_Cobertura] [varchar](max) NULL,
						[Descripcion_Cobertura] [varchar](max) NULL,
						[idAdminFlete] [int]  NULL,
						[Id_Proveedor] [int]  NULL,
						costo decimal (18,2) NULL,
						[NombreDataRango] [varchar](max) NULL
					);  
				insert #tpTblTipoPaquete

				  select TblTipoPaquete.[idTipoPaquete],[TipoPaquete],[Largo],[Width],[Height],[Weight_],RangoPesoV,
			         Cobertura.[idCobertura],[Nombre_Cobertura],[Descripcion_Cobertura],
					 TblAdminFlete.[idAdminFlete],TblAdminFlete.[Id_Proveedor],
				    ISNULL(TblAdminFlete.costo ,0) as costo,NombreDataRango
		        	from TblTipoPaquete
					  LEFT JOIN Cobertura ON Cobertura.fechaBaja IS NULL
					  LEFT JOIN TblNombreDataRango ON TblNombreDataRango.fechaBaja IS NULL AND TblNombreDataRango.id_proveedor = @Id  AND TblNombreDataRango.idNombreDataRango = @idNombreDataRango
					  LEFT JOIN TblAdminFlete ON TblAdminFlete.fechaBaja IS NULL AND  TblAdminFlete.idCobertura=Cobertura.idCobertura AND TblAdminFlete.idTipoPaquete = TblTipoPaquete.idTipoPaquete AND TblAdminFlete.id_proveedor = @Id AND TblNombreDataRango.idNombreDataRango = TblAdminFlete.idNombreDataRango AND TblAdminFlete.idNombreDataRango = @idNombreDataRango and idIdioma = @idIdioma
					  WHERE TblAdminFlete.fechaBaja IS NULL AND Cobertura.fechaBaja IS NULL AND TblAdminFlete.fechaBaja IS NULL  

					DECLARE @cols AS NVARCHAR(MAX),
						@query  AS NVARCHAR(MAX)

					select @cols = STUFF((SELECT ',' + QUOTENAME(Nombre_Cobertura)
										from #tpTblTipoPaquete
										group by Nombre_Cobertura,idCobertura
										order by idCobertura
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')


						set @query = 'SELECT idTipoPaquete,[TipoPaquete],[Largo],[Width],[Height],[Weight_],RangoPesoV,NombreDataRango,' + @cols + ' from 
									 (
										select idTipoPaquete,[TipoPaquete],[Largo],[Width],[Height],[Weight_],RangoPesoV,
			                                   [Nombre_Cobertura],costo,NombreDataRango 
										from #tpTblTipoPaquete
									) x
									pivot 
									(
										sum(costo)
										for Nombre_Cobertura in (' + @cols + ')
									) p '

						execute(@query);





END


GO
/****** Object:  StoredProcedure [dbo].[SpListafletesInsert]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[SpListafletesInsert]
	@id_proveedor as int=0,
	@idCobertura as int=0
	,@tblrutas TBLRangoruta READONLY,
	@idNombreDataRango int = 0,
	@NombreDataRango varchar(max) = null
	
AS
BEGIN
 	IF OBJECT_ID('tempdb..#TBLRangoruta') IS NOT NULL
		DROP TABLE #TBLRangoruta

  CREATE TABLE #TBLRangoruta
					(  [Latitud] numeric (18,6) NULL,
	                   [Longuitud] numeric (18,6) NULL
					);  
					INSERT INTO #TBLRangoruta 
				SELECT Latitud,
	                   Longuitud
			   FROM    @tblrutas;


			   --INSERT INTO #TBLRangoruta 
			   --values          ('25.66006', '-100.07396'),
      --          ('25.73957', '-100.13404'),
      --          ('25.78734', '-100.1682'),
      --          ('25.82049', '-100.19455'),
      --          ('25.84127', '-100.236'),
      --          ('25.83417', '-100.29574'),
      --          ('25.82397', '-100.35342'),
      --          ('25.81022', '-100.39033'),
      --          ('25.79461', '-100.41693'),
      --          ('25.74622', '-100.51083'),
      --          ('25.69843', '-100.55598'),
      --          ('25.6285', '-100.36612'),
      --          ('25.6093', '-100.26553')



			
	--declare @id_proveedor as int=1,
	--@idCobertura as int=1,
	--@idNombreDataRango int = 0,
	--@NombreDataRango varchar(max) = 'Rango Pruebas'

	--SELECT * FROM TblRangoMapa where id_proveedor=@id_proveedor AND idCobertura =@idCobertura and idNombreDataRango =@idNombreDataRango
	--select * from TblRangoMapaid


	declare @idRangoMapa INT = NULL
	if(@id_proveedor <> 0)
	BEGIN
					if(@idNombreDataRango = 0)
							BEGIN
							   insert TblNombreDataRango (NombreDataRango,Id_Proveedor,fechaModificacion)
														  VALUES (@NombreDataRango,@id_proveedor,getdate())

								set @idNombreDataRango = SCOPE_IDENTITY();

								insert TblRangoMapa (idCobertura,fechaModificacion,Id_Proveedor,idNombreDataRango)
								values (@idCobertura,getdate(),@id_proveedor,@idNombreDataRango)
								set @idRangoMapa = SCOPE_IDENTITY();
								insert TblRangoMapaid (idRangoMapa, Latitud,Longuitud,fechaModificacion)
								  SELECT @idRangoMapa, Latitud,Longuitud,getdate() FROM #TBLRangoruta

							END
					ELSE
					BEGIN

							if(exists (SELECT * FROM TblRangoMapa where id_proveedor=@id_proveedor AND idCobertura =@idCobertura and idNombreDataRango =@idNombreDataRango) )
							BEGIN
								   UPDATE TblNombreDataRango set NombreDataRango=@NombreDataRango  WHERE idNombreDataRango = @idNombreDataRango;

								   set @idRangoMapa = (SELECT TOP 1 idRangoMapa FROM TblRangoMapa where id_proveedor=@id_proveedor AND idCobertura =@idCobertura and idNombreDataRango =@idNombreDataRango)
								   UPDATE TblRangoMapaid set fechaBaja = getdate() WHERE idRangoMapa = @idRangoMapa;
								   insert TblRangoMapaid (idRangoMapa, Latitud,Longuitud,fechaModificacion)
								   SELECT @idRangoMapa, Latitud,Longuitud,getdate() FROM #TBLRangoruta
							END
							ELSE BEGIN
								   UPDATE TblNombreDataRango set NombreDataRango=@NombreDataRango  WHERE idNombreDataRango = @idNombreDataRango;
    								insert TblRangoMapa (idCobertura,fechaModificacion,Id_Proveedor,idNombreDataRango)
									values (@idCobertura,getdate(),@id_proveedor,@idNombreDataRango)
									set @idRangoMapa = SCOPE_IDENTITY();
									 insert TblRangoMapaid (idRangoMapa, Latitud,Longuitud,fechaModificacion)
									  SELECT @idRangoMapa, Latitud,Longuitud,getdate() FROM #TBLRangoruta

							END

				   END

				   select @idRangoMapa as idRangoMapa
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerBanner]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC SpObtenerFeed


CREATE PROCEDURE [dbo].[SpObtenerBanner] 

AS

BEGIN


SELECT Id, Descripcion, RutaImagen, Liga FROM BannerMovil



END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerCategorias]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SpBusqueda 'vaso'

CREATE PROCEDURE [dbo].[SpObtenerCategorias]  
	@Id_Pvd int = 0
AS
BEGIN
 IF @Id_Pvd = 0
 BEGIN
	 SELECT c.Id_Categoria, c.Categoria, ISNULL(c.FILE_PATH, '') AS FILE_PATH  FROM Categorias_Productos c 
	 WHERE c.Estatus_Categoria = 1 AND  Id_Categoria IN(SELECT Id_Categoria from Productos_en_Produccion GROUP BY Id_Categoria)
	 ORDER BY c.Categoria
END
ELSE
BEGIN
SELECT c.Id_Categoria, c.Categoria , ISNULL(c.FILE_PATH, '') AS FILE_PATH FROM Categorias_Productos c 
	 WHERE c.Estatus_Categoria = 1 AND  Id_Categoria IN (SELECT Id_Categoria from Productos_en_Produccion where Id_Proveedor = @Id_Pvd)
	 ORDER BY c.Categoria

END

END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerFeed]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC SpObtenerFeed

CREATE PROCEDURE [dbo].[SpObtenerFeed] 

AS

BEGIN




SELECT 1 AS Id,P.Id_Proveedor AS Id_Action, p.Nombre_Proveedor AS Name, pp.pro_imagen AS Image, pp.Pro_titulo + '. '  + pp.Pro_Descripcion AS status, p.FilePath AS profilePic,   GETDATE() -1   AS timestap, 2 AS tipo  , '' AS url    from  [dbo].[Promociones] pp
	INNER JOIN   Proveedores P ON pp.Id_Proveedor = p.Id_Proveedor
UNION 
SELECT 1 AS Id, 1  AS Id_Action, 'LinknRed' AS Name, 'https://scontent-ord1-1.xx.fbcdn.net/hphotos-xlp1/v/t1.0-9/11988197_1015885481775568_7862526127932760331_n.jpg?oh=4a0c2c7754c2a73234b13e3e3a95c35c&oe=56CD98A2' AS Image , 
'Link´n Red es una empresa que esta enfocada en hacer crecer la marca de nuestros clientes bajo el concepto de “La unión, hace la fuerza”, apoyados por un canal de ventas en Internet y exponiendo la marca a mayores segmentos de mercado.' AS Status,
'https://scontent-ord1-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/11138526_937612592936191_3013543209014483137_n.png?oh=13d4a83fb726867f2ce50bb1c63d075e&oe=56895CC6' AS profilePic, GETDATE()  AS timestap,1 AS tipo, 'http://linknred.com/AcercaDe' AS url 

UNION 

SELECT 1 AS Id, 1 AS Id_Action, 'LinknRed' AS Name,  'https://scontent-ord1-1.xx.fbcdn.net/hphotos-xat1/t31.0-8/11140218_937622899601827_3890710263126112963_o.jpg'  AS Image, 
'¿Quieres pertenecer al programa de asesores Link´n Red?, !Tenemos una propuesta muy interesante para TI y Gana dinero desde la comodidad de tu Hogar¡'  AS Status,
'https://scontent-ord1-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/11138526_937612592936191_3013543209014483137_n.png?oh=13d4a83fb726867f2ce50bb1c63d075e&oe=56895CC6' AS profilePic, GETDATE()  AS timestap , 1 AS tipo, 'http://linknred.com/ProgramaAsesores' AS url 

UNION
SELECT Id, Id_Action, Name, Image, ' Producto No ' + CAST( ROW_NUMBER() Over(Order by [Id])  AS VARCHAR(MAX))+ ' con más puntos. ' + Nombre + ' ' + CAST(Puntos AS VARCHAR(MAX)) + ' puntos '  as Status, profilePic, timestap, tipo, url FROM
(SELECT TOP 5  1 AS Id, p.Id AS Id_Action, 'LinknRed' AS Name,  p.Ruta_Img_Principal  AS Image, p.Puntos, p.Nombre ,
 '' AS Status, 
'https://scontent-ord1-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/11138526_937612592936191_3013543209014483137_n.png?oh=13d4a83fb726867f2ce50bb1c63d075e&oe=56895CC6' AS profilePic, GETDATE()  AS timestap , 3 AS tipo, '' AS url FROM Productos_en_Produccion p
WHERE 1 = 1 ORDER BY p.Puntos DESC) AS TABLA
WHERE 1 = 1 ORDER BY timestap asc


END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerLocaciones]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpObtenerLocaciones]
AS BEGIN
SELECT * FROM (
SELECT ROW_NUMBER() Over(Order by P.[Id_Proveedor]) as RowID,  p.Id_Proveedor, p.FilePath,p.Nombre_Proveedor, p.Latitud, p.Longitud, c.Categoria, p.Direccion FROM Proveedores p 
INNER JOIN Categorias_Productos c ON p.Id_Categoria = c.Id_Categoria 
WHERE p.Latitud IS NOT NULL AND p.Longitud IS NOT NULL) AS TABLA
ORDER BY RowID




END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerPedidoHistorico]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpObtenerPedidoHistorico]
@Id_cliente INT
AS
BEGIN

	
	

	select P.id_pedido, PV.Nombre_Proveedor, T.Puntos,  T.PuntosUsados,  T.Total 
	 from [dbo].[PedidosCab] P  
	INNER JOIN Clientes C ON P.id_cliente = C.id_cliente
	INNER JOIN Proveedores PV ON P.Id_Proveedor = PV.Id_Proveedor
	INNER JOIN (SELECT Id_cliente, Id_pedido,  TOTAL.Puntos,  TOTAL.PuntosUsados,  TOTAL.Total  FROM (
	SELECT   Id_Cliente, Id_Pedido, SUM(Puntos) AS Puntos, SUM(PuntosUsados) AS PuntosUsados,  SUM(Precio * Cantidad) AS Total  FROM PedidosNuevo	
	GROUP BY Id_Cliente, Id_Pedido) AS TOTAL )  as T  ON P.Id_Cliente = T.Id_Cliente AND P.Id_Pedido = T.Id_Pedido
	WHERE P.id_cliente = @id_cliente	
	Order by P.id_pedido
END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerProductos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SpObtenerProductos 0,0,0,0,26
CREATE PROCEDURE [dbo].[SpObtenerProductos]
 @Promocion INT = 0, 
 @Id  INT = 0,
 @Id_Categoria INT  = 0,
 @Categoria_Aleatoria INT  = 0,
 @Id_Pvd INT = 0
 AS
BEGIN

IF @Promocion = 0 AND @Id = 0 AND @Id_Categoria = 0 AND @Categoria_Aleatoria = 0 AND @Id_Pvd = 0
BEGIN

  SELECT P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
	  ,PV.Correo AS ProveedorCorreo
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
  INNER JOIN Proveedores PV ON P.Id_Proveedor = PV.Id_Proveedor  
  UNION ALL

 
   SELECT     
     S.Id_Servicio AS Id
      ,S.Nombre_Servicio AS Nombre     
      ,'' AS Tipo_Producto	  
      ,''  AS  SubTipo_Producto
      ,'' AS clave
      ,S.Precio
      ,'' AS Marca
      ,S.Proveedor
	  ,S.Descripcion
      ,'' AS Usuario_Alta
      ,GETDATE() AS Fecha_Alta
	  ,GETDATE() AS Ultima_Modificacion
      ,S.Img as Nom_Img_Principal
      ,S.Img AS Ruta_Img_Principal
      ,S. Estatus
      ,S.[Id_Categoria]
      ,0 AS [Id_Tipo]
      , 0 AS [Id_Subtipo]
      ,'' AS [Url_QRcode]
      ,S.Folder_Path AS [Ruta_Carpeta]
      ,0 AS [Existencia]
      ,0 AS [Descuento]
      ,0 AS [Id_Proveedor]
      ,0 AS [Id_Marca]
      ,ISNULL(S.[Puntos], 0) AS Puntos
	  ,S.Categoria
	  , ''AS ProveedorCorreo
  FROM [dbo].[Servicios_nuevos] S
  



  END
  ELSE IF  @Promocion = 1
  BEGIN 
	SELECT
		TOP 10
	   P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
	  ,PV.Correo AS ProveedorCorreo
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
   INNER JOIN Proveedores PV ON P.Id_Proveedor = PV.Id_Proveedor  
	WHERE 1 = 1
	ORDER BY P.Puntos DESC
  END
   ELSE IF  @Id <> 0

  BEGIN 
  SELECT P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,PV.Nombre_Proveedor
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
	  ,PV.FilePath AS PV_FilePath
	  ,PV.Correo AS ProveedorCorreo
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
  INNER JOIN Proveedores PV ON P.Id_Proveedor = PV.Id_Proveedor  
  WHERE P.Id = @Id

  UNION ALL

      SELECT     
     S.Id_Servicio AS Id
      ,S.Nombre_Servicio AS Nombre     
      ,'' AS Tipo_Producto	  
      ,''  AS  SubTipo_Producto
      ,'' AS clave
      ,S.Precio
      ,'' AS Marca
      ,S.Proveedor
	  ,S.Descripcion
      ,'' AS Usuario_Alta
      ,GETDATE() AS Fecha_Alta
	  ,GETDATE() AS Ultima_Modificacion
      ,S.Img as Nom_Img_Principal
      ,S.Img AS Ruta_Img_Principal
      ,S. Estatus
      ,S.[Id_Categoria]
      ,0 AS [Id_Tipo]
      , 0 AS [Id_Subtipo]
      ,'' AS [Url_QRcode]
      ,S.Folder_Path AS [Ruta_Carpeta]
      ,0 AS [Existencia]
      ,0 AS [Descuento]
      ,0 AS [Id_Proveedor]
      ,0 AS [Id_Marca]
      ,ISNULL(S.[Puntos], 0) AS Puntos
	  ,S.Categoria
	  ,PV.FilePath AS PV_FilePath
	  ,'' AS ProveedorCorreo
  FROM [dbo].[Servicios_nuevos] S
   INNER JOIN Proveedores PV ON S.Proveedor = PV.Nombre_Proveedor 
   WHERE S.Id_Servicio = @Id 


  
  END

  ELSE IF  @Id_Categoria <> 0

  BEGIN 
  SELECT P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
	  ,PV.Correo AS ProveedorCorreo
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto 
  INNER JOIN Proveedores PV ON P.Id_Proveedor = PV.Id_Proveedor  
  WHERE P.Id_Categoria = @Id_Categoria

   UNION ALL


   SELECT     
     S.Id_Servicio AS Id
      ,S.Nombre_Servicio AS Nombre     
      ,'' AS Tipo_Producto	  
      ,''  AS  SubTipo_Producto
      ,'' AS clave
      ,S.Precio
      ,'' AS Marca
      ,S.Proveedor
	  ,S.Descripcion
      ,'' AS Usuario_Alta
      ,GETDATE() AS Fecha_Alta
	  ,GETDATE() AS Ultima_Modificacion
      ,S.Img as Nom_Img_Principal
      ,S.Img AS Ruta_Img_Principal
      ,S. Estatus
      ,S.[Id_Categoria]
      ,0 AS [Id_Tipo]
      , 0 AS [Id_Subtipo]
      ,'' AS [Url_QRcode]
      ,S.Folder_Path AS [Ruta_Carpeta]
      ,0 AS [Existencia]
      ,0 AS [Descuento]
      ,0 AS [Id_Proveedor]
      ,0 AS [Id_Marca]
      ,ISNULL(S.[Puntos], 0) AS Puntos
	  ,S.Categoria
	  ,'' AS ProveedorCorreo
  FROM [dbo].[Servicios_nuevos] S
  WHERE S.Id_Categoria = @Id_Categoria

  END
  ELSE IF  @Categoria_Aleatoria = 1

  BEGIN 
  SELECT 
		TOP 10
		P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
	  ,PV.Correo AS ProveedorCorreo
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
  INNER JOIN Proveedores PV ON P.Id_Proveedor = PV.Id_Proveedor  
  WHERE P.Id_Categoria IN ( SELECT TOP 1 id_categoria FROM Productos_en_Produccion
ORDER BY NEWID())

  END
   ELSE IF  @Id_Pvd <> 0

  BEGIN 

  DECLARE @NAME VARCHAR(MAX)

SELECT @NAME = Nombre_Proveedor FROM PROVEEDORES WHERE ID_PROVEEDOR  = @Id_Pvd
  SELECT P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
	  ,PV.Correo AS ProveedorCorreo
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
   INNER JOIN Proveedores PV ON P.Id_Proveedor = PV.Id_Proveedor  
  WHERE P.Id_Proveedor = @Id_Pvd
  UNION

  SELECT     
     S.Id_Servicio AS Id
      ,S.Nombre_Servicio AS Nombre     
      ,'' AS Tipo_Producto	  
      ,''  AS  SubTipo_Producto
      ,'' AS clave
      ,S.Precio
      ,'' AS Marca
      ,S.Proveedor
	  ,S.Descripcion
      ,'' AS Usuario_Alta
      ,GETDATE() AS Fecha_Alta
	  ,GETDATE() AS Ultima_Modificacion
      ,S.Img as Nom_Img_Principal
      ,S.Img AS Ruta_Img_Principal
      ,S. Estatus
      ,S.[Id_Categoria]
      ,0 AS [Id_Tipo]
      , 0 AS [Id_Subtipo]
      ,'' AS [Url_QRcode]
      ,S.Folder_Path AS [Ruta_Carpeta]
      ,0 AS [Existencia]
      ,0 AS [Descuento]
      ,0 AS [Id_Proveedor]
      ,0 AS [Id_Marca]
      ,ISNULL(S.[Puntos], 0) AS Puntos
	  ,S.Categoria
	  ,'' AS ProveedorCorreo
  FROM [dbo].[Servicios_nuevos] S
  WHERE S.Proveedor = @NAME


  

  END

END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerProductosProveedor]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SpObtenerProductosProveedor 0,1, 470,1

--select * from productos_en_produccion where id_subtipo = 470

CREATE PROCEDURE [dbo].[SpObtenerProductosProveedor] 
 @Id_Pvd INT = 0,
 @Show_All INT = 0,
 @Id_Subtipo INT = 0,
 @Page INT =0
 AS
BEGIN
DECLARE @FIN  INT
DECLARE @INI INT 
DECLARE @SIZE  INT ;
DECLARE @NAME VARCHAR(MAX)

SELECT @NAME = Nombre_Proveedor FROM PROVEEDORES WHERE ID_PROVEEDOR  = @Id_Pvd

IF(@Show_All = 0)
BEGIN
   
  SELECT TOP 2 * FROM (
  SELECT TOP 10
	 1 AS RowID
	 ,P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
  WHERE P.Id_Proveedor = @Id_Pvd AND  P.[Id] IN (SELECT Id_Producto FROM ItemPromocion WHERE Id_Proveedor = @Id_Pvd)


  UNION 
  SELECT TOP 10
	  1 AS RowID
	  ,P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
  WHERE P.Id_Proveedor = @Id_Pvd 
 
  UNION

  SELECT  TOP 10
      1 AS RowID
     ,S.Id_Servicio AS Id
      ,S.Nombre_Servicio AS Nombre     
      ,'' AS Tipo_Producto	  
      ,''  AS  SubTipo_Producto
      ,'' AS clave
      ,S.Precio
      ,'' AS Marca
      ,S.Proveedor
	  ,S.Descripcion
      ,'' AS Usuario_Alta
      ,GETDATE() AS Fecha_Alta
	  ,GETDATE() AS Ultima_Modificacion
      ,S.Img as Nom_Img_Principal
      ,S.Img AS Ruta_Img_Principal
      ,S. Estatus
      ,S.[Id_Categoria]
      ,0 AS [Id_Tipo]
      , 0 AS [Id_Subtipo]
      ,'' AS [Url_QRcode]
      ,S.Folder_Path AS [Ruta_Carpeta]
      ,0 AS [Existencia]
      ,0 AS [Descuento]
      ,0 AS [Id_Proveedor]
      ,0 AS [Id_Marca]
      ,ISNULL(S.[Puntos], 0) AS Puntos
	  ,S.Categoria
  FROM [dbo].[Servicios_nuevos] S
   WHERE S.Proveedor = @NAME 
  ORDER BY S.[Puntos] DESC  
  ) AS TABLA

  
 

  END
  ELSE
  BEGIN
  IF @Id_Subtipo = 0
  BEGIN
  SET @Id_Subtipo = null
  END

  IF @Id_Pvd = 0
  BEGIN
  SET @Id_Pvd = null
  END

	
	SET @SIZE = 10
	SET @INI = ((@Page - 1) * @SIZE) + 1
	SET @FIN = @Page * @SIZE
  SELECT * FROM (
  SELECT  ROW_NUMBER() Over(Order by Id) as RowID, *  FROM
  ( SELECT    
	 P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,ISNULL(P.[Puntos], 0) AS Puntos
	  ,C.Categoria
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
  WHERE P.Id_Proveedor = ISNULL(@Id_Pvd, P.Id_Proveedor)  AND P.Id_Subtipo = ISNULL(@Id_Subtipo, P.Id_Subtipo)

  UNION
    SELECT     
     S.Id_Servicio AS Id
      ,S.Nombre_Servicio AS Nombre     
      ,'' AS Tipo_Producto	  
      ,''  AS  SubTipo_Producto
      ,'' AS clave
      ,S.Precio
      ,'' AS Marca
      ,S.Proveedor
	  ,S.Descripcion
      ,'' AS Usuario_Alta
      ,GETDATE() AS Fecha_Alta
	  ,GETDATE() AS Ultima_Modificacion
      ,S.Img as Nom_Img_Principal
      ,S.Img AS Ruta_Img_Principal
      ,S. Estatus
      ,S.[Id_Categoria]
      ,0 AS [Id_Tipo]
      , 0 AS [Id_Subtipo]
      ,'' AS [Url_QRcode]
      ,S.Folder_Path AS [Ruta_Carpeta]
      ,0 AS [Existencia]
      ,0 AS [Descuento]
      ,0 AS [Id_Proveedor]
      ,0 AS [Id_Marca]
      ,ISNULL(S.[Puntos], 0) AS Puntos
	  ,S.Categoria
  FROM [dbo].[Servicios_nuevos] S
   WHERE S.Proveedor = @NAME 

  
  ) AS TABLA
  ) AS TABLAGRAL
  WHERE RowID >= @INI and RowID <= @FIN

  END
END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerProductosxSKU]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SpObtenerProductos 0,0,0,0,26
CREATE PROCEDURE [dbo].[SpObtenerProductosxSKU]
 @SKU VARCHAR(150) 
 AS
BEGIN


  SELECT P.[Id]
      ,P.[Nombre]     
      ,T.Tipo_Producto
      ,S.SubTipo_Producto
      ,P.[clave]
      ,P.[Precio]
      ,P.[Marca]
      ,P.[Proveedor]
      ,P.[Descripcion]
      ,P.[Usuario_Alta]
      ,P.[Fecha_Alta]
      ,P.[Ultima_Modificacion]
      ,P.[Nom_Img_Principal]
      ,P.[Ruta_Img_Principal]
      ,P.[Estatus]
      ,P.[Id_Categoria]
      ,P.[Id_Tipo]
      ,P.[Id_Subtipo]
      ,P.[Url_QRcode]
      ,P.[Ruta_Carpeta]
      ,P.[Existencia]
      ,P.[Descuento]
      ,P.[Id_Proveedor]
      ,P.[Id_Marca]
      ,P.[Puntos]
	  ,C.Categoria
  FROM [dbo].[Productos_en_Produccion] P
  INNER JOIN Categorias_Productos C ON p.Id_Categoria = c.Id_Categoria
  INNER JOIN Tipo_Productos T ON T.Id_Categoria = C.Id_Categoria  AND P.Id_Tipo = t.Id_Tipo_Producto
  INNER JOIN SubTipo_Productos S ON p.Id_Subtipo = S.Id_SubTipo_Producto
  WHERE P.[clave] = @SKU 
END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerProductTipo]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SpBusqueda 'vaso'

CREATE PROCEDURE [dbo].[SpObtenerProductTipo]  
@Id_Categoria int = 0,
@Id_Pvd int = 0

AS
BEGIN
 
 IF @Id_Pvd = 0
 BEGIN
	 SELECT Id_Categoria, Id_Tipo_Producto, Tipo_Producto FROM Tipo_Productos 
	WHERE Id_Categoria = @Id_Categoria AND  Id_Tipo_Producto IN(SELECT Id_Tipo from Productos_en_Produccion where 1 = 1 GROUP BY Id_Tipo)
END
ELSE
BEGIN
	SELECT Id_Categoria, Id_Tipo_Producto, Tipo_Producto FROM Tipo_Productos 
	WHERE Id_Categoria = @Id_Categoria AND  Id_Tipo_Producto IN(SELECT Id_Tipo from Productos_en_Produccion where Id_Proveedor = @Id_Pvd)
END
END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerPromocionesProveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpObtenerPromocionesProveedores]
@Id_Proveedor INT
AS

BEGIN

SELECT [Id]
      ,[Titulo]
      ,[Descripcion]
      ,[Img]
      ,[Proveedor]
      ,[Fecha]
      ,[Estatus]
      ,[Img_Name]
      ,[Id_Proveedor]
  FROM [dbo].[Promociones_Proveedores]
  WHERE Id_Proveedor = @Id_Proveedor

END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerProveedorDetalle]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SpObtenerProveedorDetalle 26
CREATE PROCEDURE [dbo].[SpObtenerProveedorDetalle]
@Id_Proveedor int
AS
BEGIN
SELECT P.Id_Proveedor
      ,P.Nombre_Proveedor
      ,P.Correo
      ,P.Direccion
      ,P.Ciudad
      ,P.Estado
      ,P.Pais
      ,P.Tipo_Proveedor
      ,P.Cuota_Proveedor
      ,P.Usuario_Alta
      ,P.Fecha_Alta
      ,P.Usuario_Act
      ,P.Fecha_Act
      ,P.Usuario_Baja
      ,P.Fecha_Baja
      ,P.Estatus_Proveedor
      ,P.Descuento
      ,P.FileName
      ,P.FilePath
      ,P.Password
      ,P.LastLoginDate
      ,P.FolderPath
      ,P.Id_Categoria
	  , C.Categoria
	  ,I.Mision
	  ,I.Vision
	  ,I.Contacto
	  ,I.Descripcion
	  ,I.Origen_Empresa
	  ,I.Fecha
	  ,C.FILE_PATH AS C_FilePath
	  ,Telefono
	  ,Website
  FROM dbo.Proveedores P
LEFT JOIN  dbo.Categorias_Productos C ON P.Id_Categoria = C.Id_Categoria AND C.Estatus_Categoria = 1
LEFT JOIN Proveedor_Info I ON p.Id_Proveedor = I.Id_Proveedor 
WHERE p.Id_Proveedor = @Id_Proveedor

END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerProveedores]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpObtenerProveedores]
@Id_Categoria INT,
@Buscar VARCHAR(MAX)
AS
BEGIN

IF @Buscar = '@@@'
BEGIN
	SET @Buscar = null
END
IF @Id_Categoria = 0
BEGIN
SELECT P.Id_Proveedor
      ,P.Nombre_Proveedor
      ,P.Correo
      ,P.Direccion
      ,P.Ciudad
      ,P.Estado
      ,P.Pais
      ,P.Tipo_Proveedor
      ,P.Cuota_Proveedor
      ,P.Usuario_Alta
      ,P.Fecha_Alta
      ,P.Usuario_Act
      ,P.Fecha_Act
      ,P.Usuario_Baja
      ,P.Fecha_Baja
      ,P.Estatus_Proveedor
      ,P.Descuento
      ,P.FileName
      ,P.FilePath
      ,P.Password
      ,P.LastLoginDate
      ,P.FolderPath
      ,P.Id_Categoria
	  , C.Categoria

  FROM dbo.Proveedores P

LEFT JOIN  dbo.Categorias_Productos C ON P.Id_Categoria = C.Id_Categoria AND C.Estatus_Categoria = 1
WHERE   C.Categoria LIKE '%' + ISNULL(@Buscar, C.Categoria) + '%' OR
		P.Nombre_Proveedor LIKE '%' + ISNULL(@Buscar, P.Nombre_Proveedor)+ '%' OR
		P.Tipo_Proveedor LIKE '%' + ISNULL(@Buscar, P.Tipo_Proveedor)+ '%'



END
ELSE
BEGIN

	SELECT P.Id_Proveedor
      ,P.Nombre_Proveedor
      ,P.Correo
      ,P.Direccion
      ,P.Ciudad
      ,P.Estado
      ,P.Pais
      ,P.Tipo_Proveedor
      ,P.Cuota_Proveedor
      ,P.Usuario_Alta
      ,P.Fecha_Alta
      ,P.Usuario_Act
      ,P.Fecha_Act
      ,P.Usuario_Baja
      ,P.Fecha_Baja
      ,P.Estatus_Proveedor
      ,P.Descuento
      ,P.FileName
      ,P.FilePath
      ,P.Password
      ,P.LastLoginDate
      ,P.FolderPath
      ,P.Id_Categoria
	  , C.Categoria
  FROM dbo.Proveedores P
LEFT JOIN  dbo.Categorias_Productos C ON P.Id_Categoria = C.Id_Categoria AND C.Estatus_Categoria = 1
WHERE  C.Id_Categoria = @Id_Categoria  AND P.Nombre_Proveedor LIKE '%' + ISNULL(@Buscar, P.Nombre_Proveedor)+ '%'


END


END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerProveedoresxCategorias]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpObtenerProveedoresxCategorias]
@Id_Categoria INT = 0  

AS
BEGIN
 IF @Id_Categoria = 0
 BEGIN
  select c.Id_Categoria, c.Categoria, p.Id_Proveedor, p.Nombre_Proveedor, p.FilePath  from proveedores p INNER JOIN Categorias_Productos c ON p.Id_Categoria = c.Id_Categoria WHERE c.Estatus_Categoria = 1
 ORDER BY c.Categoria
 END
 ELSE
 select c.Id_Categoria, c.Categoria, p.Id_Proveedor, p.Nombre_Proveedor, p.FilePath  from proveedores p INNER JOIN Categorias_Productos c ON p.Id_Categoria = c.Id_Categoria 
 WHERE c.Estatus_Categoria = 1 AND c.Id_Categoria = @Id_Categoria
 ORDER BY c.Categoria 
END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerPuntos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpObtenerPuntos]
@Id_Cliente INT = 0
AS
BEGIN
DECLARE @PuntosConfirmados INT, @PuntosUsados INT, @Total INT, @Cliente INT
	
	
	SELECT @PuntosConfirmados = ISNULL(SUM(ISNULL(Puntos,0)),0) from PedidosNuevo
	WHERE Estatus_Proveedor = 'Confirmado'
	AND id_cliente = @id_cliente

	SELECT @PuntosUsados = ISNULL(SUM(ISNULL(PuntosUsados,0)),0) from PedidosNuevo
	WHERE id_cliente = @id_cliente


	SET  @Total = ( @PuntosConfirmados  - @PuntosUsados )

	IF(@Total < 0 )
	BEGIN
	SET @Total = 0

	
	

	END
	SELECT @Cliente = Id_Cliente FROM Clientes WHERE Id_Cliente = @Id_Cliente

	SELECT @Total AS Total, @PuntosUsados AS PuntosUsados,  @Cliente AS Id_Cliente

END
GO
/****** Object:  StoredProcedure [dbo].[SpObtenerSubProductTipo]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SpBusqueda 'vaso'

CREATE PROCEDURE [dbo].[SpObtenerSubProductTipo]  
@Id_ProductoTipo int = 0,
@Id_Pvd int = 0
AS
BEGIN
IF  @Id_Pvd = 0
BEGIN
	SELECT Id_Categoria, Id_Tipo_Producto ,Id_SubTipo_Producto, SubTipo_Producto From [dbo].[SubTipo_Productos] 
	WHERE Id_Tipo_Producto = @Id_ProductoTipo AND  Id_SubTipo_Producto IN(SELECT Id_Subtipo from Productos_en_Produccion where 1 = 1 GROUP BY Id_Subtipo)
END
ELSE
BEGIN
	SELECT Id_Categoria, Id_Tipo_Producto ,Id_SubTipo_Producto, SubTipo_Producto From [dbo].[SubTipo_Productos] 
	WHERE Id_Tipo_Producto = @Id_ProductoTipo AND  Id_SubTipo_Producto IN(SELECT Id_Subtipo from Productos_en_Produccion where Id_Proveedor = @Id_Pvd)

END
END
GO
/****** Object:  StoredProcedure [dbo].[SpObtieneAParatos]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpObtieneAParatos]
AS
SELECT [Id]
      ,[Gcm_Regid]
      ,[Plataforma]
      ,[Name]
      ,[Email]
      ,[Created_at]
  FROM [dbo].[GCM_Usuarios]
GO
/****** Object:  StoredProcedure [dbo].[SpObtieneCliente]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpObtieneCliente]
@Id_Cte int = 0
AS
BEGIN

SELECT [Id_Cliente]
      ,[Nombre]
      ,[Apellidos]
      ,[Email]
      ,[Password]
      ,[Direccion]
      ,[Colonia]
      ,[Ciudad]
      ,[Estado]
      ,[Pais]
      ,[Codigo_Postal]
      ,[Sexo]
      ,[Fecha_Nacimiento]
      ,[Img_Nombre]
      ,[Img_Ruta]
      ,[Estatus]
      ,[Fecha_Registro]
      ,[Ultima_Actualizacion]
      ,[Fecha_Baja]
      ,[Recibir_Notificaciones]
      ,[Perfil]
      ,[Id_Perfil]
      ,[LastLoginDate]
      ,[Avatar]
      ,[Tel_Celular]
      ,[Tel_Casa]
      ,[Tel_Oficina]
  FROM [dbo].[Clientes]
  WHERE Id_Cliente = @Id_Cte

  END
GO
/****** Object:  StoredProcedure [dbo].[SpPagos_Insertar]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpPagos_Insertar]
@UserId INT
,@PaypalPaymentId VARCHAR(MAX)
,@Create_time VARCHAR(MAX)
,@Update_time VARCHAR(MAX)= NULL
,@State  VARCHAR(50)
,@Amount DECIMAL (6,2)
,@Currency VARCHAR(3)
AS
BEGIN
INSERT INTO [dbo].[Pagos]
           ([UserId]
           ,[PaypalPaymentId]
           ,[Create_time]
           ,[Update_time]
           ,[State]
           ,[Amount]
           ,[Currency])
     VALUES
           (@UserId
			,@PaypalPaymentId
			,@Create_time
			,@Update_time
			,@State
			,@Amount
			,@Currency
			)

			Select  @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[SpPedidos_Insertar]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpPedidos_Insertar]
	@Id_Cliente int
	,@Id_Proveedor int
	,@Cliente VARCHAR(MAX) = NULL 
	,@Direccion1 VARCHAR(max) = NULL
	,@Direccion2 VARCHAR(max) = NULL
	,@Ciudad VARCHAR(max) = NULL
	,@Estado  VARCHAR(MAX) = NULL
	,@Zip VARCHAR(MAX) =NULL
	,@Telefono VARCHAR(MAX) =NULL
	,@Envio DECIMAL(9,2) =NULL
AS
BEGIN


INSERT INTO [dbo].[PedidosCab]
			   ([Id_Cliente]
			    ,Id_Proveedor
			    ,Fecha
				,Cliente 
				,Direccion1
				,Direccion2
				,Ciudad
				,Estado
				,Zip
				,Telefono
				 ,CostoEnvio
			 )


		 VALUES
			   (@Id_Cliente
			   ,@Id_Proveedor
			   ,GETDATE()
			   ,'X' 
				,'X'
				,'X'
				,'X'
				,'X'
				,'X'
				,'X'
				,0
			  )
			  SELECT SCOPE_IDENTITY() 

END
GO
/****** Object:  StoredProcedure [dbo].[SpPedidosDet_Insertar]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpPedidosDet_Insertar]	
	@Id_Cliente int
	,@Id_Canasta int
	,@Id_Producto int
	,@Precio decimal(18,0)
	,@Cantidad int
	,@Descuento int
	,@Puntos int	
	,@Estatus_Cliente nvarchar(50)
	,@FormaDePago nvarchar(50)
	,@Comentarios nvarchar(50)
	,@Id_Proveedor int
	,@Estatus_Proveedor nvarchar(50)
	,@PuntosUsados int
AS
BEGIN





	INSERT INTO [dbo].[PedidosNuevo]
			   (
			   [Id_Cliente]
			   ,[Id_Canasta]
			   ,[Id_Producto]
			   ,[Precio]
			   ,[Cantidad]
			   ,[Descuento]
			   ,[Puntos]
			   ,[Fecha]
			   ,[Estatus_Cliente]
			   ,[FormaDePago]
			   ,[Comentarios]
			   ,[Id_Proveedor]
			   ,[Estatus_Proveedor]
			   ,[PuntosUsados])
		 VALUES
			   (
			   @Id_Cliente
			   ,@Id_Canasta 
			   ,@Id_Producto
			   ,@Precio
			   ,@Cantidad 
			   ,@Descuento
			   ,@Puntos 
			   ,GETDATE()
			   ,@Estatus_Cliente 
			   ,@FormaDePago
			   ,@Comentarios 
			   ,@Id_Proveedor 
			   ,@Estatus_Proveedor
			   ,@PuntosUsados)

			   SELECT 1

END
GO
/****** Object:  StoredProcedure [dbo].[SpProductos_Insertar]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpProductos_Insertar]
@idiomaproduc int = null,
@esVerdadero VARCHAR(MAX) = null,
@HasImage bit = 0,
@Id INT = null,
@Nombre VARCHAR(MAX) = null,
--@Categoria VARCHAR(MAX) = null,
--@Tipo VARCHAR(MAX) = null,
--@Subtipo VARCHAR(MAX) = null,
@clave VARCHAR(MAX) = null,
@Precio decimal(16,2),
--@Proveedor VARCHAR(MAX) = null,
@Descripcion VARCHAR(MAX) = null,
@Usuario_Alta VARCHAR(MAX) = null,
@Nom_Img_Principal VARCHAR(MAX) = null,
@Ruta_Img_Principal VARCHAR(MAX) = null,
@Estatus int = null,
@Id_Categoria int = null,
@Id_Tipo int = null,
@Id_Subtipo int = null,
@Ruta_Carpeta VARCHAR(MAX) = null,
@Existencia int = null,
@Descuento int = null,
@Id_Proveedor int = null, 
@Puntos int = null, 
@Weight_ VARCHAR(MAX) = null, 
@Largo VARCHAR(MAX) = null, 
@Width VARCHAR(MAX) = null, 
@Height VARCHAR(MAX) = null, 
@tipoEnvio int = null, 
--@zonaenvio int = null, 
@ETA int = null, 
--@Costoenvio VARCHAR(MAX) = null,
@idOrigen int = null,
@RecogerTienda int = null
,@tblrutasproducto typeCoberturaProducto READONLY,
@idNombreDataRango int = null

AS
BEGIN

 	  IF OBJECT_ID('tempdb..#tblrutasproducto') IS NOT NULL
		DROP TABLE #tblrutasproducto
           CREATE TABLE #tblrutasproducto
					( 	[idCobertura] [int] NULL,
	                    [Nombre] [varchar](max) NULL
					);  
					INSERT INTO #tblrutasproducto 
				    SELECT  idCobertura,Nombre
			        FROM @tblrutasproducto;

IF(@esVerdadero = 'true')
BEGIN
set @Ruta_Img_Principal = 'Productos_Produccion/' + CONVERT(VARCHAR(MAX),@Id_Proveedor) + '/' + @Nom_Img_Principal
set @Ruta_Carpeta = 'Productos_Produccion/' + CONVERT(VARCHAR(MAX),@Id_Proveedor) + '/' + CONVERT(VARCHAR(MAX),@id) +'/'
--Si el producto no existe se inserta en la tabla de productos, tabla de temporales y tabla de idioma
     IF(NOT EXISTS (select 1 from Productos_en_Produccion WHERE id= @id) )
	    BEGIN
		    if(NOT EXISTS (select 1 from Productos_en_Produccion WHERE clave = @clave and Id_Proveedor = @Id_Proveedor))
			BEGIN
				INSERT INTO Productos_en_Produccion(Nombre,clave,Usuario_Alta,Fecha_Alta,Nom_Img_Principal,Ruta_Img_Principal,Estatus,Id_Categoria,Id_Tipo,Id_Subtipo,Ruta_Carpeta,Existencia,Descuento,Id_Proveedor, Weight_, Largo, Width, Height, tipoEnvio, ETA,idOrigen,RecogerTienda) 
				VALUES(@Nombre,@clave,@Usuario_Alta,GETDATE(),@Nom_Img_Principal,@Ruta_Img_Principal,@Estatus,@Id_Categoria,@Id_Tipo,@Id_Subtipo,@Ruta_Carpeta,@Existencia,@Descuento,@Id_Proveedor, @Weight_, @Largo, @Width, @Height, @tipoEnvio, @ETA,@idOrigen,@RecogerTienda)
			
			     Select @id = SCOPE_IDENTITY()

				 INSERT INTO TblIdiomaProductos (id_Idioma,id_Tbl,Tabla,IdiomaNombre, IdiomaDescripcion,M_Precio,M_Puntos)
				 values (@idiomaproduc,@id,'Productos_en_Produccion',@Nombre,@Descripcion,@Precio,@Puntos)

				 set @Ruta_Img_Principal = 'Productos_Produccion/' + CONVERT(VARCHAR(MAX),@Id_Proveedor) + '/' + CONVERT(VARCHAR(MAX),@id) +'/'+ @Nom_Img_Principal


				 update Productos_en_Produccion set Ruta_Carpeta = 'Productos_Produccion/' + CONVERT(VARCHAR(MAX),@Id_Proveedor) + '/' + CONVERT(VARCHAR(MAX),@id) +'/',
				                                    Ruta_Img_Principal = @Ruta_Img_Principal
				 where id = @id

				 INSERT INTO Productos_en_ProduccionTem(Id_Producto,Nombre,Descripcion,Fecha_Alta,Nom_Img_Principal,Ruta_Img_Principal,idIdioma) 
				 VALUES(@id,@Nombre,@Descripcion,GETDATE(),@Nom_Img_Principal,@Ruta_Img_Principal,@idiomaproduc)

					IF(@tipoEnvio = 1 or @tipoEnvio = 3)
					BEGIN
				    set @idNombreDataRango = (SELECT idNombreDataRango FROM Proveedores_Sucursales where Id= @idOrigen)
					INSERT TBLCoberturaProducto (Id_Producto,idCobertura,idNombreDataRango,fechaModificacion)
					SELECT @id,idCobertura, @idNombreDataRango ,GETDATE() FROM #tblrutasproducto
					END
			 END
			END
        END
        ELSE
-- si el producto si existe se actualizan las tablas de Productos_En_Produccion y Productos_En_Produccion
        BEGIN
			   if(EXISTS (select * from TblIdiomaProductos where Tabla = 'Productos_en_Produccion' and id_Tbl = @id and id_Idioma = @idiomaproduc))
			   BEGIN
					UPDATE TblIdiomaProductos set M_Precio = @Precio, M_Puntos = @Puntos where Tabla = 'Productos_en_Produccion' and id_Tbl = @id and id_Idioma = @idiomaproduc 

					if(@Nom_Img_Principal = null or @Nom_Img_Principal = '')
					BEGIN
					  set @Nom_Img_Principal  = (select Nom_Img_Principal from Productos_en_Produccion where Id = @id)
					  set @Ruta_Img_Principal = 'Productos_Produccion/' + CONVERT(VARCHAR(100),@Id_Proveedor)  +'/'+ @Nom_Img_Principal
					END

					  if(EXISTS (select * from Productos_en_ProduccionTem where  Id_Producto = @id and idIdioma = @idiomaproduc))
					    BEGIN
							Update Productos_en_ProduccionTem SET
							Nombre = @Nombre,Descripcion = @Descripcion, ValGaleria = null, ComentarioVal = null,Fecha_Alta= getdate()  WHERE Id_Producto = @Id and idIdioma = @idiomaproduc
						END
					    ELSE BEGIN
					         INSERT INTO Productos_en_ProduccionTem(Id_Producto,Nombre,Descripcion,Fecha_Alta,Nom_Img_Principal,Ruta_Img_Principal,idIdioma) 
							 VALUES(@id,@Nombre,@Descripcion,GETDATE(),@Nom_Img_Principal,@Ruta_Img_Principal,@idiomaproduc)
					    END

			   END
			   ELSE
			   BEGIN
       						 INSERT INTO TblIdiomaProductos (id_Idioma,id_Tbl,Tabla,IdiomaNombre, IdiomaDescripcion,M_Precio,M_Puntos)
							 values (@idiomaproduc,@id,'Productos_en_Produccion',@Nombre,@Descripcion,@Precio,@Puntos)

							 if(@Nom_Img_Principal = null or @Nom_Img_Principal = '')
					BEGIN
					  set @Nom_Img_Principal  = (select Nom_Img_Principal from Productos_en_Produccion where Id = @id)
					  set @Ruta_Img_Principal = 'Productos_Produccion/' + CONVERT(VARCHAR(100),@Id_Proveedor)  +'/'+ @Nom_Img_Principal
					END

					    if(EXISTS (select * from Productos_en_ProduccionTem where  Id_Producto = @id and idIdioma = @idiomaproduc))
					    BEGIN
							Update Productos_en_ProduccionTem SET
							Nombre = @Nombre,Descripcion = @Descripcion, ValGaleria = null, ComentarioVal = null,Fecha_Alta= getdate()  WHERE Id_Producto = @Id and idIdioma = @idiomaproduc
						END
					    ELSE BEGIN
					         INSERT INTO Productos_en_ProduccionTem(Id_Producto,Nombre,Descripcion,Fecha_Alta,Nom_Img_Principal,Ruta_Img_Principal,idIdioma) 
							 VALUES(@id,@Nombre,@Descripcion,GETDATE(),@Nom_Img_Principal,@Ruta_Img_Principal,@idiomaproduc)
					    END
			   END


    IF(@HasImage = 1)
    BEGIN
	 	    Update Productos_En_Produccion SET
                    Descuento = @Descuento,
                    Existencia = @Existencia, Id_Categoria = @Id_Categoria, Id_Tipo = @Id_Tipo,
                    Id_SubTipo = @Id_Subtipo, idOrigen = @idOrigen,
					Ruta_Carpeta = 'Productos_Produccion/' +CONVERT(VARCHAR(MAX),@Id_Proveedor) + '/' +CONVERT(VARCHAR(MAX),@id) +'/',
                    Weight_ = @Weight_, Largo = @Largo, Width = @Width, Height = @Height, tipoEnvio = @tipoEnvio, ETA = @ETA, RecogerTienda=@RecogerTienda  WHERE ID = @Id

			Update Productos_en_ProduccionTem SET
                    Nombre = @Nombre, Descripcion = @Descripcion,Nom_Img_Principal = @Nom_Img_Principal,Ruta_Img_Principal = 'Productos_Produccion/' + CONVERT(VARCHAR(100),@Id_Proveedor) + '/' + CONVERT(NVARCHAR(MAX),@id) +'/'+ @Nom_Img_Principal,ValGaleria = null, ComentarioVal = null,Fecha_Alta= getdate()
                    WHERE Id_Producto = @Id and idIdioma = @idiomaproduc 
	END
	ELSE
	BEGIN
 					Update Productos_En_Produccion SET
									 Descuento = @Descuento,
									Existencia = @Existencia,
									 Id_Categoria = @Id_Categoria, Id_Tipo = @Id_Tipo,
									Id_SubTipo = @Id_Subtipo, idOrigen = @idOrigen,
									Ruta_Carpeta = 'Productos_Produccion/' + CONVERT(VARCHAR(MAX),@Id_Proveedor) + '/' + CONVERT(VARCHAR(MAX),@id) +'/',
									Weight_ = @Weight_, Largo = @Largo, Width = @Width, Height = @Height, tipoEnvio = @tipoEnvio, ETA = @ETA, RecogerTienda=@RecogerTienda  WHERE ID = @Id

	END



	if(@tipoEnvio = 1 or @tipoEnvio = 3)
			BEGIN
			UPDATE TBLCoberturaProducto set fechaBaja = GETDATE()
			WHERE Id_Producto = @id

			SET @idNombreDataRango = (SELECT idNombreDataRango FROM Proveedores_Sucursales where Id= @idOrigen)

			    INSERT TBLCoberturaProducto (Id_Producto,idCobertura,idNombreDataRango,fechaModificacion)
				SELECT @id,idCobertura, @idNombreDataRango ,GETDATE() FROM #tblrutasproducto

			 END


  END
  SELECT @id as id
END
GO
/****** Object:  StoredProcedure [dbo].[spRegistrarAparato]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRegistrarAparato]
@Gcm_Regid VARCHAR(MAX),
@Plataforma VARCHAR(50),
@Name VARCHAR(250),
@Email VARCHAR(250)
AS
BEGIN

IF NOT EXISTS(SELECT * FROM  GCM_Usuarios WHERE Gcm_Regid = @Gcm_Regid AND Email =  @Email )
BEGIN
INSERT INTO [dbo].[GCM_Usuarios]
           ([Gcm_Regid]
           ,[Plataforma]
           ,[Name]
           ,[Email]
           ,[Created_at])
     VALUES
           (@Gcm_Regid
           ,@Plataforma
           ,@Name
           ,@Email
           ,GETDATE())
SELECT 1
END
ELSE
BEGIN
SELECT 0
END
END
GO
/****** Object:  StoredProcedure [dbo].[SpServicios_Insertar]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpServicios_Insertar]
@idiomaproduc int = null,
@esVerdadero VARCHAR(MAX) = null,
@HasImage bit = 0,
@Id_Servicio INT = null,
@Nombre_Servicio VARCHAR(MAX) = null,
--@Categoria VARCHAR(MAX) = null,
@Area_Covertura VARCHAR(MAX) = null,
@Precio decimal(16,2) null,
@Puntos INT null,
@Descripcion VARCHAR(MAX) = null,
@Img VARCHAR(MAX) = null,
@Folder_Path VARCHAR(MAX) = null,
@Id_Categoria int = null,
@Descuento int = null,
@Correo VARCHAR(MAX) = null,
@Proveedor VARCHAR(MAX) = null,
@Id_Proveedor INT = null,
@Nom_Img_Principal VARCHAR(MAX) = null
AS
BEGIN
IF(@esVerdadero = 'true')
BEGIN

set @Img = 'Servicios/' + CONVERT(VARCHAR(100),@Id_Proveedor) + '/' + @Nom_Img_Principal
set @Folder_Path = 'Servicios_Img/' + CONVERT(VARCHAR(100),@Id_Proveedor) + '/' + @Nom_Img_Principal

   
				INSERT INTO servicios_nuevos(Proveedor,Area_Covertura,Fecha_Creacion,Nombre_Servicio,Correo,Img,Id_Categoria,Folder_Path,Descuento,Estatus) 
				VALUES(@Proveedor,@Area_Covertura,getdate(),@Nombre_Servicio,@Correo,@Img,@Id_Categoria,@Folder_Path,@Descuento,1)
			
			     Select @Id_Servicio = @@IDENTITY

				  INSERT INTO TblIdiomaProductos (id_Idioma,id_Tbl,Tabla,IdiomaNombre, IdiomaDescripcion,M_Precio,M_Puntos)
				 values (@idiomaproduc,@Id_Servicio,'servicios_nuevos',@Nombre_Servicio,@Descripcion,@Precio,@Puntos)

				 --update servicios_nuevos set Ruta_Carpeta = 'Productos_Produccion/' + CONVERT(VARCHAR(100),@Id_Proveedor) + '/' + CONVERT(VARCHAR(100),@id) +'/'
				 --where Id_Servicio = @Id_Servicio

				 INSERT INTO servicios_nuevosTem(Id_Servicio,Nombre_Servicio,Descripcion,Fecha_Creacion,img,Folder_Path,idIdioma) 
				 VALUES(@Id_Servicio,@Nombre_Servicio,@Descripcion,GETDATE(),@Img,@Folder_Path,@idiomaproduc)


END
ELSE
BEGIN
    IF(@HasImage = 1)
    BEGIN
	        UPDATE TblIdiomaProductos set M_Precio = @Precio, M_Puntos = @Puntos where Tabla = 'servicios_nuevos' and id_Tbl = @Id_Servicio and id_Idioma = @idiomaproduc 

	 	    Update servicios_nuevos SET
                    Descuento = @Descuento,Area_Covertura = @Area_Covertura,
                    Id_Categoria = @Id_Categoria, Correo = @Correo  WHERE Id_Servicio = @Id_Servicio

			Update servicios_nuevosTem SET
                    Nombre_Servicio = @Nombre_Servicio, Descripcion = @Descripcion,img = @Img,Folder_Path = 'Servicios_Img/' + CONVERT(VARCHAR(100),@Id_Proveedor) + '/' + @Nom_Img_Principal ,ValGaleria = null, ComentarioVal = null,Fecha_Creacion= getdate()
                    WHERE Id_Servicio = @Id_Servicio

			 if(EXISTS (select * from servicios_nuevosTem where  Id_Servicio = @Id_Servicio and idIdioma = @idiomaproduc))
					    BEGIN
							Update servicios_nuevosTem SET
							Nombre_Servicio = @Nombre_Servicio,Descripcion = @Descripcion, ValGaleria = null, ComentarioVal = null,Fecha_Creacion= getdate()  WHERE Id_Servicio = @Id_Servicio and idIdioma = @idiomaproduc
						END
					    ELSE BEGIN
					         INSERT INTO servicios_nuevosTem(Id_Servicio,Nombre_Servicio,Descripcion,Fecha_Creacion,img,Folder_Path,idIdioma) 
							 VALUES(@Id_Servicio,@Nombre_Servicio,@Descripcion,GETDATE(),@Img,@Folder_Path,@idiomaproduc)
					    END



	END
	ELSE
	BEGIN
	      UPDATE TblIdiomaProductos set M_Precio = @Precio, M_Puntos = @Puntos  where Tabla = 'servicios_nuevos' and id_Tbl = @Id_Servicio and id_Idioma = @idiomaproduc 


 					Update servicios_nuevos SET
									Descuento = @Descuento,
									Area_Covertura = @Area_Covertura,
									 Id_Categoria = @Id_Categoria, Correo = @Correo  
									 WHERE Id_Servicio = @Id_Servicio
			 if(EXISTS (select * from servicios_nuevosTem where  Id_Servicio = @Id_Servicio and idIdioma = @idiomaproduc))
					    BEGIN
							Update servicios_nuevosTem SET
							Nombre_Servicio = @Nombre_Servicio,Descripcion = @Descripcion, ValGaleria = null, ComentarioVal = null,Fecha_Creacion= getdate()  WHERE Id_Servicio = @Id_Servicio and idIdioma = @idiomaproduc
						END
					    ELSE BEGIN
					         INSERT INTO servicios_nuevosTem(Id_Servicio,Nombre_Servicio,Descripcion,Fecha_Creacion,img,Folder_Path,idIdioma) 
							 VALUES(@Id_Servicio,@Nombre_Servicio,@Descripcion,GETDATE(),@Img,@Folder_Path,@idiomaproduc)
					    END
	END
  END
  SELECT @Id_Servicio as Id_Servicio
END
GO
/****** Object:  StoredProcedure [dbo].[SpVentas_Insertar]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpVentas_Insertar]
			@PaymentId INT
           ,@ProductId INT
           ,@State VARCHAR(15)
           ,@SalePrice DECIMAL(6,2)
           ,@Quantity INT
AS
BEGIN


INSERT INTO [dbo].[Ventas]
           ([PaymentId]
           ,[ProductId]
           ,[State]
           ,[SalePrice]
           ,[Quantity])
     VALUES
           (@PaymentId
           ,@ProductId
           ,@State
           ,@SalePrice
           ,@Quantity)

		   SELECT @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[TextoBuscador]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[TextoBuscador]
@Param nvarchar(50),
@id_Idioma int = 1
AS
BEGIN

--declare @Param nvarchar(50) = 'relie',
--@id_Idioma int = 2

		SELECT TOP 5 IdiomaNombre as Nombre FROM Productos_en_Produccion
		INNER JOIN TblIdiomaProductos on TblIdiomaProductos.Tabla = 'Productos_en_Produccion' AND TblIdiomaProductos.id_Tbl = Productos_en_Produccion.Id and TblIdiomaProductos.id_Idioma = @id_Idioma 
		where IdiomaNombre LIKE '%' + @Param + '%'
	--SELECT TOP 5 Nombre FROM Productos_en_Produccion where Nombre LIKE '%' + @Param + '%'
	UNION
		SELECT TOP 5 IdiomaNombre as Nombre_Servicio FROM Productos_en_Produccion
		INNER JOIN TblIdiomaProductos on TblIdiomaProductos.Tabla = 'servicios_nuevos' AND TblIdiomaProductos.id_Tbl = Productos_en_Produccion.Id and TblIdiomaProductos.id_Idioma = @id_Idioma 
		where IdiomaNombre LIKE '%' + @Param + '%'

	--SELECT TOP 5 Nombre_Servicio FROM servicios_nuevos where Nombre_Servicio LIKE '%' + @Param + '%'
	UNION
	SELECT TOP 5 Nombre_Proveedor FROM Proveedores where Nombre_Proveedor LIKE '%' + @Param + '%'
END

GO
/****** Object:  StoredProcedure [dbo].[Validador]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Validador]
      @Id int   
AS
BEGIN
     
      IF @Id IS NOT NULL
      BEGIN
            IF((SELECT Premium FROM Proveedores WHERE Id_Proveedor = @Id) = 1) 
            BEGIN
                  SELECT -1 -- es 1
            END
            ELSE
            BEGIN
                  SELECT -2 -- no es 1 o no hay nada
            END
      END
END
GO
/****** Object:  StoredProcedure [dbo].[Validate_User]    Script Date: 08/12/2021 08:40:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Validate_User]
      @Email VARCHAR(100),
      @Password VARCHAR(100)
AS
BEGIN
      SET NOCOUNT ON;
      DECLARE @UserId INT, @LastLoginDate DATETIME
     
      SELECT @UserId = Id_Cliente, @LastLoginDate = LastLoginDate
      FROM Clientes WHERE Email = @Email AND [Password] = @Password
     
      IF @UserId IS NOT NULL
      BEGIN
            IF NOT EXISTS(SELECT Id_Cliente FROM Clientes_Activacion WHERE Id_Cliente = @UserId)
            BEGIN
                  UPDATE Clientes
                  SET LastLoginDate = GETDATE()
                  WHERE Id_Cliente = @UserId
                  SELECT @UserId [Id_Cliente] -- User Valid
            END
            ELSE
            BEGIN
                  SELECT -2 -- Userio no Activado.
            END
      END
      ELSE
      BEGIN
            SELECT -1 -- EMail Invalido.
      END
END
GO

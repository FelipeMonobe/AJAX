USE [Ajax]
GO

/****** Object:  Table [dbo].[USUARIO]    Script Date: 05/07/2014 19:44:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[USUARIO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[USERNAME] [varchar](25) NOT NULL,
	[NOME] [varchar](25) NOT NULL,
	[IDADE] [int] NOT NULL,
	[FOTO] [varchar](25) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


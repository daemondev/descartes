Imports App_entidades
Imports App_datos
Imports System.Data.Common
Imports System.Data
Imports System.Collections.Generic
Imports System.Windows.Forms
Imports Microsoft.Practices.EnterpriseLibrary
Imports Microsoft.Practices.EnterpriseLibrary.Data
Imports GS.Framework.Data

Namespace BL

    Public Class BL_cliente
        'Inherits DAOBase
        'Private DLA As DL.DL_cliente
        'Protected lDataset As DataSet
        'Public Sub New(ByRef db As Database)
        '    MyBase.New(db)
        'End Sub
        'Public dao As New DL.DL_cliente(db)



        'TRAER LOS DATOS DE LOS CLIENTES PARA RELLENAR LOS TEXTBOX
        'Public Function _buscar_cliente() As List(Of SOT.TB_datos_cliente)

        '    Dim lst_escala As New List(Of SOT.TB_datos_cliente)
        '    Using connection As DbConnection = db.CreateConnection
        '        Dim stock As Integer = 0
        '        connection.Open()
        '        'Dim transaction As DbTransaction = connection.BeginTransaction
        '        Try
        '            lst_escala = dao.ListadoUsuarios()

        '        Catch ex As Exception
        '            MessageBox.Show("ERROR")
        '        End Try
        '        connection.Close()
        '        Return lst_escala
        '    End Using
        'End Function

        Public Function CargarNotas() As List(Of SOT.TB_datos)
            ' Return dao._seleccionar_datos()
        End Function


        'Public Function CargarNotas() As List(Of SOT.TB_datos)
        '    Dim dao As New DL.DL_cliente(db)
        '    Dim lst_escala As New List(Of SOT.TB_datos)
        '    Using connection As DbConnection = db.CreateConnection
        '        Dim stock As Integer = 0
        '        connection.Open()
        '        'Dim transaction As DbTransaction = connection.BeginTransaction
        '        Try
        '            lst_escala = dao._seleccionar_datos()

        '        Catch ex As Exception
        '            MessageBox.Show("ERROR")
        '        End Try
        '        connection.Close()
        '        Return lst_escala
        '    End Using
        'End Function


        'Public Function BE_REPORTEVECINOS_BACK(ByVal E_REPORT As TB_REPORTEGENERAL) As DataTable
        '    Dim d_test = New DA_ENCUESTA
        '    Return d_test.DA_reporte_vecinos_back(E_REPORT)
        'End Function


        'Public Function _ListadoSupervisor() As List(Of EU.TB_supervisor)
        '    Dim dao As New DU.DL_Usuario(db)
        '    Dim lst_supervisor As New List(Of EU.TB_supervisor)
        '    Dim BL_Util As New BL_Util
        '    Using connection As DbConnection = db.CreateConnection
        '        connection.Open()
        '        Try
        '            lst_supervisor = dao.ListadoSupervisor()
        '        Catch ex As Exception
        '            BL_Util.GeneraLog(ex.Message, "_ListadoSupervisor")
        '        End Try
        '        connection.Close()
        '    End Using
        '    Return lst_supervisor
        'End Function


        'Public Function _buscar_cliente() As List( By vOf SOT.TB_datos_cliente) As Integer
        '    Dim dao As New DG.DL_Motivo(db)
        '    Dim lst_tiempo As New List(Of EG.TB_tiempo)
        '    Dim BL_Util As New BL_util
        '    Dim result As New Result
        '    Dim stock As Integer = 0
        '    Using connection As DbConnection = db.CreateConnection
        '        connection.Open()
        '        Dim transaction As DbTransaction = connection.BeginTransaction
        '        Try
        '            stock = dao.Insertar_fin_llamada_caidas(Motivo11, transaction)
        '            transaction.Commit()
        '        Catch ex As Exception
        '            transaction.Rollback()
        '            result.Code = result.RESULT_ERROR
        '            BL_Util.GeneraLog(ex.Message, "_Registrarpostventa")
        '        End Try
        '        connection.Close()
        '    End Using
        '    Return stock
        'End Function



        'Public Function _buscar_cliente(ByVal oUser As SOT.TB_datos) As SOT.TB_datos
        '    Dim dao As New DAO.DL_usuario(db)
        '    Dim BE As New SOT.TB_datos
        '    Dim BL_Util As New BL_usuario
        '    Using connection As DbConnection = db.CreateConnection
        '        connection.Open()
        '        Try

        '            BE = dao.buscar_cliente(oUser)   'Autentificacion DAO

        '        Catch ex As Exception
        '            'BL_Util.GeneraLog(ex.Message, "_LogeoUsuario")
        '        End Try

        '        connection.Close()
        '        Return BE
        '    End Using
        'End Function
    End Class
End Namespace


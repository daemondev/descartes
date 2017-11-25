Imports System.IO
Public Class BL_util
    'Public Sub GeneraLog(ByVal cad As String, ByVal srtProc As String)
    '    'Esta declaracion la haremos a nivel global para poder accesar el DataSet en cualquier metodo
    '    'Variables para abrir el archivo en modo de escritura

    '    Dim strStreamW As Stream
    '    Dim strStreamWriter As StreamWriter
    '    Try
    '        Dim path As New BE.Keys
    '        Dim FilePath As String = path._path & Format(Now, "ddMMyyyy_hhmm") & ".txt"

    '        'Se abre el archivo y si este no existe se crea
    '        strStreamW = File.OpenWrite(FilePath)
    '        strStreamWriter = New StreamWriter(strStreamW, System.Text.Encoding.UTF8)


    '        strStreamWriter.WriteLine("ERROR :" & Format(Now, "dd/MM/yyyy hh:mm:ss") & " --> " & cad & " <-- PROCEDIMIENTO ==>" & srtProc & "<==")
    '        strStreamWriter.Close()

    '    Catch ex As Exception
    '        'strStreamWriter.Close()
    '        'MsgBox(ex.Message)
    '    End Try
    'End Sub
End Class

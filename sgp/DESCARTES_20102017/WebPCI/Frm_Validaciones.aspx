<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_Validaciones.aspx.cs" Inherits="Frm_Validaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/validaciones.js"></script>
    <center>
        <div>
            <input type="hidden" id="hdCapaID" value="" />
            <input type="hidden" id="hdPerfil" value="" />
            <table>
                <tr>
                    <td>
                        <table id="tbCabecera"  class="mGrid2"></table>
                    </td>
                    <td>
                        <table id="tbCabeValidaciones" class="mGrid2"></table>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" id="btnGuardar">Guardar</button>
                    </td>
                </tr>
                <tr>
                </tr>
            </table>
        </div>
        <div style="width: auto; height: 500px; overflow-y: scroll">
            <table id="tbDetalle" class="mGrid2"></table>
        </div>
    </center>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_CambiarClave.aspx.cs" Inherits="Frm_CambiarClave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/cambiarClave.js"></script>
    <center>
        <div id="dvCapacitacion" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: 700px;">
                    <%--<form class="form-horizontal">--%>
                    <div style="background-color: #00A65A; border-radius: 5px;">
                        <h4 class="modal-title">CAMBIAR CLAVE</h4>
                    </div>
                    <div class="modal-body">
                        <table class="tb_desempeño">
                            <tr>
                                <td><input type="password" class="form-control" id="txtClave" placeholder="Nueva clave" style="width: 300px;" /></td>
                             </tr>
                        </table>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="btn_grabar">Guardar</button>
                        <input type="hidden" id="hdCapacitacion" value="0" />
                    </div>
                </div>
            </div>
        </div>
    </center>
</asp:Content>


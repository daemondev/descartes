<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_MantSede.aspx.cs" Inherits="Frm_MantSede" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/manSede.js"></script>
    <center>
    <div style="background-color: #00A65A; border-radius: 5px;">
        <h4 class="modal-title">SEDES</h4>
    </div>
    <br />
        <button type="button" class="btn btn-primary btn-md" onclick="JQ_Open_Ventana_Registro();">Nuevo Registro</button>
        <div>
            <table id="tbSedes" class="mGrid" style="width:800px;">  
                <thead>
                    <tr>	    
                        <th style="text-align:center;">SEDE</th>
                        <th style="text-align:center;">REGISTRADO POR</th>
                        <th style="text-align:center;">FEC. REG.</th>
                        <th style="width:5%;"></th>
                        <th style="width:5%;"></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>        
            </table>
        </div>    
        <!-- Modal de Registro Nueva sede-->
        <div class="modal fade" id="dvSede" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: 465px;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">REGISTRO DE SEDES</h4>
                    </div>
                    <div class="modal-body">
                        <table class="tb_desempeño">
                            <tr>
                                <td><label>Sede</label></td>
                                <td><input type="text" class="form-control" id="txtSede" placeholder="Ingr. Sede" style="width: 200px;" /></td>
                             </tr>
                        </table>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btn_grabar">Guardar</button>
                        <input type="hidden" id="hdSede" value="0" />
                    </div>
                </div>
            </div>
        </div>
    </center>
</asp:Content>


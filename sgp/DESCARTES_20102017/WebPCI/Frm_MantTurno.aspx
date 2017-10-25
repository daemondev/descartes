<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_MantTurno.aspx.cs" Inherits="Frm_MantTurno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/mantTurno.js"></script>
    <%--<script src="Libreria/plugins/timepicker/bootstrap-timepicker.js"></script>--%>
    <%--<link href="Libreria/plugins/timepicker/bootstrap-timepicker.css" rel="stylesheet" />--%>
    <%--<script src="Libreria/plugins/dist/wickedpicker.min.js"></script>
    <link href="Libreria/plugins/dist/wickedpicker.min.css" rel="stylesheet" />--%>
    <center>
    <div style="background-color: #00A65A; border-radius: 5px;">
        <h4 class="modal-title">TURNOS</h4>
    </div>
    <br />
        <table>
            <tr>
                <td>
                    <label>Sede</label>
                </td>
                <td>
                    <select id="ddlSedes" class="form-control" style="width: 200px;"></select>
                </td>
                <td style="width: 50px;">&nbsp;&nbsp;</td>
                <td style="text-align: right;">
                    <button type="button" class="btn btn-primary btn-md" onclick="JQ_Open_Ventana_Registro();">Nuevo Registro</button>
                </td>
            </tr>
        </table>
        <div>
            <table id="tbTurnos" class="mGrid" style="width:60%;">  
                <thead>
                    <tr>	    
                        <th style="text-align:center;">S</th>
                        <th style="text-align:center;">DESCRIPCIÓN</th>
                        <th style="text-align:center;">INICIO</th>
                        <th style="text-align:center;">FIN</th>
                        <th style="text-align:center;">MODIFICADO POR</th>
                        <th style="width:5%;"></th>
                        <th style="width:5%;"></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>        
            </table>
        </div>    
        <!-- Modal de Registro Nueva campaña-->
        <div class="modal fade" id="dvTurno" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: 465px;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">REGISTRO DE TURNOS</h4>
                    </div>
                    <div class="modal-body">
                        <table class="tb_desempeño">
                            <tr>
                                <td><label>Símbolo</label></td>
                                <td><input type="text" class="form-control" id="txtSimbolo" style="width: 50px;" onkeypress="return sololetras(event)" maxlength="1" /></td>
                             </tr>
                            <tr>
                                <td><label>Descripción</label></td>
                                <td><input type="text" class="form-control" id="txtDescripcion" placeholder="Descripción" style="width: 200px;" /></td>
                             </tr>
                            <tr>
                                <td><label>Hora Inicio</label></td>
                                <td><input type="text" class="form-control" id="txtHoraInicio" style="width: 100px;" /></td>
                             </tr>
                            <tr>
                                <td><label>Hora Fin</label></td>
                                <td><input type="text" class="form-control" id="txtHoraFin" style="width: 100px;" /></td>
                             </tr>
                        </table>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btn_grabar">Guardar</button>
                        <input type="hidden" id="hdTurno" value="0" />
                    </div>
                </div>
            </div>
        </div>
    </center>
</asp:Content>


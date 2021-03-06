﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_MantValidaciones.aspx.cs" Inherits="Frm_MantValidaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/mantValidaciones.js"></script>
    <center>
    <div style="background-color: #00A65A; border-radius: 5px;">
        <h4 class="modal-title">VALIDACIONES</h4>
    </div>
        <br />
        <table style="width: 72%;">
            <tr>
                <td>
                    <label>Sede</label>
                </td>
                <td>
                    <select id="ddlSedes" class="form-control" style="width: 200px;"></select>
                </td>
                <td>
                    <label>Campañas</label>
                </td>
                <td>
                    <select id="ddlCampanias" class="form-control" style="width: 200px;"></select>
                </td>
            </tr>
        </table>
        <div id="dvCapas">
            <table id="tbCapacitacion" class="mGrid" style="width:100%;">  
                <thead>
                    <tr>	    
                        <th style="text-align:center;">ABREV.</th>
                        <th style="text-align:center;">TITULO</th>
                        <th style="text-align:center;">FEC. REG.</th>
                        <th style="text-align:center;">FEC. INI.</th>
                        <th style="text-align:center;">FEC. FIN.</th>
                        <th style="text-align:center;">REGISTRADO POR</th>
                        <th style="text-align:center;">AGENTES</th>
                        <th style="text-align:center;">DIAS</th>
                        <th style="text-align:center;">PAGO TOTAL</th>
                        <th style="text-align:center;">PAGO DIA</th>
                        <th style="text-align:center;">PARTES</th>
                        <th style="text-align:center;">ESTADO</th>
                        <th style="text-align:center;">VALIDA</th>
                        <th style="width:3%;"></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>        
            </table>
        </div>
        <div class="modal fade" id="dvDetalleCapa" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: 400px;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">DETALLE DE LA CAPACITACION</h4>
                    </div>
                    <div style="height: auto;" class="modal-body">
                        <div id="dvDetalle">
                            <table id="tbDetalleCapa" class="mGrid">
                                <thead>
                                    <tr>
                                        <th style="text-align:center;">Partes</th>
                                        <th style="text-align:center;">Cierre</th>
                                        <th style="text-align:center;">Monto a pagar</th>
                                        <th style="text-align:center;">Día de pago</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </center>
</asp:Content>


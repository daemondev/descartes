<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_AsistenciaAgentesConsulta.aspx.cs" Inherits="Frm_AsistenciaAgentesConsulta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/frmAsisteciaAgentesConsulta.js"></script>
    <div id="dvCapas">
        <input type="hidden" id="hdCapaID" value="0" />
        <input type="hidden" id="hdEstado" value="" />
        <table id="tbCapa" class="mGrid" style="width:100%;">  
            <thead>
                <tr>	    
                    <th style="text-align:center;">ABREV.</th>
                    <th style="text-align:center;">TITULO</th>
                    <th style="text-align:center;">FEC. REGISTRO</th>
                    <th style="text-align:center;">REGISTRADO POR</th>
                    <th style="text-align:center;">AGENTES</th>
                    <th style="text-align:center;">DIAS</th>
                    <th style="text-align:center;">P. TOTAL</th>
                    <th style="text-align:center;">P. DIA</th>
                    <th style="text-align:center;">PARTES</th>
                    <th style="width:3%;"></th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            </tbody>        
        </table>
    </div>
    <div class="modal fade" id="dvDetalleCapa" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width: auto;">
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
    <div style="width: auto; height: 500px; overflow-y: scroll">
        <table id="tbAsistencia" class="mGrid">

        </table>
    </div>
</asp:Content>


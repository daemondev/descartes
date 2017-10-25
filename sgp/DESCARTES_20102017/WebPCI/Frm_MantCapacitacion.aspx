<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_MantCapacitacion.aspx.cs" Inherits="Frm_MantCapacitacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/jquery-ui-1.10.3.custom/js/jquery.number.js"></script>
    <script src="Libreria/js/Codigo_Web/mantCapacitacion.js"></script>
    <center>
    <div style="background-color: #00A65A; border-radius: 5px;">
        <h4 class="modal-title">CAPACITACIONES</h4>
    </div>
    <br />
        <input type="hidden" id="hdPerfil" value="" />
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
                <td style="text-align: right;">
                    <button type="button" class="btn btn-primary btn-md" onclick="JQ_Open_Ventana_Registro();">Nuevo Registro</button>
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
                        <th style="text-align:center;">TURNO</th>
                        <th style="text-align:center;">REGISTRADO POR</th>
                        <th style="text-align:center;">AGENTES</th>
                        <th style="text-align:center;">DIAS</th>
                        <th style="text-align:center;">PAGO TOTAL</th>
                        <th style="text-align:center;">PAGO DIA</th>
                        <th style="text-align:center;">PARTES</th>
                        <th style="text-align:center;">ESTADO</th>
                        <th style="width:3%;"></th>
                        <th style="width:3%;"></th>
                        <th style="width:3%;"></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>        
            </table>
        </div> 
        <input type="hidden" id="hdEstado" value="" />
        </center>
        <!-- Modal de Registro Nueva campaña-->
        <div style="display: none;" id="dvCapacitacion" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: auto;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">REGISTRO DE CAPACITACIONES</h4>
                    </div>
                    <div class="modal-body">
                        <table class="tb_desempeño" style="width: 100%">
                            <tr>
                                <td>
                                    <label>Abreviatura</label>
                                    <input type="text" class="form-control" id="txtAbrev" placeholder="Abrev" style="width: 100px;" />
                                </td>
                                <td colspan="2">
                                    <label>Título</label>
                                    <input type="text" class="form-control" id="txtTitulo" placeholder="Ingrese título" style="width: 250px;" />
                                </td>
                                <td colspan="2">
                                    <label>Turno</label>
                                    <select id="ddlTurno" class="form-control" style="width: 150px;"></select>
                                </td>
                             </tr>
                            <tr><td colspan="10"><hr /></td></tr>
                            <tr>
                                <td>
                                    <label>Fecha Inicio</label>
                                    <input type="text" class="form-control" id="txtFecInicio" placeholder="Fecha" style="width: 100px;" />
                                </td>
                                <td>
                                    <label>C. Agentes</label>
                                    <input type="text" class="form-control" id="txtCantAgentes" style="width: 100px;" onkeypress="return solonumeros(event)" />
                                </td>
                                <td>
                                    <label>C. Días</label>
                                    <input type="text" class="form-control" id="txtCantDias" style="width: 100px;" onkeypress="return solonumeros(event)" />
                                </td>
                                <td>
                                    <label>P. Dia</label>
                                    <input type="text" class="form-control" id="txtPagoDia" style="width: 60px;" disabled="disabled" />
                                </td>
                                <td>
                                    <label>P. total</label>
                                    <input type="text" class="form-control" id="txtPagoTotal" style="width: 80px;" disabled="disabled" />
                                </td>
                             </tr>
                            <tr><td colspan="10"><hr /></td></tr>                            
                            <tr>
                                <td>
                                    <label>Partes</label>
                                    <select class="form-control" style="width: 60px;" id="ddlPartes">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                    </select>
                                </td>
                                <td colspan="4">
                                    <table style="width: 100%">
                                        <tr>
                                            <td><label>D. Cierres</label></td>
                                            <td><label>Montos</label></td>
                                            <td><label>D. PAGOS</label></td>
                                        </tr>
                                        <tr>
                                            <td><label id="lblCierres"></label></td>
                                            <td><label id="lblMontos"></label></td>
                                            <td><label id="lblPagos"></label></td>
                                            <td rowspan="2"><button type="button" id="btnCambiar" class="btn btn-primary btn-md" onclick="JQ_CambiarDia();">Cambiar</button></td>
                                        </tr>
                                    </table>
                                </td>
                             </tr>
                        </table>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button  type="button" class="btn" id="btnCerrar" onclick="JQ_Close_Ventana_Registro();">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btn_grabar">Guardar</button>
                        <input type="hidden" id="hdCapacitacion" value="0" />
                    </div>
                </div>
            </div>
        </div>
        <%--cambiar de sede--%>
        <center>
        <div class="modal fade" id="dvCambiarSede" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: 465px;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">CAMBIAR DE SEDE</h4>
                    </div>
                    <div class="modal-body">
                        <table class="tb_desempeño">
                            <tr>
                                <td><label>Sede</label></td>
                                <td><select id="ddlCambiarSede" class="form-control" style="width: 200px;"></select></td>
                             </tr>
                        </table>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btnCambiarSede">Guardar</button>
                        <input type="hidden" id="hdCambiar" value="0" />
                    </div>
                </div>
            </div>
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
        <div class="modal fade" id="dvDetalleRegistro" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: auto;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">REGISTRO ADICIONAL</h4>
                    </div>
                    <div style="height: auto;" class="modal-body">
                        <div>
                            <table id="tbDetalleRegistro" class="mGrid2"></table>
                        </div>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btnAceptar">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="dvCambiarDiaPago" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: auto;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">DIA</h4>
                    </div>
                    <div style="height: auto;" class="modal-body">
                        <div>
                            <label>Día</label>
                            <input type="text" class="form-control" id="txtNuevoDia" style="width: 60px;" onkeypress="return solonumeros(event)" />
                        </div>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btnGuardarNuevoDia">Guardar</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="dvCambiarDiaFinal" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: auto;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">MODIFICAR LA CANTIDAD DE DIAS DE LA CAPACITACION</h4>
                    </div>
                    <div style="height: auto;" class="modal-body">
                        <div>
                            <label>Datos de la capacitación hasta este momento</label>
                            <table id="tbDiaFinalPagoNuevo" class="mGrid2">
                                <thead>
                                    <tr>
                                        <td>Días</td>
                                        <td>Partes</td>
                                        <td>Pagado</td>
                                    </tr>
                                </thead>
                            </table>
                            <label>Ingrese un día de cierre(superior al día actual de capacitación) y día de pago</label>
                            <table class="mGrid2">
                                <tr>
                                    <td style="text-align: center">
                                        <label>Día</label>
                                        <input type="text" class="form-control" id="txtNuevoDiaCierre" style="width: 100px; text-align: center;" onkeypress="return solonumeros(event)" />
                                    </td>
                                    <td style="text-align: center">
                                        <label>D Pago</label>
                                        <input type="text" class="form-control" id="txtDiaPagoNuevo" style="width: 100px; text-align: center;" onkeypress="return solonumeros(event)" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btnGuardarNuevoDiaCierre">Guardar</button>
                    </div>
                </div>
            </div>
        </div>
    </center>
</asp:Content>


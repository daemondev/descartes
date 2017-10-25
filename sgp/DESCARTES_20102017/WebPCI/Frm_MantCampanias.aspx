<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_MantCampanias.aspx.cs" Inherits="Frm_MantCampanias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/jquery-ui-1.10.3.custom/js/jquery.number.js"></script>
     <script src="Libreria/js/jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
<%--    <script src="Libreria/js/Codigo_Web/manNiveles.js"></script>--%>
    <script src="Libreria/js/Codigo_Web/mantCampania.js"></script>
	<%--Expandir fila tabla--%>
	<%--<script src="Libreria/js/listarNiveles/jExpand.js"></script>--%>
	<%--<script src="Libreria/js/listarNiveles/jquery.min.js"></script>--%>

    <center>
    <div style="background-color: #d43f3a;color:white; border-radius: 5px;">
        <h4 class="modal-title">MATENIMIENTO DE CAMPAÑAS</h4>
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
            <table id="tbCampanias" class="mGrid" style="width:800px;">  
                <thead>
                    <tr>	    
                        <th style="text-align:center;">Campaña</th>
                        <th style="text-align:center;">fec. Registro</th>
                <%--        <th style="text-align:center;">RESPUESTA</th>
						<th style="text-align:center;">TIPO RESPUESTA</th>
                        <th style="text-align:center;">DEPENDE</th>
						<th style="text-align:center;">ALERTA</th>
						<th style="text-align:center;">ORDEN</th>--%>
						<th style="text-align:center;">ADD</th>
                        <th style="width:5%;">Editar</th>
                        <th style="width:5%;">Eliminar</th>
                    </tr>
                </thead>
                <tbody id="tbody_procesos">
                </tbody>        
            </table>
        </div>    
        <!-- Modal de Registro Nueva campaña-->
        <div class="modal fade" id="dvCampania" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: 465px;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">REGISTRO DE CAMPAÑAS</h4>
                    </div>
                    <div class="modal-body">
                        <table class="tb_desempeño">
                            <tr>
                                <td><label>Campaña</label></td>
                                <td><input type="text" class="form-control" id="txtCampania" placeholder="Ingrese Campaña" style="width: 200px;" /></td>
                             </tr>
                          <%--  <tr>
                                <td><label>Pago dia</label></td>
                                <td><input type="text" class="form-control" id="txtPagoDia" placeholder="Ingrese pago x día" style="width: 100px;" /></td>
                             </tr>--%>
                        </table>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btn_grabar">Guardar</button>
                        <input type="hidden" id="hdCampania" value="0" />
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="div_AsignarMatriz" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content" style="width: 465px;">
                    <%--<form class="form-horizontal">--%>
                    <div class="modal-header">
                        <h4 class="modal-title">ASIGNAR MATRIZ</h4>
                    </div>
                    <div class="modal-body">
                        <table class="tb_desempeño" class="mGrid">
                            <tr>
                                <td><label>Campaña: </label></td>
                                <td><label id="lblCampannia"></label>
                                    <input type="hidden" id="hd_id_campannia" />
                                </td>
                             </tr>
                           <tr>
                                <td><label>Matriz:</label></td>
                                <td>
                                    <select id="ddl_matrices">
                                        
                                    </select>
                                </td>
                               <td>
                                   <input  type="button" class="btn btn-primary" value="Agregar" onclick="fnc_asignar_matriz();"/>
                               </td>
                             </tr>
                            <tr>
                                <td colspan="3">
                                    <hr />
                                    <div style="height: 200px; overflow-y: scroll;">
                                        <table class="table">
                                            <thead> 
                                                <%--<tr>
                                                    <th>Campaña</th>
                                                    <th>Eliminar</th>
                                                </tr>--%>
                                            </thead>
                                            <tbody id="tb_lst_Campa">

                                            </tbody>
                                        
                                        </table>
                                    </div>                                    
                                </td>
                                
                            </tr>
                        </table>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                     <%--   <button type="button" class="btn btn-primary" id="fnc_asignar()">Guardar</button>--%>
                        <input type="hidden" id="hidd_id_campannia" value="0" />
                    </div>
                </div>
            </div>
        </div>

        <%--cambiar de sede--%>
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
    </center>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_Usuarios.aspx.cs" Inherits="Frm_Usuarios" %>


<asp:Content ID="Content2" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/Frm_usuarios.js"></script>
	
    <div style="background-color: #d43f3a;color:white; border-radius: 5px;    text-align: center;">
        <h4 class="modal-title">USUARIOS</h4>
    </div>
    <br />
    <table>
        <tr>
            <td>
                <input type="text" class="form-control" id="txtBuscar" placeholder="Buscar..." style="width: 200px;" />
            </td>
            <td>
                <button type="button" class="btn btn-primary btn-md" onclick="GetGridUsuario(1);" >Bucar</button>
            </td>
            <td style="width: 20px;"></td>
            <td>
                <button type="button" class="btn btn-primary btn-md" onclick="JQ_Open_Ventana_Registro();">Nuevo Registro</button>
            </td>
            <td style="width: 20px;"></td>
        <%--    <td>
                <select id="ddl_filtro_sedes">
                </select>
            </td>
            <td>
                <select id="ddl_filtro_campañas">
                </select>
            </td>--%>
            <td>
                <button type="button" class="btn btn-primary btn-md" onclick="fnc_carga_masiva();">Carga Masiva</button>
            </td>
        </tr>
    </table>
    
    <div>
        <table id="tb_usuarios" class="mGrid" style="width:100%;">  
            <thead>
                <tr>	    
                    <th style="text-align:center;">PERSONAL</th>
                    <th style="text-align:center;">DNI</th>
                    <th style="text-align:center;">USUARIO</th>
                    <%--<th style="text-align:center;">CORREO</th>--%>
                    <th style="text-align:center;">PERFIL</th>
                    <th style="text-align:center;">SEDE</th>
                    <th style="text-align:center;">FEC. REG</th>
                    <th style="width:5%;">Editar</th>
                    <th style="width:5%;">Eliminar</th>
                 <%--   <th style="width:5%;"></th>--%>
                </tr>
            </thead>
            <tbody>
            </tbody>        
        </table>
    </div>
    <!-- Modal de Registro Nuevo Usuario-->
    <div class="modal fade" id="div_CargaMasiva" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width: 550px;">
                <%--<form class="form-horizontal">--%>
                <div class="modal-header">
                    <h4 class="modal-title">CARGA MASIVA USUARIOS</h4>
                </div>
                <div class="modal-body">
                    <table class="tb_desempeño">
                        <tr>
                            <td><label>Sede:</label></td>
                            <td>
                                <select id="ddl_carga_Sede"  class="form-control">
                                </select>
                            </td>
                            </tr>
                        <tr>
                            <td><label>Campaña:</label></td>
                            <td>
                                <select id="ddl_carga_campaña"  class="form-control">
                                </select>
                            </td>
                        </tr>
                       <%--   <tr >
                            <td><label>Perfil:</label></td>
                            <td><select id="ddl_perfil_carga" name="ddlPerfil" class="form-control" style="width: 300px;">
                                <option value="2" selected="selected">Asesor</option>
                                </select></td>
                        </tr>--%>
                        <tr>
                            <td><label>Elegir Archivo de carga</label></td>
                            <td><input type="file" class="form-control" id="fileupload" style="width: 300px;" /></td>
                         </tr>
                       
                       <%-- <tr>
                            <td><input type="button" class="btn btn-primary" onclick="Carga_Datos();" value="Cargar"/> </td>
                        </tr>--%>
                        <tr>
                            <td colspan="2">
                                <div id="indicadores">
                                    <ul>
                                        <li><a id="CONTENEDOR_HyperLink1" title="Formato Carga" class="btn btn-primary btn-md" href="Archivos_Carga/FormatoCarga/FRMT_USUARIOS.xlsx" style="color:White;">Descargar Formato</a></li>
                                        <li>Convertir a txt delimintado por tabulaciones</li>
                                        <li>No deben haber celdas vacias en la carga</li>
                                    </ul>
                                </div>
                            </td>
                         </tr>
                        
                    </table>
                </div>
                <!-- Botones de controles-->
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
            
                    <input type="hidden" id="Hidden1" value="0" />
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="dvUsuario" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width: 550px;">
                <%--<form class="form-horizontal">--%>
                <div class="modal-header">
                    <h4 class="modal-title">REGISTRO DE PERSONAL</h4>
                </div>
                <div class="modal-body">
                    <table class="tb_desempeño">
                        <tr>
                            <td><label>Nombres</label></td>
                            <td><input type="text" class="form-control" id="txt_Nombre" placeholder="Ingr. el Nombre" style="width: 300px;" /></td>
                         </tr>
                        <tr>
                            <td><label>Ap. Paterno</label></td>
                            <td><input type="text" class="form-control" id="txt_ApePaterno" placeholder="Ingr. apellido paterno" style="width: 300px;" /></td>
                         </tr>
                        <tr>
                            <td><label>Ap. Materno</label></td>
                            <td><input type="text" class="form-control" id="txt_ApeMaterno" placeholder="Ingr. apellido materno" style="width: 300px;" /></td>
                         </tr>
                        <tr>
                            <td><label>DNI</label></td>
                            <td><input type="text" class="form-control" id="txt_dni" placeholder="Ingr. el DNI" style="width: 100px;" maxlength="8" onkeypress="return solonumeros(event)" /></td>
                        </tr>
                        <tr>
                            <td><label>Usuario</label></td>
                            <td><input type="text" class="form-control" id="txt_Usuario" placeholder="Ingr. el Usuario de Acceso" style="width: 300px;" /></td>
                        </tr>
                      <%--  <tr>
                            <td><label>Correo</label></td>
                            <td><input type="text" class="form-control" id="txtCorreo" placeholder="Ingr. un correo" style="width: 300px;" /></td>
                        </tr>--%>
                        <tr>
                            <td><label>Perfil:</label></td>
                            <td><select id="ddlPerfil" name="ddlPerfil" class="form-control" style="width: 300px;"></select></td>
                        </tr>
                        <tr>
                            <td><label>Sede</label></td>
                            <td><select id="ddl_Sede" name="ddl_Sede" class="form-control"  onchange="ListarCampaña();" style="width: 300px;"></select></td>
                        </tr>
                                                <tr>
                            <td><label>Campaña:</label></td>
                            <td><select id="ddlCampania" name="ddlCampania" class="form-control" style="width: 300px;"></select></td>
                        </tr>
                    </table>
                </div>
                <!-- Botones de controles-->
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="btn_grabar">Guarda Dato</button>
                    <input type="hidden" id="hdIdUsuario" value="0" />
                </div>
            </div>
        </div>
    </div>
    </center>
</asp:Content>


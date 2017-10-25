<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_MantCapacitador.aspx.cs" Inherits="Frm_MantCapacitador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/mantCapacitador.js"></script>
    <center>
    <div style="background-color: #00A65A; border-radius: 5px;">
        <h4 class="modal-title">CAPACITADORES</h4>
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
            <td>
                <label>Campañas</label>
            </td>
            <td>
                <select id="ddlCampanias" class="form-control" style="width: 200px;"></select>
            </td>
            <td>
                <input type="text" class="form-control" id="txtBuscar" placeholder="Buscar..." style="width: 200px;" />
            </td>
            <td>
                <button type="button" class="btn btn-primary btn-md" onclick="GetGridCapacitador(1);" >Bucar</button>
            </td>
            <td style="width: 20px;"></td>
            <td>
                <button type="button" class="btn btn-primary btn-md" onclick="JQ_Open_Ventana_Registro();">Nuevo Registro</button>
            </td>
        </tr>
    </table>
    
    <div>
        <table id="tbCapacitador" class="mGrid" style="width:80%;">  
            <thead>
                <tr>	    
                    <th style="text-align:center;">PERSONAL</th>
                    <th style="text-align:center;">DNI</th>
                    <th style="text-align:center;">USUARIO</th>
                    <th style="text-align:center;">REGISTRADO POR</th>
                    <th style="text-align:center;">FEC. REG</th>
                    <th style="width:5%;"></th>
                    <th style="width:5%;"></th>
                    <th style="width:5%;"></th>
                </tr>
            </thead>
            <tbody>
            </tbody>        
        </table>
    </div>
    <!-- Modal de Registro Nuevo Usuario-->
    <div class="modal fade" id="dvRegistroCapacitador" role="dialog">
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
                            <td><input type="text" class="form-control" id="txt_Nombre" placeholder="Ingr. el Nombre" style="width: 200px;" /></td>
                         </tr>
                        <tr>
                            <td><label>Ap. Paterno</label></td>
                            <td><input type="text" class="form-control" id="txt_ApePaterno" placeholder="Ingr. apellido paterno" style="width: 200px;" /></td>
                         </tr>
                        <tr>
                            <td><label>Ap. Materno</label></td>
                            <td><input type="text" class="form-control" id="txt_ApeMaterno" placeholder="Ingr. apellido materno" style="width: 200px;" /></td>
                         </tr>
                        <tr>
                            <td><label>Usuario</label></td>
                            <td><input type="text" class="form-control" id="txt_Usuario" placeholder="Ingr. el Usuario de Acceso" style="width: 200px;" /></td>
                        </tr>
                        <tr>
                            <td><label>DNI</label></td>
                            <td><input type="text" class="form-control" id="txt_dni" placeholder="Ingr. el DNI" style="width: 100px;" maxlength="8" onkeypress="return solonumeros(event)" /></td>
                        </tr>
                    </table>
                </div>
                <!-- Botones de controles-->
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="btn_grabar">Guardar</button>
                    <input type="hidden" id="hdCapacitador" value="0" />
                </div>
            </div>
        </div>
    </div>
    </center>
</asp:Content>


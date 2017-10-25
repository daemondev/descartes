<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="frm_personasConectadas.aspx.cs" Inherits="frm_personasConectadas" %>

<asp:Content ID="Content3" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/Frm_personasConectadas.js"></script>
	
    <div style="background-color: #d43f3a;color:white; border-radius: 5px;    text-align: center;">
        <h4 class="modal-title">ASESORES CONECTADOS</h4>
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
        </tr>
    </table>
    <div style="text-align:center;">
        <table id="tb_conectados" class="mGrid" style="width:70%;margin-left:200px">  
            <thead>
                <tr>	    
                    <th style="text-align:center;">PERSONAL</th>
                    <th style="text-align:center;">USUARIO</th>
                    <th style="text-align:center;">PERFIL</th>
                    <th style="text-align:center;">ESTADO</th>
                    <th style="text-align:center;">MENSAJES</th>
                </tr>
            </thead>
            <tbody>
            </tbody>        
        </table>
    </div>
    <div class="modal fade" id="dvMensaje" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width: 650px;">
                <%--<form class="form-horizontal">--%>
                <div class="modal-header" style="background-color:#d43f3a;">
                    <button style="background-color:red;height:25px;width:25px;border-radius:8px;color:white;" type='button' class='close' data-dismiss='modal' aria-label='Close' id="parar"><span aria-hidden='true'>&times;</span></button>
                    <h5 style="color:white" id="nombreEmisor" class="modal-title"></h5>
                    <span id="idEmisor" style="visibility:hidden"></span>
                </div>
                <div class="modal-body">
                    <div id="mensajesAnteriores" style="height:350px;width:620px;border:1px solid #A7A7A7;padding:10px;overflow:auto;"></div>
                </div>
                <!-- Botones de controles-->
                <div class="modal-footer">
                    <table>
                        <tr>
                            <td rowspan="2"><textarea id="enviarMensaje"rows="4" cols="77"></textarea></td>                           
                            <td><button style="padding:5px 35px" type="button" class="btn btn-primary" id="btn_Enviar">ENVIAR</button></td>                            
                        </tr>
                        <tr>
                            <td style="padding-left:15px;"><button type="button" class="btn btn-danger" id="btn_Eliminar">Borrar Historial</button></td>
                        </tr>
                    </table>
                    
                </div>
            </div>
        </div>
    </div>
    <br />
</asp:Content>

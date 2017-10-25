<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_CargaAgentes.aspx.cs" Inherits="Frm_CargaAgentes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">	
    <script src="Libreria/js/Validador.js"></script>
    <script src="Libreria/js/Codigo_Web/mantCargaAgentes.js"></script>

    <center>
        <div id="dvListaCapacitaciones" style="width:820px;">
            <div style="background-color: #d43f3a; border-radius: 5px;color:white;font-weight:bold;">
                <h4 class="modal-title">CARGA MASIVA DE CLIENTE</h4>
            </div>
            <br />
            
			 <table class="Fondo_Tabla" style="width:800px;">
                    <tr>
                        <td>
                            <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="white" NavigateUrl="~/Archivos_Carga/FormatoCarga/FRMT_CLIENTE.xlsx" ToolTip="Formato Carga" class="btn btn-primary btn-md">Descargar Formato</asp:HyperLink>                  
                        </td>
                        <td>
                         <span> 
<input id="fileupload" type="file" name="file" class="btn btn-primary btn-md fileinput-button" style="width: 350px;"/>
                            </span> 
                        </td>
                        <td>
                            <button type="button" id="btnCargaAgenteIndividual" class="btn btn-primary btn-md" >Registrar individualmente</button>
                        </td>
                        <td>                           							
								<%--<input type="text" class="form-control" id="txtbuscar" style="width: 100px;" maxlength="8" placeholder="CODIGO" />--%>							
                        </td>
                    </tr>
                </table>       
        </div>

		<div style="overflow-y: scroll; height:450px;width:1000px"  >					
		     <table id="tbCapacitaciones" class="mGrid" style="width:95%">  
                <thead>
                    <tr>                        
                        <th style="text-align:center;">NOMBRE CLIENTE</th>
						<th style="text-align:center;">APELLIDO CLIENTE</th>
                        <th style="text-align:center;">CODIGO</th> 
						 <th style="text-align:center;">Fecha Registro</th>    
						<th style="text-align:center;">EDITAR</th>                  
                        <th style="text-align:center;">ESTADO</th>						
                        <th style="width:5%;">Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>        
            </table>
		</div>

        <div id="dvCargarAgentes" style="display: none; height:600px; width:850px;">
            <div style="background-color: #00A65A; border-radius: 5px;">
                <h4 class="modal-title">CARGAR AGENTES</h4>
            </div>
            <input type="hidden" id="hdCapaID" value="0" />
            <table id="tbCapa" class="mGrid" style="width:800px;">  
                <thead>
                    <tr>	    
                        <th style="text-align:center;">ABREV.</th>
                        <th style="text-align:center;">TITULO</th>
                        <th style="text-align:center;">CAMPAÑA</th>
                        <th style="text-align:center;">FEC. REGISTRO</th>
                        <th style="text-align:center;">FEC. INICIO</th>
                        <th style="text-align:center;">TURNO</th>
                        <th style="text-align:center;">AGENTES</th>
                        <th style="text-align:center;">ESTADO</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>        
            </table>
			
           
	        <div id="dvProgressBarDown" style="width:70%;display:none;margin-top:10px;">
		        <div id="progressDown" class="progress" >
			        <div class="bar" style="width: 0%;float:left;">
				        <p style=" text-align:center;font-weight:bold;vertical-align:middle;color:#433F38;">
					        <label id="lblProgressDown"></label>
				        </p>
			        </div>				
		        </div>
	        </div>
            <div style="height:460px; margin-left: 15px; width:auto; overflow-y: scroll;">
                <table id="tbAgentesCargados" class="mGrid" style="width:800px;">  
                    <thead>
                        <tr>	    
                            <th style="width:5%;"></th>
                            <th style="text-align:center;">USUARIO</th>
                            <th style="text-align:center;">DNI</th>
                            <th style="text-align:center;">NOMBRES</th>
                            <th style="text-align:center;">APE. PATERNO</th>
                            <th style="text-align:center;">APE. MATERNO</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>        
                </table>
            </div>
	    </div>
   
			 <div class="modal fade" id="dvCargaAgenteIndividual" role="dialog" >
				  <%--    <div class="modal-content">--%>
                <!-- Modal content-->
              <div class="modal-content" style="width: 500px;margin-top:200px" >
                   <div style="width: auto;">
                  <div class="modal-header">
                        <h4 class="modal-title" id="h_title">NUEVO INGRESO</h4>
                    </div>
                    <div class="modal-body">
                        <table class="tb_desempeño">
                            <tr>
                                <td><label>Nombre Cliente</label>
									<label id="lblidClie" visible="false"></label>
                                </td>
                                <td>
								<%--onKeyUp="ajustar($(this).prop('id'))" --%>
								<input type="text" class="" id="txtCliente" style="width:300px;height:35px;"    placeholder="Nombres" maxlength="200" /></td>
                             </tr>
							 <tr>
                                <td><label>Aplellido Cliente:</label>
                                </td>
                                <td><input type="text" class="" id="txtapellido" style="width:300px;height:35px;"   placeholder="Apellidos" maxlength="200" /></td>
                             </tr>
                            <tr>
                                <td><label>Codigo</label></td>
                                <td><input type="text" class="form-control" id="txtCodigo" onkeypress="return solonumeros(event)"  style="width: 200px;" maxlength="8" placeholder="CODIGO" /></td>
                            </tr>
                        </table>
                    </div>
                    <!-- Botones de controles-->
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>						
                        <button type="button" id="btnGuardarAgente" class="btn btn-primary btn-md" >Guardar</button>
						<button type="button" id="btnUpdate" class="btn btn-primary btn-md"  >Actualizar</button>
                        <input type="hidden" id="hdCambiar" value="0" />
                    </div>
                </div>
            </div>
			</div> 			
		<div id="div1" class="se_plazo" style="opacity: 2.5;margin-top :300px;margin-left:500px;position:absolute" >
			<img  id="gif_loading" src="Images/gif/default.gif"  width="60px"/>
		</div>

<script>
	$(window).load(function ()
	{
		// Animate loader off screen
		$(".se-pre-con").fadeOut("slow");;

	});

</script>
<style>
 .no-js #loader { display: none;  }

.js #loader { display: block; position: absolute; left: 100px; top: 0; }

	.se_plazo
	{

	left: 0px;
	top: 0px;
	width: 100px;
	height: 100px%;
	z-index: 9999;
	background-color:transparent;
	}

	    input {
            width:100px;
            font-family: monospace;
        }

		</style>

    </center>
</asp:Content>


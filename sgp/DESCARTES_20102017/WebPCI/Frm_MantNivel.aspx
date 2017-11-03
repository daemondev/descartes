<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_MantNivel.aspx.cs" Inherits="Frm_MantNivel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" runat="Server">
	<%--<script src="Libreria/js/jquery-ui-1.10.3.custom/js/jquery.number.js"></script>--%>

	

    
	<center>
        <div id="myReact" class="background-color:red; width:100%;height:100%; position:absolute;z-index:99999;"></div>
		<style>
			
		</style>
	    <div style="background-color: #d43f3a;color:white; border-radius: 5px;">
        <h4 class="modal-title">MATENIMIENTO DE PROCESOS</h4>
		</div>

		<%--<input type="button" oncontextmenu="alert('derecho')" onclick="alert('izquierdo')" value="click"/>--%>
    <br />
        <table >
            <tr >

                <td>
                    <label></label>
                </td>
                <td>
                    <%--<select id="ddlSedes" class="form-control" style="width: 200px;"></select>--%>
                </td>
                
                <td style="text-align: right;">
                    <button type="button" class="btn btn-primary btn-md" onclick="fnc_nuevaCategoria(0,0);">Nuevo Registro</button>
                </td>
			<%-- 
				<td style="width: 50px;" colspan="3">					
					<a href='javascript:fnc_preview(0)'>					
					<img src='Images/iconos/preview.png'  width='32px' /></a>				
				</td>
				--%>
	<%--			<td><input type="button" value="click" id="btnclick" onclick="fnc_click()"/></td>--%>
            </tr>
        </table>

<div style=" overflow-y: scroll;height:445px;width:1100px; margin-left:18px;">			
	<table id="tbCampanias" class="mGrid" style="width:98%;"> 
			  
                <thead>
                    <tr>				
                        <th style="text-align:center;width:100px;" >GRUPO</th>
					
						<th style="text-align:center;">TITULO</th>
                        <th style="text-align:center;">DESCRIPCION</th>
                        <th style="text-align:center;width:5%;">RESPUESTA</th>
                        <%--<th style="text-align:center;">TIPO RESPUESTA</th>--%>
                        <%--<th style="text-align:center;">DEPENDE</th>--%>
                        <th style="text-align:center;width:100px;">ALERTA</th>
                        <%--<th style="text-align:center;width: 5%;">Enlase</th> --%>
                        <th style="text-align:center;">ESTADO</th>
                        <th style="width:5%;">Editar</th>
                    
						<th style="width:5%;">Nuevo</th>
						  <th style="width:5%;">Eliminar</th>
						  <th style="width:5%;">Vista previa</th>
                    </tr>
                </thead>
                <tbody id="tb_0" >
                </tbody>        
            </table>
    </div>
        
	<!--REGISTRO DE LOS DATOS DE DESCARTE--> <!--++++ begin MODAL NUEVO REGISTRO  {{ -->
	<div id="plazo"  role="dialog" style="width:800px;height:500px; z-index:999;"  > 
		  <%-- <div class="modal-content"  style="width: 75%;margin-top:10px" >
			   <div class="modal-content"  style="width: 75%;margin-top:10px" >--%>
			<table id="tbl_dialog" style="border-collapse: separate; border-spacing: 4px;">
				<tr>
					<td>
						<label>T&Iacute;TULO:</label>
						
						<label id="lbl_id_categoria"></label>
						<br />
						<label id="lbl_id_nivel" ></label>
					</td>
					<td><input required="required" id="txtTitulo" style="width:200px" /></td>

				</tr>
				<tr>
					<td>
						<label>DESCRIPCI&Oacute;N:</label>
					</td>
						<td><textarea required="required" id="txtArea_desc" rows="10"  style="width:300px;height:80px;resize: none;"></textarea></td>
				</tr>
				<tr>
					<td>
						<label>IMAGEN2 :</label>
					</td>
						<td>                           
							<input  type="file" id="fileupload" name="files[]"  class=""/>						
							<output id="output_img"></output>
						
						</td>
				</tr>
				<tr>
					<td>
						<label>ALERTA :</label>
					</td>
					<td>
						<%--<img id="img1" src="Images/gif/colores_alerta.png" />--%>
                        <div style="background-color: black;" class="div_colores" > 
                            <input type="radio" id="chk_am" name="rdColor" value="yellow"/><label style="color:yellow">Amarrillo</label>
                            <input type="radio" id="chk_ve" name="rdColor" value="green"/><label style="color:green">Verde</label>
                            <input type="radio" id="chk_ro" name="rdColor" value="red"/><label style="color:red">Rojo</label>                      
                        </div>
						<textarea id="Textarea_alerta"  rows="5" style="width:300px;height:80px;resize: none;"></textarea>
					</td>
				</tr>
				<tr>
					<td><label>RESPUESTA</label></td>
					<td><select id="ddl_rpta">							
								<option value="1">otros</option>
								<option value="2" selected="selected">Imagen</option>
								<option value="3" >btn Finalizacion</option>
								<option value="4" >Confirmacion</option>
								<option value="5" >Negacion</option>
								<option value="6" >Boton Seleccion</option>
								<option value="7" >link</option>
								<option value="8" >Contenido</option>
					    </select></td>
					<br />
				</tr>
				<%--<tr>
					<td><label>Contenidos:</label></td>
					<td>
						 <button type="button" class="btn btn-primary btn-md" onclick="JQ_Open_Contexto();">Agregar</button>
					</td>
				</tr>--%>
				<tr>
					<td><label>MATRIZ :</label></td>
					<td><select id="mismatrices" disabled><option value="0">[Seleccione]-</option></select></td>
				</tr>
				<tr>
					<td><label>PROCESO :</label></td>
					<td><select id="misprocesos" disabled><option value="0">[Seleccione]</option></select></td>
				</tr>

				<tr>
					<td>
				<div id="dvProgressBarFiles" style="width:95%;display:none;margin:3px;">
					<div id="progressFiles" class="progress" >
						<div class="bar" style="width: 0%;float:left;"><p style="float:right;font-weight:bold;vertical-align:middle;color:#433F38;margin:2px;"><label id="lblProgressFiles"></label></p></div>				
					</div>
				</div>
					</td>
				</tr>
			</table>
			<%--	</div>
			   </div>--%>
		</div><!--++++ end MODAL NUEVO REGISTRO  }} -->

	<!--REGISTRO DE LOS CONTENIDOS DE PROCESO DE DESCARTE -->
	<div class="modal fade" id="div_Contenido" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="width: 750px; left:-40px;">
                <%--<form class="form-horizontal">--%>
                <div class="modal-header">
                    <h4 class="modal-title"><b>REGISTRO DE CONTENIDOS</b></h4>
                </div>
                <div class="modal-body">                                        
                    <table style="border-collapse: separate; border-spacing: 2px;box-shadow: 0 5px 5px 1px rgba(0, 0, 0, 0.5);">
                        <tr>                            
                            <td><textarea id="Textarea_contenido"  rows="5" style="width:410px;height:75px;resize: none;"></textarea></td>                            
                         </tr>						
                    </table>
                
				    <table id="tb_contenido" class="mGrid" style="width:90%;">  
					    <thead>
					        <tr>	    
						        <th style="text-align:center;">CONTENIDO</th>						
						        <th style="text-align:center; width:10px;">ACCIONES</th>
						        
					        </tr>
					    </thead>
					<tbody>
					</tbody>        
				</table>
                </div> 
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>                    
                    <button type="button" class="btn btn-primary" id="btn_grabar_Contenido">Guarda Dato</button>
                    <input type="hidden" id="hdIddescarte" value="0" />
					<input type="hidden" id="hd_idcontenido" value="0" />
                </div>
            </div>
        </div>
    </div>

	<div id="divAddItems" style="font-size: 17px; text-align: center; width: auto;">
            <div id="div5" style="background-color: white; float: center; width: auto;">
                <div id="div6" style="text-align: center; width: 490px;">
                    <table id="Table1" style="width: 450px;">
                        <tr>
                            <td style="width: 100px" align="center" colspan="3">                         
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label id="Label13" style="font-size: 12px; text-align: right;">
                                    Items:</label>
                            </td>
                            <td rowspan="1">
								
                                <textarea id="A_txtarea" rows="4" cols="50"  style="width:400px;max-width: 400px; max-height: 70px;"></textarea>
                            </td>
                        </tr>  
                    </table>
                    <hr />
                    <table id="tbA" style="width: 450px;" class="mGrid">
                        <thead> <tr>                                                           
                                <th>
                                  Opciones de respuesta <img src='Images/iconos/radio-button-group.png' width='24px' />
                                </th>
							</tr>
                        </thead>
                        <tbody id="tbody_opciones">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


	<div id="div_menu" class="modal fade" role="dialog" style="height:155px;width:240px;margin-top:250px;margin-left:500px;">
				<%--<div class="modal-content"  style="width: 50%;height:120px;width:250px;">--%>	
				<div class="modal-content"  style="width: 50%;height:150px;width:250px;">
					<div style="width: 250px;">
					<div class="modal-header" style="width: 250px;">
                        <h4 class="modal-title" id="h2">Seleccionar</h4>
                    </div>
                    <div class="modal-body">
						<div style="float:left" ><input type="button" value="Derivacion" class="btn btn-secundari btn-md"/></div>
					<div style="float:left"><input type="button" value="Visita Tecnica" class="btn btn-secundari btn-md"/></div><br />
						<input type="button" value="cerrar" onclick="fnc_close('div_menu')" class="btn btn-primary btn-md" />
						</div>
						</div>					
				</div>
		</div>

		<!-- VISTA PREVIA O RESUMEN DEL PROCESO DE DESCARTE REGISTRADO-->
	<fieldset id="fsResumen" style="display:block">
			<div  id="div_plazo" class="modal fade" role="dialog" style="margin-top:-150px" >
		
			    <%--    <div class="modal-content">--%>
                <!-- Modal content-->
                <div class="modal-content"  style="width: 75%;margin-top:200px;box-shadow:inherit" >
	                <div style="width: auto;">
		                <div class="modal-header">
			                <h4 class="modal-title" id="h_title">MATRIZ DE DESCARTES</h4>
		                </div>
		                <div class="modal-body" style="margin-top:-20px;">
			                <div id="campañas" class="row" style="overflow-y:scroll;"></div>
				            <div class="row" id="todo">
					            <div class="col-lg-3" style="overflow-y:scroll;overflow-x:no-display ;height:550px;margin-top:10px">
						            <div id="div_cabe_secuencia"><p style="margin-left:-55px;font-weight:bold;font-size:24px">Secuencia</p></div>
							        <p></p>
							        <div id="div_secuencia" style="">
								        GHIAN_SEGUIMIENTO
							        </div>							
					            </div>
					            <div class="col-lg-9">
						            <ul id="tb_matricez" style="width:100%; text-align:left; margin-left:-120px;margin-right:-40px"></ul>
						            <div id="tb_imagenes" style="margin-left:-10px;"></div>
						            <div  id="div_plazo2" style="width:100%;">
							            <div style="margin-right:20px;margin-top:-5px;/*border-radius:30px;border:2px solid #A7A7A7;*/overflow-y:scroll;overflow-x:hidden;height:500px;/*background-color:rgba(232, 232, 232,0.5)*/" >
								            <div style="width:100%; text-align:left;" id="tbl_nivel">				
									            <br/>						            
									            <br/>
									            <br/>
									            <div class="row" style="/*padding-left:20px;*/margin-top:0px">
										            <div id="div_contenido" style="text-align:center; position: relative;left: 18px;width: 94%;">
											            <table id="tb_contenido_nivel">
											            </table>
										            </div>
										            <div id="tb_plazo" style="" ></div>
									            </div>			
		    					            </div>
							            </div>
						            </div>
					            </div>		
				            </div>	
			            </div>
		            </div>
	            </div>
            </div>
    </fieldset>
			 
	<div class="modal fade" id="div_resultado" role="dialog" style="margin-top:-100px" >
		
				  <%--    <div class="modal-content">--%>
                <!-- Modal content-->
              <div class="modal-content"  style="width: 50%;margin-top:200px" >
			
                   <div style="width: auto;">
					<div class="modal-header">
                        <h4 class="modal-title" id="h1">RESULTADO</h4>
                    </div>
                    <div class="modal-body">

						<table>
							<tr>
								<td><label>N° Incidente:</label></td>
								<td><label>23184652</label></td>
								
							</tr>
							<tr><td><label>Cliente:</label>
							    </td><td><label>Pedro Lazo</label></td></tr>
							
							<tr>
								<td><label>Tipo de solución:</label>
							    </td><td><label id="lblSolucion">No amerita VISITA TECNICA</label></td>
							</tr>
							<tr>
								<td>
									<label>Fecha Visita:</label>
								</td>
								<td>
								<input type="date"	id="txt_date"/>
								</td>
							</tr>
							<tr>
								<td><label>Hora:</label></td>
								<td><input id="txt_hora" type="time" value="11:45:00" max="22:30:00" min="10:00:00" step="1"/></td>
							</tr>
							<tr>
								<td><label>Tiempo trancurrido:</label>
								</td>
								<td><label id="lblhora_result">00:12:02</label>
							    </td>
							</tr>
							<tr>
								<td>
									<label>Observaciones:</label>
								</td>
								<td>
									<textarea id="txtarea" style="width:400px"></textarea>
								</td>
							</tr>
						</table>
						<div class="modal-footer">
                      
							<input type="button" value="Guardar" class="btn btn-primary btn-md" />
                            <input type="button" value="Cerrar" onclick="fnc_close('div_resultado');" class="btn btn-primary btn-md" />
							
                    </div>
										
						
						</div>
				</div>
				</div>
				 </div>
		<input type="hidden"  id="input_id_nivel"/>
		<style>
			.shadow {
				-moz-box-shadow: 3px 3px 5px 6px #ccc;
				-webkit-box-shadow: 3px 3px 5px 6px #ccc;
				box-shadow: 3px 3px 5px 6px #ccc;
			}

			#img_plazo {
				height: 400px;
				width: 600px;
				background-repeat: no-repeat;
				background-position: 50%;
				border-radius: 4%;
				background-size: 100% auto;
				border-color: #B4886B;
				border: solid;
			}
			/* #div_secuencia {
  border-top-width: 10px;
  border-right-width: 1em;
  border-bottom-width: thick;
  border-left-width: thin;
  border:solid;
  padding:4px;

}*/

			/*#div_alerta
			{
				border-radius: 25px;
				border: 2px solid #73AD21;
				padding: 20px;
				width: 200px;
			}*/

			#lblSecuencia {
				color: #B4886B;
				font-weight: bold;
				display: block;
				width: 150px;
				float: left;
			}

			ul {
				list-style: none;
				list-style-type: none;
				list-style-position: outside;
			}

			li {
				line-height: 30px;
				font-size: 16px;
				cursor: pointer;
			}

			#div_menu {
				width: auto;
				position: absolute;
				border: 1px solid black;
				-moz-box-shadow: 0 0 5px #888;
				-webkit-box-shadow: 0 0 5px#888;
				box-shadow: 0 0 5px #888;
			}

			.div_colores {
				width: 200px;
				text-align: center;
				float: left;
				border-radius: 8px;
				border-color: limegreen;
			}

			#tab_matrices {
				position: fixed;
				margin-top: 10px;
				width: 60%;
			}

			.desactivado {
				background-color: rgba(175, 8, 8,0.5);
			}

				.desactivado:hover {
					background-color: rgba(175, 8, 8,0.7);
				}

			.activado {
				background-color: rgba(175, 8, 8,1);
			}

			.si {
				background-color: rgba(181, 177, 176,0.7);
			}

				.si:hover {
					background-color: rgba(181, 177, 176,1);
				}

			.ultimosi {
				background-color: rgba(250, 169, 8,0.7);
			}

				.ultimosi:hover {
					background-color: rgba(250, 169, 8,1);
				}

			.no {
				background-color: rgba(175, 8, 8,0.7);
			}

				.no:hover {
					background-color: rgba(175, 8, 8,1);
				}

			.caso {
				border: 4px solid #B0B0B0;
				background-color: rgba(255, 255, 255,0.7);
			}

				.caso:hover {
					background-color: rgba(255, 255, 255,1);
				}

			.reclamo {
				border: 4px solid #B0B0B0;
				background-color: rgba(255, 255, 255,0.7);
			}

				.reclamo:hover {
					background-color: rgba(255, 255, 255,1);
				}

			.pasitos {
				background-color: #959595;
				color: black;
			}

				.pasitos:focus {
					background-color: #AF0808;
					color: #fff;
				}


			/*#tbCampanias tr:hover {
  background-color: #f00;
  cursor: pointer;
}*/
    .shadowBox{
        width: 400px;
        height: 180px;
        background-color: #AAAAAA;
        -webkit-box-shadow: 0 8px 6px -6px black;
        -moz-box-shadow: 0 8px 6px -6px black;
        box-shadow: 0 8px 6px -6px black;
    }          
		</style>
		</center>

<script src="assets/lib/react/react.min.js"></script>
    <script src="assets/lib/react/react-dom.min.js"></script>
    <script src="assets/js/sgp.jsx" type="text/javascript"></script>
    <script src="assets/lib/ckeditor/ckeditor.js"></script>
    <script src="Libreria/js/Codigo_Web/manNiveles.js"></script>    
    <script>
        //CKEDITOR.config.height = 150;
        //CKEDITOR.config.width = 'auto';
        ////CKEDITOR.config.width = 600;
        //CKEDITOR.replace("Textarea_contenido");                
    </script>    
</asp:Content>



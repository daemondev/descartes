<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_Gestion.aspx.cs" Inherits="Frm_Gestion" %>


<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
	<script src="Libreria/js/Codigo_Web/JS_frmGestion.js"></script>
	<link href="Libreria/reloj/Relojstyle.css" rel="stylesheet" />

	<center>
			
	   <div style="background-color: #00A65A; border-radius: 5px;">
        <%--<h4 class="modal-title">Gestion de procesos</h4>--%>
            <div id="timer" class="shadow">
                <div class="container">
                    <div id="hour">00</div>
                    <div class="divider">:</div>
                    <div id="minute">00</div>
                    <div class="divider">:</div>
                    <div id="second">00</div>       
                 
                </div>
<%--      <input type="button" id="btn-comenzar" value="Iniciar" onclick="fnc_stop2()"/>--%>
			    <a onclick= "fnc_stop2()"><label id="lblEstado" >Comenzar</label></a>
            </div>
		</div>
		<div style="visibility:hidden"><p id="nombreMatriz"></p></div>		
        <div style="float:initial;width:100%;" id="div_buscarCliente"> 
			<br />			
			<div style="margin-top:-20px;">
				<!--<div  style="height:280px;width:600px;border-radius:15px;border-color:#B4886B" class="ui-accordion ui-widget ui-helper-reset" role="tablist" >-->
            <div id="campañas" class="row" style="overflow-y:scroll;"></div>
            <div class="row" id="todo"> <!--### begin div id=todo {{-->
                <div class="col-lg-3" style="overflow-y:scroll;overflow-x:no-display ;height:550px">
                        <div id="div_cabe_secuencia">
                            <p style="margin-left:-55px;margin-top:-12px;font-weight:bold;font-size:24px">Secuencia</p>
                        </div>
                        <p></p>
                        <div id="div_secuencia" style=""> </div>							
					
                </div>
                <div class="col-lg-9">
                    <ul id="tb_matricez" style="width:100%; text-align:left; margin-left:-120px;margin-right:-40px"></ul>
                    <div id="tb_imagenes" style="margin-left:-10px;"></div>
                    <div  id="div_plazo" style="width:100%;">
                        <div style="margin-right:20px;margin-top:-5px;/*border-radius:30px;border:2px solid #A7A7A7;*/overflow-y:scroll;overflow-x:hidden;height:500px;/*background-color:rgba(232, 232, 232,0.5)*/" >
					        <div style="width:100%; text-align:left;" id="tbl_nivel">				
                                <br/>
						        <!--<label id="lblDescripcion_plazo" style="font-size:24px;color:rgba(175, 8, 8,1);font-weight: bold;"></label>-->
                                <br/>
                                <br/>
                                <div class="row" style="/*padding-left:20px;*/margin-top:-61px">
								    <div id="div_alerta" style="border-radius:9px;" >
										<label id="lblAlerta_plazo" style="margin-left:30px;font-size:16px;"></label>						
									</div>
									<div id="tb_plazo" style=""></div>
                                </div>			
		    				</div>
				        </div>
                    </div>
                </div>		
            </div>	                 <!--### end div id=todo  }}-->
		</div>
        </div>

		
		<input type="hidden"  id="input_id_nivel"/>
	

		<div class="modal fade" id="div_resultado" role="dialog" style="margin-top:-100px" >
		
				  <%--    <div class="modal-content">--%>
                <!-- Modal content-->
              <div class="modal-content"  style="width: 50%;margin-top:200px;"  >
			
                   <div style="width: auto;">
					<div class="modal-header" >
                        <h4 class="modal-title" id="h1">FINALIZACION DEL PROCESO</h4>
                    </div>
                    <div class="modal-body">
                        <h5>¿DESEA GUARDAR EL PROCESO?</h5>
						<!--<table>
							<%--<tr>
								<td><label>N° Incidente:</label></td>
								<td><label>23184652</label></td>
								
							</tr>--%>
							<tr><td><label>Cliente:</label>
							    </td><td><label id="lblClieSolucion"></label></td></tr>
							
							<tr>
								<td><label>Tipo de solución:</label>
							    </td><td><label id="lblSolucion"></label></td>
							</tr>
							<tr>
								<td>
									<label>Fecha Visita:</label>
								</td>
								<td>
								<input type="date"	id="txt_date" value=""/>
								</td>
							</tr>
							<tr>
								<td><label>Hora:</label></td>
								<td><input id="txt_hora" type="time" value="00:00:00" max="21:00:00" min="10:00:00" step="1"/></td>
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
						</table>-->
						<div class="modal-footer">                      
							<input type="button" value="Guardar" class="btn btn-primary btn-md"  onclick="fnc_guardarSolucion()"/>
				<input type="button" value="Cerrar" onclick="fnc_close('div_resultado');" class="btn btn-primary btn-md" />							
                    </div>
										
						
						</div>
				</div>
				</div>
				 </div>
	

			<div id="div_cod_incidencia" class="modal fade" role="dialog" style="width:auto" >

			<div class="modal-content" style="border-radius: 15px;" >
				<div class="modal-header"><h4>Codigo de incidencia</h4></div>
				<div class="modal-body">
					<h6><label id="lblCod_incidencia"></label></h6>
				</div>
							</div>
		</div>


        	<div id="div_historial" class="modal fade" role="dialog" style="width:auto;" >

			<div class="modal-content" style="border-radius: 15px;width:800px;margin-top:100px" >
				<div class="modal-header" style="    border-radius: 10px;"><h4>Historial del Cliente</h4></div>
				<div class="modal-body" style="overflow-y: scroll;">
					<h6><label id="Label1"></label></h6>
                    <table class="mGrid">
                        <thead>
                            <tr>
                                <th>Cliente</th>
                                <th>Codigo Cliente</th>
                                <th>Resultado</th>
                                <th>Fec. Registro</th>
                                <th>Duracion</th>
                                <th>Tpificacion</th>
                                <th>Observacion</th>
                            </tr>
                        </thead>
                        <tbody id="tb_historiaCliente"></tbody>
                    </table>
				</div>
							</div>
		</div>
		<input type="hidden" id="hiden_in_cliente" />
<input type="hidden" id="hiden_vc_resultado" />

		<style>
	  .shadow {
  -moz-box-shadow:    3px 3px 5px 6px #ccc;
  -webkit-box-shadow: 3px 3px 5px 6px #ccc;
  box-shadow:         3px 3px 5px 6px #ccc;
}
	  #img_plazo{   
		height: 400px;
		width: 1000px;    
		background-repeat: no-repeat;
		background-position: 50%;
		border-radius: 4%;
		background-size: 100% auto;
		border-color:#B4886B;
		border: solid;	
	}
	/*#div_secuencia {
	  border-top-width: 10px;
	  border-right-width: 1em;
	  border-bottom-width: thick;
	  border-left-width: thin;
	  border:solid;
	  padding:4px;

	}*/


			#lblSecuencia{
				color: #B4886B;
				font-weight: bold;
				display: block;
				width: 150px;
				float: left;
			}

			ul
			{
				list-style: none;
				list-style-type: none;
				list-style-position: outside;
			}

			li
			{
				line-height: 30px;
				font-size: 16px;
				cursor: pointer;
			}

			#div_menu{
			  width:auto;
			  position:absolute;      
			  border:1px solid black;       
			  -moz-box-shadow: 0 0 5px #888;
			  -webkit-box-shadow: 0 0 5px#888;
			  box-shadow: 0 0 5px #888;
		}

.plegable{
   height:0;
   overflow:hidden;
}
#timer {
    background-color: #EBE9EA;
    border: 1px solid #D2D2D2;
    border-radius: 8px 8px 8px 8px;
    float: right;
    position: absolute;
    min-height: 60px;
    margin-bottom: 10px;
    margin-left: 84%;
    margin-top: 35%;
    overflow: hidden;
    text-align: center;
    width: 130px;
    height: 10px;	
}
			#div_Cliente
			{
				margin-top: -45px;
				float:right;
				width:200px;
				border-radius:14px;			
				border:solid;
				border-color:#B4886B;		
    position: absolute;
    margin-left: 83%;
    margin-top: 10px;
}
			
			#div_cabe_secuencia {
                padding:20px 140px;
				border-radius: 8px;
				color: #000;
                font-weight:bold;
				margin-top: 5px;
                /*margin-left:-40px;
                margin-right:-40px*/
				/*width: 180px;*/
				/*position: static;*/
				height: 50px;
				/*border-radius:14px;*/
				background-color: #949191;
			}
			#div_cod_incidencia
			{
				
    width: 200px;
    display: block;
    position: fixed;
    margin-top: 20%;
    margin-left: 50%;
    border-radius: 10px;
	
		border-color: darkkhaki;
		border:solid;
}
			#div_plazo
			{
				    position: absolute;
                    /*margin-left: 10%;*/
			}

			#tab_matrices
			{
				position:fixed;

				margin-top:10px;
				width:60%;

			}

		    .desactivado {
		    
                background-color:rgba(175, 8, 8,0.5);
            }

		    .desactivado:hover {
		        background-color:rgba(175, 8, 8,0.7);
            }

            .activado {
		    
                background-color:rgba(175, 8, 8,1);
            }

		    .si {
		       background-color:rgba(181, 177, 176,0.7); 
            }

		    .si:hover {
		        background-color:rgba(181, 177, 176,1);
            }

            .ultimosi {
		       background-color:rgba(250, 169, 8,0.7); 
            }

		    .ultimosi:hover {
		        background-color:rgba(250, 169, 8,1);
            }

            .no {
		       background-color:rgba(175, 8, 8,0.7); 
            }

		    .no:hover {
		        background-color:rgba(175, 8, 8,1);
            }

		    .caso {
                border:4px solid #B0B0B0;
		      background-color:rgba(255, 255, 255,0.7);   
            }
		    .caso:hover {
              background-color:rgba(255, 255, 255,1);   
		    }

            .reclamo {
                border:4px solid #B0B0B0;
		      background-color:rgba(255, 255, 255,0.7);   
            }
		    .reclamo:hover {
              background-color:rgba(255, 255, 255,1);   
		    }
		    .pasitos {
		         background-color:#959595;
                 color:black;
            }
		    .pasitos:focus {
		        background-color:#AF0808;
                color:#fff;                    
            }

		</style>
	
		</center>
</asp:Content>


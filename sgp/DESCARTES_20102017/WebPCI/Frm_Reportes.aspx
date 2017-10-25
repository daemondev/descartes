<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Frm_Reportes.aspx.cs" Inherits="Frm_Reportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CONTENEDOR" Runat="Server">
    <script src="Libreria/js/Codigo_Web/reportes.js"></script>
    <center>        
    <div style="background-color: #d43f3a; border-radius: 5px;color:white">
        <h4 class="modal-title">REPORTES</h4>
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
            <tr>
            </tr>
            <tr>
                <td>
                    <label>Desde :</label>
                </td>
                <td> 
                    <input type="date" id="f1" class="form-control" style="width:200px" />
                    </td>
              
                   <td><label>Hasta:</label></td>
                    <td><input type="date" id="f2" class="form-control"  style="width:200px"/></td>
                    

<%--                    <select id="ddlOpc" class="form-control" style="width: 200px;">
                        <option value="0">[SELECCIONAR]</option>
                        <option value="1">Asistencias</option>
                        <option value="2">Pagos</option>
                    </select>--%>
                
                <!--<td style="text-align: right;">
                    <button type="button" class="btn btn-primary btn-md" onclick="Exportar();">Exportar</button>
                </td>-->
            </tr>
        </table>
        <br />
        <br />
        <br />  
        <ul>
            <li style='display: inline-block; margin-left:0px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:18px;'><button type="button" class="btn btn-primary btn-lg btn-md" onclick="ExportarGeneral();">Reporte General y Detallado</button></li>
            
        </ul>
        
        <%--<div id="dvCapas">
            <table id="tbCapacitacion" class="mGrid" style="width:100%;">  
                <thead>
                    <tr>	    
                        <th style="width:3%;"></th>
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
                        <th style="width:3%;"></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>        
            </table>
        </div>--%>
    </center>
</asp:Content>


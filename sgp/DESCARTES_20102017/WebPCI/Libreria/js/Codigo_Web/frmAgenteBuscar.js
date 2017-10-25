var urlCamp = "Frm_MantCampanias.aspx/";
var urlSedes = "Frm_MantSede.aspx/";
var urlAgenteBuscar = "Frm_AgenteBuscar.aspx/";
var urlCapa = "Frm_MantCapacitacion.aspx/";
var urlAsistencia = "Frm_AsistenciaAgentes.aspx/";
var urlValidaciones = "Frm_Validaciones.aspx/";
var pgnum = 1;

$(document).ready(function () {

    ListarSede("#ddlSedes");
    ListarCampanias("#ddlCampanias");

    $("#ddlSedes").change(function () {
        ListarCampanias("#ddlCampanias");
    });

    $("#ddlCampanias").change(function () {
        getBuscarAgente(1);
    });
});

function getBuscarAgente(pgnum) {
    if ($("#ddlCampanias").val() != 0 || $.trim($("#txtBuscar").val()) != "") {
        var txt = "%";
        if ($.trim($("#txtBuscar").val()) != "") {
            txt = $("#txtBuscar").val();
        }
        var objData = {};
        objData["in_Opc"] = 1;
        objData["in_NumPagina"] = pgnum;
        objData["in_TamPagina"] = 20;
        objData["vc_Agente"] = txt;
        objData["in_AgenteID"] = 0;
        objData["in_CampaniaID"] = $("#ddlCampanias").val();
        objData["in_CapaID"] = 0;

        $.ajax({
            async: false,
            type: "POST",
            url: urlAgenteBuscar + "getAgentesBuscar",
            data: JSON.stringify(objData),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                var pageCount = 0;
                var StrPager; var strRows;
                $('#tbAgentes tr:not(:first)').remove();
                if (data.length > 0) {
                    for (var i = 0; i <= data.length; i++) {
                        if (data.length == i) {
                            pageCount = data[0].in_TotalRegistros;
                            var StrPager = "";
                            if (pageCount > 1) {
                                for (var x = 1; x <= pageCount; x++) {
                                    if (x == 1) {
                                        StrPager = "<tr class='pgr'><td colspan='15' style='text-align:center;padding:6px;'>";
                                    }
                                    StrPager = StrPager + "<label style='line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #0A0A0A;font-weight: bold;" + (x == pgnum ? "color: #F4FAF4;" : "color: #080809;cursor:pointer;" + "'  onclick='getBuscarAgente(" + x + ");") + "'>" + x + "</label>";
                                    if (x == pageCount) {
                                        StrPager = StrPager + "</td></tr>";
                                    }
                                }
                            } else { StrPager = "<tr class='pgr'><td colspan='15' style='text-align:left;padding:10px;'></td></tr>"; }
                        } else {
                            if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                            strRows += //"<td align=center><img src='libreria/imagenes/Botones/Activo.png' title='Detalle' onclick='irDetalleAgente(" + data[i].in_AgenteID + "," + data[i].in_CapaID + ");' style='cursor:pointer;' width='13px' height='13px' /></td>" +
                                       "<td>" + data[i].vc_Usuario + "</td>" +
                                       "<td>" + data[i].vc_DNI + "</td>" +
                                       "<td>" + data[i].Nombres + "</td>" +
                                       "<td>" + data[i].vc_Titulo + "</td>" +
                                       "<td>" + data[i].vc_Campania + "</td>";
                            strRows += "<td align=center><img src='libreria/imagenes/Botones/ver.jpg' title='Detalle' onclick='irDetalleAgente(" + data[i].in_AgenteID + "," + data[i].in_CapaID + ");' style='cursor:pointer;' width='15px' height='15px' /></td>" +
                                       "<td align=center>" + (data[i].in_Estado == 0 ? "<img src='libreria/imagenes/Botones/Desactivo.png' " : "<img src='libreria/imagenes/Botones/Activo.png' ") + " width='13px' height='13px' /></td>" +
                                       "</tr>";
                        }
                    }
                    $("#tbAgentes").append(strRows + StrPager);

                } else { $("#tbAgentes").append("<tr><td style='text-align:center;' colspan='15'>No hay datos para mostrar</td></tr>"); } 
            }//Fin Success
        }); //Fin Ajax
    } else {
        $('#tbCapa tr:not(:first)').remove();
        $("#tbCapa").append("<tr><td style='text-align:center;' colspan='10'>No hay capacitaciones registradas</td></tr>");
        $('#tbAgentes tr:not(:first)').remove();
        $("#tbAgentes").append("<tr><td style='text-align:center;' colspan='15'>No hay datos para mostrar</td></tr>");
        $('#tbAsistencia tr:not(:first)').remove();
        $("#tbAsistencia").empty().html("<tr><td>No registra asistencia</td></tr>");
        $('#tbDetalle tr:not(:first)').remove();
        $("#tbDetalle").empty().html("<tr><td>No registra pagos</td></tr>");
    }
}

function getAgente(idAgente) {
    var objData = {};
    objData["in_Opc"] = 4;
    objData["in_NumPagina"] = 0;
    objData["in_TamPagina"] = 20;
    objData["vc_Agente"] = "";
    objData["in_AgenteID"] = idAgente;
    objData["in_CampaniaID"] = 0;
    objData["in_CapaID"] = 0;

    $.ajax({
        async: false,
        type: "POST",
        url: urlAgenteBuscar + "getAgentesBuscar",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                $("#Nombres").text(data[0].Nombres);
            }
        }//Fin Success
    }); //Fin Ajax
}
function irDetalleAgente(idAgente, idCapa) {
    getAgente(idAgente);
    var objData = {};
    objData["in_opc"] = 5;
    objData["nroPagina"] = 0;
    objData["tamPagina"] = 0;
    objData["in_CapaID"] = idCapa;
    objData["vc_Abreviatura"] = "";
    objData["vc_Titulo"] = "";
    objData["in_CampaniaID"] = 0;
    objData["vc_FechaInicio"] = "";
    objData["in_CantAgentes"] = 0;
    objData["in_CantDias"] = 0;
    objData["PagoTotal"] = 0;
    objData["PagoDia"] = 0;
    objData["in_CantPartes"] = 0;
    objData["vc_Cierre"] = "";
    objData["vc_Monto"] = "";
    objData["vc_Pago"] = "";
    objData["in_TurnoID"] = 0;
    $.ajax({
        async: false,
        type: "POST",
        url: urlCapa + "mantCapacitacion",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tbCapa tr:not(:first)').remove();
            if (data.length > 0) {
                for (var i = 0; i <= data.length; i++) {
                    if (data.length == i) {
                        pageCount = data[0].in_TotalRegistros;
                        var StrPager = "";
                        if (pageCount > 1) {
                            for (var x = 1; x <= pageCount; x++) {
                                if (x == 1) {
                                    StrPager = "<tr class='pgr'><td colspan='9' style='text-align:left;padding:6px;'>";
                                }
                                if (x == pageCount) {
                                    StrPager = StrPager + "</td></tr>";
                                }
                            }
                        } else { StrPager = "<tr class='pgr'><td colspan='9' style='text-align:left;padding:10px;'></td></tr>"; }
                    } else {
                        if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                        strRows +=
                                   "<td>" + data[i].vc_Abreviatura + "</td>" +
                                   "<td>" + data[i].vc_Titulo + "</td>" +
                                   "<td>" + data[i].dt_FechInicio + "</td>" +
                                   "<td>" + data[i].dt_FechFin + "</td>" +
                                   //"<td>" + data[i].vc_Nombres + "</td>" +
                                   //"<td style='text-align:center;'>" + data[i].in_CantAgentes + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantDias + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_PagoTotal + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_PagoDia + "</td>" +
                                   //"<td style='text-align:center;'>" + data[i].in_CantPartes + "</td>" +
                                   //"<td align=center><img src='libreria/imagenes/Botones/addControl.gif' title='Ver detalle' onclick='getDetalleCapacitacion(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' /></td>"+
                                   "</tr>";
                    }
                }
                $("#tbCapa").append(strRows);

            } else { $("#tbCapa").append("<tr><td style='text-align:center;' colspan='10'>No hay capacitaciones registradas</td></tr>"); }
            getDetalleAsistencias(idAgente, idCapa);
            getDetallePagos(idAgente, idCapa);
            $("#dvAgenteBuscarDetalle").modal('show');
        }//Fin Success
    }); //Fin Ajax
}

function getDetallePagos(idAgente, idCapa) {
    var objData = {};
    objData["idAgente"] = idAgente;
    objData["idCapa"] = idCapa;

    $.ajax({
        async: false,
        type: "POST",
        url: urlAgenteBuscar + "getAgenteBuscarPagos",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var contenido;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                contenido += "<thead><tr>";
                var cabe = data[0].vc_Filas.split(";");
                //contenido += "<th></th>";
                for (var i = 1; i < cabe.length; i++) {
                    //contenido += "<th></th><th>A</th><th>F</th>";
                    if (i > 2) {                        
                        contenido += "<th colspan='7' style='text-align:center;'><button type='button' style='color: black'>" + cabe[i] + "</button></th>";
                    } 
                }
                contenido += "</tr></thead><tbody><tr>";
                for (var i = 1; i < data.length; i++) {
                    var deta = data[i].vc_Filas.split(";");
                    for (var j = 0; j < deta.length; j++) {
                        if (j > 2) {
                            contenido += "<td style='text-align:center;'>Monto</td><td style='text-align:center;'>A</td><td style='text-align:center;'>F</td><td colspan='4'></td>";
                        }
                    }
                    contenido += "</tr><tr class='alt'>";
                    for (var j = 1; j < deta.length; j++) {
                        if (j > 2) {
                            contenido += "<td style='text-align:center;'>" + deta[j] + "</td>";
                            var objData = {};
                            objData["inOpc"] = 3;
                            objData["idCapa"] = idCapa;
                            objData["inAgenteID"] = deta[0];
                            objData["inNroPago"] = cabe[j];
                            objData["inValidar"] = 0;

                            $.ajax({
                                async: false,
                                type: "POST",
                                url: urlValidaciones + "getPagosDetalle",
                                data: JSON.stringify(objData),
                                dataType: "json",
                                contentType: "application/json; charset=utf-8",
                                success: function (response) {
                                    var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                                    if (data.length > 0) {
                                        contenido += "<td style='text-align:center;'>" + data[0].in_CantAsis + "</td>";
                                        contenido += "<td style='text-align:center;'>" + data[0].in_CantFalt + "</td>";
                                        if (data[0].dc_Monto == 0) {
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                        } else if (data[0].in_ValidCapa == 0) {
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValCa" + deta[0] + "' name='chValCa" + cabe[j] + "' disabled='disabled' /></td>";
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                        } else {
                                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValCa" + deta[0] + "' name='chValCa" + cabe[j] + "' disabled='disabled' checked='checked' /></td>";
                                            if (data[0].in_ValidDH == 0) {
                                                contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValDH" + deta[0] + "' name='chValDH" + cabe[j] + "' disabled='disabled' /></td>";
                                                contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                                contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                            } else {
                                                contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValDH" + deta[0] + "' name='chValDH" + cabe[j] + "' disabled='disabled' checked='checked' /></td>";
                                                if (data[0].in_ValidPM == 0) {
                                                    contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValPM" + deta[0] + "' name='chValPM" + cabe[j] + "' disabled='disabled' /></td>";
                                                    contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' /></td>";
                                                } else {
                                                    contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValPM" + deta[0] + "' name='chValPM" + cabe[j] + "' disabled='disabled' checked='checked' /></td>";
                                                    if (data[0].in_Pagado == 0) {
                                                        contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chPagos" + deta[0] + "' name='chPagos" + cabe[j] + "' disabled='disabled'  /></td>";
                                                    } else {
                                                        contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chPagos" + deta[0] + "' name='chPagos" + cabe[j] + "' disabled='disabled' checked='checked' /></td>";
                                                    }
                                                }
                                            }
                                        }
                                    }
                                },
                            });
                            //////////////////////////////////////////
                        }
                    }
                }
                contenido += "</tr></tbody>";
                $("#tbDetalle").empty().html(contenido);
            } else {
                var contenido = "<tr><td>No registra pagos</td></tr>";
                $("#tbDetalle").empty().html(contenido);
            }
        },
        error: function (data) {
            var contenido = "<tr><td>No registra pagos</td></tr>";
            $("#tbDetalle").empty().html(contenido);
        }
    });
};

function getDetalleAsistencias(idAgente, idCapa) {
    var objData = {};
    objData["idAgente"] = idAgente;
    objData["idCapa"] = idCapa;

    $.ajax({
        async: false,
        type: "POST",
        url: urlAgenteBuscar + "getAgentesBuscarAsistencia",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var contenido;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                contenido += "<thead><tr>";
                var cabe = data[0].vc_ItemAsistencia.split(";");
                var cabeTitle = data[1].vc_ItemAsistencia.split(";");
                for (var i = 1; i < cabe.length; i++) {
                    if (i == 1 || i == 2) {
                    } else {
                        contenido += "<th style='text-align:center;'><button type='button' title='" + cabeTitle[i] + "' style='color: black'>" + cabe[i] + "</button></th>";
                    }
                }
                contenido += "<th style='text-align:center;width:3%;'>ASIST</th><th style='text-align:center;width:3%;'>FALTAS</th>";
                contenido += "</tr></thead><tbody>";
                for (var i = 2; i < data.length; i++) {
                    var deta = data[i].vc_ItemAsistencia.split(";");
                    contenido += "<tr class='alt'>";
                    for (var j = 1; j < deta.length; j++) {
                        if (deta[j] == 1) {
                            contenido += "<td align=center><img src='libreria/imagenes/Botones/Activo.png' width='13px' height='13px' /></td>";
                        } else if (deta[j] == 0) {
                            contenido += "<td align=center><img src='libreria/imagenes/Botones/Desactivo.png' width='13px' height='13px' /></td>";
                        } else {
                        }
                    }
                    var objData = {};
                    objData["in_Opc"] = 6;
                    objData["in_CapaID"] = 0;
                    objData["in_CantAsist"] = 0;
                    objData["in_CantFalt"] = 0;
                    objData["in_Agente"] = deta[0];
                    objData["in_Asitencia"] = 0;
                    objData["in_Condicion"] = 0;

                    $.ajax({
                        async: false,
                        type: "POST",
                        url: urlAsistencia + "mantAsistencias",
                        data: JSON.stringify(objData),
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                            if (data.length > 0) {
                                contenido += "<td style='text-align:center;width:3%;'>" + data[0].in_CantAsitentes + "</td>" +
                                    "<td style='text-align:center;width:3%;'>" + data[0].in_CantFaltantes + "</td>" +
                                    "</tr>";
                            }
                        },
                        error: function (data) {
                        }
                    });
                }
                contenido += "</tbody>";
                $("#tbAsistencia").empty().html(contenido);
            } else {
                contenido = "<tr><td>No registra asistencia</td></tr>";
                $("#tbAsistencia").empty().html(contenido);
            }
        },
        error: function (data) {
            contenido = "<tr><td>No registra asistencia</td></tr>";
            $("#tbAsistencia").empty().html(contenido);
        }
    });
};

function getDetalleCapacitacion(idCapacitacion) {
    var objData = {};
    objData["id"] = idCapacitacion;

    $.ajax({
        async: false,
        type: "POST",
        url: urlCapa + "VerDetalle",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tbDetalleCapa tr:not(:first)').remove();
            if (data.length > 0) {
                for (var i = 0; i <= data.length; i++) {
                    if (data.length == i) {
                        pageCount = data[0].in_TotalRegistros;
                        var StrPager = "";
                        if (pageCount > 1) {
                            for (var x = 1; x <= pageCount; x++) {
                                if (x == 1) {
                                    StrPager = "<tr class='pgr'><td colspan='15' style='text-align:left;padding:6px;'>";
                                }
                                if (x == pageCount) {
                                    StrPager = StrPager + "</td></tr>";
                                }
                            }
                        } else { StrPager = "<tr class='pgr'><td colspan='15' style='text-align:left;padding:10px;'></td></tr>"; }
                    } else {
                        if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                        strRows +=
                                   "<td style='text-align:center;'>" + data[i].in_Orden + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_Cierre + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_Monto + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_Dia + "</td>" +
                                   "</td></tr>";
                    }
                }
                $("#tbDetalleCapa").append(strRows + StrPager);

            } else { $("#tbDetalleCapa").append("<tr><td style='text-align:center;' colspan='15'>No hay datos para mostrar</td></tr>"); }
            $("#dvDetalleCapa").modal('show');
        },
        error: function (data) {
            new Messi("Error al traer los datos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    });
};

function ListarSede(cbo) {
    var objData = {};
    objData["in_opc"] = 6;
    objData["in_SedeID"] = 0;
    objData["vc_Sede"] = "";

    $.ajax({
        async: false,
        type: "POST",
        url: urlSedes + "mantSedes",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        beforeSend: function () { $(cbo).html("<option>Cargando..</option").attr("disabled", "disabled"); },
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $(cbo).html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");
            for (var i = 0; i < data.length; i++) {
                $(cbo).append("<option value=\"" + data[i].in_SedeID + "\">" + data[i].vc_Sede + "</option>");
            }
        }
    });
};

function ListarCampanias(cbo) {
    var objData = {};
    objData["in_opc"] = 1;
    objData["in_CampaniaID"] = 0;
    objData["in_SedeID"] = $("#ddlSedes").val();
    objData["vc_Campania"] = "";
    objData["dc_PagoDia"] = 0;

    $.ajax({
        async: false,
        type: "POST",
        url: urlCamp + "mantCampania",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        beforeSend: function () { $(cbo).html("<option>Cargando..</option").attr("disabled", "disabled"); },
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $(cbo).html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");
            for (var i = 0; i < data.length; i++) {
                $(cbo).append("<option value=\"" + data[i].in_CampaniaID + "\">" + data[i].vc_Campania + "</option>");
            }
        }
    });
};
var urlCapa = "Frm_MantCapacitacion.aspx/";
var urlAsistencia = "Frm_AsistenciaAgentes.aspx/";
var pgnum = 1; var cantAsis = 0; var cantFalt = 0; var inResul = 0; var inAsisID = 0;

$(document).ready(function () {
    
    if (sessionStorage.getItem("seCapacitacion") == null) {
        window.location.href = "Frm_MantCapacitacion.aspx";
    }
    var objCapa = sessionStorage.getItem("seCapacitacion");
    var objCapa = JSON.parse(objCapa);
    $("#hdCapaID").val(objCapa.idCapacitacion);
    $("#hdEstado").val(objCapa.vcEstado);

    getCapa();
    getDetalleAsistencias();
});

function getDetalleAsistencias() {
    var objData = {};
    objData["idCapa"] = $("#hdCapaID").val();

    $.ajax({
        async: false,
        type: "POST",
        url: urlAsistencia + "VerDetalleAsistencias",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var contenido;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                debugger;
                contenido += "<thead><tr>";
                var cabe = data[0].vc_ItemAsistencia.split(";");
                var cabeTitle = data[1].vc_ItemAsistencia.split(";");
                contenido += "<th></th>";
                for (var i = 1; i < cabe.length; i++) {
                    if (i == 1 || i == 2) {
                        contenido += "<th>" + cabe[i].substring(3, cabe[i].length) + "</th>";
                    } else {
                        contenido += "<th style='text-align:center;'><label style='font-weight: bold;' title='" + cabeTitle[i] + "'>" + cabe[i] + "</label></th>";
                        //contenido += "<th style='text-align:center;'><button type='button' title='" + cabeTitle[i] + "' style='color: black; font-size: 10px;'>" + cabe[i] + "</button></th>";
                    }
                }
                if ($("#hdEstado").val() == "Cerrado") {
                    contenido += "<th style='text-align:center;width:3%;'>ASIST</th><th style='text-align:center;width:3%;'>FALTAS</th>";
                } else {
                    contenido += "<th></th><th>Seleccione</th>";
                }
                contenido += "</tr></thead><tbody>";
                for (var i = 2; i < data.length; i++) {
                    var deta = data[i].vc_ItemAsistencia.split(";");
                    if (i % 2 == 0) {
                        contenido += "<tr><td>" + (i-1) + "</td>";
                    } else {
                        contenido += "<tr class='alt'><td>" + (i - 1) + "</td>";
                    }
                    for (var j = 1; j < deta.length; j++) {
                        if (deta[j] == 1) {
                            contenido += "<td align=center><img src='libreria/imagenes/Botones/Activo.png' width='13px' height='13px' /></td>";
                        } else if (deta[j] == 0) {
                            contenido += "<td align=center><img src='libreria/imagenes/Botones/Desactivo.png' width='13px' height='13px' /></td>";
                        } else {
                            contenido += "<td>" + deta[j] + "</td>";
                        }
                    }
                    if ($("#hdEstado").val() == "Cerrado") {
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
                    } else {
                        contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' checked='checked' id='" + deta[0] + "' name='ch' onclick='setHabDDL(" + deta[0] + ");' disabled='disabled' /></td>" +
                                    "<td style='text-align:center;width:10%;'><select id='ddlCondicion" + deta[0] + "' name='ddl' disabled='disabled' style='width: 80px;' >" +
                                    "<option value='1'>Normal</option>" +
                                    "</select>" +
                                    "</td>" +
                                    "</tr>";
                    }
                }
                contenido += "</tbody>";
                $("#tbAsistencia").empty().html(contenido);
            }
        },
        error: function (data) {
            //alert('error');
        }
    });
};

function setHabDDL(id) {
    if ($("#" + id).prop("checked") == true) {
        $("#ddlCondicion" + id).attr("disabled", true);
        $("#ddlCondicion" + id).empty().html("<option value='1'>Normal</option>");
    } else {
        $("#ddlCondicion" + id).attr("disabled", false);
        $("#ddlCondicion" + id).empty().html("<option value='2'>Falta</option><option value='3'>Deserción</option>");
    }
}

function getCapa() {
    var objData = {};
    objData["in_opc"] = 5;
    objData["nroPagina"] = 0;
    objData["tamPagina"] = 0;
    objData["in_CapaID"] = $("#hdCapaID").val();
    objData["vc_Abreviatura"] = "";
    objData["vc_Titulo"] = "";
    objData["in_CampaniaID"] = 0;
    objData["vc_FechaInicio"] = "";
    objData["in_CantAgentes"] = 0;
    objData["in_CantDias"] = 0;
    objData["PagoDia"] = 0;
    objData["PagoTotal"] = 0;
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
                                   "<td style='text-align:center;'>" + data[i].vc_Abreviatura + "</td>" +
                                   "<td>" + data[i].vc_Titulo + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dt_FechInicio + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_Turno + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantAgentes + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantDias + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_PagoTotal + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_PagoDia + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantPartes + "</td>" +
                                   "<td align=center><img src='libreria/imagenes/Botones/addControl.gif' title='Ver detalle' onclick='getDetalleCapacitacion(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' /></td>";
                        if ($("#hdEstado").val() != "Cerrado") {
                            strRows += "<td style='text-align:center;'><button type='button' id='btnHabAsistencia' onclick='setHabilitarAsistencia();' class='btn btn-primary btn-md' >Pasar lista</button>" +
                                        "<label style='font-weight: bold; color: red;'>Repetir</label>" +
                                        "<input type='checkbox' id='chRepetirAsistencia' name='chRepetirAsistencia' /></td>" +
                                        "<td style='text-align:center;'><button type='button' id='btnGuardarAsistencia'  onclick='setAsistencia();'  disabled='disabled' class='btn btn-primary btn-md'>Guardar</button></td>" +
                                        "</tr>";
                        } else {
                            strRows += "<td></td>" +
                                        "<td></td>" +
                                        "</tr>";
                        }
                    }
                }
                $("#tbCapa").append(strRows);

            } else { $("#tbCapa").append("<tr><td style='text-align:center;' colspan='10'>No hay capacitaciones registradas</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
}

function setAsistencia() {
    setDesHabilitarCheck();
    $("#btnGuardarAsistencia").attr("disabled", true);
    $("#btnHabAsistencia").attr("disabled", false);
    setGuardarAsistencia();
    if (inResul != 0) {
        getDetalleAsistencias();
        new Messi("Guardado con éxito", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
    } else {
        new Messi("Ocurrió un error al tratar de guardar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
    }
    $("#chRepetirAsistencia").attr("disabled", false);
    $("#chRepetirAsistencia").attr("checked", false);
}

function setGuardarAsistencia() {
    var inOpc = 3;//gurdar asistencia diaria
    if ($("#chRepetirAsistencia").is(":checked")) {
        inOpc = 8;
    } 
    cantAsis = 0;
    cantFalt = 0;
    $('input:checkbox[name=ch]').each(function () {
        if (!$(this).is(":checked")) {
            cantFalt++;
        } else { cantAsis++; }
    });
    var objData = {};
    objData["in_Opc"] = inOpc;
    objData["in_CapaID"] = $("#hdCapaID").val();
    objData["in_CantAsist"] = cantAsis;
    objData["in_CantFalt"] = cantFalt;
    objData["in_Agente"] = 0;
    objData["in_Asitencia"] = inAsisID; //tambien para actualizar la asistencia del dia
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
            if (data[0].in_Resul >= 1) {
                if (inOpc == 8) {
                    setGuardarDetalleAsistencia(inAsisID);
                } else {
                    setGuardarDetalleAsistencia(data[0].in_Resul);
                }
            } else { inResul = 0; }
        },
        error: function (data) {
            inResul = 0;
        }
    });
}

function setGuardarDetalleAsistencia(idAsisCabe) {
    var inOpc = 4;//gurdar asistencia diaria
    if ($("#chRepetirAsistencia").is(":checked")) {
        inOpc = 9;
    }
    $('input:checkbox[name=ch]').each(function () {
        var check = 1;
        var cond = 1;
        if (!$(this).is(":checked")) {
            check = 0;
            cond = $("#ddlCondicion" + $(this).prop("id")).val();
        }
        var objData = {};
        objData["in_Opc"] = inOpc;
        objData["in_CapaID"] = $("#hdCapaID").val();
        objData["in_CantAsist"] = idAsisCabe; //tambien usado para enviar el ultimo codigo generado en tb_asistencia
        objData["in_CantFalt"] = 0;
        objData["in_Agente"] = $(this).prop("id");
        objData["in_Asitencia"] = check;
        objData["in_Condicion"] = cond;

        $.ajax({
            async: false,
            type: "POST",
            url: urlAsistencia + "mantAsistencias",
            data: JSON.stringify(objData),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                if (data[0].in_Resul >= 1) {
                    inResul++;
                } else { inResul = 0; }
            },
            error: function (data) {
                inResul = 0;
            }
        });
    });
}

function setHabilitarAsistencia() {
    if ($("#chRepetirAsistencia").is(":checked")) {
        setHabilitarAsistenciaRepetir();
    } else { setHabilitarAsistenciaDiaria(); }
    
}

function setHabilitarAsistenciaRepetir() {
    var objData = {};
    objData["in_Opc"] = 7;
    objData["in_CapaID"] = $("#hdCapaID").val();
    objData["in_CantAsist"] = 0;
    objData["in_CantFalt"] = 0;
    objData["in_Agente"] = 0;
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
            if (data[0].in_Resul > 0) {
                inAsisID = data[0].in_Resul;
                setHabilitarCheck();
                $("#btnGuardarAsistencia").attr("disabled", false);
                $("#btnHabAsistencia").attr("disabled", true);
                $("#chRepetirAsistencia").attr("disabled", true);
            } else {
                new Messi("Aún no se registra la asistencia para hoy", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }
        },
        error: function (data) {
            new Messi("Error de conexión", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    });
}

function setHabilitarAsistenciaDiaria() {
    var objData = {};
    objData["in_Opc"] = 2;
    objData["in_CapaID"] = $("#hdCapaID").val();
    objData["in_CantAsist"] = 0;
    objData["in_CantFalt"] = 0;
    objData["in_Agente"] = 0;
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
            if (data[0].in_Resul == 0) {
                setHabilitarCheck();
                $("#btnGuardarAsistencia").attr("disabled", false);
                $("#btnHabAsistencia").attr("disabled", true);
                $("#chRepetirAsistencia").attr("disabled", true);
            } else {
                new Messi("Ya se registró la asistencia para hoy o la capacitación ya terminó", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }
        },
        error: function (data) {
            new Messi("Error de conexión", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    });
}

function setHabilitarCheck() {
    $('input:checkbox[name=ch]').each(function () {
        var cond = 0;
        var objData = {};
        objData["in_Opc"] = 5;
        objData["in_CapaID"] = 0;
        objData["in_CantAsist"] = 0;
        objData["in_CantFalt"] = 0;
        objData["in_Agente"] = $(this).prop("id");
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
                if (data[0].in_Resul != 0) {
                    cond = 1;
                }
            },
            error: function (data) {
                new Messi("Error de conexión", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }
        });
        if (cond == 0) {
            $(this).attr("disabled", true);
            $(this).prop("checked", false);
            $("#ddlCondicion" + $(this).prop("id")).empty().html("<option value='3'>Deserción</option>");
        } else {
            $(this).attr("disabled", false);
            $(this).prop("checked", true);
        }
    });
}

function setDesHabilitarCheck() {
    $('input:checkbox[name=ch]').each(function () {
        $(this).attr("disabled", true);
        $("#ddlCondicion" + $(this).prop("id")).attr("disabled", true);
    });
}

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
            alert('error');
        }
    });
};
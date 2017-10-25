var urlCamp = "Frm_MantCampanias.aspx/";
var urlSedes = "Frm_MantSede.aspx/";
var urlTurnos = "Frm_MantTurno.aspx/";
var pgnum = 1;
var url = "Frm_MantCapacitacion.aspx/";
var ddlPartes = 1;

$(document).ready(function () {

    $("#btnGuardarNuevoDiaCierre").click(function () {
        debugger;
        var ndc = parseInt($("#txtNuevoDiaCierre").val());
        var dc = parseInt($("#lblDiaCapa").text());
        if ($("#txtNuevoDiaCierre").val() == "" || ndc <= dc || $("#txtDiaPagoNuevo").val() == "") {
            alert($("#txtNuevoDiaCierre").val());
            new Messi("Ingrese un día superior al día actual de capacitación y complete todos los campos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            return false;
        }
        setNuevoDiaFinal();
        GetGridCapacitaciones(1);
    });

    $("#txtCantDias").keyup(function () {
        $("#lblCierres").text($("#txtCantDias").val());
        var canDia = parseFloat($("#txtCantDias").val());
        var pagDia = parseFloat($("#txtPagoDia").val());
        $("#txtPagoTotal").val(canDia * pagDia);
        $("#lblMontos").text($("#txtPagoTotal").val());
        $("#lblPagos").text(0);
        $("#ddlPartes").val(1);
    });

    $("#txtNuevoPagoTotal").number(true, 2);

    var objPerfil = sessionStorage.getItem("sePerfil");
    var objPerfil = JSON.parse(objPerfil);
    $("#hdPerfil").val(objPerfil.inPerfil);

    $("#btnGuardarNuevoDia").click(function () {
        if ($("#txtNuevoDia").val() != 0) {
            $("#lblPagos").text($("#txtNuevoDia").val());
            $("#dvCambiarDiaPago").modal('hide');
        }
    });

    $("#txtFecInicio").datepicker({ dateFormat: 'dd/mm/yy' });
    ListarSede("#ddlSedes");
    ListarCampanias("#ddlCampanias");
    GetGridCapacitaciones(1);

    $("#ddlSedes").change(function () {
        $("#dvCapacitacion").hide('fade');
        $("#dvCapas").show('fade');
        ListarCampanias("#ddlCampanias");
        GetGridCapacitaciones(1);
    });

    $("#ddlCampanias").change(function () {
        $("#dvCapacitacion").hide('fade');
        $("#dvCapas").show('fade');
        GetGridCapacitaciones(1);
    });

    $("#ddlPartes").change(function () {
        if ($("#ddlPartes").val() == 1) {
            ddlPartes = 1;
            $("#lblCierres").text($("#txtCantDias").val());
            $("#lblPagos").text(0);
            $("#lblMontos").text($("#txtPagoTotal").val());
            $("#btnCambiar").attr("disabled", false);
        } else if ($("#txtPagoTotal").val() > 0) {
            $("#btnCambiar").attr("disabled", true);
            $("#dvDetalleRegistro").modal('show');
            var htm = "";
            htm += "<tr><td colspan='3' style='text-align: center;'>Pago total: <label id='lblCierres'>" + $("#txtPagoTotal").val() + "</label></td></tr>";
            for (var i = 0; i < $("#ddlPartes").val() ; i++) {
                htm += "<tr>";
                if (i+1 == $("#ddlPartes").val()) {
                    htm += "<td style='text-align: center;'>Cierre " + (i+1) + "<input type='text' id='cierre" + i + "' class='form-control' style='width: 80px;' value='" + $("#txtCantDias").val() + "' disabled='disabled' /></td>";
                } else {

                    htm += "<td style=''>Cierre " + (i + 1) + "<input type='text' id='cierre" + i + "' class='form-control' style='width: 80px;' onkeypress='return solonumeros(event)' /></td>";
                }
                htm += "<td style='text-align: center;'>Monto " + (i + 1) + "<input type='text' id='monto" + i + "' class='form-control' style='width: 80px;' /></td>" +
                    "<td style='text-align: center;'>Día de pago " + (i + 1) + "<input type='text' id='pago" + i + "' class='form-control' style='width: 80px;' onkeypress='return solonumeros(event)' /></td>";
                htm += "</tr>";
            }
            $("#tbDetalleRegistro").empty().html(htm);

            for (var i = 0; i < $("#ddlPartes").val() ; i++) {
                $("#monto"+i).number(true, 2);
            }
        }
    });

    $("#btnAceptar").click(function () {
        var cierreTotal = ""; var montoToal = ""; var pagoTotal = "";
        for (var i = 0; i < $("#ddlPartes").val() ; i++) {
            if ($("#cierre" + i).val() == "") {
                new Messi("Complette todos los campos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                return false;
            }
            if ($("#monto" + i).val() == "") {
                new Messi("Complette todos los campos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                return false;
            }
            if ($("#pago" + i).val() == "") {
                new Messi("Complette todos los campos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                return false;
            }
            cierreTotal += $("#cierre" + i).val() + ";";
            montoToal += $("#monto" + i).val() + ";";
            pagoTotal += $("#pago" + i).val() + ";";
        }
        var c = cierreTotal.substring(0, cierreTotal.length - 1);
        var ct = c.split(";");
        var m = montoToal.substring(0, montoToal.length - 1);
        var mt = m.split(";");
        var p = pagoTotal.substring(0, pagoTotal.length - 1);
        var aux = parseInt(ct[0]);
        for (var i = 0; i < ct.length - 1; i++) {
            if (aux >= parseInt(ct[i + 1])) {
                new Messi("Fechas de corte incoherentes", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                return false;
            } else {
                aux = parseInt(ct[i+1]);
            }
        }
        var sumMontos = 0;
        var mFinal = "";
        for (var i = 0; i < mt.length; i++) {
            var x = parseFloat(mt[i]);
            sumMontos += (Math.round(x * 100) / 100);
            mFinal += x.toFixed(2) + ";";
        }
        if (sumMontos != parseFloat(($("#txtPagoTotal").val()))) {
            new Messi("La suma de los pagos por corte debe ser igual al pago total", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            return false;
        }
        $("#lblCierres").text(c);
        $("#lblMontos").text(mFinal.substring(0, mFinal.length - 1));
        $("#lblPagos").text(p);
        ddlPartes = $("#ddlPartes").val();
        $("#dvDetalleRegistro").modal('hide');
    });

    $("#btn_grabar").click(function () {
        if ($("#txtCantAgentes").val() == "") {
            new Messi("Se requiere la cantidad de agentes", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#txtCantDias").val() == "") {
            new Messi("Se requiere la cantidad de días", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#txtPagoTotal").val() == "") {
            new Messi("Se requiere el monto a pagar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#ddlTurno").val() == 0) {
            new Messi("Seleccione un turno", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else {
            setCapacitaciones();
        }
    })    
});

function setNuevoDiaFinal() {
    var objData = {};
    objData["in_opc"] = 8;
    objData["nroPagina"] = 0;
    objData["tamPagina"] = 0;
    objData["in_CapaID"] = $("#hdCapacitacion").val();
    objData["vc_Abreviatura"] = "";
    objData["vc_Titulo"] = "";
    objData["in_CampaniaID"] = 0;
    objData["vc_FechaInicio"] = "";
    objData["in_CantAgentes"] = 0;
    objData["in_CantDias"] = $("#txtNuevoDiaCierre").val();
    objData["PagoTotal"] = 0;
    objData["PagoDia"] = 0;
    objData["in_CantPartes"] = $("#txtDiaPagoNuevo").val(); //actualizar el nuevo dia de pago
    objData["vc_Cierre"] = "";
    objData["vc_Monto"] = "";
    objData["vc_Pago"] = "";
    objData["in_TurnoID"] = 0;

    $.ajax({
        async: false,
        type: "POST",
        url: url + "mantCapacitacion",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data[0].in_Resul >= 1) {
                new Messi("Registrado correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                $("#dvCambiarDiaFinal").modal('hide');
            } else {
                new Messi("error al tratar de registrar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }
        },//Fin Success
        error: function (response) {
            new Messi("Falló la conexión con la base de datos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin Ajax
};

function setCapacitaciones() {
    var objData = {};
    objData["in_opc"] = 2;
    objData["nroPagina"] = 0;
    objData["tamPagina"] = 0;
    objData["in_CapaID"] = $("#hdCapacitacion").val();
    $("#txtAbrev").val() == "" ? objData["vc_Abreviatura"] = "" : objData["vc_Abreviatura"] = $("#txtAbrev").val();
    $("#txtTitulo").val() == "" ? objData["vc_Titulo"] = "" : objData["vc_Titulo"] = $("#txtTitulo").val();
    objData["in_CampaniaID"] = $("#ddlCampanias").val();
    $("#txtFecInicio").val() == "" ? objData["vc_FechaInicio"] = "" : objData["vc_FechaInicio"] = $("#txtFecInicio").val();
    objData["in_CantAgentes"] = $("#txtCantAgentes").val();
    objData["in_CantDias"] = $("#txtCantDias").val();
    objData["PagoTotal"] = $("#txtPagoTotal").val();
    objData["PagoDia"] = $("#txtPagoDia").val();
    objData["in_CantPartes"] = ddlPartes;
    objData["vc_Cierre"] = $("#lblCierres").text();
    objData["vc_Monto"] = $("#lblMontos").text();
    objData["vc_Pago"] = $("#lblPagos").text();
    objData["in_TurnoID"] = $("#ddlTurno").val();
    $.ajax({
        async: false,
        type: "POST",
        url: url + "mantCapacitacion",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data[0].in_Resul >= 1) {
                new Messi("Registrado correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                $("#dvCapacitacion").hide('fade');
                $("#dvCapas").show('fade');
                GetGridCapacitaciones(1);
            } else {
                new Messi("error al tratar de registrar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }
        },//Fin Success
        error: function (response) {
            new Messi("Falló la conexión con la base de datos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin Ajax
};

function JQ_Open_Ventana_Registro() {
    if ($("#ddlCampanias").val() == 0) {
        new Messi("Seleccione una campaña", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        return false;
    }
    getPagoDia();
    $("#hdCapacitacion").val(0);
    $("#txtAbrev").val("");
    $("#txtTitulo").val("");
    $("#txtFecInicio").val("");
    $("#txtCantAgentes").val("");
    $("#txtCantDias").val("");
    $("#txtPagoTotal").val("");
    $("#ddlPartes").val(1);
    $("#lblCierres").text("");
    $("#lblMontos").text("");
    $("#lblPagos").text();
    getTurnos();
    $("#dvCapacitacion").show();
    $("#dvCapas").hide();
};

function getPagoDia() {
    var objData = {};
    objData["in_opc"] = 2;
    objData["in_CampaniaID"] = $("#ddlCampanias").val();
    objData["in_SedeID"] = 0;
    objData["vc_Campania"] = "";
    objData["dc_PagoDia"] = 0;

    $.ajax({
        type: "POST",
        url: urlCamp + "mantCampania",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#txtPagoDia").val(data[0].dc_PagoDia);
        },//Fin data
        error: function (response) {
            new Messi("Error al leer el pago por día", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin DEL .aja
}
function JQ_CambiarDia() {
    if ($("#txtCantDias").val() != 0) {
        $("#dvCambiarDiaPago").modal('show');
        $("#txtNuevoDia").val("");
    }
};

function JQ_Close_Ventana_Registro() {
    $("#dvCapacitacion").hide();
    $("#dvCapas").show();
};

function GetGridCapacitaciones(pgnum) {
    var objData = {};
    objData["in_opc"] = 1;
    objData["nroPagina"] = pgnum;
    objData["tamPagina"] = 10;
    objData["in_CapaID"] = 0;
    objData["vc_Abreviatura"] = "";
    objData["vc_Titulo"] = "";
    objData["in_CampaniaID"] = $("#ddlCampanias").val();
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
        url: url + "mantCapacitacion",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            debugger;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tbCapacitacion tr:not(:first)').remove();
            if (data.length > 0) {
                for (var i = 0; i <= data.length; i++) {
                    if (data.length == i) {
                        pageCount = data[0].in_TotalRegistros;
                        var StrPager = "";
                        if (pageCount > 1) {
                            for (var x = 1; x <= pageCount; x++) {
                                if (x == 1) {
                                    StrPager = "<tr class='pgr'><td colspan='16' style='text-align:left;padding:6px;'>";
                                }
                                StrPager = StrPager + "<label style='line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #0A0A0A;font-weight: bold;" + (x == pgnum ? "color: #F4FAF4;" : "color: #080809;cursor:pointer;" + "'  onclick='GetGridCapacitaciones(" + x + ");") + "'>" + x + "</label>";
                                if (x == pageCount) {
                                    StrPager = StrPager + "</td></tr>";
                                }
                            }
                        } else { StrPager = "<tr class='pgr'><td colspan='16' style='text-align:left;padding:10px;'></td></tr>"; }
                    } else {
                        debugger;
                        if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                        
                        strRows += "<td>" + data[i].vc_Abreviatura + "</td>" +
                                   "<td>" + data[i].vc_Titulo + "</td>" +
                                   "<td>" + data[i].dt_FechRegistro + "</td>" +
                                   "<td>" + data[i].dt_FechInicio + "</td>" +
                                   "<td>" + data[i].dt_FechFin + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_Turno + "</td>" +
                                   "<td>" + data[i].vc_Nombres + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantAgentes + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantDias + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_PagoTotal + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_PagoDia + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantPartes + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_Estado + "</td>";
                        if (data[i].vc_Estado == "Cerrado" || data[i].vc_Estado == "En curso") {
                            strRows += "<td align=center><img src='libreria/imagenes/Botones/Lista.png' title='Asistencia' onclick='irAsistenciaAgentes(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' width='20px' height='20px' /></td>";
                        } else {
                            strRows += "<td align=center></td>";
                        }
                        if ((data[i].vc_Estado == "Pendiente" || data[i].vc_Estado == "Agentes cargados") && $("#hdPerfil").val() == "CAPACITACION") {
                            strRows += "<td align=center><img src='libreria/imagenes/Botones/btnEditarG.gif' title='Editar' onclick='getEditCapacitacion(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' /></td>";
                        } else if (data[i].vc_Estado == "En curso" && $("#hdPerfil").val() == "JEFA CAPACITACION") {
                            strRows += "<td align=center><img src='libreria/imagenes/Botones/modify-key.jpg' title='Reducir días de capa' width='15px' height='15px' onclick='getCambiarDiasCapa(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' /></td>";
                        } else { strRows += "<td></td>"; }
                        strRows += "<td align=center><img src='libreria/imagenes/Botones/addControl.gif' title='Ver detalle' onclick='getDetalleCapacitacion(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</td></tr>";
                    }
                }
                $("#tbCapacitacion").append(strRows + StrPager);

            } else { $("#tbCapacitacion").append("<tr><td style='text-align:center;' colspan='16'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
};

function getCambiarDiasCapa(idCapaID) {
    $("#txtNuevoDiaCierre").val("");
    $("#txtNuevoPagoTotal").val("");
    $("#txtDiaPagoNuevo").val("");
    var objData = {};
    objData["idCapa"] = idCapaID;

    $.ajax({
        async: false,
        type: "POST",
        url: url + "getDiaMaxPagoActual",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var contenido = "";
            $('#tbDiaFinalPagoNuevo tr:not(:first)').remove();
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    contenido += "<tr>";
                    if (i == 0) {
                        contenido += "<td style='text-align:center;'><label id='lblDiaCapa'>" + data[i].in_Dia + "</label></td>";
                    } else {
                        contenido += "<td></td>";
                    }
                    contenido += "<td style='text-align:center;'><label id='lblPartes'>" + data[i].in_Orden + "</label></td>" +
                        "<td style='text-align:center;'><label id='lblMontoPagado'>" + data[i].dc_Monto + "</label></td>" +
                        "</tr>";
                }
                $("#tbDiaFinalPagoNuevo").append(contenido);
                $("#hdCapacitacion").val(idCapaID);
                $("#dvCambiarDiaFinal").modal('show');
            }
        }//Fin Success
    }); //Fin Ajax
}

function irAsistenciaAgentes(idCapaID) {
    if (sessionStorage.getItem("seCapacitacionConsulta") != null) {
        sessionStorage.removeItem("seCapacitacionConsulta");
    }
    var objCapa = {
        idCapacitacion: idCapaID,
    };

    var objSim = JSON.stringify(objCapa);
    sessionStorage.setItem("seCapacitacionConsulta", objSim);
    window.location.href = "Frm_AsistenciaAgentesConsulta.aspx";
}

function getEditCapacitacion(in_CapaID) {
    getTurnos();
    var objData = {};
    objData["in_opc"] = 3;
    objData["nroPagina"] = 0;
    objData["tamPagina"] = 0;
    objData["in_CapaID"] = in_CapaID;
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
        url: url + "mantCapacitacion",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            getPagoDia();
            debugger;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#hdCapacitacion").val(data[0].in_CapaID);
            $("#txtAbrev").val(data[0].vc_Abreviatura);
            $("#txtTitulo").val(data[0].vc_Titulo);
            $("#txtFecInicio").val(data[0].dt_FechInicio);
            $("#ddlTurno").val(data[0].in_TurnoID);
            $("#txtCantAgentes").val(data[0].in_CantAgentes);
            $("#txtCantDias").val(data[0].in_CantDias);
            var dias = data[0].in_CantDias;
            var pagoDia = $("#txtPagoDia").val();
            $("#txtPagoTotal").val(dias * pagoDia);
            $("#ddlPartes").val(1);
            $("#lblCierres").text(data[0].in_CantDias);
            $("#lblMontos").text($("#txtPagoTotal").val());
            $("#lblPagos").text(0);
            $("#dvCapacitacion").show();
            $("#dvCapas").hide();
        },//Fin Success
        error: function (response) {
            new Messi("Error al traer los datos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin Ajax
};

function getDetalleCapacitacion(idCapacitacion) {
    var objData = {};
    objData["id"] = idCapacitacion;

    $.ajax({
        async: false,
        type: "POST",
        url: url + "VerDetalle",
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

function getTurnos() {
    debugger;
    var objData = {};
    objData["in_opc"] = 5;
    objData["in_TurnoID"] = 0;
    objData["in_SedeID"] = $("#ddlSedes").val();
    objData["vc_Simbolo"] = "";
    objData["vc_Descripcion"] = "";
    objData["vc_HoraInicio"] = "";
    objData["vc_HoraFin"] = "";

    $.ajax({
        async: false,
        type: "POST",
        url: urlTurnos + "mantTurno",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            debugger;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#ddlTurno").html("<option value=\"0\">SELECCIONAR</option").removeAttr("disabled");
            for (var i = 0; i < data.length; i++) {
                $("#ddlTurno").append("<option value=\"" + data[i].in_TurnoID + "\">" + data[i].vc_Simbolo + " - " + data[i].vc_HoraInicio + " " + data[i].vc_HoraFin + "</option>");
            }
        }//Fin Success
    }); //Fin Ajax
};
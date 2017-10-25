var urlSedes = "Frm_MantSede.aspx/";
var urlTurnos = "Frm_MantTurno.aspx/";

$(document).ready(function () {

    $("#btn_grabar").click(function () {
        if ($.trim($("#txtSimbolo").val()) == "") {
            setMensaje("Ingrese un símbolo");
        } else if ($.trim($("#txtDescripcion").val()) == "") {
            setMensaje("Ingrese la descripción");
        } else if ($.trim($("#txtHoraInicio").val()) == "") {
            setMensaje("Ingrese la hora de inicio");
        } else if ($.trim($("#txtHoraFin").val()) == "") {
            setMensaje("Ingrese la hora final");
        } else {
            var hrIni = $("#txtHoraInicio").val();
            var hrFin = $("#txtHoraFin").val();
            if (hrFin == "00:00" && hrIni != "00:00") {
                setTurno();
            } else {
                hrFin = parseInt(hrFin.replace(":", ""));
                hrIni = parseInt(hrIni.replace(":", ""));
                if (hrFin > hrIni) {
                    setTurno();
                } else {
                    setMensaje("Seleccione correctamente las horas");
                }
            }
        }
    })

    ListarSede("#ddlSedes");
    getGridTurnos();

    $("#ddlSedes").change(function () {
        getGridTurnos();
    });

    $("#txtHoraInicio").timepicker({ 'timeFormat': 'H:i' });
    $("#txtHoraFin").timepicker({ 'timeFormat': 'H:i' });

});

function setTurno() {
    var objData = {};
    objData["in_opc"] = 3;
    objData["in_TurnoID"] = $("#hdTurno").val();
    objData["in_SedeID"] = $("#ddlSedes").val();
    objData["vc_Simbolo"] = $("#txtSimbolo").val();
    objData["vc_Descripcion"] = $("#txtDescripcion").val();
    objData["vc_HoraInicio"] = $("#txtHoraInicio").val();
    objData["vc_HoraFin"] = $("#txtHoraFin").val();

    $.ajax({
        async: false,
        type: "POST",
        url: urlTurnos + "mantTurno",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data[0].in_Resul > 0) {
                setMensaje("Registrado correctamente");
                $("#hdTurno").val(0);
                getGridTurnos();
                $("#dvTurno").modal('hide');
            } else {
                setMensaje("Error al tratar de registrar los datos");
            }
        },//Fin Success
        error: function (response) {
            setMensaje("Error al tratar de registrar los datos");
        }
    }); //Fin Ajax
}

function setMensaje(msj) {
    new Messi(msj, { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 2000, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
}

function JQ_Open_Ventana_Registro() {
    if ($("#ddlSedes").val() != 0) {
        $("#dvTurno").modal('show');
        $("#txtSimbolo").val("");
        $("#txtDescripcion").val("");
        $("#txtHoraInicio").val("");
        $("#txtHoraFin").val("");
    } else {
        new Messi("Seleccione una sede", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
    }
}

function getGridTurnos() {
    var objData = {};
    objData["in_opc"] = 1;
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
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tbTurnos tr:not(:first)').remove();
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
                                   "<td style='text-align:center;'>" + data[i].vc_Simbolo + "</td>" +
                                   "<td>" + data[i].vc_Descripcion + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_HoraInicio + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_HoraFin + "</td>" +
                                   "<td>" + data[i].vc_Nombres + "</td>" +
                                   "<td align=center><img src='libreria/imagenes/Botones/btnEditarG.gif' title='Editar' onclick='getEditarTurno(" + '"' + data[i].in_TurnoID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "<td align=center>" + (data[i].in_Estado == 1 ? "<img src='libreria/imagenes/Botones/Activo.png' title='Desactivar'" : "<img src='libreria/imagenes/Botones/Desactivo.png' title='Activar'") + " onclick='setEstadoTurno(" + '"' + data[i].in_TurnoID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</tr>"
                    }
                }
                $("#tbTurnos").append(strRows + StrPager);

            } else { $("#tbTurnos").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
};

function setEstadoTurno(idTurno) {
    new Messi('Desea cambiar de estado a este turno?', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                var objData = {};
                objData["in_opc"] = 4;
                objData["in_TurnoID"] = idTurno;
                objData["in_SedeID"] = 0;
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
                        var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                        if (data[0].in_Resul > 0) {
                            setMensaje("Registrado correctamente");
                            getGridTurnos();
                        } else {
                            setMensaje("Error al tratar de registrar los datos");
                        }
                    },//Fin Success
                    error: function (response) {
                        setMensaje("Error al tratar de leer los datos");
                    }
                }); //Fin Ajax
            } // Fin del IF
        } // Fin title
    });
};

function getEditarTurno(idTurno) {
    var objData = {};
    objData["in_opc"] = 2;
    objData["in_TurnoID"] = idTurno;
    objData["in_SedeID"] = 0;
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
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                $("#hdTurno").val(data[0].in_TurnoID);
                $("#txtSimbolo").val(data[0].vc_Simbolo);
                $("#txtDescripcion").val(data[0].vc_Descripcion);
                $("#txtHoraInicio").val(data[0].vc_HoraInicio);
                $("#txtHoraFin").val(data[0].vc_HoraFin);
                $("#dvTurno").modal('show');
            } else {
                setMensaje("Error al tratar de leer los datos");
            }
        },//Fin Success
        error: function (response) {
            setMensaje("Error al tratar de leer los datos");
        }
    }); //Fin Ajax
}

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
var urlValidaciones = "Frm_Validaciones.aspx/";
var inResul = 0;

$(document).ready(function () {
    if (sessionStorage.getItem("seCapacitacion") == null) {
        window.location.href = "Frm_MantValidaciones.aspx";
    }
    var objCapa = sessionStorage.getItem("seCapacitacion");
    var objCapa = JSON.parse(objCapa);
    
    var objPerfil = sessionStorage.getItem("sePerfil");
    var objPerfil = JSON.parse(objPerfil);
    $("#hdPerfil").val(objPerfil.inPerfil);
    $("#hdCapaID").val(objCapa.idCapacitacion);
    getCabeceraPagos();
    getCabeValidaciones();
    getDetallePagos();
    $("#btnGuardar").click(function () {
        var resul = 0;
        $("input:checkbox[name=ch]").each(function () {
            var nroPago = $(this).prop("id");
            var opc = nroPago.substring(0, 7)
            var inOpc = 0;
            if (opc == "chValCa") {
                inOpc = 4;
            } else if (opc == "chValDH") {
                inOpc = 5;
            } else if (opc == "chValPM") {
                inOpc = 6;
            } else if (opc == "chPagos") {
                inOpc = 7;
            }
            if ($(this).is(":checked")) {
                $("input:checkbox[name=" + $(this).prop("id") + "]").each(function () {
                    var idAgente = $(this).prop("id")
                    var valid = 0;
                    if ($(this).is(":checked")) {
                        valid = 1;
                    }
                    var objData = {};
                    objData["inOpc"] = inOpc;
                    objData["idCapa"] = $("#hdCapaID").val();
                    objData["inAgenteID"] = idAgente.substring(7, idAgente.length);
                    objData["inNroPago"] = nroPago.substring(7, nroPago.length);
                    objData["inValidar"] = valid;

                    $.ajax({
                        async: false,
                        type: "POST",
                        url: urlValidaciones + "getPagosDetalle",
                        data: JSON.stringify(objData),
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                            if (data[0].in_Resul >= 1) {
                                resul++;
                            } else { resul = 0; }
                        },
                    });
                })
            }
        });
        if (resul >= 1) {
            new Messi("Registrado con éxito", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            getDetallePagos();
            getCabeValidaciones();
        }
    });
});

function getCabeValidaciones() {
    var objData = {};
    objData["inOpc"] = 9;
    objData["idCapa"] = $("#hdCapaID").val();
    objData["inAgenteID"] = 0;
    objData["inNroPago"] = 0;
    objData["inValidar"] = 0;

    $.ajax({
        async: false,
        type: "POST",
        url: urlValidaciones + "getCabeValidaciones",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                var head = "<thead><tr><th>Validaciones</th>";
                var valCapa = "<tr class='alt'><td>Val. Capacitación</td>";
                var valDH = "<tr><td>Val. DH</td>";
                var valPM = "<tr class='alt'><td>Val. MP</td>";
                for (var i = 0; i < data.length; i++) {
                    head += "<th style='text-align:center;'><button type='button' style='color: black'>" + data[i].in_NroPago + "</button></th>";
                    if (data[i].in_ValidCapa == 1) {
                        valCapa += "<td align=center><img src='libreria/imagenes/Botones/Activo.png' width='10px' height='10px' /></td>";
                    } else {
                        valCapa += "<td align=center><img src='libreria/imagenes/Botones/Desactivo.png' width='10px' height='10px' /></td>";
                    }
                    if (data[i].in_ValidDH == 1) {
                        valDH += "<td align=center><img src='libreria/imagenes/Botones/Activo.png' width='10px' height='10px' /></td>";
                    } else {
                        valDH += "<td align=center><img src='libreria/imagenes/Botones/Desactivo.png' width='10px' height='10px' /></td>";
                    }
                    if (data[i].in_ValidPM == 1) {
                        valPM += "<td align=center><img src='libreria/imagenes/Botones/Activo.png' width='10px' height='10px' /></td>";
                    } else {
                        valPM += "<td align=center><img src='libreria/imagenes/Botones/Desactivo.png' width='10px' height='10px' /></td>";
                    }
                }
                head += "</thead><body><tr>";
                valCapa += "</tr>";
                valDH += "</tr>";
                valPM += "</tr></body>";
                $("#tbCabeValidaciones").empty().html(head + valCapa + valDH + valPM);
            }
        },
    });
};

function getCabeceraPagos() {
    var objData = {};
    objData["inOpc"] = 1;
    objData["idCapa"] = $("#hdCapaID").val();
    objData["inAgenteID"] = 0;
    objData["inNroPago"] = 0;
    objData["inValidar"] = 0;

    $.ajax({
        async: false,
        type: "POST",
        url: urlValidaciones + "getCabeceraPagos",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var contenido;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                contenido += "<thead><tr><th>Detalle</th>";
                var cabe = data[0].vc_Filas.split(";");
                for (var i = 0; i < cabe.length; i++) {
                    contenido += "<th style='text-align:center;'><button type='button' id='btn" + cabe[i] + "' style='color: black'>" + cabe[i] + "</button></th>";
                }
                contenido += "</tr></thead><tbody>";
                for (var i = 1; i < data.length; i++) {
                    var deta = data[i].vc_Filas.split(";");
                    if (i % 2 == 0) {
                        contenido += "<tr>";
                    } else {
                        contenido += "<tr class='alt'>";
                    }
                    for (var j = 0; j < deta.length; j++) {
                        if (i == 1 && j == 0) {
                            contenido += "<td>Días de corte</td>";
                        } else if (i == 2 && j == 0) {
                            contenido += "<td>Monto a pagar</td>";
                        } else if (i == 3 && j == 0) {
                            contenido += "<td>Fecha a pagar</td>";
                        }
                        contenido += "<td>" + deta[j] + "</td>";
                    }
                }
                contenido += "</tr></tbody>";
                $("#tbCabecera").empty().html(contenido);
            } else {
                var contenido = "<tr><td>La capacitación aún no registra Pagos</td></tr>";
                $("#tbCabecera").empty().html(contenido);
            }
        },
        error: function (data) {
            var contenido = "<tr><td>La capacitación aún no registra Pagos</td></tr>";
            $("#tbCabecera").empty().html(contenido);
        }
    });
};

function getDetallePagos() {
    var objData = {};
    objData["inOpc"] = 2;
    objData["idCapa"] = $("#hdCapaID").val();
    objData["inAgenteID"] = 0;
    objData["inNroPago"] = 0;
    objData["inValidar"] = 0;

    $.ajax({
        async: false,
        type: "POST",
        url: urlValidaciones + "getCabeceraPagos",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var contenido;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                contenido += "<thead><tr>";
                var cabe = data[0].vc_Filas.split(";");
                contenido += "<th></th>";
                for (var i = 1; i < cabe.length; i++) {
                    if (i == 1 || i == 2) {
                        contenido += "<th>" + cabe[i].substring(3, cabe[i].length) + "</th>";
                    } else {
                        contenido += "<th colspan='7' style='text-align:center;'><button type='button' style='color: black'>" + cabe[i] + "</button></th>";
                    }
                }
                contenido += "</tr></thead><tbody>";
                contenido += "<tr><td></td>";
                for (var i = 1; i < cabe.length; i++) {
                    contenido += "<td></td>";
                    if (i > 2) {
                        contenido += "<td style='text-align:center;'>A</td>";
                        contenido += "<td style='text-align:center;'>F</td>";
                        if ($("#hdPerfil").val() == "CAPACITACION") {
                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValCa" + cabe[i] + "' name='ch' onclick='setHabCapa(" + cabe[i] + ");' />CA</td>";
                        } else {
                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValCa" + cabe[i] + "' name='ch' disabled='disabled' onclick='setHabCapa(" + cabe[i] + ");' />CA</td>";
                        }
                        if ($("#hdPerfil").val() == "DH") {
                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValDH" + cabe[i] + "' name='ch' onclick='setHabDH(" + cabe[i] + ");' />DH</td>";
                        } else {
                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValDH" + cabe[i] + "' name='ch' disabled='disabled' onclick='setHabDH(" + cabe[i] + ");' />DH</td>";
                        }
                        if ($("#hdPerfil").val() == "MP") {
                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValPM" + cabe[i] + "' name='ch' onclick='setHabPM(" + cabe[i] + ");' />MP</td>";
                        } else {
                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chValPM" + cabe[i] + "' name='ch' disabled='disabled' onclick='setHabPM(" + cabe[i] + ");' />MP</td>";
                        }
                        if ($("#hdPerfil").val() == "PROVEEDOR") {
                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chPagos" + cabe[i] + "' name='ch' onclick='setHabPago(" + cabe[i] + ");' />PAGO</td>";
                        } else {
                            contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' id='chPagos" + cabe[i] + "' name='ch' disabled='disabled' onclick='setHabPago(" + cabe[i] + ");' />PAGO</td>";
                        }                        
                    }
                }
                contenido += "</tr>";
                for (var i = 1; i < data.length; i++) {
                    var deta = data[i].vc_Filas.split(";");
                    if (i % 2 == 0) {
                        contenido += "<tr><td>" + i + "</td>";
                    } else {
                        contenido += "<tr class='alt'><td>" + i + "</td>";
                    }
                    for (var j = 1; j < deta.length; j++) {
                        contenido += "<td>" + deta[j] + "</td>";
                        if (j > 2) {
                            ///////////////////////////////////////////
                            var objData = {};
                            objData["inOpc"] = 3;
                            objData["idCapa"] = $("#hdCapaID").val();
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
                                                        contenido += "<td style='text-align:center;width:3%;'><input type='checkbox' disabled='disabled' checked='checked' /></td>";
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
            }
        },
        error: function (data) {
            var contenido = "<tr><td>La capacitación aun no tiene Pagos</td></tr>";
            $("#tbDetalle").empty().html(contenido);
        }
    });
};
function msj() {
    alert("bla");
}

function setHabCapa(id) {
    var valid = 1;
    var objData = {};
    objData["inOpc"] = 8;
    objData["idCapa"] = $("#hdCapaID").val();
    objData["inAgenteID"] = 0;
    objData["inNroPago"] = id;
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
                if (data[0].in_ValidCapa > 0) {
                    valid = 0;
                }
            }
        },
    });
    if (valid == 0) {
        new Messi("No se puede volver a validar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 2000, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        $("#chValCa" + id).prop("checked", false);
        return false;
    }
    $("input:checkbox[name=chValCa" + id + "]").each(function () {
        if ($("#chValCa" + id).prop("checked") == false) {
            $(this).attr("disabled", true);
        } else {
            $(this).attr("disabled", false);
        }
    });
}
function setHabDH(id) {
    var valid = 0;
    ///////////////////////////////////////////
    var objData = {};
    objData["inOpc"] = 8;
    objData["idCapa"] = $("#hdCapaID").val();
    objData["inAgenteID"] = 0;
    objData["inNroPago"] = id;
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
                if (data[0].in_ValidDH > 0) {
                    valid = 0;
                } else if (data[0].in_ValidCapa > 0) {
                    valid = 1;
                }
            }
        },
    });
    //////////////////////////////////////////
    if (valid == 0) {
        new Messi("Se requiere la validación de capacitación, no se puede volver a validar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        $("#chValDH" + id).prop("checked", false);
        return false;
    }
    $("input:checkbox[name=chValDH" + id + "]").each(function () {
        if ($("#chValDH" + id).prop("checked") == false) { 
            $(this).attr("disabled", true);
        } else {
            $(this).attr("disabled", false);
        }
    });
}
function setHabPM(id) {
    var valid = 0;
    ///////////////////////////////////////////
    var objData = {};
    objData["inOpc"] = 8;
    objData["idCapa"] = $("#hdCapaID").val();
    objData["inAgenteID"] = 0;
    objData["inNroPago"] = id;
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
                if (data[0].in_ValidPM > 0) {
                    valid = 0;
                } else if (data[0].in_ValidDH > 0) {
                    valid = 1;
                }
            }
        },
    });
    //////////////////////////////////////////
    if (valid == 0) {
        new Messi("Se requiere la validación de DH, no se puede volver a validar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 2000, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        $("#chValPM" + id).prop("checked", false);
        return false;
    }
    $("input:checkbox[name=chValPM" + id + "]").each(function () {
        if ($("#chValPM" + id).prop("checked") == false) {
            $(this).attr("disabled", true);
        } else {
            $(this).attr("disabled", false);
        }
    });
}
function setHabPago(id) {
    var valid = 0;
    ///////////////////////////////////////////
    var objData = {};
    objData["inOpc"] = 8;
    objData["idCapa"] = $("#hdCapaID").val();
    objData["inAgenteID"] = 0;
    objData["inNroPago"] = id;
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
                if (data[0].in_CantAsis > 0) {
                    valid = 1; //verificar la validacion de mp y la fecha
                }
            }
        },
    });
    //////////////////////////////////////////
    if (valid == 0) {
        new Messi("Verificar la fecha de pago o MP aún no valida", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 2000, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        $("#chPagos"+id).prop("checked", false);
        return false;
    }
    $("input:checkbox[name=chPagos" + id + "]").each(function () {
        if ($("#chPagos" + id).prop("checked") == false) {
            $(this).attr("disabled", true);
        } else {
            $(this).attr("disabled", false);
        }
    });
}
var urlCamp = "Frm_MantCampanias.aspx/";
var urlSedes = "Frm_MantSede.aspx/";
var pgnum = 1;
var url = "Frm_MantCapacitacion.aspx/";

$(document).ready(function () {
    ListarSede("#ddlSedes");
    ListarCampanias("#ddlCampanias");
    GetGridCapacitaciones(1);

    $("#ddlSedes").change(function () {
        ListarCampanias("#ddlCampanias");
        GetGridCapacitaciones(1);
    });

    $("#ddlCampanias").change(function () {
        GetGridCapacitaciones(1);
    });
});

function GetGridCapacitaciones(pgnum) {
    var objData = {};
    objData["in_opc"] = 6;
    objData["nroPagina"] = pgnum;
    objData["tamPagina"] = 10;
    objData["in_CapaID"] = 0;
    objData["vc_Abreviatura"] = "";
    objData["vc_Titulo"] = "";
    objData["in_CampaniaID"] = $("#ddlCampanias").val();
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
        url: url + "mantCapacitacion",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
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
                                    StrPager = "<tr class='pgr'><td colspan='15' style='text-align:left;padding:6px;'>";
                                }
                                StrPager = StrPager + "<label style='line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #0A0A0A;font-weight: bold;" + (x == pgnum ? "color: #F4FAF4;" : "color: #080809;cursor:pointer;" + "'  onclick='GetGridCapacitaciones(" + x + ");") + "'>" + x + "</label>";
                                if (x == pageCount) {
                                    StrPager = StrPager + "</td></tr>";
                                }
                            }
                        } else { StrPager = "<tr class='pgr'><td colspan='15' style='text-align:left;padding:10px;'></td></tr>"; }
                    } else {
                        if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                        strRows += "<td>" + data[i].vc_Abreviatura + "</td>" +
                                   "<td>" + data[i].vc_Titulo + "</td>" +
                                   "<td>" + data[i].dt_FechRegistro + "</td>" +
                                   "<td>" + data[i].dt_FechInicio + "</td>" +
                                   "<td>" + data[i].dt_FechFin + "</td>" +
                                   "<td>" + data[i].vc_Nombres + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantAgentes + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantDias + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_PagoTotal + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dc_PagoDia + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].in_CantPartes + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_Estado + "</td>";
                        if (data[i].vc_Estado != "Pendiente") {
                            strRows += "<td align=center><img src='libreria/imagenes/Botones/Activo.png' title='Validaciones' onclick='irValidaciones(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' /></td>";
                        } else {
                            strRows += "<td align=center></td>";
                        }
                        strRows += "<td align=center><img src='libreria/imagenes/Botones/addControl.gif' title='Ver detalle' onclick='getDetalleCapacitacion(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</td></tr>";
                    }
                }
                $("#tbCapacitacion").append(strRows + StrPager);

            } else { $("#tbCapacitacion").append("<tr><td style='text-align:center;' colspan='15'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
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

function irValidaciones(idCapaID) {
    if (sessionStorage.getItem("seCapacitacion") != null) {
        sessionStorage.removeItem("seCapacitacion");
    }
    var objCapa = {
        idCapacitacion: idCapaID,
    };
    var objSim = JSON.stringify(objCapa);
    sessionStorage.setItem("seCapacitacion", objSim);
    window.location.href = "Frm_Validaciones.aspx";
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
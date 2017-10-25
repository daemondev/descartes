var urlCamp = "Frm_MantCampanias.aspx/";
var urlSedes = "Frm_MantSede.aspx/";
var urlCapacitacion = "Frm_MantCapacitacion.aspx/";
var urlReportes = "Frm_Reportes.aspx/";
var pgnum = 1;

$(document).ready(function () {
    //ListarSede("#ddlSedes");
    //ListarCampanias("#ddlCampanias");
    //GetGridCapacitaciones(1);

    //$("#ddlSedes").change(function () {
    //    ListarCampanias("#ddlCampanias");
    //    GetGridCapacitaciones(1);
    //});

    //$("#ddlCampanias").change(function () {
    //    GetGridCapacitaciones(1);
    //});
    //setInterval(llamada_general, 10000); // 1 minutos=60000 milisegundos
    //$.ajaxSetup({ cache: false });

});

function ExportarDetallado() {
    debugger;

    if ($('#f1').val() == '' || $('#f2').val() == '') {
        new Messi("Seleccione rango fechas", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });


    } else {
        var in_sede = '%';
        var in_camp = '%';

        var vc_sede = 'Todas';
        var vc_camp = 'Todas';


        if ($('#ddlSedes').val() != 0) {
            in_sede = $('#ddlSedes').val();
            vc_sede = $('#ddlSedes option:selected').text();
            //in_camp = $('#ddlCampanias').val();
        }
        if ($('#ddlCampanias').val() != 0) {
            in_camp = $('#ddlCampanias').val();
            vc_camp=$('#ddlCampanias option:selected').text();
        }
        var objData = {};
        objData["f1"] = $('#f1').val();
        objData["f2"] = $('#f2').val();
        objData["in_sede"] = in_sede;
        objData["in_camp"] = in_camp;
        objData["vc_sede"] = vc_sede;
        objData["vc_camp"] = vc_camp;
        debugger;

        $.ajax({
            async: false,
            type: "POST",
            url: "Frm_Reportes.aspx/ExportarReporte",
            data: JSON.stringify(objData),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {

                if (data.d == null) {
                    $(function () {
                        new Messi("No hay datos Disponibles", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                    });
                } else {
                    location.href = data.d;
                    $(function () {
                        new Messi("Reporte exportado Correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                    });
                }
            } //Fin data
        }); //Fin DEL .aja
    }

        
    
    //if ($("#ddlOpc").val() == 0) {
    //    new Messi("Seleccione una opción para exportar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
    //    return false;
    //}
    //$("input:radio[name=rb]").each(function () {
    //    if ($(this).is(":checked")) {
    //        if ($("#ddlOpc").val() == 1) {
    //            ExportarAsistencias($(this).val());
    //        } else {
    //            ExportarPagos($(this).val());
    //        }
    //    }
    //});
}

function ExportarGeneral() {
    debugger;

    if ($('#f1').val() == '' || $('#f2').val() == '') {
        new Messi("Seleccione rango fechas", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });


    } else {
        var in_sede = '%';
        var in_camp = '%';

        var vc_sede = 'Todas';
        var vc_camp = 'Todas';


        if ($('#ddlSedes').val() != 0) {
            in_sede = $('#ddlSedes').val();
            vc_sede = $('#ddlSedes option:selected').text();
            //in_camp = $('#ddlCampanias').val();
        }
        if ($('#ddlCampanias').val() != 0) {
            in_camp = $('#ddlCampanias').val();
            vc_camp = $('#ddlCampanias option:selected').text();
        }
        var objData = {};
        objData["f1"] = $('#f1').val();
        objData["f2"] = $('#f2').val();
        objData["in_sede"] = in_sede;
        objData["in_camp"] = in_camp;
        objData["vc_sede"] = vc_sede;
        objData["vc_camp"] = vc_camp;
        debugger;
        //setInterval(llamada_general, 10000); // 1 minutos=60000 milisegundos
        //$.ajaxSetup({ cache: false });
        $.ajax({
            async: false,
            type: "POST",
            url: "Frm_Reportes.aspx/ExportarReporteGeneral",
            data: JSON.stringify(objData),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {

                if (data.d == null) {
                    $(function () {
                        new Messi("No hay datos Disponibles", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                    });
                } else {
                    location.href = data.d;
                    $(function () {
                        new Messi("Reporte exportado Correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                    });
                }
            } //Fin data
        }); //Fin DEL .aja
    }



    //if ($("#ddlOpc").val() == 0) {
    //    new Messi("Seleccione una opción para exportar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
    //    return false;
    //}
    //$("input:radio[name=rb]").each(function () {
    //    if ($(this).is(":checked")) {
    //        if ($("#ddlOpc").val() == 1) {
    //            ExportarAsistencias($(this).val());
    //        } else {
    //            ExportarPagos($(this).val());
    //        }
    //    }
    //});
}


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
    objData["PagoDia"] = 0;
    $.ajax({
        async: false,
        type: "POST",
        url: urlCapacitacion + "mantCapacitacion",
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
                        strRows += "<td><input type='radio' id='" + data[i].in_CapaID + "' value='" + data[i].in_CapaID + "' name='rb' /></td>" +
                                   "<td>" + data[i].vc_Abreviatura + "</td>" +
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
                                   "<td style='text-align:center;'>" + data[i].vc_Estado + "</td>" +
                                   "<td align=center><img src='libreria/imagenes/Botones/addControl.gif' title='Ver detalle' onclick='getDetalleCapacitacion(" + '"' + data[i].in_CapaID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</td></tr>";
                    }
                }
                $("#tbCapacitacion").append(strRows + StrPager);

            } else { $("#tbCapacitacion").append("<tr><td style='text-align:center;' colspan='15'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
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

//function ExportarAsistencias(idCapa) {
//    var objData = {};
//    objData["opc"] = 1;
//    objData["idCapa"] = idCapa;

//    $.ajax({
//        async: false,
//        type: "POST",
//        url: urlReportes + "ExportarAsistencias",
//        data: JSON.stringify(objData),
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        success: function (data) {
//            if (data.d == null) {
//                $(function () {
//                    new Messi("No hay datos Disponibles", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
//                });
//            } else {
//                location.href = data.d;
//                $(function () {
//                    new Messi("Reporte exportado Correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
//                });
//            }
//        } //Fin data
//    }); //Fin DEL .aja
//};

//function ExportarPagos(idCapa) {
//    var objData = {};
//    objData["opc"] = 2;
//    objData["idCapa"] = idCapa;

//    $.ajax({
//        async: false,
//        type: "POST",
//        url: urlReportes + "ExportarPagos",
//        data: JSON.stringify(objData),
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        success: function (data) {
//            if (data.d == null) {
//                $(function () {
//                    new Messi("No hay datos Disponibles", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
//                });
//            } else {
//                location.href = data.d;
//                $(function () {
//                    new Messi("Reporte exportado Correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
//                });
//            }
//        } //Fin data
//    }); //Fin DEL .aja
//};




function ListarSede(vc_control) {
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
        beforeSend: function () { $("#" + vc_control + "").html("<option>Cargando..</option").attr("disabled", "disabled"); },
        success: function (response) {

            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#" + vc_control + "").html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");
            for (var i = 0; i < data.length; i++) {
                $("#" + vc_control + "").append("<option value=\"" + data[i].in_SedeID + "\">" + data[i].vc_Sede + "</option>");
            }
            //ddl_Sede

        }
    });
};

$(document).ready(function () {
    $("#ddlCampanias").html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");

    ListarSede('ddlSedes');
    $("#ddlSedes").change(function () {
        debugger;
        ListarCampaña('ddlCampanias', 'ddlSedes');
    });

 

});

var urlSedes = "Frm_MantSede.aspx/";
var url = "Frm_Reportes.aspx/";
function ListarCampaña(vc_control, vc_dependencia) {
    //alert($('#ddl_Sede').val());
    var objData = {};
    objData["in_Opc"] = 1;
    objData["in_SedeID"] = $('#' + vc_dependencia + '').val();
    debugger;
    // 
    $.ajax({
        async: false,
        type: "POST",
        url: url + "mantCampania",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        beforeSend: function () { $("#" + vc_control + "").html("<option>Cargando..</option").attr("disabled", "disabled"); },
        success: function (response) {
            debugger;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#" + vc_control + "").html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");
            for (var i = 0; i < data.length; i++) {
                $("#" + vc_control + "").append("<option value=\"" + data[i].in_CampaniaID + "\">" + data[i].vc_Campania + "</option>");
            }

        }
    });
};
var urlCamp = "Frm_MantCampanias.aspx/";
var urlSedes = "Frm_MantSede.aspx/";
var urlCapacitador = "Frm_MantCapacitador.aspx/";
var pgnum = 1;

$(document).ready(function () {

    $("#btn_grabar").click(function () {
        if ($.trim($("#txt_Nombre").val()) == "") {
            setMensajes("Inrese su nombre");
        } else if ($.trim($("#txt_ApePaterno").val()) == "") {
            setMensajes("Inrese su apellido paterno");
        } else if ($.trim($("#txt_ApeMaterno").val()) == "") {
            setMensajes("Inrese su apellido materno");
        } else if ($.trim($("#txt_dni").val()) == "") {
            setMensajes("Inrese su DNI");
        } else if ($.trim($("#txt_Usuario").val()) == "") {
            setMensajes("Inrese su usuario");
        } else {
            setCapacitador();
        }
    });

    ListarSede("#ddlSedes");
    ListarCampanias("#ddlCampanias");
    GetGridCapacitador(1);

    $("#ddlSedes").change(function () {
        ListarCampanias("#ddlCampanias");
        GetGridCapacitador(1);
    });

    $("#ddlCampanias").change(function () {
        GetGridCapacitador(1);
    });

});

function setCapacitador() {
    var objData = {};
    objData["in_opc"] = 3;
    objData["nroPagina"] = 0;
    objData["tamPagina"] = 0;
    objData["in_CapacitadorID"] = $("#hdCapacitador").val();
    objData["vc_DNI"] = $("#txt_dni").val();
    objData["vc_Nombre"] = $("#txt_Nombre").val();
    objData["vc_ApePaterno"] = $("#txt_ApePaterno").val();
    objData["vc_ApeMaterno"] = $("#txt_ApeMaterno").val();
    objData["vc_Usuario"] = $("#txt_Usuario").val();
    objData["vc_Clave"] = "";
    objData["vc_Buscar"] = "";
    objData["in_SedeID"] = $("#ddlSedes").val();
    objData["in_CampaniaID"] = $("#ddlCampanias").val();

    $.ajax({
        async: false,
        type: "POST",
        url: urlCapacitador + "mantCapacitador",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var obj = data.d;
            if (obj[0].in_Resul >= 1) {
                setMensajes("Registrado con éxito");
                $("#dvRegistroCapacitador").modal('hide');
                GetGridCapacitador(1);
            } else {
                setMensajes("Error al trata de registrar");
            }//Fin condicion
        }//Fin Success
    }); //Fin Ajax
};

function setMensajes(msj) {
    new Messi(msj, { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 2000, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
}

function JQ_Open_Ventana_Registro() {
    debugger;
    if ($("#ddlCampanias").val() == 0) {
        setMensajes("Seleccione una sede y luego una campaña");
        return false;
    }
    $("#txt_Nombre").val("");
    $("#txt_ApePaterno").val("");
    $("#txt_ApeMaterno").val("");
    $("#txt_dni").val("");
    $("#txt_Usuario").val("");
    $("#dvRegistroCapacitador").modal('show');
}

function GetGridCapacitador(pgnum) {
    var objData = {};
    objData["in_opc"] = 1;
    objData["nroPagina"] = pgnum;
    objData["tamPagina"] = 10;
    objData["in_CapacitadorID"] = 0;
    objData["vc_DNI"] = "";
    objData["vc_Nombre"] = "";
    objData["vc_ApePaterno"] = "";
    objData["vc_ApeMaterno"] = "";
    objData["vc_Usuario"] = "";
    objData["vc_Clave"] = "";
    objData["vc_Buscar"] = $("#txtBuscar").val();
    objData["in_SedeID"] = $("#ddlSedes").val();
    objData["in_CampaniaID"] = $("#ddlCampanias").val();

    $.ajax({
        async: false,
        type: "POST",
        url: urlCapacitador + "mantCapacitador",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tbCapacitador tr:not(:first)').remove();
            if (data.length > 0) {
                for (var i = 0; i <= data.length; i++) {
                    if (data.length == i) {
                        pageCount = data[0].in_TotalRegistros;
                        var StrPager = "";
                        if (pageCount > 1) {
                            for (var x = 1; x <= pageCount; x++) {
                                if (x == 1) {
                                    StrPager = "<tr class='pgr'><td colspan='10' style='text-align:left;padding:6px;'>";
                                }
                                StrPager = StrPager + "<label style='line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #0A0A0A;font-weight: bold;" + (x == pgnum ? "color: #F4FAF4;" : "color: #080809;cursor:pointer;" + "'  onclick='GetGridCapacitador(" + x + ");") + "'>" + x + "</label>";
                                if (x == pageCount) {
                                    StrPager = StrPager + "</td></tr>";
                                }
                            }
                        } else { StrPager = "<tr class='pgr'><td colspan='10' style='text-align:left;padding:10px;'></td></tr>"; }
                    } else {
                        if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                        strRows +=
                                   "<td>" + data[i].vc_ApePaterno + " " + data[i].vc_ApeMaterno + ", " + data[i].vc_Nombre + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_DNI + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_Usuario + "</td>" +
                                   "<td>" + data[i].NomRegistro + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_FecRegistro + "</td>" +
                                   "<td align=center><img src='libreria/imagenes/Botones/btnEditarG.gif' title='Editar' onclick='getCapacitador(" + '"' + data[i].in_CapacitadorID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "<td align=center><img src='libreria/imagenes/Botones/Resetear.png' title='Resetear Clave' onclick='Resetear_Clave(" + '"' + data[i].in_CapacitadorID + '"' + ");' style='cursor:pointer;' /></td>"+
                                   "<td align=center>" + (data[i].in_Estado == 1 ? "<img src='libreria/imagenes/Botones/Activo.png' title='Desactivar'" : "<img src='libreria/imagenes/Botones/Desactivo.png' title='Activar'") + " onclick='estadoCapacitador(" + '"' + data[i].in_CapacitadorID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</td></tr>";
                    }
                }
                $("#tbCapacitador").append(strRows + StrPager);

            } else { $("#tbCapacitador").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
};

function estadoCapacitador(idCapacitador) {
    new Messi('Confirme el cambio de estado de este capacitador', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                var objData = {};
                objData["in_opc"] = 5;
                objData["nroPagina"] = 0;
                objData["tamPagina"] = 0;
                objData["in_CapacitadorID"] = idCapacitador;
                objData["vc_DNI"] = "";
                objData["vc_Nombre"] = "";
                objData["vc_ApePaterno"] = "";
                objData["vc_ApeMaterno"] = "";
                objData["vc_Usuario"] = "";
                objData["vc_Clave"] = "";
                objData["vc_Buscar"] = "";
                objData["in_SedeID"] = 0;
                objData["in_CampaniaID"] = 0;

                $.ajax({
                    async: false,
                    type: "POST",
                    url: urlCapacitador + "mantCapacitador",
                    data: JSON.stringify(objData),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (response) {
                        var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                        if (data.length > 0) {
                            if (data[0].in_Resul >= 1) {
                                setMensajes("Registrado con éxito");
                                GetGridCapacitador(1);
                            } else {
                                setMensajes("Error al trata de registrar");
                            }//Fin condicion
                        }
                    }//Fin Success
                }); //Fin Ajax              
            } // Fin del IF
        } // Fin title
    });
}

function Resetear_Clave(idCapacitador) {
    new Messi('Confirme el reseteo de la clave de este capacitador', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                var objData = {};
                objData["in_opc"] = 4;
                objData["nroPagina"] = 0;
                objData["tamPagina"] = 0;
                objData["in_CapacitadorID"] = idCapacitador;
                objData["vc_DNI"] = "";
                objData["vc_Nombre"] = "";
                objData["vc_ApePaterno"] = "";
                objData["vc_ApeMaterno"] = "";
                objData["vc_Usuario"] = "";
                objData["vc_Clave"] = "";
                objData["vc_Buscar"] = "";
                objData["in_SedeID"] = 0;
                objData["in_CampaniaID"] = 0;

                $.ajax({
                    async: false,
                    type: "POST",
                    url: urlCapacitador + "mantCapacitador",
                    data: JSON.stringify(objData),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (response) {
                        var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                        if (data.length > 0) {
                            if (data[0].in_Resul >= 1) {
                                setMensajes("Registrado con éxito");
                                GetGridCapacitador(1);
                            } else {
                                setMensajes("Error al trata de registrar");
                            }//Fin condicion
                        }
                    }//Fin Success
                }); //Fin Ajax              
            } // Fin del IF
        } // Fin title
    });
}

function getCapacitador(idCapacitor) {
    var objData = {};
    objData["in_opc"] = 2;
    objData["nroPagina"] = 0;
    objData["tamPagina"] = 0;
    objData["in_CapacitadorID"] = idCapacitor;
    objData["vc_DNI"] = "";
    objData["vc_Nombre"] = "";
    objData["vc_ApePaterno"] = "";
    objData["vc_ApeMaterno"] = "";
    objData["vc_Usuario"] = "";
    objData["vc_Clave"] = "";
    objData["vc_Buscar"] = "";
    objData["in_SedeID"] = 0;
    objData["in_CampaniaID"] = 0;

    $.ajax({
        async: false,
        type: "POST",
        url: urlCapacitador + "mantCapacitador",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            if (data.length > 0) {
                $("#hdCapacitador").val(data[0].in_CapacitadorID);
                $("#txt_Nombre").val(data[0].vc_Nombre);
                $("#txt_ApePaterno").val(data[0].vc_ApePaterno);
                $("#txt_ApeMaterno").val(data[0].vc_ApeMaterno);
                $("#txt_dni").val(data[0].vc_DNI);
                $("#txt_Usuario").val(data[0].vc_Usuario);
                $("#dvRegistroCapacitador").modal('show');
            }
        }//Fin Success
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
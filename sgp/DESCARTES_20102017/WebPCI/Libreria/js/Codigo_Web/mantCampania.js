var url = "Frm_MantCampanias.aspx/";
var urlSedes = "Frm_MantSede.aspx/";

$(document).ready(function () {

    //$("#txtPagoDia").number(true, 2);

    ListarSede("#ddlSedes");
    getGridCampanias();

    $("#ddlSedes").change(function () {
        getGridCampanias();
    });

    $("#btn_grabar").click(function () {
        if ($("#txtCampania").val() == "") {
            new Messi("Ingrese el nombre de la campaña", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else{
            setCampania();
        }
    })

    $("#btnCambiarSede").click(function () {
        if ($("#ddlCambiarSede").val() == 0) {
            new Messi("Seleccione una sede", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else {
            setCambiarSede();
        }

    })
});

function setCampania() {
    var objData = {};
    objData["in_opc"] = 3;
    objData["in_CampaniaID"] = $("#hdCampania").val();
    objData["in_SedeID"] = $("#ddlSedes").val();
    objData["vc_Campania"] = $("#txtCampania").val();
    objData["dc_PagoDia"] = 0;

    $.ajax({
        type: "POST",
        url: url + "mantCampania",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var obj = data.d;
            if (obj[0].in_Resul >= 1) {
                new Messi("Registrado correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                $("#txtCampania").val("");
                $("#hdCampania").val(0);
                $("#dvCampania").modal('hide');
                getGridCampanias();
            } else {
                new Messi("Error de Registro", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }//Fin condicion
        },//Fin data
        error: function (data) {
            new Messi("Error de Registro", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin DEL .aja
};

function getEditarCampania(idCampania) {
    $("#dvCampania").modal('show');
    var objData = {};
    objData["in_opc"] = 2;
    objData["in_CampaniaID"] = idCampania;
    objData["in_SedeID"] = 0;
    objData["vc_Campania"] = "";
    objData["dc_PagoDia"] = 0;

    $.ajax({
        type: "POST",
        url: url + "mantCampania",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#hdCampania").val(data[0].in_CampaniaID);
            $("#txtCampania").val(data[0].vc_Campania);
            $("#txtPagoDia").val(data[0].dc_PagoDia);
        },//Fin data
        error: function (response) {
            new Messi("Error al leer los datos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin DEL .aja
}

function setEstadoCampania(idCampania) {
    new Messi('Desea eliminar esta campaña?', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                var objData = {};
                objData["in_opc"] = 4;
                objData["in_CampaniaID"] = idCampania;
                objData["in_SedeID"] = 0;
                objData["vc_Campania"] = "";
                objData["dc_PagoDia"] = 0;

                $.ajax({
                    type: "POST",
                    url: url + "mantCampania",
                    data: JSON.stringify(objData),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var obj = data.d;
                        if (obj[0].in_Resul >= 1) {
                            new Messi("Campaña eliminada", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 13 });
                            getGridCampanias();
                        } else {
                            new Messi("Error al cambiar estado - Verificar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                        }//Fin condicion
                    },//Fin data
                    error: function (data) {
                        new Messi("Error al cambiar el estado - Verificar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                    }
                }); //Fin DEL .aja
            } // Fin del IF
        } // Fin title
    });
};

function JQ_Open_Ventana_Registro() {
    if ($("#ddlSedes").val() != 0) {
        $("#dvCampania").modal('show');
        $("#txtCampania").val("");
        $("#hdCampania").val(0);
        $("#txtPagoDia").val("");
    } else {
        new Messi("Seleccione una sede", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
    }
}


function getGridCampanias() {
    var objData = {};
    objData["in_opc"] = 1;
    objData["in_CampaniaID"] = 0;
    objData["in_SedeID"] = $("#ddlSedes").val();
    objData["vc_Campania"] = "";
    objData["dc_PagoDia"] = 0.0;

    $.ajax({
        async: false,
        type: "POST",
        url: url + "mantCampania",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tbCampanias tr:not(:first)').remove();
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
                                   "<td>" + data[i].vc_Campania + "</td>" +
                                   //"<td>" + data[i].vc_Nombres + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dt_FechRegistro + "</td>" +                                   
                                  "<td style='text-align:center;'><a href='javascript:fnc_asignarMatrices(" + data[i].in_CampaniaID + ", /" + data[i].vc_Campania + "/);'>Agregar Matriz </a></td>" +
 "<td align=center><img src='libreria/imagenes/Botones/btnEditarG.gif' title='Editar' onclick='getEditarCampania(" + '"' + data[i].in_CampaniaID + '"' + ");' style='cursor:pointer;' /></td>" +
 "<td align=center>" + (data[i].in_Estado == 1 ? "<img src='libreria/imagenes/Botones/Activo.png' title='Desactivar'" : "<img src='libreria/imagenes/Botones/Desactivo.png' title='Activar'") + " onclick='setEstadoCampania(" + '"' + data[i].in_CampaniaID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</tr>"
                    }
                }
                $("#tbCampanias").append(strRows + StrPager);

            } else { $("#tbCampanias").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
};



function getCambiarSede(idCampania) {
    new Messi('Desea cambiar de sede a esta campaña?', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                $("#dvCambiarSede").modal('show');
                $("#hdCambiar").val(idCampania);
                ListarSede("#ddlCambiarSede");
            } // Fin del IF
        } // Fin title
    });
}

function setCambiarSede() {
    var objData = {};
    objData["in_opc"] = 7;
    objData["in_CampaniaID"] = $("#hdCambiar").val();;
    objData["in_SedeID"] = $("#ddlCambiarSede").val();
    objData["vc_Campania"] = "";
    objData["dc_PagoDia"] = 0;

    $.ajax({
        type: "POST",
        url: url + "mantCampania",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var obj = data.d;
            if (obj[0].in_Resul >= 1) {
                new Messi("Cambiado correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                $("#dvCambiarSede").modal('hide');
                getGridCampanias();
            } else {
                new Messi("Error al cambiar de sede", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }//Fin condicion
        },//Fin data
        error: function (data) {
            new Messi("Error al cambiar de sede", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin DEL .aja
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

/*Asignar matrices*/


function fnc_asignarMatrices(in_CampaniaID,vc_campannia) {

 
    $('#lblCampannia').text(JQ_reemplazar(vc_campannia));
    $('#hd_id_campannia').val(in_CampaniaID);

    $("#div_AsignarMatriz").modal('show');
    debugger;
    ListarMatrices();

    listar_matricesxCamp(in_CampaniaID);
    
}
function JQ_reemplazar(vc_cadena) {

    var result = "" + vc_cadena;
    while (result.indexOf("/") != -1) {
        result = result.replace("/", "");
    }
    return result;
}
function listar_matricesxCamp(in_CampaniaID) {
    var objData = {};
    objData["indice"] = 2;
    objData["in_campannia"] = in_CampaniaID;
    objData["in_nivel"] = 0;
    objData["cod"] = 0;
    objData["in_usuario_reg"] = 0;
    objData["pagenum"] = 1;
    objData["pagesize"] = 10;
    var DTA = {};
    DTA.objData = objData;

    $.ajax({
        async: false,
        type: "POST",
        url: url + "Asignacion",
        data: JSON.stringify(DTA),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            debugger;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tb_lst_Campa tr:not(:first)').remove();
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
                                   "<tr><td style='text-align:left;'>" + data[i].vc_titulo + "</td>" +
                                    "<td><a href='javascript:fnc_eliminar(" + data[i].cod + ","+data[i].in_CampaniaID+")'>Eliminar</a></td></tr>";

                    }
                }

                $("#tb_lst_Campa").empty().html(strRows + StrPager);

            } else { $("#tb_lst_Campa").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
}

function fnc_asignar_matriz() {

    var in_matriz = $('#ddl_matrices').val();

    var objData = {};
    objData["indice"] = 3;
    objData["in_campannia"] = $('#hd_id_campannia').val();
    objData["in_nivel"] = in_matriz;
    objData["cod"] = 0;
    objData["in_usuario_reg"] = 0;

    var DTA = {};
    DTA.objData = objData;

    $.ajax({
        async: false,
        type: "POST",
        url: url + "Asignacion",
        data: JSON.stringify(DTA),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            debugger;
            //var obj = data.d;
            if (data[0].in_Resul >= 1) {
                new Messi("Matriz asignada", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });

                listar_matricesxCamp( $('#hd_id_campannia').val());
            } else {
                new Messi("Error al asignar matriz. No se puede duplicar la matriz", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }//Fin condicion
        }
    });
}
function fnc_eliminar(cod, in_CampaniaID) {
    //alert(cod);
    //PL
    var objData = {};
    objData["indice"] = 4;
    objData["in_campannia"] = 0;
    objData["in_nivel"] = 0;
    objData["cod"] = cod;
    objData["in_usuario_reg"] = 0;

    var DTA = {};
    DTA.objData = objData;

    $.ajax({
        async: false,
        type: "POST",
        url: url + "Asignacion",
        data: JSON.stringify(DTA),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            debugger;
          
            if (data[0].in_Resul >= 1) {
               
                listar_matricesxCamp($('#hd_id_campannia').val());
            } else {
                new Messi("Error al cambiar estado - Verificar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }//Fin condicion
        }
    });
}

$(document).ready(function () {



    $('#ddl_matrices').change(function () {

    });
});


function ListarMatrices() {


    var objData = {};
    objData["indice"] = 1;
    objData["in_campannia"] = 0;
    objData["in_nivel"] = 0;
    objData["cod"] = 0;
    objData["in_usuario_reg"] = 0;

    var DTA = {};
    DTA.objData = objData;

    $.ajax({
        async: false,
        type: "POST",
        url: url + "Asignacion",
        data: JSON.stringify(DTA),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        beforeSend: function () { $("#ddl_matrices").html("<option>Cargando..</option").attr("disabled", "disabled"); },
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#ddl_matrices").html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");
            for (var i = 0; i < data.length; i++) {
                $("#ddl_matrices").append("<option value=\"" + data[i].cod + "\">" + data[i].vc_titulo + "</option>");
            }

        }
    });
};
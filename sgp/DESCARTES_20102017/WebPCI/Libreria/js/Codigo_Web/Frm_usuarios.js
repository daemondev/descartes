//DECLARACION DE LA URL DEL FORMULARIO
var url = "Frm_usuarios.aspx/";
var urlSedes = "Frm_MantSede.aspx/";
var pgnum = 1;

$(document).ready(function () {
    
    GetGridUsuario(1);
    //Guarda los Datos
    $("#btn_grabar").click(function () {
        
        if ($("#txt_Nombre").val() == "") {
            new Messi("Ingrese el nombre", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#txt_ApePaterno").val() == "") {
            new Messi("Ingrese el apellido paterno", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#txt_ApeMaterno").val() == "") {
            new Messi("Ingrese el apellido materno", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#txt_dni").val() == "") {
            new Messi("Ingrese el DNI", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#txt_Usuario").val() == "") {
            new Messi("Ingrese el Usuario", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#ddlPerfil").val() == 0) {
            new Messi("Seleccione el Perfil", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else if ($("#ddl_Sede").val() == 0) {
            new Messi("Seleccione la sede", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
            //} else if ($("#txtCorreo").val() != "" && !validar_email($("#txtCorreo").val())) {
            //    new Messi("Ingrese un correo válido", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            //}
        else {
            Grabar_Usuario();
        }

    })

});

function validar_email(valor) {
    // creamos nuestra regla con expresiones regulares.
    var filter = /[\w-]{3,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w-]{2,4}/;
    // utilizamos test para comprobar si el parametro valor cumple la regla
    if (filter.test(valor))
        return true;
    else
        return false;
}

function Grabar_Usuario() {
    debugger;
    var objData = {};
    objData["in_opc"] = 4;
    objData["tamPagina"] = 0;
    objData["nroPagina"] = 0;
    objData["in_UsuarioID"] = $("#hdIdUsuario").val();
    objData["vc_DNI"] = $("#txt_dni").val();
    objData["vc_Nombre"] = $("#txt_Nombre").val();
    objData["vc_ApePaterno"] = $("#txt_ApePaterno").val();
    objData["vc_ApeMaterno"] = $("#txt_ApeMaterno").val();
    objData["vc_Usuario"] = $("#txt_Usuario").val();
    objData["vc_Clave"] = "";
    objData["in_PerfilID"] = $("#ddlPerfil").val();
    objData["in_SedeID"] = $("#ddl_Sede").val();
    objData["in_CampaniaID"] = $('#ddlCampania').val();
    //$("#txtCorreo").val() == "" ? objData["vc_Correo"] = "" : objData["vc_Correo"] = $("#txtCorreo").val();
    $.ajax({
        type: "POST",
        url: url + "mantUsuarios",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var obj = data.d;
            if (obj[0].in_Resul >= 1) {
                new Messi("Registro Correctamente realizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                Limpiar();
                $("#dvUsuario").modal('hide');
                GetGridUsuario(1);
            } else {
                new Messi("Error de Registro - No pueden haber dos usuarios iguales", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }//Fin condicion
        }//Fin data
    }); //Fin DEL .aja
};

function JQ_Open_Ventana_Registro() {
    $("#dvUsuario").modal('show');
    Limpiar();
    ListarPerfil();
    ListarSede('ddl_Sede');
}

//Limpiar Caja de Texto
function Limpiar() {
    $("#hdIdUsuario").val(0);
    $("#txt_Nombre").val("");
    $("#txt_ApePaterno").val("");
    $("#txt_ApeMaterno").val("");
    $("#txt_dni").val("");
    $("#txt_Usuario").val("");
    $("#ddlPerfil").val(0);
    $("#ddl_Sede").val(0);
    $("#txtCorreo").val("");
}

function GetGridUsuario(pgnum) {
    var objData = {};
    objData["in_opc"] = 2;
    objData["tamPagina"] = 20;
    objData["nroPagina"] = pgnum;
    objData["in_UsuarioID"] = 0;
    $("#txtBuscar").val() == "" ? objData["vc_DNI"] = "%" : objData["vc_DNI"] = $("#txtBuscar").val();
    objData["vc_Nombre"] = "";
    objData["vc_ApePaterno"] = "";
    objData["vc_ApeMaterno"] = "";
    objData["vc_Usuario"] = "";
    objData["vc_Clave"] = "";
    objData["in_PerfilID"] = 0;
    objData["in_SedeID"] = 0;
    objData["in_CampaniaID"] = 0;

    


    $.ajax({
        async: false,
        type: "POST",
        url: url + "mantUsuarios",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tb_usuarios tr:not(:first)').remove();
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
                                StrPager = StrPager + "<label style='line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #0A0A0A;font-weight: bold;" + (x == pgnum ? "color: #F4FAF4;" : "color: #080809;cursor:pointer;" + "'  onclick='GetGridUsuario(" + x + ");") + "'>" + x + "</label>";
                                if (x == pageCount) {
                                    StrPager = StrPager + "</td></tr>";
                                }
                            }
                        } else { StrPager = "<tr class='pgr'><td colspan='10' style='text-align:left;padding:10px;'></td></tr>"; }
                    } else {
                        if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                        strRows +=
                                   "<td>" + data[i].vc_ApePaterno + " " + data[i].vc_ApeMaterno + ", " + data[i].vc_Nombre + "</td>" +
                                   "<td style='text-align: center;'>" + data[i].vc_DNI + "</td>" +
                                   "<td style='text-align: center;'>" + data[i].vc_Usuario + "</td>" +
                                   //"<td style='text-align: center;'>" + data[i].vc_Correo + "</td>" +
                                   "<td style='text-align: center;'>" + data[i].vc_Perfil + "</td>" +
                                   "<td style='text-align: center;'>" + data[i].vc_Sede + "</td>" +
                                   "<td style='text-align: center;'>" + data[i].vc_FecRegistro + "</td>" +
                                   "<td align=center><img src='Images/iconos/edit.png'  width='18px' title='Editar' onclick='Editar_usuario(" + '"' + data[i].in_UsuarioID + '"' + ");' style='cursor:pointer;' /></td>";
                                   //"<td align=center><img src='libreria/imagenes/Botones/Resetear.png' title='Resetear Clave' onclick='Resetear_Clave(" + '"' + data[i].in_UsuarioID + '"' + ");' style='cursor:pointer;' /></td>";
                        if (data[i].in_UsuarioID == 1) {
                            strRows += "<td></td>";
                        } else {
                            strRows += "<td align=center>" + (data[i].in_Estado == 1 ? "<img src='Images/iconos/checked.png' width='18px' title='Desactivar'" : "<img src='Images/iconos/unchecked.png' width='18px' title='Activar'") + " onclick='Estado_usuario(" + '"' + data[i].in_UsuarioID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</td></tr>";
                        }
                    }
                }
                $("#tb_usuarios").append(strRows + StrPager);

            } else { $("#tb_usuarios").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
};

function Estado_usuario(id_usuario) {
    new Messi('Confirme el cambio de estado de este usuario', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                var objData = {};
                objData["in_opc"] = 6;
                objData["tamPagina"] = 0;
                objData["nroPagina"] = 0;
                objData["in_UsuarioID"] = id_usuario;
                objData["vc_DNI"] = "";
                objData["vc_Nombre"] = "";
                objData["vc_ApePaterno"] = "";
                objData["vc_ApeMaterno"] = "";
                objData["vc_Usuario"] = "";
                objData["vc_Clave"] = "";
                objData["in_PerfilID"] = 0;
                objData["in_SedeID"] = 0;
                objData["vc_Correo"] = "";
				objData["in_CampaniaID"] = 0;
                $.ajax({
                    type: "POST",
                    url: url + "mantUsuarios",
                    data: JSON.stringify(objData),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var obj = data.d;
                        if (obj[0].in_Resul >= 1) {
                            new Messi("Cambio correctamente realizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 150, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                            GetGridUsuario(1);
                        } else {
                            new Messi("Error - Verificar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 12, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                        }//Fin condicion
                    }//Fin data
                }); //Fin DEL .aja                
            } // Fin del IF
        } // Fin title
    });
}

function Resetear_Clave(id_usuario) {
    new Messi('Confirme el reseteo de la clave de este usuario', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                var objData = {};
                objData["in_opc"] = 5;
                objData["tamPagina"] = 0;
                objData["nroPagina"] = 0;
                objData["in_UsuarioID"] = id_usuario;
                objData["vc_DNI"] = "";
                objData["vc_Nombre"] = "";
                objData["vc_ApePaterno"] = "";
                objData["vc_ApeMaterno"] = "";
                objData["vc_Usuario"] = "";
                objData["vc_Clave"] = "";
                objData["in_PerfilID"] = 0;
                objData["in_SedeID"] = 0;
                objData["vc_Correo"] = "";
                $.ajax({
                    async: false,
                    type: "POST",
                    url: url + "mantUsuarios",
                    data: JSON.stringify(objData),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var obj = data.d;
                        if (obj[0].in_Resul == 1) {
                            new Messi("Proceso realizado Correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                            GetGridUsuario(1);
                        } else {
                            $(function () {
                                new Messi("Error de Actualización", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                            });
                        }//Fin condicion
                    }//Fin del Data
                });// Fin del ajax
            } // Fin del IF
        } // Fin title
    }); // Fin Messi
}



function Editar_usuario(id_usuario) {
    ListarPerfil();
    ListarSede('ddl_Sede');   
    debugger;
    $("#dvUsuario").modal('show');
    var objData = {};
    objData["in_opc"] = 3;
    objData["tamPagina"] = 0;
    objData["nroPagina"] = 0;
    objData["in_UsuarioID"] = id_usuario;
    objData["vc_DNI"] = "";
    objData["vc_Nombre"] = "";
    objData["vc_ApePaterno"] = "";
    objData["vc_ApeMaterno"] = "";
    objData["vc_Usuario"] = "";
    objData["vc_Clave"] = "";
    objData["in_PerfilID"] = 0;
    objData["in_SedeID"] = 0;
    objData["in_CampaniaID"] = 0;
    debugger;

    $.ajax({     
        type: "POST",
        url: url + "mantUsuarios",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            debugger;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#hdIdUsuario").val(data[0].in_UsuarioID);
            $("#txt_Nombre").val(data[0].vc_Nombre);
            $("#txt_ApePaterno").val(data[0].vc_ApePaterno);
            $("#txt_ApeMaterno").val(data[0].vc_ApeMaterno);
            $("#txt_dni").val(data[0].vc_DNI);
            $("#txt_Usuario").val(data[0].vc_Usuario);
            //$("#txtCorreo").val(data[0].vc_Correo);
            $("#ddlPerfil").val(data[0].in_PerfilID);
            $("#ddl_Sede").val(data[0].in_SedeID);
            //alert(data[0].in_CampaniaID);
            
            ListarCampaña('ddlCampania','ddl_Sede');
            debugger;
            $('#ddlCampania').val(data[0].in_CampaniaID);
        }//Fin data
    }); //Fin DEL .aja

}

function ListarPerfil() {

    $.ajax({
        async: false,
        type: "POST",
        url: url + "mantPerfil",
        //data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        beforeSend: function () { $("#ddlPerfil").html("<option>Cargando..</option").attr("disabled", "disabled"); },
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#ddlPerfil").html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");
            for (var i = 0; i < data.length; i++) {
                $("#ddlPerfil").append("<option value=\"" + data[i].in_PerfilID + "\">" + data[i].vc_Perfil + "</option>");
            }
        }
    });
};

$(document).ready(function () {
    ListarSede('ddl_filtro_sedes');
    ListarSede('ddl_carga_Sede');

    ListarCampaña('ddl_carga_campaña', 'ddl_carga_Sede');
    $('#ddl_filtro_sedes').change(function () {
        ListarCampaña('ddl_filtro_campañas', 'ddl_filtro_sedes');
    }); 

    $("#ddl_filtro_campañas").html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");

});

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
    $("#ddlCampania").html("<option value=\"0\">[SELECCIONAR]</option").removeAttr("disabled");
  
    $("#ddl_Sede").change(function () {
        debugger;
        ListarCampaña('ddlCampania', 'ddl_Sede');
    });

    $("#ddl_carga_Sede").change(function () {
        debugger;
        ListarCampaña('ddl_carga_campaña', 'ddl_carga_Sede');
    });

});


function ListarCampaña(vc_control,vc_dependencia) {
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
                $("#"+vc_control+"").append("<option value=\"" + data[i].in_CampaniaID + "\">" + data[i].vc_Campania + "</option>");
            }

        }
    });
};


$(document).ready(function () {

    //$('#indicadores').hide();
    $('#div_CargaMasiva').hide();


    $("#fileupload").click("change", function () {
        Carga_Datos(this);
    });

});
function fnc_mostrarIndicaciones() {
    if ($('#indicadores').is(':visible')) {
        $('#indicadores').hide();
    } else {
        $('#indicadores').show();
    }
   
}

function fnc_carga_masiva() {
    $("#div_CargaMasiva").modal('show');
}


function Carga_Datos() {
    debugger;


    if ($('#ddl_carga_Sede').val() == "0" || $('#ddl_carga_campaña').val() == "0") {
        new Messi("Seleccionar sede y campaña", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500 });

        return false;
    } else {
    

    $("#fileupload").fileupload({
        replaceFileInput: false,
        dataType: 'json',
        url: 'UploadHandler.ashx',
        add: function (e, data) {
            var valid = true;
            var re = /^.+\.((txt))$/i;
            $.each(data.files, function (index, file) {
                if (!re.test(file.name)) {
                    valid = false;
                }
            });
            debugger;
            if (valid) {
                //if ($("#hdCapaID").val() == "0") {
                //    new Messi("Se presento un error al cargar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                //    return false;
                //}

                $('#dvProgressBarDown').fadeIn(400, function () {
                    document.getElementById("progressDown").className = "progress";
                    $('#dvProgressBarDown').css("display", "block");
                });
                data.submit();
            }
            else {
                $('#dvProgressBarDown').fadeOut(400, function () {
                    $('#dvProgressBarDown').css("display", "none");
                });
                new Messi("Seleccionar Archivos txt con el formato correcto", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }
        },
        done: function (e, data) {
            $.each(data.result, function (index, file) {
                $('#dvProgressBarDown').fadeOut(400, function () {
                    $('#dvProgressBarDown').css("display", "none");
                });
                setCargaAgentesFile(file.fileName);
            });
        },
        progressall: function (e, data) {
            $(".se-pre-con").fadeOut("slow");;

            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progressDown .bar').css(
                'width',
                progress + '%'
            );
            $("#lblProgressDown").text(progress + '%');
        },
        fail: function (e, data) {
            $('#dvProgressBarDown').css("display", "none");
            new Messi("Error al subir el archivo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    });

    }
};

function setCargaAgentesFile(file) {
    var objData = {};
    //objData["idCapacitacion"] = $("#hdCapaID").val();
    objData["vc_archivo"] = file;
    objData["in_SedeID"] = $('#ddl_carga_Sede').val();
    objData["in_CampaniaID"] = $('#ddl_carga_campaña').val();
    objData["in_PerfilID"] = 2;
    debugger;


    $.ajax({

        type: "POST",
        url: url + "setCargaAsFile",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            debugger;
            var obj = data.d;

            if (obj[0].in_Resul >= 1) {
                new Messi("Carga Realizada Correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                GetGridUsuario(1);
                $('#div_CargaMasiva').hide();
                $('#div_CargaMasiva').modal('hide');
                $("#fileupload").val("");
              
                //getCapa();
                //getCapaAgentes($("#hdCapaID").val());
            } else {
                new Messi("Error de Registro - Verificar nombre del Archivo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });

                $("#fileupload").val("");
            }//Fin condicion
        },//Fin data
        error: function (data) {
            new Messi("Error de Registro - Verificar nombre del Archivo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin DEL .aja
};

var url = "Frm_MantSede.aspx/";

$(document).ready(function () {
    getGridSedes();

    $("#btn_grabar").click(function () {
        if ($("#txtSede").val() == "") {
            new Messi("Ingrese el nombre de la sede", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else {
            setSede();
        }

    })
});

function setSede() {
    var objData = {};
    objData["in_opc"] = 3;
    objData["in_SedeID"] = $("#hdSede").val();
    objData["vc_Sede"] = $("#txtSede").val();

    $.ajax({
        type: "POST",
        url: url + "mantSedes",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var obj = data.d;
            if (obj[0].in_Resul >= 1) {
                new Messi("Registro Correctamente realizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                $("#txtSede").val("");
                $("#hdSede").val(0);
                $("#dvSede").modal('hide');
                getGridSedes();
            } else {
                new Messi("Error de Registro - Verificar nombre del Archivo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
            }//Fin condicion
        },//Fin data
        error: function (data) {
            new Messi("Error de Registro - Verificar nombre del Archivo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin DEL .aja
};

function JQ_Open_Ventana_Registro() {
    $("#dvSede").modal('show');
    $("#txtSede").val("");
    $("#txtSede").focus();
    $("#hdSede").val(0);
}

function getEditarSede(idSede) {
    $("#dvSede").modal('show');
    var objData = {};
    objData["in_opc"] = 2;
    objData["in_SedeID"] = idSede;
    objData["vc_Sede"] = "";

    $.ajax({
        type: "POST",
        url: url + "mantSedes",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            $("#hdSede").val(data[0].in_SedeID);
            $("#txtSede").val(data[0].vc_Sede);
        },//Fin data
        error: function (response) {
            new Messi("Error al leer los datos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    }); //Fin DEL .aja

}

function getGridSedes() {
    var objData = {};
    objData["in_opc"] = 1;
    objData["in_SedeID"] = 0;
    objData["vc_Sede"] = "";

    $.ajax({
        async: false,
        type: "POST",
        url: url + "mantSedes",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tbSedes tr:not(:first)').remove();
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
                                   "<td>" + data[i].vc_Sede + "</td>" +
                                   "<td>" + data[i].vc_Nombres + "</td>" +
                                   "<td>" + data[i].dt_FechRegistro + "</td>" +
                                   "<td align=center><img src='libreria/imagenes/Botones/btnEditarG.gif' title='Editar' onclick='getEditarSede(" + '"' + data[i].in_SedeID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "<td align=center>" + (data[i].in_Estado == 1 ? "<img src='libreria/imagenes/Botones/Activo.png' title='Desactivar'" : "<img src='libreria/imagenes/Botones/Desactivo.png' title='Activar'") + " onclick='setEstadoSede(" + '"' + data[i].in_SedeID + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</td></tr>"
                    }
                }
                $("#tbSedes").append(strRows + StrPager);

            } else { $("#tbSedes").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
};

//cambiar de estado
function setEstadoSede(in_SedeID) {
    new Messi('Desea cambiar de estado a esta sede?', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                var objData = {};
                objData["in_opc"] = 4;
                objData["in_SedeID"] = in_SedeID;
                objData["vc_Sede"] = "";

                $.ajax({
                    type: "POST",
                    url: url + "mantSedes",
                    data: JSON.stringify(objData),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var obj = data.d;
                        if (obj[0].in_Resul >= 1) {
                            new Messi("Estado cambiado correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                            getGridSedes();
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
}
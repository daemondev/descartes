var url = "Frm_usuarios.aspx/";

$(document).ready(function () {
    $("#btn_grabar").click(function () {
        if ($("#txtClave").val().length != 0) {
            Resetear_Clave();
        } else {
            new Messi("Ingrese una clave!", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        }
    });
});

function Resetear_Clave() {
    var objData = {};
    objData["in_opc"] = 5;
    objData["tamPagina"] = 0;
    objData["nroPagina"] = 0;
    objData["in_UsuarioID"] = 0;
    objData["vc_DNI"] = "";
    objData["vc_Nombre"] = "";
    objData["vc_ApePaterno"] = "";
    objData["vc_ApeMaterno"] = "";
    objData["vc_Usuario"] = "";
    objData["vc_Clave"] = $("#txtClave").val();
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
                location.href = "Frm_Principal.aspx";
            } else {
                $(function () {
                    new Messi("Error de Actualización", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                });
            }//Fin condicion
        }//Fin del Data
    });// Fin del ajax
}
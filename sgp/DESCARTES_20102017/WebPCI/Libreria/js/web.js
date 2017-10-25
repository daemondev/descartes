/// <reference path="../../Service.svc" />
$(document).ready(function () {
    setInterval(function () {
        var minum = mensajesNoLeidos();
        if (minum != 0) {
            mostrarMensajes();
            $("#cantMsg").html(minum);
        }    
    }, 5000);
    $("#closemsg").click(ocultate);
});
function ocultate() {
    $("#revelacion").animate({
        left: '1350px',
        top: '640px',
        width: '0px',
        height: '0px',
    }, "slow");
    $("#revelacion").fadeOut(10, function () {
        this.html("");
        this.css("visibility", "hidden");
    });
}
//setInterval(llamada_general, 10000); // 1 minutos=60000 milisegundos
//$.ajaxSetup({ cache: false });
function carga() {
    if (elusu != 1) {
        window.location.assign("Frm_mensaje.aspx");
  
     }
    else {
        window.location.assign("frm_personasConectadas.aspx");
  
    }
}
function mostrarMensajes() {
    $("#revelacion").animate({
        left: '1350px',
        top: '640px',
        width: '0px',
        height: '0px',
    }, 10);
    $("#revelacion").html("");
    $("#revelacion").css("visibility", "hidden");


    $("#revelacion").css("visibility", "visible");
    $("#revelacion").append('<div class="modal-dialog" role="document">' +
                                '<div class="modal-content">' +
                                    '<div class="modal-header" style="width:200px">' +
                                        //'<button type="button" class="close" data-dismiss="modal" aria-label="Close" id="closemsg"><span aria-hidden="true">&times;</span></button>' +
                                         '<h5 class="modal-title" style="font-weight:bold;color:white;">Mensajes no leidos</h5>' +
                                     '</div>' +
                                '<div class="modal-body" style="width:200px;cursor:pointer;"onclick="carga()">' +
                                    '<p id="cantMsg" style="font-size:24px;text-align:center"></p>' +
                                 '</div>' +
                                '</div>' +
                            '</div>');
    $("#revelacion").animate({
        left: '1160px',
        top: '490px',
        width: '50px',
        height: '50px',
    }, 10);
}
var elusu = 0;
function mensajesNoLeidos() {
    var url = "Frm_Principal.aspx/";
    var msg = 0;
    $.ajax({
        async: false,
        type: "POST",
        url: url + "mensajesNoLeidos",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            msg = data.d[0];
            elusu = data.d[1];
        }
    }); // Fin ajax	

    return msg;
}

$(function () {
    //LISTA DE MENUS
    GC_Web.Lista_Menu();
});

function setPagina(pagina) {
    alert(pagina);
}

var GC_Web = (function (obj) {
    obj.url = "Frm_Principal.aspx/";

    //Lista Menu de Opciones
    obj.Lista_Menu = function () {
        $.ajax({
            async: false,
            type: "POST",
            url: obj.url + "getMenuPerfil",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                var hijo = data;
                var hijo_1 = data;
                var nieto = data;
                if (data.length > 0) {
                    debugger;
                    var item = "";
                    item += "<ul class='sidebar-menu'>";
                    //1° Nivel
                    for (var i = 0; i < data.length; i++) {
                        if ((data[i].in_PadreID == 0)) {
                            item += "<li class='treeview'><a href='" + data[i].vc_Url + "'><i class='" + data[i].vc_Imagen + "'></i><span>" + data[i].vc_NomMenu + "</span><i class='fa fa-angle-left pull-right'></i></a>";
                            item += "<ul class='treeview-menu'>";

                            //2º Nivel
                            for (var h = 0; h < hijo.length; h++) {
                                if (data[i].in_MenuID == hijo[h].in_PadreID) {
                                    item += "<li><a href='" + hijo[h].vc_Url + "' onclick='setPagina('" + hijo[h].vc_NomMenu + "');' ><i class='" + data[h].vc_Imagen + "'></i>" + hijo[h].vc_NomMenu + "</a></li>";
                                }
                            }
                            item += "</ul></li>"
                        }
                    }//Fin for 1° Nivel
                    item += "</ul>"
                    $("#divMenu_Horiz").append(item);
                }
            }
        });//ajax
    }; // Fin Lista Menu

   return obj;
}(GC_Web || {}));

function JQ_Logout() {
    var url = "Frm_Principal.aspx/";
    new Messi('Desea cerrar su session actual?', {
        modal: true, center: true,
        title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val) {
            if (val == true) {
                if (sessionStorage.getItem("sePerfil") != null) {
                    sessionStorage.removeItem("sePerfil");
                }
                $.ajax({
                    async: false,
                    type: "POST",
                    url: url + "cerrarSession",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var xobj = data.d;
                        if (xobj === 1) {
                            location.href = 'Login.aspx';
                        }
                       
                    }
                }); // Fin ajax	
            } // Fin del IF
        } // Fin title
    }); // Fin Messi
};

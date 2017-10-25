var url = "frm_personasConectadas.aspx/";
var pgnum = 1;
$(document).ready(function () {

    GetGridUsuario(1);
    $("#parar").click(function () {
        clearInterval(myvar);
        Limpiar();
    });

    $("#btn_Enviar").click(function () {
        var objData = {};
        objData["msg"] = $("#enviarMensaje").val();
        objData["receptor"] = $("#idEmisor").text();
        $.ajax({
            async: false,
            type: "POST",
            url: url + "EnviarMensaje",
            data: JSON.stringify(objData),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function () {
                var strNuevoMsg = "";
                /*var d = new Date();
                var fecha = d.getDate()+"/"+d.getMonth()+"/"+d.getFullYear+" "+d.getHours()+":"+d.getMinutes+":"+d.getSeconds();*/

                strNuevoMsg += "<div style='float:right;width:300px;background-color:#8DD17D;color:white;padding:5px;border-radius:10px;'><p>" + $("#enviarMensaje").val() + "</p></div><div style='float:right;padding:5px;height:50px;visibility:hidden'></div>";

                $("#mensajesAnteriores").append(strNuevoMsg);
                $("#enviarMensaje").val("");
            }
        });
    });

    $("#btn_Eliminar").click(function () {

        new Messi('¿Esta seguro que desea eliminar el historial?',
                {
                    title: 'Eliminar Historial',
                    buttons: [
                        { id: 0, label: 'Yes', val: 'Y' },
                        { id: 1, label: 'No', val: 'N' }
                    ],
                    callback: function (val) {
                        if (val == 'Y') {
                            var objData = {};
                            objData["receptor"] = $("#idEmisor").text();
                            $.ajax({
                                async: false,
                                type: "POST",
                                url: url + "EliminarHistorial",
                                data: JSON.stringify(objData),
                                dataType: "json",
                                contentType: "application/json; charset=utf-8",
                                success: function () {
                                    $("#mensajesAnteriores").html("");
                                }                                    
                             });
                        } else autoclose: 500;
                    }
                }
                );      
    });
});


function GetGridUsuario(pgnum) {
    var objData = {};
    objData["in_opc"] = 8;
    objData["tamPagina"] = 10;
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
        url: url + "conectados",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tb_conectados tr:not(:first)').remove();
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
                                   "<td style='text-align: center;'>" + data[i].vc_Usuario + "</td>" +
                                   "<td style='text-align: center;'>" + data[i].vc_Perfil + "</td>";                     
                        var nombreCompleto = data[i].vc_ApePaterno + " " + data[i].vc_ApeMaterno + " " + data[i].vc_Nombre;
                        strRows += "<td align=center>" + (data[i].EstadoConexion == true ? "<img src='Images/iconos/bola_verdad.png' width='18px' title='Conectado'" : "<img src='Images/iconos/BolaRoja.png' width='18px' title='Desconectado'") + " /></td>" +
                                    "</td>" +
                                    "<td align=center><img src='Images/iconos/mensaje.png' width='36px' title='Correo' style='cursor:pointer;'onclick='mostrarChat(" + data[i].in_UsuarioID + "," + '"' + nombreCompleto + '"' + ")'/>" +
                                    "&nbsp;&nbsp;&nbsp;<span id='" + data[i].in_UsuarioID + "'>" + (data[i].msgsNoleidos == 0 ? "<img src='Images/numeros/0.png' width='36px'/>" : (data[i].msgsNoleidos == 1 ? "<img src='Images/numeros/1.png' width='36px'/>" : (data[i].msgsNoleidos == 2 ? "<img src='Images/numeros/2.png' width='36px'/>" : (data[i].msgsNoleidos == 3 ? "<img src='Images/numeros/3.png' width='36px'/>" : (data[i].msgsNoleidos == 4 ? "<img src='Images/numeros/4.png' width='36px'/>" : (data[i].msgsNoleidos == 5 ? "<img src='Images/numeros/5.png' width='36px'/>" : "<img src='Images/numeros/mas5.png' width='50px'/>" )))))) + "</span></td>" +
                                    "</td></tr>";
                        

                    }
                }
                $("#tb_conectados").append(strRows + StrPager);

            } else { $("#tb_conectados").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
};
var myvar;
function mostrarChat(Emisor, nombre) {
    myvar=setInterval(function () {
    $("#revelacion").animate({
        left: '1350px',
        top: '640px',
        width: '0px',
        height: '0px',
    }, 10);
    $("#revelacion").html("");
    $("#revelacion").css("visibility", "hidden");
    $("#mensajesAnteriores").html("");
    $("#idEmisor").html(Emisor);
    $("#nombreEmisor").html(nombre);
    $("#" + Emisor).html("");
    $("#" + Emisor).prepend("<img src='Images/numeros/0.png' width='36px'/>");
    var objData = {};
    objData["Emisor"] = Emisor;
    $.ajax({
        async: false,
        type: "POST",
        url: url + "mostrarChat",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var strMensajesAnteriores = "";
           
            if (data.length > 0) {
               
                var i = 0;
                for (i = 0; i < data.length; i++) {
                    if (data[i].emisor == Emisor) {
                        strMensajesAnteriores += "<div style='float:left;width:300px;padding:5px;border-radius:10px;background-color:#C1C1C1;margin-bottom:10px'><p>" + data[i].mensaje + "</p>" +
                            "<p style='font-style:italic;font-size:10px;float:right'>" + data[i].FechaHoraMSG + "</p></div>";
                    }
                    else strMensajesAnteriores += "<div style='float:right;width:300px;background-color:#8DD17D;color:white;padding:5px;border-radius:10px;;margin-bottom:10px'><p>" + data[i].mensaje + "</p>" +
                        "<p style='font-style:italic;font-size:10px;float:right'>" + data[i].FechaHoraMSG + "</p></div><br>";

                }

                $("#mensajesAnteriores").append(strMensajesAnteriores);
            }
            JQ_Open_Ventana_Registro();
        }

    });
    },1000);
}

function JQ_Open_Ventana_Registro() {
    $("#dvMensaje").modal('show');
}

function Limpiar() {
    $("#nombreEmisor").html("");
    $("#idEmisor").html("");
    $("#mensajesAnteriores").html("");
    $("#enviarMensaje").val("");
}
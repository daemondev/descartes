var urlCapacitaciones = "Frm_MantCapacitacion.aspx/";
var urlMantAgentes = "Frm_MantAgente.aspx/";
var urlSedes = "Frm_MantSede.aspx/";
var urlCamp = "Frm_MantCampanias.aspx/";
var urlCargaAgente = "Frm_CargaAgentes.aspx/";

function ajustar(id)
{
	
	var texto = document.getElementById(id);
	var txt = texto.value;
	var tamano = txt.length +1;
	
	tamano *= 8.1; //el valor multiplicativo debe cambiarse dependiendo del tamaño de la fuente
	
	if (tamano > 100)
	{
		texto.style.width = tamano + "px";
	} else
	{
		texto.style.width = "100px";
	}

}

$(document).ready(function ()
{
	$('#div1').hide();
	$('#btnUpdate').hide();
	debugger;
	$("#btnCargaAgenteIndividual").click(function ()
	{

		debugger;
		$('#txtCliente').val('');
		$('#txtapellido').val('');
		$('#txtCodigo').val('');
        $("#dvCargaAgenteIndividual").modal('show');
    });
    $("#btnUpdate").click(function ()
    {
    	fnc_UpdateClie();
    });
    //ListarSede("#ddlSedes");
    //ListarCampanias("#ddlCampanias");
    GetClientes(1);

    //$("#ddlSedes").change(function () {
    //    ListarCampanias("#ddlCampanias");
    //    getGridCapacitaciones();
    //});

    //$("#ddlCampanias").change(function () {
    //    getGridCapacitaciones();
    //});

    $("#fileupload").click("change", function () {
        Carga_Datos(this);
    });

    $("#btnCerrarCargaAgentes").click(function () {
        //getGridCapacitaciones();
        $("#dvCargarAgentes").hide();
        $("#dvListaCapacitaciones").show();
    })
    
  

    $("#btnGuardarAgente").click(function ()
    {
        //PL
        debugger;


    	if ($("#txtCliente").val() == "" || $("#txtCodigo").val() == "" || $("#txtapellido").val()=="" )
    	{
            new Messi("Ingrese todos los campos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
        } else {
    		var objData = {};
    		objData["indice"] = 1;
    		objData["id_cliente"] = 0;
    		objData["vc_nombre"] = $("#txtCliente").val();
    		objData["vc_apellidos"] = $("#txtapellido").val();
            objData["vc_codigo"] = $("#txtCodigo").val();
          
            $.ajax({
                type: "POST",
                url: urlCargaAgente + "setCargaAgente",
                data: JSON.stringify(objData),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data)
                {
                	debugger;
                    var obj = data.d;
                    if (obj[0].in_Resul >= 1) {
                        new Messi("Registro correcto", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                        GetClientes(1);
                        $("#dvCargaAgenteIndividual").modal('hide');
                    } else {
                        new Messi("Error de Registro - Verificar nombre del Archivo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });                        
                    }//Fin condicion
                },//Fin data
                error: function (data) {
                    new Messi("Error de Registro - Verificar nombre del Archivo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                }
            }); //Fin DEL .aja
        }

    })
});

function limpiarCampos() {
    $("#txtUsuario").val("");
    $("#txtDNI").val("");
    $("#txtNombres").val("");
    $("#txtPaterno").val("");
    $("#txtMaterno").val("");
}

function GetClientes(p) {
    var objData = {};
    objData["indice"] = 2;
    objData["pagenum"] = p;
    objData["pagesize"] = 50;

	
	//PL
    debugger;
    $.ajax({
        async: false,
        type: "POST",
        url: urlCargaAgente + "mantClie",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response)
        {
        	debugger;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager; var strRows;
            $('#tbCapacitaciones tr:not(:first)').remove();
            if (data.length > 0) {
            	for (var i = 0; i <= data.length; i++)
            	{
            		debugger;
                	if ((data.length)== i)
                	{
                		var pageCount = data[0].total;
                		var StrPager = "";
                		if (pageCount > 1)
                		{
                			for (var x = 1; x <= pageCount; x++)
                			{
                				if (x == 1)
                				{
                					StrPager = "<tr class='pgr'><td colspan='7' style='text-align:left;padding:6px;'>";
                				}
                				StrPager = StrPager + "<label style='cursor:pointer;line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #666;font-weight: bold;" + (x == pageCount ? "color: #63B46D;" : "color: #666666;") + "' onclick='GetClientes(" + x + ");'>" + x + "</label>";
                				if (x == pageCount)
                				{
                					StrPager = StrPager + "</td></tr>";
                				}
                			}
                		} else
                		{ StrPager = "<tr class='pgr'><td colspan='7' style='text-align:left;padding:10px;'></td></tr>"; }
                    	//pageCount = data[0].total;
                        //var StrPager = "";
                        //if (pageCount > 1) {
                        //    for (var x = 1; x <= pageCount; x++) {
                        //        if (x == 1) {
                        //            StrPager = "<tr class='pgr'><td colspan='9' style='text-align:left;padding:6px;'>";
                        //        }
                        //        if (x == pageCount) {
                        //            StrPager = StrPager + "</td></tr>";
                        //        }
                        //    }
                		//} else { StrPager = "<tr class='pgr'><td colspan='9' style='text-align:left;padding:10px;'></td></tr>"; }


                    } else {
                        if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                        strRows +=
                                    "<td>" + data[i].vc_nombre + "</td>" +
								   "<td>" + data[i].vc_apellidos + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].vc_codigo + "</td>" +
                                   "<td style='text-align:center;'>" + data[i].dt_fecregistro + "</td>" +
								    "<td style='text-align:center;'><img src='Images/iconos/edit.png' width='18px' onclick='fnc_EditarCliente(" + data[i].id_cliente + ",/" + data[i].vc_nombre + "/,/ " + data[i].vc_apellidos + "/,/" + data[i].vc_codigo + "/)' /></td>" +
								   "<td style='text-align:center;'>" + (data[i].in_estado == 1 ? "<img src='Images/iconos/checked.png' width='18px' onclick='fnc_CambiarEstado(" + data[i].id_cliente + "," + data[i].in_estado + ")' />" : "<img src='Images/iconos/unchecked.png' width='18px' onclick='fnc_CambiarEstado(" + data[i].id_cliente + "," + data[i].in_estado + ")'/>") + " </td>" +
								   "<td style='text-align:center;'><img src='Images/iconos/garbage.png' width='18px' onclick='fnc_EliminarCliente(" + data[i].id_cliente + ")' /> </td>" +
//"<td align=center><img src='libreria/imagenes/Botones/addControl.gif' title='Cargar agentes' onclick='getCargaAgentes(" + '"' + data[i].in_estado + '"' + ");' style='cursor:pointer;' /></td>" +
                                   "</tr>"					
                    }
                }
                debugger;
                $("#tbCapacitaciones").append(strRows + StrPager);

            } else { $("#tbCapacitaciones").append("<tr><td style='text-align:center;' colspan='10'>No hay capacitaciones registradas</td></tr>"); }
        }//Fin Success
    }); //Fin Ajax
};

function JQ_reemplazar(vc_cadena)
{ 
	var result = "" + vc_cadena;
	while (result.indexOf("/") != -1)
	{
		result = result.replace("/", "");
	}
	return result;
}

function fnc_EditarCliente(id_cliente, vc_nombre,vc_apellidos, vc_codigo)
{
	//alert(id_cliente.toString() + ':' + vc_nombre + ':' + vc_codigo);

    //$("#txtCodigo").solonumeros();

    $('#lblidClie').text(id_cliente);

	$("#txtCliente").val(JQ_reemplazar(vc_nombre));
	$('#txtapellido').val(JQ_reemplazar(vc_apellidos));
	$("#txtCodigo").val(JQ_reemplazar(vc_codigo));
	$('#btnUpdate').show();
	$('#btnGuardarAgente').hide();
	debugger;
	$("#dvCargaAgenteIndividual").modal({
		title:"Editar"
	});

//	fnc_UpdateClie(id_cliente, $("#txtCliente").val(), $("#txtCodigo").val());
}
function fnc_UpdateClie()
{
	debugger;
	
	var objData = {};
	objData["indice"] = 3;
	objData["id_cliente"] = $('#lblidClie').text();
	objData["vc_nombre"] = $("#txtCliente").val();
	objData["vc_apellidos"] = $("#txtapellido").val();
	objData["vc_codigo"] = $("#txtCodigo").val();
	objData["in_archivo"] = 0;
	//in_archivo=0 es cuando registramos un cliente individualmente, no pertener a un archivo de carga

	$.ajax({
		async: false,
		type: "POST",
		url: urlCargaAgente + "setCargaAgente",
		data: JSON.stringify(objData),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		beforeSend: function () { },
		success: function (response)
		{
			debugger;
			var obj = response.d;
			
			if (obj[0].in_Resul >= 1)
			{
				new Messi("Actualización correcta", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
				$("#dvCargaAgenteIndividual").modal('hide');
				GetClientes(1);
			}
		}
	});
}

function fnc_CambiarEstado(id_cliente, in_estado)
{	
	//ModEstadoClie
	var objData = {};
	objData["indice"] = 5;
	objData["id_cliente"] = id_cliente;
	objData["in_estado"] =(in_estado==1? 2:1);

	debugger;
	$.ajax({
		async: false,
		type: "POST",
		url: urlCargaAgente + "ModEstadoClie",
		data: JSON.stringify(objData),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		beforeSend: function () { },
		success: function (response)
		{
			debugger;
			var obj = response.d;

			if (obj >= 1)
			{				
			
				GetClientes(1);
			}
		}
	});
}

function fnc_EliminarCliente(id_cliente)
{

	var objData = {};
	objData["indice"] = 4;
	objData["id_cliente"] = id_cliente;

	debugger;
	$.ajax({
		async: false,
		type: "POST",
		url: urlCargaAgente + "DeleteClie",
		data: JSON.stringify(objData),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		beforeSend: function () { },
		success: function (response)
		{
			debugger;
			var obj = response.d;

			if (obj >= 1)
			{
				GetClientes(1);
			}
		}
	});
}

$(window).load(function ()
{
	// Animate loader off screen
	$(".se-pre-con").fadeOut("slow");;
});

function Carga_Datos(n)
{
	debugger;

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
        progressall: function (e, data)
        {
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
};

function setCargaAgentesFile(file) {
    var objData = {};
	//objData["idCapacitacion"] = $("#hdCapaID").val();
    objData["vc_archivo"] = file;
    debugger;
   $('#div1').show();

    $.ajax({
    	
        type: "POST",
        url: urlCargaAgente + "setCargaAgenteFile",
        data: JSON.stringify(objData),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data)
        {
        	debugger;
        	var obj = data.d;
    
            if (obj[0].in_Resul >= 1)
            {
                new Messi("Carga Realizada Correctamente", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
                $('#div1').hide();
                
                $("#fileupload").val("");
                GetClientes(1);
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



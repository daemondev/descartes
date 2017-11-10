CKEDITOR.on('instanceReady', function (ev) {
    var t = $(".cke_toolbar .cke_voice_label");
    $.each(t, function (k, v) {
        if ($(v).html() != "Documento") $(v).parent().hide();
    });

    CKEDITOR.instances.divEditor.getCommand('selectAll').enable();

    $('iframe').contents().dblclick(function (e) {
        //if (typeof e.target.href != 'undefined' && e.ctrlKey == true) {
        if (typeof e.target.href != 'undefined') {
            window.open(e.target.href, 'new' + e.screenX);
        }

        /*
        var ag = af.data.getTarget(), ah = { element: ag, dialog: '' };
        if (ag.is('a') && ag.$.href && (ag.$.protocol.indexOf('http') == 0)) {
            window.open(ag.$.href, '_blank'); af.data.preventDefault(); return;
        } //*/
    });
});

var inInicio = 0;
$(document).ready(function () {
	//GetNiveles(0, 1, 'tb_0', 'lst');
	//$('#lbl_id_nivel').hide();

	$('#lbl_id_categoria').hide();
	$('#lbl_id_nivel').text(0);
	$('#lbl_id_categoria').text(0);
	$('#plazo').hide();
	
	$('#lbl_id_nivel').hide();

	$('#lblid_nivel').hide();

	$("#btn_inicio").click(function (e) {	    
	    $('#campañas').show();
	    $('#todo').hide();	    
	    e.preventDefault();
	});
	

});
$(document).tooltip();

function ConsultarHistorial(p) {

    $('#div_historial').modal();

   // debugger;
    var objData = {};
    objData["indice"] = 1;
    objData["pagenum"] = p;
    objData["pagesize"] = 10;
    objData["vc_codigo"] = $('#lblCod').text();

    var DTA = {};
    DTA.objData = objData;

    $.ajax({
        async: false,
        type: "POST",
        url: urlFrm_MantNivel + "ConsultarHistorial",
        data: JSON.stringify(DTA),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            //debugger;
            var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
            var pageCount = 0;
            var StrPager = '';
            var strRows = '';

            //$('#'+vc_id_control+' tr:not(:first)').remove();
            if (data.length > 0) {
                for (var i = 0; i <= data.length; i++) {
                    //debugger;

                    if ((data.length) == i) {

                        var pageCount = data[0].total;
                        var StrPager = "";
                        if (pageCount >= 1) {
                            for (var x = 1; x <= pageCount; x++) {

                                if (x == 1) {
                                    StrPager = "<tr class='pgr'><td colspan='12' style='text-align:left;padding:6px;'>";
                                }
                                StrPager = StrPager + "<label style='cursor:pointer;line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #666;font-weight: bold;" + (x == pageCount ? "color: #63B46D;" : "color: #666666;") + "' onclick='ConsultarHistorial(" + x + ");'>" + x + "</label>";
                                if (x == pageCount) {
                                    StrPager = StrPager + "</td></tr>";
                                }
                            }

                        } else {
                            StrPager = "<tr  class='pgr'><td colspan='12' style='text-align:left;padding:10px;'></td></tr>";

                            if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
                        }
                    } else {
                        strRows += "<tr>" +
						            "<td style='width: 120px'>" + data[i].vc_nombre + "</td>" +
                                    "<td style='width: 120px'>" + data[i].vc_codigo + "</td>" +
                                    "<td style='width: 120px'>" + data[i].vc_resultado + "</td>" +
                                    "<td style='width: 120px'>" + data[i].dt_fecregistro + "</td>" +
                                    "<td style='width: 120px'>" + data[i].vc_duracion + "</td>" +
                                    "<td  style='width: 250px'>" + data[i].vc_tipificacion + "</td>" +
                                    "<td  style='width: 120px'>" + data[i].vc_obs + "</td>" +
						            "</tr>";
                    }
                }
                //debugger;
                $('#tb_historiaCliente').empty().html(strRows + StrPager);

                //$("#" + vc_id_control + "").append(strRows + StrPager);
            } else {
                $('#tb_historiaCliente').empty().html("<tr><td style='text-align:center;' colspan='10'>No hay Niveles registrados</td></tr>");
                //$("#" + vc_id_control + "").append();
            }
        }//Fin Success
    }); //Fin Ajax

}

function GetNiveles(in_dpndncia_idnivel, p, vc_id_control, vc_lst)
{
	vc_lst = JQ_reemplazar(vc_lst);

	
	vc_id_control = JQ_reemplazar(vc_id_control);

	//averiguar porque se puso >= 1
	if (($('#' + JQ_reemplazar(vc_id_control) + ' >tr').length >= 1) && (vc_lst == 'lst'))
	{
		$('#' + JQ_reemplazar(vc_id_control) + '').empty().html('');
		return;
	}

	vc_id_control = JQ_reemplazar(vc_id_control);
	var objData = {};
	objData["indice"] = 1;
	objData["pagenum"] = p;
	objData["pagesize"] = 4;
	objData["in_dpndncia_idnivel"] = in_dpndncia_idnivel;

	var DTA = {};
	DTA.objData = objData;

	$.ajax({
		async: false,
		type: "POST",
		url: urlFrm_MantNivel + "mantNivel",
		data: JSON.stringify(DTA),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response) {
		
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			var pageCount = 0;
			var StrPager = '';
			var strRows = '';

			//$('#'+vc_id_control+' tr:not(:first)').remove();
			if (data.length > 0) {
				for (var i = 0; i <= data.length; i++) {
					if ((data.length) == i) {						
						var pageCount = data[0].total;
						var StrPager = "";
						if (pageCount >= 1) {
							for (var x = 1; x <= pageCount; x++) {								
								if (x == 1) {
									StrPager = "<tr class='pgr'><td colspan='12' style='text-align:left;padding:6px;'>";
								}
								StrPager = StrPager + "<label style='cursor:pointer;line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #666;font-weight: bold;" + (x == pageCount ? "color: #63B46D;" : "color: #666666;") + "' onclick='GetNiveles(" + in_dpndncia_idnivel + ", " + x + ",/" + vc_id_control + "/,/pag/);'>" + x + "</label>";
								if (x == pageCount) {
									StrPager = StrPager + "</td></tr>";
								}
							}

						}
						else {
							StrPager = "<tr  class='pgr'><td colspan='12' style='text-align:left;padding:10px;'></td></tr>";
							
							if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
						}
					}
					else {
						strRows += "<tr id='" + data[i].id_nivel + "'>" +
"<td style='width:80px;' ><a id='href_" + data[i].id_nivel + "' href='javascript:GetNiveles(" + data[i].id_nivel + "," + 1 + ",/tb_" + data[i].id_nivel + "/,/" + "lst" + "/)'>" + (data[i].in_cate == 0 ? 'Principal' : (data[i].in_cate == 1 ? 'Categoria' : (data[i].in_cate == 2 ? 'Subcategoria' : 'Proceso'))) + "</a></td>" +

								  "<td   style='text-align:center;width:100px; '>" + data[i].vc_titulo + "</td>" +
								  "<td   style='text-align:center;width:100px; '>" + data[i].vc_descripcion + "</td>" +
								  //"<td style='text-align:center;width:100px;'>" + data[i].vc_url_img + "</td>" +

"<td style='text-align:center;width:5%;'>" +
(data[i].in_rpta == 1 ? "<img src='Images/iconos/radio-on-button.png' width='18px' />" :
					   (data[i].in_rpta == 2 ? "<img src='Images/iconos/image-square-button.png' width='18px'  />" :
											   (data[i].in_rpta == 5 ? "<a href='javascript:fnc_linkeo(" + data[i].id_nivel + ")'  title='" + data[i].vc_enlase + "' ><img src='Images/iconos/external-link-symbol.png'  width='16px' /></a></a>" :
												   (data[i].in_rpta == 3 ? "<img src='Images/iconos/like.png' width='22px'  />" :
																		   "<img src='Images/iconos/image-square-button.png' width='18px'  />")))) + "</td>" +

"<td style='text-align:center;width:100px;'>" + data[i].vc_alerta + "</td>" +
//"<td style='text-align:center;width: 5%;' >" + (data[i].in_rpta == 5 ? "<a href='javascript:fnc_linkeo(" + data[i].id_nivel + ")'><img src='Images/iconos/external-link-symbol.png'  width='16px' /></a></a>" : "nolink") + "</td>" +
"<td style='text-align:center;width:5%;'>" + (data[i].in_estado == 1 ? "<img src='Images/iconos/checked.png'  width='18px' onclick='fnc_CambiarEstado(" + data[i].id_nivel + "," + data[i].in_estado + "," + data[i].in_dpndncia_idnivel + ")' />" : "<img src='Images/iconos/unchecked.png'  width='18px' onclick='fnc_CambiarEstado(" + data[i].id_nivel + "," + data[i].in_estado + "," + in_dpndncia_idnivel + ")'/>") + "</td>" +

"<td style='text-align:center;width:5%;'><img src='Images/iconos/edit.png' width='18px' onclick='fnc_EditarNivel(" + data[i].id_nivel + "," + data[i].in_cate + ",/" + (data[i].vc_titulo == '' ? '-' : data[i].vc_titulo) + "/,/" + (data[i].vc_descripcion == '' ? '-' : data[i].vc_descripcion) + "/,/" + (data[i].vc_url_img == '' ? '-' : data[i].vc_url_img) + "/," + data[i].in_rpta + "," + data[i].in_tipo_rpta + "," + data[i].in_dpndncia_idnivel + ",/" + (data[i].vc_alerta == '' ? '-' : data[i].vc_alerta) + "/)'/></td>" +
"<td style='text-align:center;width:5%;'><img src='Images/iconos/add.png' width='18px' onclick='fnc_nuevaCategoria(" + data[i].id_nivel + "," + data[i].in_cate + ")' /></td>" +
"<td style='text-align:center;width:5%;'><img src='Images/iconos/garbage.png' width='18px' onclick='fnc_EliminarNivel(" + data[i].id_nivel + "," + data[i].in_dpndncia_idnivel + ")'/></td>" +

"<td style='text-align:center;width:5%;'>" + (data[i].in_dpndncia_idnivel == 0 ? " <a href='javascript:fnc_preview(" + data[i].id_nivel + ")'><img src='Images/iconos/preview.png'  width='32px' /></a>" : "<input type='radio' name='rd_link' onclick='fnc_AsignarLink(" + data[i].id_nivel + ")' id='rd_link_" + data[i].id_nivel + "' style='visibility:hidden'/>") + "</td>" +

								   "</tr><tr style='display:'><td colspan='12'>" +
								   "<table  id='tab_" + data[i].id_nivel + "' style='width:98%;margin-left:2%;' >" +
			   "<tbody id='tb_" + data[i].id_nivel + "' >" +
			   "</tbody> " +
								   "</table>" +
								   "</td></tr>";
					}
				}
				

				$('#' + vc_id_control + '').empty().html(strRows + StrPager);

				//$("#" + vc_id_control + "").append(strRows + StrPager);
			}
			else {
				$('#' + vc_id_control + '').empty().html("<tr><td style='text-align:center;' colspan='10'>No hay Niveles registrados</td></tr>");
				//$("#" + vc_id_control + "").append();
			}
		}//Fin Success
	}); //Fin Ajax
};

function fnc_linkeo(in_nivel)
{

	$('#input_id_nivel').val(in_nivel);

	
	for (var i = 0; i < 9999; i++)
	{
		//var id = id_ref.substr(5, id_ref.length);
		if (i != in_nivel)
		{
			$('#rd_link_' + i + '').css("visibility", "visible");
		}
	}
}

function fnc_AsignarLink(in_link_nivel) {
	//alert(in_link_nivel);
	//alert($('#input_id_nivel').val());
	
	var objData = {};
	objData["indice"] = 6;
	objData["id_nivel"] = $('#input_id_nivel').val();;
	objData["in_link"] = in_link_nivel;
	//$('#input_id_link').val();


	var DTO = {};
	DTO.objData = objData;
	$.ajax({
		async: false,
		type: "POST",
		url: urlFrm_MantNivel + "mantNivel",
		data: JSON.stringify(DTO),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		beforeSend: function () { },
		success: function (response)
		{
			
			var obj = response.d;

			if (obj[0].in_result >= 1)
			{
				new Messi("Asignacion correcta", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
				for (var i = 0; i < 9999; i++)
				{
					//var id = id_ref.substr(5, id_ref.length);					
					$('#rd_link_' + i + '').css("visibility", "hidden");
				}
			}
		}
	});

}


function fnc_CambiarEstado(id_nivel, in_estado, in_dpndncia_idnivel) {
	//alert(id_nivel);
	//alert(in_estado);

	new Messi('Al cambiar de estado también afectará a los subniveles', {
		title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val)
		{
			if (val == true)
			{
				
				var objData = {};
				objData["indice"] = 5;
				objData["id_nivel"] = id_nivel;
				objData["in_estado"] = (in_estado == 1 ? 2 : 1);

				var DTO = {};
				DTO.objData = objData;
				$.ajax({
					async: false,
					type: "POST",
					url: urlFrm_MantNivel + "mantNivel",
					data: JSON.stringify(DTO),
					dataType: "json",
					contentType: "application/json; charset=utf-8",
					beforeSend: function () { },
					success: function (response)
					{
					
						var obj = response.d;

						if (obj[0].in_result >= 1)
						{
							new Messi("Nivel Actualizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 6 });
							var in_categoria = 0;
						
							//alert(in_dpndncia_idnivel);
							//id_nivel = $('#lbl_id_nivel').text();

							GetNiveles((in_dpndncia_idnivel), 1, '/tb_' + in_dpndncia_idnivel + '/', '/reg/');
						}
					}
				});

			} //endif (val == true)
		} // Fin title
	});    // Fin Messi
}



function fnc_EliminarNivel(id_nivel, in_dpndncia_idnivel)
{

	new Messi('Desea Eliminar este nivel?', {
		title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val)
		{
			if (val == true)
			{
				var objData = {};
				objData["indice"] = 4;
				objData["id_nivel"] = id_nivel;
				//debugger;
				var DTO = {};
				DTO.objData = objData;
				$.ajax({
					async: false,
					type: "POST",
					url: urlFrm_MantNivel + "mantNivel",
					data: JSON.stringify(DTO),
					dataType: "json",
					contentType: "application/json; charset=utf-8",
					beforeSend: function () { },
					success: function (response) {
						//debugger;
						var obj = response.d;

						if (obj[0].in_result >= 1) {
							new Messi("Nivel eliminado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
							var in_categoria = 0;
							//debugger;
							in_categoria = $('#lbl_id_categoria').text();

							GetNiveles((in_dpndncia_idnivel), 1, '/tb_' + in_dpndncia_idnivel + '/', '/reg/');
						}
					}
				});
			} //endif (val == true)
		} // Fin title
	});    // Fin Messi

}

function fnc_nuevaCategoria(in_nivel, in_cate)
{
	//debugger;

	fnc_clear();
	//alert(in_cate);

	$('#lbl_id_nivel').text(in_nivel);
	$('#lbl_id_categoria').text(in_cate);
	$('#Textarea_alerta').text('');


	$('#plazo').dialog({
		title: 'Nueva Categoria',
		/*buttons: buttons,		*/
		buttons: [{
			text: 'Guardar',
			click: function ()
			{
				fnc_guardar(2, 0);
			},
			class: 'btn btn-primary btn-md'
		}],
		width: 500
	});
}

function fnc_EditarNivel(id_nivel, in_cate, vc_titulo, vc_descripcion, vc_url_img, in_rpta, in_tipo_rpta, in_dpndncia_idnivel, vc_alerta)
{
	//debugger;
	if (vc_alerta == '/-/')
	{
		vc_alerta = '';
	}

	//debugger;
	//alert(vc_alerta);
	$('#txtTitulo').val(JQ_reemplazar(vc_titulo));
	$('#txtArea_desc').val(JQ_reemplazar(vc_descripcion));
	$('#Textarea_alerta').val(JQ_reemplazar(vc_alerta));
	//$('#fileupload').val(JQ_reemplazar(vc_url_img));
	$('#fileupload').val('');

	$('#ddl_rpta').val(2);

	//$('#lbl_id_nivel').hide();
	$('#lbl_id_nivel').text(id_nivel);
	//$('#tbl_dialog').modal();
	$('#plazo').show();
	$('#tbl_dialog').show();


	//$('#plazo').modal({
	//	buttons: [{text  : 'Editar',
	//				click : function() {
	//					fnc_guardar(3, in_dpndncia_idnivel);
	//				}, 
	//				class : 'btn btn-primary btn-md'
	//			}],
	//});


	$('#plazo').dialog({
		title: 'Editar nivel',
		buttons: [{
			text: 'Editar',
			click: function ()
			{
				fnc_guardar(3, in_dpndncia_idnivel);
			},
			class: 'btn btn-primary btn-md'
		}],
		width: 500
	});
}
function img_vista()
{
	$('#output_img').dialog();
}
$(document).ready(function ()
{
	//document.getElementById('files').addEventListener('change', archivo, false);
	$('#output_img').hide();
	$("#menu").hide();


	//(function ()
	//{
	//	$('btn_1').on('contextmenu', function ()
	//	{
	//		alert('derecho');
	//		// código
	//	});
	//})();
	//(function ()
	//{
	//	$('href_1').on('click', function ()
	//	{
	//		alert('asd');
	//		// código
	//	});
	//})();

	//$('#btn_1').bind("contextmenu", function (e)
	//{
	//	alert($(this).prop('id'));
	//	$("#menu").css({ 'display': '', 'left': e.pageX, 'top': e.pageY });
	//	return false;
	//});


	//$(document).click(function (e)
	//{
	//	if (e.button == 0)
	//	{
	//		$("#menu").css("display", "none");
	//	}
	//});

	//si pulsamos escape, el menú desaparecerá

	//$(document).keydown(function (e)
	//{
	//	if (e.keyCode == 27)
	//	{
	//		$("#menu").css("display", "none");
	//	}
	//});

	//controlamos los botones del menú		
});


function fnc_guardar(in_gestion, in_dpndncia_idnivel)
{

	//debugger;
	var id_nivel = 0;
	if ($('#lbl_id_nivel').text() != '')
	{
		id_nivel = $('#lbl_id_nivel').text();
	}
	if ($('#txtTitulo').val() == '' || $('#txtarea_desc').val() == '')
	{
		new Messi("Ingresar todos los datos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });

	} else
	{
		//debugger;


		var objData = {};
		objData["indice"] = in_gestion;
		objData["in_cate"] = $('#lbl_id_categoria').text();
		objData["vc_titulo"] = $('#txtTitulo').val();
		objData["vc_descripcion"] = $("#txtArea_desc").val();
		if ($("#fileupload").val() != '')
		{
		    objData["vc_url_img"] = $("#fileupload").val();
		    //objData["vc_url_img"] = $("#fileupload")[0].files[0].name; //### replace
		}
		objData["in_rpta"] = $('#ddl_rpta').val();
		objData["in_dpndncia_idnivel"] = (in_gestion == 2 ? $('#lbl_id_nivel').text() : in_dpndncia_idnivel);
		objData["vc_alerta"] = $("#Textarea_alerta").val();
		objData["id_nivel"] = id_nivel;
		//in_archivo=0 es cuando registramos un cliente individualmente, no pertener a un archivo de carga

		var DTO = {};
		DTO.objData = objData;
		$.ajax({
			async: false,
			type: "POST",
			url: urlFrm_MantNivel + "mantNivel",
			data: JSON.stringify(DTO),
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			beforeSend: function () { },
			success: function (response)
			{
				//debugger;
				var obj = response.d;

				if (obj[0].in_result >= 1)
				{
					if (in_gestion == 2)
					{
						new Messi("Nivel registrado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
						id_nivel = $('#lbl_id_nivel').text()
						GetNiveles((id_nivel), 1, '/tb_' + $('#lbl_id_nivel').text() + '/', '/reg/');
					} else
					{
						new Messi("Nivel Actualizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });

						GetNiveles((in_dpndncia_idnivel), 1, '/tb_' + in_dpndncia_idnivel + '/', '/reg/');
					}
					var in_categoria = 0;
					//debugger;
					$('#plazo').dialog("close");

				}
			}
		});


	}




}

function Carga_Img()
{
	//debugger;
	//alert('cargar imAG');
	$("#fileupload").fileupload({
		replaceFileInput: false,
		dataType: 'json',
		url: 'UploadHandler.ashx',
		add: function (e, data)
		{
			var valid = true;
			//var re = /^.+\.((txt))$/i;
			var re = /^.+\.((jpg)|(png)|(gif))$/i;
			$.each(data.files, function (index, file)
			{
				if (!re.test(file.name))
				{
					valid = false;
				}
			});
			//debugger;
			if (valid)
			{
				//if ($("#hdCapaID").val() == "0") {
				//    new Messi("Se presento un error al cargar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
				//    return false;
				//}

				$('#dvProgressBarDown').fadeIn(400, function ()
				{
					document.getElementById("progressDown").className = "progress";
					$('#dvProgressBarDown').css("display", "block");
				});
				data.submit();
			}
			else
			{
				$('#dvProgressBarDown').fadeOut(400, function ()
				{
					$('#dvProgressBarDown').css("display", "none");
				});
				new Messi("Seleccionar Archivos txt con el formato correcto", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
			}
		},
		done: function (e, data)
		{
			//debugger;
			$.each(data.result, function (index, file)
			{
				$('#dvProgressBarDown').fadeOut(400, function ()
				{
					$('#dvProgressBarDown').css("display", "none");
				});
				setCargaAgentesFile(file.fileName);
				//fnc_guardar(file.fileName);
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
		fail: function (e, data)
		{
			$('#dvProgressBarDown').css("display", "none");
			new Messi("Error al subir el archivo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
		}
	});
};

$(document).ready(function ()
{

	$("#fileupload").click("change", function ()
	{
		Carga_Img();
	});

	//$("#tbCampanias tr.odd").click(function ()
	//{

	//	//alert('VER SUBCATEGORIA');
	//	var id=$(this).prop('id');
	//	//alert(id);

	//	$(this).next("tr").toggle();
	//	$(this).find(".arrow").toggleClass("up");

	//	GetNiveles($(this).prop('id'), 1, 'tb_' + id+ '');
	//});
	//$("#tbCampanias").jExpand();

});
/*<UTILITARIOS>*/
function JQ_reemplazar(vc_cadena)
{

	var result = "" + vc_cadena;
	while (result.indexOf("/") != -1)
	{
		result = result.replace("/", "");
	}
	return result;
}

function JQ_reemplazarTbody(vc_cadena)
{

	var result = "" + vc_cadena;
	while (result.indexOf("tbody#") != -1)
	{
		result = result.replace("tbody#", "");
	}
	return result;
}

function ajustar(id)
{
	//alert(id);
	var texto = document.getElementById(id);
	var txt = texto.value;
	var tamano = txt.length + 1;

	tamano *= 8.1; //el valor multiplicativo debe cambiarse dependiendo del tamaño de la fuente

	if (tamano > 100)
	{
		texto.style.width = tamano + "px";
	} else
	{
		texto.style.width = "100px";
	}

}
function fnc_clear()
{
	$('#txtTitulo').val('');
	$('#txtArea_desc').val('');
	$('#Textarea_alerta').val('');
	$('#fileupload').val('');
}
/*</UTILITARIOS>*/

$(document).ready(function ()
{
	$('#lbl_time').hide();
	$('#div_plazo').hide();
	//$('#div_plazo').modal();
	//fnc_listar_niveles(1, 164);
	$('#div_buscarCliente').show();
	guardarpasosantessalto = "";
	horaInicioantessalto = "";
	
});


var urlFrm_MantNivel = "Frm_Gestion.aspx/";

/*ARMAR VISTA PREVIA*/

function fnc_preview(id_nivel)
{
	$('#lblSecuencia').text('');
	//$('#div_plazo').modal();
	$('#td_secuencia').empty().html;
	//$('#div_plazo').dialog({
	////	title: 'VISTA PREVIA',
	////	width: 710,
	////show: "scale",
	////hide: "scale",
	////resizable: "false",
	////position: { my: "center", at: "center", of: window },
	//////modal: "true",
	//});

	fnc_listar_niveles(1, id_nivel);
}

var hasContent = false;

function fnc_listar_niveles(in_listar, in_dpndncia_idnivel) {
    //if(in_listar == 2) return;    
    
    //debugger;
    if (inInicio == 0) {
        fnc_BuscarClie();
        inInicio++;
    }
	//if ($('#lblCliente').text() == '')
	//{
	//	alert('Busque cliente');
	//} else
	//{
	
    //debugger;
    var cadena = "#" + in_dpndncia_idnivel;
	$('#tb_imagenes').hide();
	$('#div_plazo').show();
	$(cadena).css("visibility","visible");

	var d = new Date();
	//alert(d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds());
	$('#lbl_time').text(d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds());


	var objResult = {};
	objResult.hora = d.getHours();
	objResult.min = d.getMinutes();
	objResult.sec = d.getSeconds();
	objResult.horaactual = d.getTime();

	var objJson = JSON.stringify(objResult);
	sessionStorage.setItem("hora", objJson);


	var objData = {};
	objData["indice"] = in_listar;
	objData["in_dpndncia_idnivel"] = in_dpndncia_idnivel;

	var DTA = {};
	DTA.objData = objData;

	var itemsOrdered = {"imagen":"","contenido":"","botones":"", "otros":""};

	hasContent = false;
	$("#hasContent").val("");
	//debugger;
	$.ajax({
		//async: false,
		type: "POST",
		url: urlFrm_MantNivel + "ArmarPreview",
		data: JSON.stringify(DTA),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response) {

			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			var pageCount = 0;
			var StrPager = '';
			var strRows = '';
			var contenidoul = '';
			var imagenespasos = '';
			var existencipasos = 0;
			//$('#'+vc_id_control+' tr:not(:first)').remove();
			if (data.length > 0) {
				//console.log(data[0].vc_alerta);
				$('#lblAlerta_plazo').text(data[0].vc_alerta);
				$('#lblAlerta_plazo').css('color', '');
                //### begin alerta {{
				if (data[0].vc_alerta != '') {
					$('#div_alerta').css('background-color', '' + data[0].vc_color_alerta + '');
				} else {
					$('#div_alerta').css('background-color', 'transparent');
				}
				//alert(data[0].id_nivel);
				if (data[0].vc_color_alerta == 'green' || data[0].vc_color_alerta == 'red') {
				    $('#lblAlerta_plazo').css('color', 'white');
				} else {
					$('#lblAlerta_plazo').css('color', 'black');
				}
			    //### end alerta }}
				if (in_listar == 1) {
					var valores;

					//creando los link de secuencia:
					//$('#tb_secuencia a' ).

					var id_ref = 'href_' + data[0].id_nivel;

					//						alert(id_ref.substr(5, id_ref.length));

					for (var i = 0; i < 9999; i++) {
						//recorrer los controles de tipo href para eliminar los que son superirores al actual,
						//ya que si estoy en un nivel superior(1,2,3,4,5,6,7,8,9,10)  y quiero regresar a un nivel inferior(2), el seguimiento de proceso
					    //debe indicar: 1,2, eliminando lo restante.
					    $('#tr_ref_' + i + '').css("background-color", "#4C4A4A");
					    $('#tr_ref_' + i + '').css("border", "#4C4A4A");
						var id = id_ref.substr(5, id_ref.length);
						if (i >= id) {
							$('#href_v_' + i + '').remove();
							$('#tr_ref_' + i + '').remove();
						}
					}

					var vc_secuencia = $('#div_secuencia').html();
					
					vc_secuencia += "<a id='href_v_" + data[0].id_nivel + "' href='javascript:fnc_listar_niveles(1," + data[0].id_nivel + ")' style='color:#fff;font-weight: bold;'><button id='tr_ref_" + data[0].id_nivel + "' type='button' class='btn btn-danger btn-lg btn-block' style='margin-bottom:3px'>" + data[0].vc_descripcion + "</button></a>";
				    
                    /*### obsolete
					if (data[0].id_nivel == "954") {
					    for (var j = 1; j < 8; j++) {
					        if (j == 1) {
					            vc_secuencia += "<a href='javascript:fnc_listar_niveles(1,1133)' style='color:#fff;font-weight: bold;'><button id='tr_ref_" + data[0].id_nivel + j + "' type='button' class='btn btn-danger btn-lg btn-block' style='margin-bottom:3px;background-color:#4C4A4A;border:#4C4A4A'>Locucion " + j + "</button></a>";
					        }else if (j == 2) {
					            vc_secuencia += "<a href='javascript:fnc_listar_niveles(1,1134)' style='color:#fff;font-weight: bold;'><button id='tr_ref_" + data[0].id_nivel + j + "' type='button' class='btn btn-danger btn-lg btn-block' style='margin-bottom:3px;background-color:#4C4A4A;border:#4C4A4A'>Locucion " + j + "</button></a>";
					        }else {
					            vc_secuencia += "<a style='color:#fff;font-weight: bold;'><button id='tr_ref_" + data[0].id_nivel + j + "' type='button' class='btn btn-danger btn-lg btn-block' style='margin-bottom:3px;background-color:#4C4A4A;border:#4C4A4A'>Locucion " + j + "</button></a>";
					        }
                        }
					} //*/

					//alert(data[0].vc_alerta);
					$('#div_secuencia').empty().html(vc_secuencia);
					var valores = "";
					// Obtenemos todos los valores contenidos en los <td> de la fila
					// seleccionada

					$('#lblTitulo_plazo').text(data[0].vc_titulo);
					//var url = data[0].vc_url_img.substr(12, data[0].vc_url_img.length);
					var url = data[0].vc_url_img;
					//alert(url);
					$("#img_plazo").attr("src", "Archivos_Carga/" + url + "");
					$("#img_plazo").attr("align", "center");
					$("#img_plazo").attr("width", "1080px");

					$('#lblid_nivel').text(data[0].id_nivel);
                    $('#lblDescripcion_plazo').text(data[0].vc_descripcion);
					/*$('#lblAlerta_plazo').text(data[0].vc_alerta);
					$('#lblAlerta_plazo').css('color', '');
					if (data[0].vc_alerta != '') {
					    $('#div_alerta').css('background-color', '' + data[0].vc_color_alerta + '');
					} else {
					    $('#div_alerta').css('background-color', 'transparent');
					}
					//alert(data[0].id_nivel);
					if (data[0].vc_color_alerta == 'green' || data[0].vc_color_alerta == 'red')
					{ $('#lblAlerta_plazo').css('color', 'white'); } else {
					    $('#lblAlerta_plazo').css('color', 'black');
					}*/
					//$('#lblSecuencia').text($('#lblSecuencia').text() + ' > ' + $('#lblTitulo_plazo').text());
                    debugger;
					fnc_listar_niveles(2, data[0].id_nivel);

				}
				else if (in_listar == 2) {
				    /*var numImagenes=0;
				    for (var i = 0; i <= data.length - 1; i++){
				        var in_rpta = data[i].in_rpta;
				        if(in_rpta == 2){
				            numImagenes++;
				        }
				    }*/
				    //strRows += "<tr style='text-align:center'><td colspan='11' style='width:700px;text-align:left;'><div style='height: 150px; overflow-y: scroll;'>";
				    var strImagen = "";
				    var strContenido = "";
				    var strBotones = "";
				    var strOtros = "";
				    for (var i = 0; i <= data.length - 1; i++) {
				        //debugger;
				        //var url = data[i].vc_url_img.substr(12, data[i].vc_url_img.length);
				        var url = data[i].vc_url_img;
				        var in_rpta = data[i].in_rpta;
				        var in_link = data[i].in_link;
				        var img = '';
				        
				        //alert(data[i].in_link);
				        //debugger;
				        
				        if (in_rpta == 2) {
				            //<button type="button" class="btn btn-primary btn-lg btn-block">Block level button</button>
				            //if (numImagenes == 1) {
				            if (data[i].vc_titulo == '(Ver imagen)') {
				                
				                strImagen =
                                    "<div class='col-lg-7' style='margin-left:150px'>" +
                                        "<p style='cursor:pointer;color:#337ab7;font-weight:bold;font-size:18px;margin-top:-20px;margin-right:400px' onclick = 'muestraImagen(/div_" + data[i].id_nivel + "/)'>" + data[i].vc_titulo + "</p>" +
                                        "<div id='div_" + data[i].id_nivel + "' class='thumbnail' >" +
                                            "<script>$('#div_" + data[i].id_nivel + "').hide()</script>" +
                                            "<img src='Archivos_Carga/" + url + "' width='500px' height='300px'style=''/>" +
                                        "</div>" +
                                    "</div>" +
				                    "</br>";
				                
				            /*} else if (data[i].vc_titulo.substring(0, 4) == 'PASO') {

				                contenidoul += "<li id='div_" + data[i].id_nivel + "li' class='pasitos' style='display: inline-block;font-weight:bold;padding:10px 40px;font-size:12px;margin-right:3px;border-radius:5px;' onclick = 'muestraPaso(/div_" + data[i].id_nivel + "/)'>" + data[i].vc_titulo + "</li>"
				                imagenespasos += "<div class='col-lg-8 thumbnail' style='margin-left:40px;margin-top:-" + existencipasos * 20 + "px;' id='div_" + data[i].id_nivel + "'>" +
                                    //"<p style='cursor:pointer;color:#337ab7;font-weight:bold;font-size:24px;margin-top:-20px;margin-right:400px' onclick = 'muestraImagen(/div_" + data[i].id_nivel + "/)'>" + data[i].vc_titulo + "</p>" +
                                    //"<div class='thumbnail' >" + //style='visibility:hidden;width:0px;height:0px'
                                        //"<div class='thumbnail' style=''>"+
                                        "<img src='Archivos_Carga/" + url + "' width='800px' height='480px'style=''/>" +
                                        //"</div>"+padding:20px 60px;border-radius:10px;font-size:18px;font-weight:bold'><span style='color:black;font-weight:bold;'>" + data[i].vc_titulo + "</span>
                                    //"</div>" +
                                    "</div>" +
				                    "</br>";
				                existencipasos++;*/

				            }
				            else {
				                strImagen = "<div class='col-lg-12'>" +
                                    "<div class='thumbnail' id='div_" + data[i].id_nivel + "' style='border-radius:40px' >" +
                                        "<img src='Archivos_Carga/" + url + "' width='960px' height='620px'style='border-radius:40px'/>" +
                                    "</div>" +
                                    "</div>" +
                                    "</div>" +
				                    "</br>";
				            }

				            strRows += strImagen;
				            itemsOrdered["imagen"] += strImagen;

				            /*NO BORRAR!!!!!
                            } else {
				                $("#lblDescripcion_plazo").show();
				                strRows += "<div class='col-lg-10'>" +
                                    "<div class='thumbnail' id='div_" + data[i].id_nivel + "'>" +
                                        "<img src='Archivos_Carga/" + url + "' width='480px' height='310px'/>" +//  onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' />" +
                                        "<div class='caption'>" +
                                            //"<h5 style='text-align:center';>" + data[i].vc_titulo + "</h5>" +
                                            "<button type='button' class='btn btn-danger btn-lg btn-block' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");'>" + data[i].vc_titulo + "</button>" +
                                        "</div>" +
                                    "</div>" +
                                    "</div>" +
                                    "</div>";
				            }*/
				        } else if (in_rpta == 3) {				            
				            if (data[i].vc_titulo == "Si") {
				                strBotones = "<input type='radio' style='width:25px;height:25px;margin-left:40px' onclick='fnc_solucion(1);' name='1'/>" +
                                           "<label style='font-size:13px;vertical-align:middle;margin-top:-12px;padding-left:15px'> " + "hola" + "</label></br>";
				            } else {
				                strBotones = "<li class='si' onclick='fnc_solucion(1)' style='display: inline-block; margin-left:380px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>Finalizar</span></li>";
				            }								    //$("#lblDescripcion_plazo").hide();
				            strRows += strBotones;
				            itemsOrdered["botones"] += strBotones;
				        } else if (in_rpta == 4) {
				            strBotones = "<li class='si' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:280px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
				            strRows += strBotones;
				            itemsOrdered["botones"] += strBotones;
                        } else if (in_rpta == 5){
                            strBotones = "<li class='no' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:90px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
                            strRows += strBotones;
                            itemsOrdered["botones"] += strBotones;
						} else if (in_rpta == 6) {                             
						     contenidoul += "<li id='div_" + data[i].id_nivel + "li' class='pasitos' style='display: inline-block;font-weight:bold;padding:10px 40px;font-size:12px;margin-right:3px;border-radius:5px;' onclick = 'muestraPaso(/div_" + data[i].id_nivel + "/)'>" + data[i].vc_titulo + "</li>"
						     imagenespasos += "<div class='col-lg-8 thumbnail' style='margin-left:40px;margin-top:-" + existencipasos * 20 + "px;' id='div_" + data[i].id_nivel + "'><script>$('#div_" + data[i].id_nivel + "').hide()</script>" +
                                     "<img src='Archivos_Carga/" + url + "' width='800px' height='480px'style=''/>" +
                                 "</div>" +
                                 "</br>";						     
						     existencipasos++;


						} else if (in_rpta == 8) {						    
						    hasContent = true;
						    $("#hasContent").val("yes");
						    strContenido = "<div id='divContent' class='' style=''>" + data[i].vc_contenido + "</div>";
						    strRows += strContenido;
						    itemsOrdered["contenido"] += strContenido;
						} else {
						    //debugger;
						    if (data[i].vc_titulo == "SI") {
						        //alert(data[i].in_id_link);
						        //"<li class='desactivado' role='presentation' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-right:5px;margin-top:5px;padding:10px 20px;border-radius:6px;font-size:18px'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						        strBotones = "<li class='si' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:280px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						    } else if (data[i].vc_titulo == "NO") {
						        strBotones = "<li class='no' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:90px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						    } else if (data[i].vc_titulo == "Crear Caso") {
						        strBotones = "<li class='caso' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:200px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:18px;font-weight:bold'><span style='color:black;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						    } else if (data[i].vc_titulo == "Generar Reclamo") {
						        strBotones = "<li class='reclamo' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:90px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:18px;font-weight:bold'><span style='color:black;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						    } else if (data[i].vc_titulo == "Interiores") {
						        strBotones = "<li class='no' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:200px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						    } else if (data[i].vc_titulo == "Exteriores") {
						        strBotones = "<li class='si' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:90px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						    } else if (data[i].vc_titulo == "Si") {
						        strBotones = "<li class='ultimosi' style='display: inline-block; margin-left:280px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						    } else if (data[i].vc_titulo.substring(0, 8) == 'Locución') {
						        strBotones = "";
						    } else {
						        if (data[i].in_link == 0) {
						            strBotones = "<li class='si' onclick='fnc_listar_niveles(1," + data[i].id_nivel + ");' style='display: inline-block; margin-left:280px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						        } else {
						            strBotones = "<li class='si' onclick='fnc_listar_niveles(1," + data[i].in_jumpId + ");' style='display: inline-block; margin-left:280px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";						            
						            //strBotones = "<li class='si' onclick='saltoentreMatrices(" + data[i].in_link + ");' style='display: inline-block; margin-left:280px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						        }
						    }
						    strRows += strBotones;
						    itemsOrdered["botones"] += strBotones;
						}
					}//end for
				    //debugger;
				    
				    if (hasContent) itemsOrdered["contenido"] = "<div style='padding:0 20px;margin-top:-25px;'><div id='divEditor'>" + itemsOrdered["contenido"] + "</div></div>";

				    itemsOrdered["botones"] = "<div class='buttonsFixed'>" + itemsOrdered["botones"] + "</div>";


				    strHTML = "" + itemsOrdered["contenido"] + itemsOrdered["imagen"] + itemsOrdered["botones"] + "";

				    //$('#tb_plazo').empty().html(strRows);
				    $('#tb_plazo').empty().html(strHTML);
					if (existencipasos != 0) {
					    $('#tb_plazo').empty().html("<ul>" + contenidoul + "</ul>" + imagenespasos + strRows);
					    //$('#tb_plazo').empty().html("<ul>" + contenidoul + "</ul>" + imagenespasos + strHTML);
					}
					if ($("#hasContent").val() == "yes") {
					    CKEDITOR.replace('divEditor', { customConfig: 'configUser.js' });					    
					}
                        //borrar este for cndo cambies a todos los pasos
						/*for (var i = 0; i <= data.length - 1; i++) {
						    var in_rpta = data[i].in_rpta;
						    if (in_rpta == 2) {
						        if (data[i].vc_titulo == '(Ver imagen)' || data[i].vc_titulo.substring(0, 4) == 'PASO') {
						            $("#div_" + data[i].id_nivel + "").hide();
						        }
						    }
						}*/
				}
				//$("#" + vc_id_control + "").append(strRows + StrPager);
			}
			else {
				//alert('nodatos');
			    $('#tb_plazo').empty().html(strRows);
				//$('#' + vc_id_control + '').empty().html("<tr><td style='text-align:center;' colspan='10'>No hay Niveles registrados</td></tr>");
				//$("#" + vc_id_control + "").append();
			}
		}//Fin Success
	}); //Fin Ajax
    //}
	
}
var urlnivel = "Frm_MantNivel.aspx/";
var guardarpasosantessalto = "";
var horaInicioantessalto = "";
function saltoentreMatrices(milink) {
	//debugger;
	var pasos = "";
	for (var i = 0; i < 9999; i++) {
		if ($('#href_v_' + i + '').length) {

			pasos += ' => ' + $('#href_v_' + i + '').text();
		}
	}
	horaInicioantessalto = horaActual;
	guardarpasosantessalto = guardarpasosantessalto+"Proceso Anterior:" + tituloProceso+"=>"+subProceso + pasos + "|||";
	var miMatriz = parseInt(milink / 1000000);
	var miProceso = milink % 1000000;
	mititulo(miMatriz);
	var tituloMatriz = $("#nombreMatriz").text();
	fnc_listar_matrices(2, miMatriz, tituloMatriz);
	$("#nombreMatriz").html(""); //hidden aux
	$("#tb_matricez").empty(); //clean process
	$("#tb_plazo").html(""); // panel content
	
	$.ajax({
		//async: false,
		type: "POST",
		success: function (response) {
			muestrate("div_" + miProceso);
		}
	});
	
	//fnc_listar_niveles(1, 950);

}

function mititulo(miMatriz) {
	//debugger;
	var objData = {};
	objData["id_nivel"] = miMatriz;
	var DTA = {};
	DTA.objData = objData;
	$.ajax({
		async: false,
		type: "POST",
		url: urlnivel + "dameTitulo",
		data: JSON.stringify(DTA),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response) {
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			if (data.length > 0) {
				$("#nombreMatriz").html(data[0].vc_titulo);
			}
		}
	});
}

function jq_shadow(id)
{
	//alert(id);
	//PLL
	var vc_id_div = JQ_reemplazar(id);
	if ($('#' + vc_id_div + '').hasClass("shadow"))
	{
		$('#' + vc_id_div + '').removeClass("shadow");
	} else
	{
		$('#' + vc_id_div + '').addClass("shadow");
	}

	
}
var eltiempo;
function fnc_solucion(in_gestion)
{
	//debugger;
	$('#div_resultado').show();
	$('#div_resultado').modal();
	var n = new Date();
	//alert($('#hour').text() + ':' + $('#minute').text() + ':' + $('#second').text());
	$('#lblhora_result').text($('#hour').text() + ':' + $('#minute').text() + ':' + $('#second').text());
	var k = $('#hour').text() + ':' + $('#minute').text() + ':' + $('#second').text();
	eltiempo = k;
	var hora;
	var min;
	var sec;
	var horaactual;
	//debugger;
	if (sessionStorage.getItem("hora") != null)
	{
		//debugger;
		var objPreg = sessionStorage.getItem("hora");
		var objPreg = JSON.parse(objPreg);
		hora = objPreg.hora;
		min = objPreg.min;
		sec = objPreg.sec;
		horaactual = objPreg.horaactual;

	}

	//debugger;
	var d = new Date();
	var tiempo = new Date();
	tiempo = horaactual;


	//alert(d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds());
	var h = d.getHours();
	var m = d.getMinutes();
	var s = d.getSeconds();
    
	//restaFechas = function (f1, f2)
	//{
	//	debugger;
	//	var fFecha1 = Date.UTC(f1.getHours(), f1.getMinutes(), f1.getSeconds());
	//	var fFecha2 = Date.UTC(f2.getHours(), f2.getMinutes(), f2.getSeconds());
	//	var dif = fFecha2 - fFecha1;
	//	var dias = Math.floor(dif / (1000 * 60 * 60 * 24));
	//	return dias;
	//}

	//alert(restaFechas(tiempo.getTime(), tiempo));


	//alert((h - hora).toString() + ':' + (m - min).toString() + ':' + (s - sec).toString());
	//$('#lblhora_result').text((h - hora).toString() + ':' + (m - min).toString() + ':' + (s - sec).toString());

	$('#txtarea').focus();
	$('#txt_hora').text('');
	$('#txt_date').text('');
	$('#lblClieSolucion').text($('#lblCliente').text());

	/*if (in_gestion == 1)
	{
		$('#lblSolucion').text('NO REQUIERE VISITA TECNICA');
		$('#hiden_vc_resultado').text('Solucion');
		$('#lblSolucion').css('color', 'black');
		$('#txt_hora').prop('readonly', true);
		$('#txt_hora').css('background-color', '#B0B0B0');
		$('#txt_date').prop('readonly', true);
		$('#txt_date').css('background-color', '#B0B0B0');
		$('#txtarea').focus();
	} else
	{
	    $('#lblSolucion').text('REQUIERE VISITA TECNICA');
		$('#hiden_vc_resultado').text('No solucion');
		$('#lblSolucion').css('color', 'red');
		$('#txt_hora').prop('readonly', false);
		$('#txt_date').prop('readonly', false);
		$('#txt_hora').css('background-color', 'white');
		$('#txt_date').css('background-color', 'white');
		$('#txtarea').focus();
	}*/
	
}
$(document).ready(function ()
{
	$('#div_resultado').hide();
	$("#div_menu").hide();

	$(document).click(function (e)
	{
		if (e.button == 0)
		{
			$("#div_menu").css("display", "none");
		}
	});

	//si pulsamos escape, el menú desaparecerá

	$(document).keydown(function (e)
	{
		if (e.keyCode == 27)
		{
			$("#div_menu").css("display", "none");
		}
	});
});


function fnc_close(vc_control)
{
	//alert(vc_control);
	$('#' + vc_control + '').modal('hide');
}


function fnc_BuscarClie()
{
	//alert($('#txt_codigo').val());
	//debugger;



	if ($('#lblEstado').text() == 'Comenzar')
	{
		$('#lblEstado').text('Detener');
		$('#lblEstado').show();
		tiempo_corriendo = setInterval(function ()
		{
			// Segundos
		    tiempo.segundo++;
			if (tiempo.segundo >= 60)
			{
				tiempo.segundo = 0;
				tiempo.minuto++;
			}

			// Minutos
			if (tiempo.minuto >= 60)
			{
				tiempo.minuto = 0;
				tiempo.hora++;
			}

			$("#hour").text(tiempo.hora < 10 ? '0' + tiempo.hora : tiempo.hora);
			$("#minute").text(tiempo.minuto < 10 ? '0' + tiempo.minuto : tiempo.minuto);
			$("#second").text(tiempo.segundo < 10 ? '0' + tiempo.segundo : tiempo.segundo);
		}, 1000);
	}
	else
	{
		$('#lblEstado').text('Comenzar');
	
		clearInterval(tiempo_corriendo);
	}
		
	//var objResult = {};
	//objResult.hora = d.getHours();
	//objResult.min = d.getMinutes();
	//objResult.sec = d.getSeconds();
	//objResult.horaactual = d.getTime();

	//var objJson = JSON.stringify(objResult);
	//sessionStorage.setItem("hora", objJson);


	var objData = {};
	objData["indice"] = 1;
	objData["vc_value"] = $('#txt_codigo').val();



	//debugger;
	var DTA = {};
	DTA.objData = objData;
    /*
	$.ajax({
		async: false,
		type: "POST",
		url: urlFrm_MantNivel + "ConsultarClie",
		data: JSON.stringify(DTA),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response)
		{
			//debugger;
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

			if (data.length > 0)
			{
				$('#hiden_in_cliente').text(data[0].id_cliente);
				$('#lblCliente').text(data[0].vc_nombre + ' ' + data[0].vc_apellidos);
				$('#lblCod').text(data[0].vc_codigo);
				$('#div_Cliente').show();
			    //				$('#div_plazo').show();
				$('#txt_codigo').val('');
			} else
			{
			    new Messi("Cliente nuevo", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
			    //debugger;
			    $('#hiden_in_cliente').text(0);
			    $('#lblCliente').text('Nuevo');
			    $('#lblCod').text($('#txt_codigo').val());
			    $('#div_Cliente').show();
			    $('#txt_codigo').val('');
			    
			}

		}
	}); //*/
}

function fnc_stop2()
{
	if ($('#lblEstado').text() == 'Comenzar')
	{
		$('#lblEstado').text('Detener');
		tiempo_corriendo = setInterval(function ()
		{
			// Segundos
			tiempo.segundo++;
			if (tiempo.segundo >= 60)
			{
				tiempo.segundo = 0;
				tiempo.minuto++;
			}

			// Minutos
			if (tiempo.minuto >= 60)
			{
				tiempo.minuto = 0;
				tiempo.hora++;
			}

			$("#hour").text(tiempo.hora < 10 ? '0' + tiempo.hora : tiempo.hora);
			$("#minute").text(tiempo.minuto < 10 ? '0' + tiempo.minuto : tiempo.minuto);
			$("#second").text(tiempo.segundo < 10 ? '0' + tiempo.segundo : tiempo.segundo);
		}, 1000);
	}
	else
	{
		$('#lblEstado').text('Comenzar');
		clearInterval(tiempo_corriendo);
		location.reload();
	}
}
$(document).ready(function(){

	$('#lblEstado').hide();
	$('#div_Cliente').hide();
	$('#timer').hide();
	$('#div_cod_incidencia').hide();
});

var tiempo = {
	hora: 0,
	minuto: 0,
	segundo: 0
};

var tiempo_corriendo = null;

$(document).ready(function ()
{

		var tiempo = {
			hora: 0,
			minuto: 0,
			segundo: 0
		};

		var tiempo_corriendo = null;

		//$("#btn-comenzar").click(function ()
		//{
		//	if ($('#lblEstado').text() == 'Comenzar')
		//	{
		//		$('#lblEstado').text('Detener');
		//		tiempo_corriendo = setInterval(function ()
		//		{
		//			// Segundos
		//			tiempo.segundo++;
		//			if (tiempo.segundo >= 60)
		//			{
		//				tiempo.segundo = 0;
		//				tiempo.minuto++;
		//			}

		//			// Minutos
		//			if (tiempo.minuto >= 60)
		//			{
		//				tiempo.minuto = 0;
		//				tiempo.hora++;
		//			}

		//			$("#hour").text(tiempo.hora < 10 ? '0' + tiempo.hora : tiempo.hora);
		//			$("#minute").text(tiempo.minuto < 10 ? '0' + tiempo.minuto : tiempo.minuto);
		//			$("#second").text(tiempo.segundo < 10 ? '0' + tiempo.segundo : tiempo.segundo);
		//		}, 1000);
		//	}
		//	else
		//	{
		//		$('#lblEstado').text('Comenzar');
		//		clearInterval(tiempo_corriendo);
		//	}
		//});
	
});





function fnc_guardarSolucion()
{
    var dametodo = new Date();
	//debugger;
	$('#div_resultado').modal('hide');
	//	$('#div_cod_incidencia').modal();
	var vc_tipi = '';
	for (var i = 0; i < 9999; i++)
	{	
		if ($('#href_v_' + i + '').length)
		{
			
			vc_tipi += ' => ' + $('#href_v_' + i + '').text();
		}
	}
	var mihora = $('#hour').text() + ':' + $('#minute').text() + ':' + $('#second').text();
	var objData = {};
	objData["indice"] = 2;
	objData["Proceso"] = tituloProceso;
	objData["vc_tipificacion"] = guardarpasosantessalto + "=>"+subProceso+vc_tipi;
	//objData["vc_duracion"] = ($('#hour').text() + ':' + $('#minute').text() + ':' + $('#second').text());
	if (horaInicioantessalto != ""){
		objData["horaInicio"] = horaInicioantessalto;
	} else objData["horaInicio"] = horaActual;
	objData["vc_duracion"] = mihora;
	//objData["registro"] = dametodo;
	
	//debugger;
	var DTA = {};
	DTA.objData = objData;

	$.ajax({
		async: false,
		type: "POST",
		url: urlFrm_MantNivel + "Gestion",
		data: JSON.stringify(DTA),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response)
		{
		    //debugger;
            
		    var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

			if (data.length > 0)
			{
				/*new Messi('Codigo generado: ' +data[0].in_result.toString(), {
					title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'ok', class: 'btn-success', val: true }], callback: function (val) {
						if (val == true)
						{
							location.reload();
						} //endif (val == true)
					} // Fin title
				});    // Fin Messi*/
			    location.reload();
				
			} /*else
			{
				alert('Registro incorrecto');
				

			}*/

		}
	});


}
var cadenaAnterior = "";

function muestrate(imagen) {
    //debugger;
    $('#div_secuencia').empty().html("");
    for (var i = 0; i < 999; i++) {
            $('#href_v_' + i + '').remove();
            $('#tr_ref_' + i + '').remove();
    }
    //debugger;
        $('#tb_imagenes').show();
        $('#div_plazo').hide();
        
        var cadena = JQ_reemplazar(imagen);

        $('#' + cadena + '').css("visibility", "visible");
        //$('#' + cadenaAnterior + '').show();
        $('#' + cadena + '').css("width", "97%");
        $('#' + cadena + '').css("height", "500px");
        //$('#' + cadena + '').css("padding", "20px 40px");
        $('#' + cadena + 'li').removeClass("desactivado");
        $('#' + cadena + 'li').addClass("activado");
        
        if (cadena != cadenaAnterior) {
            //$('#' + cadenaAnterior + '').hide(); !!!!!!!!!!
            $('#' + cadenaAnterior + '').css("visibility", "hidden");
            $('#' + cadenaAnterior + '').css("width", "0px");
            $('#' + cadenaAnterior + '').css("height", "0px");
            $('#' + cadenaAnterior + '').css("padding", "0px");
            $('#' + cadenaAnterior + 'li').removeClass("activado");
            $('#' + cadenaAnterior + 'li').addClass("desactivado");
        }
        cadenaAnterior = cadena;
        //background-color:rgba(175, 8, 8,0.6)
}
var mipaso = 0;
var pasoAnterior = '';
function muestraPaso(imagen) {//FALTA!!!!!!!!
    //debugger;
    var cadena = JQ_reemplazar(imagen);
    /*if (mipaso == 0) {
        $('#' + cadena + '').show();
        mipaso++;
    } else if(mipaso==1) {
        $('#' + cadena + '').hide();
        mipaso = 0;
    }*/
    if (cadena != pasoAnterior) {
        $('#' + pasoAnterior + '').hide();
        $('#' + pasoAnterior + 'li').css("background-color", "#959595");
        $('#' + pasoAnterior + 'li').css("color", "black");
        mipaso = 0;
    }
    if (mipaso == 0) {
        $('#' + cadena + '').show();
        $('#' + cadena + 'li').css("background-color", "#AF0808");
        $('#' + cadena + 'li').css("color", "#fff");
        mipaso = 1;
    } else {
        $('#' + cadena + '').hide();
        $('#' + cadena + 'li').css("background-color", "#959595");
        $('#' + cadena + 'li').css("color", "black");
        mipaso = 0;
    }
    
    pasoAnterior = cadena;
}

var miimagen = 0;
function muestraImagen(imagen) {
    //debugger;
    var cadena = JQ_reemplazar(imagen);
    if (miimagen == 0) {
        $('#' + cadena + '').show();
        miimagen++;
    } else{
        $('#' + cadena + '').hide();
        miimagen = 0;
    }
}

var caraPrincipal = 0;
$(document).ready(function ()
{
    fnc_listar_matrices(2, 0,'');
    caraPrincipal = 0;
});

function CrearHora(valor) {
    //debugger;
    inicioOperacion = new Date();
    var dia = inicioOperacion.getDate() + '';
    var mes = inicioOperacion.getMonth() + '';
    var anio = inicioOperacion.getFullYear() + '';
    var h = inicioOperacion.getHours() + '';
    var m = inicioOperacion.getMinutes() + '';
    var s = inicioOperacion.getSeconds() + '';
    //console.log(typeof (k));
    if (dia.length == 1) {
        dia = "0" + dia;
    }
    if (mes.length == 1) {
        mes = "0" + mes;
    }
    if (h.length == 1) {
        h= "0"+h;
    }
    if (m.length == 1) {
        m = "0" + m;
    }
    if (s.length == 1) {
       s = "0" + s;
    }
    if(valor==1){
        return h + ":" + m + ":" + s;
    } else {
        return anio + "-" + mes + "-" + dia + " " + h + ":" + m + ":" + s;
    }
}
var subProceso = "";
function dameSub(sub) {
	subProceso = "";
	subProceso = sub;
}

function removerValores(id) {
	var imagen = $(id);
	imagen.removeAttr("Width");
	imagen.removeAttr("height");
	return imagen;
}

var inicioOperacion;
var horaActual;
var tituloProceso;
function fnc_listar_matrices(in_listar, in_dpndncia_idnivel, titulo) {    
    horaActual = CrearHora(1);
    tituloProceso = titulo;
	var objData = {};
	objData["indice"] = in_listar;
	objData["in_dpndncia_idnivel"] = in_dpndncia_idnivel;
	var DTA = {};
	DTA.objData = objData;
	$.ajax({		
		type: "POST",
		url: urlFrm_MantNivel + "ArmarPreview",
		data: JSON.stringify(DTA),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response) {
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			var pageCount = 0;
			var StrPager = '';
			var strRows = '';
			var strRowsc = '';
			var strRowsi = '';			
			if (data.length > 0) {
			    
			    if (in_listar == 2) {			        
				    var activacion = 1;
					for (var i = 0; i <= data.length - 1; i++) {						
					    //var url = data[i].vc_url_img.substr(12, data[i].vc_url_img.length);
					    var url = data[i].vc_url_img;
						var in_rpta = data[i].in_rpta;
						var in_link = data[i].in_link;
						var img = '';

						//debugger; 
						if (in_rpta == 2) {//border-radius:30px;border:2px solid #A7A7A7;;background-color:rgba(232, 232, 232,0.5) width='960px' height='400px'						
						    if (caraPrincipal == 0) {
						        $('#campañas').css("height", "600px");
						        strRowsc += "<div class='col-lg-6'>" +
                                                "<div class='thumbnail'>" +
                                                    "<img src='Archivos_Carga/" + url + "'  style='border-radius:20px' id='img"+url+"'/>" +											
                                                    "<div class='caption'>" +
                                                        "<button type='button' class='btn btn-danger btn-lg btn-block' onclick='fnc_listar_matrices(2," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + "," +'"'+ data[i].vc_titulo +'"'+ ");'>" + data[i].vc_titulo + "</button>" +
						                            "</div>" +
                                                "</div>" +
                                            "</div>";
						    	//var miimagen = removerValores('#img' + url);						        
						        //strRowsc += "<button onclick='fnc_listar_matrices(2," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");'>" + data[i].vc_titulo + "</button>"
						        $('#todo').hide();
						    }
						    else {
						        //$('#campañas').css("height", "0px");
						            $('#campañas').hide();
						            $("#btn_inicio").show();
						            $('#todo').show();						      
						        if (activacion == 1) {
						            strRows += "<li id='div_" + data[i].id_nivel + "li' class='desactivado' role='presentation' onclick='muestrate(/div_" + data[i].id_nivel + "/)' style='display: inline-block; margin-right:5px;margin-top:5px;padding:10px 20px;border-radius:6px;font-size:18px'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						            activacion = 0;
						        } else {
						            strRows += "<li id='div_" + data[i].id_nivel + "li' class='desactivado' role='presentation' onclick='muestrate(/div_" + data[i].id_nivel + "/)' style='display: inline-block; margin-right:5px;margin-top:5px;padding:10px 20px;border-radius:6px;font-size:18px'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
						        }

						        strRowsi += "<div id='div_" + data[i].id_nivel + "' style='visibility:hidden;padding:0px;width:0px;height:0px'>" +
                                        "<img src='Archivos_Carga/" + url + "' width='960px' height='400px' style='border-radius:20px'/>" +
                                            "<div width='20px' style='margin:30px 60px';>"+
                                                "<button type='button' class='btn btn-danger btn-lg' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");dameSub("+'"'+data[i].vc_titulo+'"'+");'>INFORMACION</button>" +
                                            "</div>"+
                                        "</div>";
						    }
						    
						}
						else { //### begin mark obsolete }}
						    
							if (in_rpta == 3) {
							    strRowsi += "<div style='width: 40%;'><input type='radio' style='width:20px;height:20px' onclick='fnc_solucion(1);' name='1'/> " + data[i].vc_titulo + "</div>"
							} else if (in_rpta == 4) {
							    strRowsi += "<div style='width: 40%;'><input type='radio' style='width:20px;height:20px' onclick='fnc_solucion(2);' name='1'/> " + data[i].vc_titulo + "</div>"
								//strRows += "<div style='width: 20%;'><input type='radio' id='" + data[i].id_nivel + "' onclick='fnc_click(" + data[i].id_nivel + ");' name='1'/> " + data[i].vc_titulo + "</div>"
							} else {
								//alert(data[i].in_id_link);
							    strRowsi += "<div style='width: 40%;'><input type='radio' style='width:20px;height:20px' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");'  name='1'/> " + data[i].vc_titulo + "</div>"
								// value='" + data[i].id_nivel + "'
							}
						} //### end mark obsolete }}
					}//end for

					//alert(strRows);
				     //debugger;
					if (strRowsc != "") $('#campañas').empty().html(strRowsc);					
					$('#tb_matricez').empty().html(strRows);
					$('#tb_imagenes').empty().html(strRowsi);
				}

				//$("#" + vc_id_control + "").append(strRows + StrPager);
			} else {
				alert('nodatos');
				//$('#' + vc_id_control + '').empty().html("<tr><td style='text-align:center;' colspan='10'>No hay Niveles registrados</td></tr>");
				//$("#" + vc_id_control + "").append();
			}
		}//Fin Success
	}); //Fin Ajax
	caraPrincipal=1;
}
/*END ARMAR VISTA PREVIA*/


function getContentOfNivel(idNivel) {
    ajax("Frm_MantNivel.aspx/" + "getContentOfNivel", { opc: 6, idNivel: idNivel }, getContentOfNivelHandler);
}

function getContentOfNivelHandler(data) {
    var json = eval('(' + data.d + ')');
    var rawStr = ""
    $.each(json, function (k, v) {
        //alert(v.vc_contenido);
        rawStr += v.vc_contenido;
    });
    //alert(json.vc_contenido);
    $("#div_contenido").html(rawStr).show();
}
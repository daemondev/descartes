//http://artofcoding.in/replace-html-audio-tags-jplayer/

CKEDITOR.on('instanceReady', function (ev) {    
    var editor = ev.editor;
    var resetEditor = new CKEDITOR.command(editor, {
        exec: function (editor) {                        
            $("#hd_idcontenido").val(0);
            setEditorText("");
        }
    });    
    ev.editor.commands.newpage.exec = resetEditor.exec;    
});


CKEDITOR.on('fileUploadResponse', function (ev) {
    //var editor = ev.editor;
    //editor.geImageData
});
/*
CKEDITOR.stylesSet.add('mystyles', [
    // Block-level styles
    { name: 'Heading 1', element: 'h1' },
    { name: 'Heading 2', element: 'h2' },
    { name: 'Heading 3', element: 'h3' },
    { name: 'Introduction', element: 'p', attributes: { 'class': 'introduction' } },

    // Inline styles
    { name: 'Link button', element: 'a', attributes: { 'class': 'button' } },
    { name: 'Highlight', element: 'span', attributes: { 'class': 'highlight' } },

    // Object styles
    { name: 'Stretch', element: 'img', attributes: { 'class': 'stretch' } },
]); //*/
/*
CKEDITOR.on('dialogDefinition', function (ev) {
    // Dialog name to find the one we want
    // Definition so we can customize it
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;

    if (dialogName == 'table' || dialogName == 'tableProperties') {

        // we want our own style 
        var advTab = dialogDefinition.getContents('advanced');

        //add our specific width
        var stylesField = advTab.get('advStyles');
        stylesField['default'] = 'width: 300px';

        var styleClassesField = advTab.get('advCSSClasses');
        styleClassesField['default'] = 'get crazy do whatever';

        //more than a suggestion... hide the field so user can't modify
        styleClassesField['hidden'] = true;   //disable might exist .. see but not touch


    }
}); //*/
/*
CKEDITOR.on('dialogDefinition', function (ev) {
    // Take the dialog window name and its definition from the event data.
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;
    
    if (dialogName == 'image') {
        dialogDefinition.onShow = function () {
            // This code will open the Advanced tab.
            this.selectPage('Upload');
        };
    }
}); //*/


//https://sdk.ckeditor.com/samples/savetextarea.html
//http://bitcookie.com/blog/drupal-ckeditor-setup-development-tutorial
//!!CKEDITOR.plugins.get('wysiwygarea');
var editor = CKEDITOR.replace('Textarea_contenido');
//CKEDITOR.addCss('html { font-size: 14px; box-shadow: 0 5px 5px 1px rgba(0, 0, 0, 0.5); }');
//var editor = CKEDITOR.document.getById('Textarea_contenido');
//var editor = CKEDITOR.inline('Textarea_contenido');
/*
CKEDITOR.plugins.registered['save'] = {
    init: function (editor) {
        var command = editor.addCommand('save',
            {
                modes: { wysiwyg: 1, source: 1 },
                exec: function (editor) { // Add here custom function for the save button
                    alert('You clicked the save button in CKEditor toolbar!');
                }
            });
        editor.ui.addButton('Save', { label: 'My Save', command: 'save' });
    }
}//*/

//assuming editor is a CKEDITOR.editor instance
editor.on('save', function (event) {
    if (getPlainText("Textarea_contenido")) {
        Guarda_contenido(1, 0);
    } else {
        new Messi("Ingrese el contenido a Mostrar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
    }    
    event.cancel();
    //your custom command logic
    //(you can access the editor instance through event.editor)
});
/*
CKEDITOR.on('instanceReady', function (env) {
    //get ctrl+clicks on <a>'s in edit mode to open the value of "href" open in new tab.
    $('iframe').contents().click(function (e) {
        //if(typeof e.target.href != 'undefined' ) {
        if (typeof e.target.href != 'undefined' && e.ctrlKey == true) {
            window.open(e.target.href, 'new' + e.screenX);
        }
    });
});//*/

/*### copy to clipboard

//<p id="selectedItem">Text to copy</p>
//<button onClick="copyT('selectedItem')">Copy</button>

function copyT(objId) {
    //Step 1: select the text from DOM element
    var txt = document.getElementById(objId).textContent;

    //Step 2: Create input and set value
    var elem = document.createElement('input');
    elem.value = txt;

    //position is set such that the element is not visible
    elem.style = 'postion:relative;top:-100px;';

    //append the input element to body
    document.body.appendChild(elem);

    //set focus to inserted input element
    elem.focus();

    //Step 4: Select the text in input element
    elem.setSelectionRange(0, txt.length);
    //Step 4: Execute document.execCommand('copy')
    if (document.execCommand('copy')) {
        alert('Copied successfully');
    } else {
        alert('Clipboard access not supported in this browser');
    }
}
//*/

/*
function loadJsFiles()
{
    //create an array of javascript file paths
    var jsFiles = [
        '//path/to/script-1.js',
        '//path/to/script-2.js',
    ];

    //loop through the array to create script element and set the "src" attribute to the script path.
    for (x in jsFiles){
        var element = document.createElement("script");
        element.src = jsFiles[x];
        document.body.appendChild(element);
    }
}
//window.addEventListener("load", loadJsFiles, false);
//*/

/*### render image before send

<img id="uploadedImg" alt="Image Preview"/>
<input type="file" id="imgInput">

$('#imgInput').change(function(){
    var file = document.querySelector('input[type=file]').files[0];
    var reader = new FileReader();
    reader.onloadend = function ()
    {
        $('#uploadedImg').attr('src', reader.result); }
        if (file){
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
        }
});
//*/

/*### Dynamically make DOM element height equal
$(window).load(function(){
var maxHeight = Math.max.apply(null,
    jQuery(".variable-height").map(function(){
        return $(this).height();
    }).get());
$(".variable-height").height(maxHeight);
});
//*/


editor.addCommand("debugCommand", {
    exec: function (edt) {
        alert(edt.getData());
    }
});
editor.ui.addButton('SuperButton', {
    label: "Show in HTML Mode",
    command: 'debugCommand',
    toolbar: 'insert',
    icon: '/assets/img/5500999.png?v=2&s=16'
});

/*
editor.on('afterCommandExec', handleAfterCommandExec);
function handleAfterCommandExec(event) {
    var commandName = event.data.name;
    alert(commandName);
} //*/
//config.removePlugins = 'newpage';
editor.on('newpage', function (event) {    
    //event.cancel();    
});

/*
editor.getCommand('save').exec = function (editor) {
    // Do whatever you need to
    alert("saving");
    return true;
};//*/

/*
editor.on('change', function (evt) {
    // getData() returns CKEditor's HTML content.
    console.log('Total bytes: ' + evt.editor.getData().length);
}); //*/

/*
var editorElement = CKEDITOR.document.getById('Textarea_contenido');
editorElement.setAttribute('contenteditable', 'true');
CKEDITOR.inline('Textarea_contenido');
//*/
var urlFrm_MantNivel = "Frm_MantNivel.aspx/";
var contentData = null;
var contentDataRaw = null;
function getPlainText(instance) {
    var strSrc = CKEDITOR.instances[instance].getData();
    contentDataRaw = strSrc;
    var resultStr = "";
    
    if (strSrc.indexOf('<p>') == 0) resultStr = strSrc.substring(3);
    else resultStr = strSrc;
    
    resultStr = resultStr.replace(/<p>/gi, "\r\n\r\n");
    
    resultStr = resultStr.replace(/<br \/>/gi, "\r\n");
    resultStr = resultStr.replace(/<br>/gi, "\r\n");   
    contentData = resultStr.replace(/<[^<|>]+?>/gi, '');
    return (contentData.length > 0)? contentData : null; 
}
//var editor = CKEDITOR.instances["Textarea_contenido"];

function cleanEditor(instance) {
    //CKEDITOR.instances[instance].setData("");
    editor.setData("");
    //CKEDITOR.replace($(this).attr('id'));
    //CKEDITOR.instances["Textarea_contenido"].destroy();

    /*
    for (name in CKEDITOR.instances) {
        //alert("deleting");
        CKEDITOR.instances[name].destroy();
        //$(this).hide();
        /*
        $('.editor').each(function () {
            CKEDITOR.replace($(this).attr('id'));
        }); //*/
    //} //*/

    //editor.setData("");
}

function setEditorText(content) {
    //alert("inner function: [" + content + "]");
    /*
    CKEDITOR.on("instanceReady", function (event) {
        CKEDITOR.instances.Textarea_contenido.setData(myContent);
    });//*/
    
    editor.setData(content);


    /*
    $("#Textarea_contenido").html(content);
    CKEDITOR.replace('Textarea_contenido'); //*/
}

function getTextPlain(instance) {
    var objEditor = CKEDITOR.instances[instance];
    var msg = objEditor.getData();
    var txt = $(msg).text().replaceAll("\n\n", "\n");    
    return txt;
}


function editorHasImnage(instance) {
    var objEditor = CKEDITOR.instances[instance];
    var strSrc = objEditor.getData();
    var hasImage = false;
    if (strSrc.indexOf('<img') == 0) hasImage = true;    
    return hasImage;
}

function toogleEditor() {
    var bar = document.getElementById("cke_1_top");
    if (bar.style.display == "none") bar.style.display = "block";
    else bar.style.display = "none";    
}

$(document).ready(function () {
    $('#div_Contenidox').on('hide.bs.modal', function (e) {
        if (typeof (CKEDITOR) != "undefined") {
            for (name in CKEDITOR.instances) {
                //alert("deleting");
                //CKEDITOR.instances[name].destroy()
                //$(this).hide();
                $('.editor').each(function () {
                    CKEDITOR.replace($(this).attr('id'));
                });
            }
        }
    });

	GetNiveles(0, 1, 'tb_0', 'lst');
	//$('#lbl_id_nivel').hide();
    $("#btnDebug").click(function () {        
        var editorData = CKEDITOR.instances.Textarea_contenido.getData();
        //var text = CKEDITOR.instances.Textarea_contenido.document.getBody().getText();

        var plain_text = getPlainText("Textarea_contenido");
        //alert(editorData); 
        //alert(plain_text + " modified"); 
        //alert(getTextPlain("Textarea_contenido"));         
    });
	$('#lbl_id_categoria').hide();
	$('#lbl_id_nivel').text(0);
	$('#lbl_id_categoria').text(0);
	$('#plazo').hide(); //### Modal Add Process/Category
	$('#divAddItems').hide();
	$('#lbl_id_nivel').hide();

	$('#lblid_nivel').hide();

	$("#ddl_rpta").change(function () {
		if ($("#ddl_rpta option:selected").val() == 7) {
			traerMatrices();
			$("#mismatrices").prop("disabled", false);
		} else {
			$("#mismatrices").prop("disabled", true);
			$("#mismatrices").html("<option value='0'>---seleccionar---</option>");
			$("#misprocesos").prop("disabled", true);
			$("#misprocesos").html("<option value='0'>---seleccionar---</option>");
		};
	});

	$("#mismatrices").change(function () {
		$("#misprocesos").prop("disabled", false);
		$("#misprocesos").html("<option value='0'>---seleccionar---</option>");
		traerProcesos(parseInt($("#mismatrices option:selected").val()));

	})

    /*### save content (x006)

    */
	$("#btn_grabar_Contenido").click(function () {
	    if (getPlainText("Textarea_contenido") || editorHasImnage("Textarea_contenido")) {
	        Guarda_contenido(1, 0);
	    } else {
	        new Messi("Ingrese el contenido a Mostrar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
	    }
	    return;

		if ($("#Textarea_contenido").val() == "") {
			new Messi("Ingrese el contenido a Mostrar", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
		} else if ($("#ddl_color").val() == 0) {
			new Messi("Seleccione el color del contenido", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
		} else if ($("#ddl_subrayodo").val() == 0) {
			new Messi("Seleccione Si el contenido será subrayado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
		} else {
			Guarda_contenido(1,0);
		}
	})
});

$(document).tooltip();

//**** REGISTRO DE LOS CONTENIDOS EN TABLA DE UN PROCESO
/*###
    Open Modal of Content (x004)
*/
function JQ_Open_Contexto(in_idnivel) {
    $('#div_Contenido').modal();
    
	$('#hdIddescarte').val(in_idnivel);
	//$("#Textarea_contenido").val("");
	cleanEditor();
	//$("#ddl_color").val("0");
	//$("#ddl_subrayodo").val("0");
	GetGrid_Contenido(1, in_idnivel);
	$("#hd_idcontenido").val("0");	
}


/*###
    Save content (x003)
*/
function Guarda_contenido(op,idcontenido) {
	var objData = {};
	objData["in_idcontenido"] = $("#hd_idcontenido").val();
	objData["in_idnivel"] = $('#hdIddescarte').val();
	objData["vc_contexto"] = $("#Textarea_contenido").val();	
	objData["vc_color"] = $("#ddl_color").val();
	objData["vc_subrayado"] = $("#ddl_subrayodo").val();
	objData["op"] = op;

    /*modified*/    
	objData["vc_contexto"] = contentDataRaw;
	objData["vc_color"] = "3";
	objData["vc_subrayado"] = 1;


	$.ajax({
		type: "POST",
		url: urlFrm_MantNivel + "Guardar_Contenidos",
		data: JSON.stringify(objData),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (data) {			 
			var obj = data.d;
			if (obj >= 1) {
				new Messi("Registro Correctamente realizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
				$("#Textarea_contenido").val("");
				$("#ddl_color").val("0");
				$("#ddl_subrayodo").val("0");
			    //$("#dvUsuario").modal('hide');
				$("#hd_idcontenido").val(obj);
				GetGrid_Contenido(1, $('#hdIddescarte').val());
			} else {
				new Messi("Error de Registro - No pueden haber dos usuarios iguales", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
			}//Fin condicion
		}//Fin data
	}); //Fin DEL .aja
}

function populateContentData(content) {    
    setEditorText(content);
    //$("#div_contenido").html();
}

function GetGrid_Contenido(pgnum,in_idnivel)
{
	var objData = {};
	objData["op"] = 2;
	objData["in_idnivel"] = in_idnivel;
	objData["tamPagina"] = 10;
	objData["nroPagina"] = pgnum;
    /*
	$('.editor').each(function () {
	    CKEDITOR.replace($(this).attr('id'));
	});//*/
	$.ajax({
		async: false,
		type: "POST",
		url: urlFrm_MantNivel + "Lista_Contenidos",
		data: JSON.stringify(objData),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response) {
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			var pageCount = 0;
			var StrPager; var strRows;
			
			$('#tb_contenido tr:not(:first)').remove();
			if (data.length > 0) {
			    for (var i = 0; i <= data.length; i++) {
			        if (data.length == i) {
			            pageCount = data[0].total;
			            var StrPager = "";
			            if (pageCount > 1) {
			                for (var x = 1; x <= pageCount; x++) {
			                    if (x == 1) {
			                        StrPager = "<tr class='pgr'><td colspan='8' style='text-align:left;padding:6px;'>";
			                    }
			                    StrPager = StrPager + "<label style='line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #0A0A0A;font-weight: bold;" + (x == pgnum ? "color: #F4FAF4;" : "color: #080809;cursor:pointer;" + "'  onclick='GetGridUsuario(" + x + ");") + "'>" + x + "</label>";
			                    if (x == pageCount) {
			                        StrPager = StrPager + "</td></tr>";
			                    }
			                }
			            } else { StrPager = "<tr class='pgr'><td colspan='8' style='text-align:left;padding:10px;'></td></tr>"; }
			        } else {

			            if (i % 2 == 0) strRows = strRows + "<tr>";
			            else strRows = strRows + "<tr class='alt'>";

			            strRows +=
                                       "<td>" + data[i].vc_contexto + "</td>" +                                   
                                       "<td align=center>" +
                                            "<img src='Images/iconos/edit.png'  width='18px' title='Editar' onclick='Editar_Contenido(" + '"' + data[i].in_idcontenido + '"' + ");' style='cursor:pointer;' />&nbsp;|&nbsp;" +
                                            (data[i].in_estado == 1 ? "<img src='libreria/imagenes/Botones/Activo.png' title='Desactivar'" : "<img src='libreria/imagenes/Botones/Desactivo.png' title='Activar'") + " onclick='Estado_Contenido(" + '"' + data[i].in_idcontenido + '"' + ");' style='cursor:pointer;' /></td>" +
								       "</td>" +
                                   "</tr>"
			        }
			    }
			    $("#tb_contenido").append(strRows + StrPager);

			} else {
			    $("#tb_contenido").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>");
			}


            /*### work
			var myContent = "";
			$.each(data, function (k,v) {
			    myContent += v.vc_contexto;
			});
			setEditorText(myContent) //*/
			
		}//Fin Success
	}); //Fin Ajax
	//populateContentData(content);
}

function Editar_Contenido(in_idcontenido)
{
	var objData = {};
	objData["in_idcontenido"] = in_idcontenido;
	objData["op"] = 3;
	$.ajax({
		type: "POST",
		url: urlFrm_MantNivel + "Datos_Contenido",
		data: JSON.stringify(objData),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response) {
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			$("#hd_idcontenido").val(data[0].in_idcontenido);
		    /*
			$("#Textarea_contenido").val(data[0].vc_contexto);            
			$("#ddl_color").val(data[0].vc_color);
			$("#ddl_subrayodo").val(data[0].vc_subrayado); //*/
			
			setEditorText(data[0].vc_contexto);
		}//Fin success
	}); //Fin DEL .ajax
}

function Estado_Contenido(in_idcontenido)
{
	var objData = {};
	objData["in_idcontenido"] = in_idcontenido;
	$.ajax({
		type: "POST",
		url: urlFrm_MantNivel + "Estado_Contenidos",
		data: JSON.stringify(objData),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (data)
		{
			 ;
			var obj = data.d;
			if (obj >= 1)
			{
				new Messi("Registro Correctamente realizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
				GetGrid_Contenido(1, $('#hdIddescarte').val());
			} else
			{
				new Messi("Error de Registro - No pueden haber dos usuarios iguales", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
			}//Fin condicion
		}//Fin data
	}); //Fin DEL .aja
}

//****

function traerProcesos(matriz)
{
	var objData = {};
	objData["in_dpndncia_idnivel"] = matriz;
	var DTA = {};
	DTA.objData = objData;

	$.ajax({
		async: false,
		type: "POST",
		url: urlFrm_MantNivel + "traerProcesos",
		data: JSON.stringify(DTA),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response)
		{
			 ;
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			if (data.length > 0)
			{
				for (var i = 0; i < data.length; i++)
				{
					$("#misprocesos").append("<option value='" + data[i].id_nivel + "'>" + data[i].vc_titulo + "</option>");
				}
			}
		}
	});
}

function traerMatrices()
{
	$.ajax({
		async: false,
		type: "POST",
		url: urlFrm_MantNivel + "traerMatrices",
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response)
		{
			 ;
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			if (data.length > 0)
			{

				for (var i = 0; i < data.length; i++)
				{
					$("#mismatrices").append("<option value='" + data[i].id_nivel + "'>" + data[i].vc_titulo + "</option>");
				}
			}
		}
	});
}

/*
Get data from DB and render
*/
function GetNiveles(in_dpndncia_idnivel, p, vc_id_control, vc_lst) {

	vc_lst = JQ_reemplazar(vc_lst);
	vc_id_control = JQ_reemplazar(vc_id_control);

	//averiguar porque se puso >= 1
	if (($('#' + JQ_reemplazar(vc_id_control) + ' >tr').length >= 1) && (vc_lst == 'lst')) {
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
		success: function (response){
			
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			var pageCount = 0;
			var StrPager = '';
			var strRows = '';

			//$('#'+vc_id_control+' tr:not(:first)').remove();
			if (data.length > 0) {

			    for (var i = 0; i <= data.length; i++) {

                    //### step 001
					if ((data.length) == i){
						 
						var pageCount = data[0].total;
						var StrPager = "";

						if (pageCount >= 1) { //### begin pagination {{

							for (var x = 1; x <= pageCount; x++) {
								 
								if (x == 1) {
									StrPager = "<tr class='pgr'><td colspan='12' style='text-align:left;padding:6px;'>";
								}

								StrPager = StrPager + "<label style='cursor:pointer;line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #666;font-weight: bold;" + (x == pageCount ? "color: #63B46D;" : "color: #666666;") + "' onclick='GetNiveles(" + in_dpndncia_idnivel + ", " + x + ",/" + vc_id_control + "/,/pag/);'>" + x + "</label>";

								if (x == pageCount) {
									StrPager = StrPager + "</td></tr>";
								}
							}

						} else {
							StrPager = "<tr  class='pgr'><td colspan='12' style='text-align:left;padding:10px;'></td></tr>";
							 
							if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
						} //### end pagination }}

					} else {
					    strRows +=
                            "<tr id='" + data[i].id_nivel + "'>" +
                                "<td style='width:80px;' ><a id='href_" + data[i].id_nivel + "' href='javascript:GetNiveles(" + data[i].id_nivel + "," + 1 + ",/tb_" + data[i].id_nivel + "/,/" + "lst" + "/)'>" + (data[i].in_cate == 0 ? 'Principal' : (data[i].in_cate == 1 ? 'Categoria' : (data[i].in_cate == 2 ? 'Subcategoria' : 'Proceso'))) + "</a>" + "</td>" +
	                            "<td   style='text-align:center;width:100px; '>" + data[i].vc_titulo + "</td>" +
	                            "<td   style='text-align:center;width:100px; '>" + data[i].vc_descripcion + "</td>" +
		                            //"<td style='text-align:center;width:100px;'>" + data[i].vc_url_img + "</td>" +
                                "<td style='text-align:center;width:5%;'>" + getRptaIcon(data[i].in_rpta, data[i].id_nivel)  + "</td>" +
                                "<td style='text-align:center;width:100px;'>" + data[i].vc_alerta + "</td>" +
                                //"<td style='text-align:center;width: 5%;' >" + (data[i].in_rpta == 5 ? "<a href='javascript:fnc_linkeo(" + data[i].id_nivel + ")'><img src='Images/iconos/external-link-symbol.png'  width='16px' /></a></a>" : "nolink") + "</td>" +
                                "<td style='text-align:center;width:5%;'>" + (data[i].in_estado == 1 ? "<img style='cursor: pointer;' src='Images/iconos/checked.png' width='18px' onclick='fnc_CambiarEstado(" + data[i].id_nivel + "," + data[i].in_estado + "," + data[i].in_dpndncia_idnivel + ")' />" : "<img style='cursor: pointer;' src='Images/iconos/unchecked.png'  width='18px' onclick='fnc_CambiarEstado(" + data[i].id_nivel + "," + data[i].in_estado + "," + in_dpndncia_idnivel + ")'/>") + "</td>" +
                                "<td style='text-align:center;width:5%;'><img style='cursor: pointer;' src='Images/iconos/edit.png' width='18px' onclick='fnc_EditarNivel(" + data[i].id_nivel + "," + data[i].in_cate + ",/" + (data[i].vc_titulo == '' ? '-' : data[i].vc_titulo) + "/,/" + (data[i].vc_descripcion == '' ? '-' : data[i].vc_descripcion) + "/,/" + (data[i].vc_url_img == '' ? '-' : data[i].vc_url_img) + "/," + data[i].in_rpta + "," + data[i].in_tipo_rpta + "," + data[i].in_dpndncia_idnivel + ",/" + (data[i].vc_alerta == '' ? '-' : data[i].vc_alerta) + "/,/" + data[i].vc_color_alerta + "/)'/></td>" +
                                "<td style='text-align:center;width:5%;'><img style='cursor: pointer;' id='img_add_" + data[i].id_nivel + "' src='Images/iconos/add.png' width='18px' onclick='fnc_nuevaCategoria(" + data[i].id_nivel + "," + data[i].in_cate + ")' /></td>" +
                                "<td style='text-align:center;width:5%;'><img style='cursor: pointer;' src='Images/iconos/garbage.png' width='18px' onclick='fnc_EliminarNivel(" + data[i].id_nivel + "," + data[i].in_dpndncia_idnivel + ")'/></td>" +
                                "<td style='text-align:center;width:5%;'>" + (data[i].in_dpndncia_idnivel == 0 ? " <a style='cursor: pointer;' href='javascript:fnc_preview(" + data[i].id_nivel + ")'><img src='Images/iconos/preview.png'  width='32px' /></a>" : "<input type='radio' name='rd_link' onclick='fnc_AsignarLink(" + data[i].id_nivel + ")' id='rd_link_" + data[i].id_nivel + "' style='visibility:hidden'/>") + "</td>" +
                            "</tr>" +
                            "<tr style='display:'>" +
                                "<td colspan='12'>" +
                                    "<table  id='tab_" + data[i].id_nivel + "' style='width:98%;margin-left:2%;' >" +
	                                    "<tbody id='tb_" + data[i].id_nivel + "' ></tbody> " +
                                    "</table>" +
                                "</td>" +
                            "</tr>";
					}
				}				 

				$('#' + vc_id_control + '').empty().html(strRows + StrPager);
				//$("#" + vc_id_control + "").append(strRows + StrPager);
			} else {
				$('#' + vc_id_control + '').empty().html("<tr><td style='text-align:center;' colspan='10'>No hay Niveles registrados</td></tr>");
				//$("#" + vc_id_control + "").append();
			}
		}//Fin Success
	}); //Fin Ajax


};

var dictRptaIcon = {
    1: "<img src='Images/iconos/radio-on-button.png' width='18px' />",
    2: "<img src='Images/iconos/image-square-button.png' width='18px'  />",
    3: "<img src='Images/iconos/like.png' width='22px'  />",
    4: "<img src='Images/iconos/radio-on-button.png' width='18px' />",
    5: "<img src='Images/iconos/radio-on-button.png' width='18px' />",
    7: "<img src='Images/iconos/external-link-symbol.png' width='22px'  />",
    8: "<img src='Libreria/imagenes/Botones/addControl.gif' onclick='JQ_Open_Contexto(|idNivel|)' />",
    999: "<img src='Images/iconos/image-square-button.png' width='18px'  />"
};

function getRptaIcon(idRpta, idNivel) {
    if  (! dictRptaIcon.hasOwnProperty(idRpta)) idRpta = 999;        
    return dictRptaIcon[idRpta].replace("|idNivel|", idNivel);
}

function fnc_linkeo(in_nivel) {
	//alert('link');
	//alert($('#input_id_nivel').val());
	$('#input_id_nivel').val(in_nivel);
	//alert($('#input_id_nivel').val());
	//var id_ref = 'href_' + data[0].id_nivel;
	 ;
	//alert(id_ref.substr(5, id_ref.length));
	//PL
	for (var i = 0; i < 9999; i++) {
		//var id = id_ref.substr(5, id_ref.length);
		if (i != in_nivel) {
			$('#rd_link_' + i + '').css("visibility", "visible");
		}
	}
}

function fnc_AsignarLink(in_link_nivel) {
	//alert(in_link_nivel);
	//alert($('#input_id_nivel').val());
	 ;
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
			 ;
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
			if (val == true) {				 
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
					success: function (response) {						 
						var obj = response.d;

						if (obj[0].in_result >= 1) {
							new Messi("Nivel Actualizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 6 });
							var in_categoria = 0;
							 ;
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


function fnc_EliminarNivel(id_nivel, in_dpndncia_idnivel) {

	new Messi('Desea Eliminar este nivel?', {
		title: 'Confirmacion', titleClass: 'anim error', buttons: [{ id: 0, label: 'SI', class: 'btn-success', val: true }, { id: 1, label: 'NO', class: 'btn-danger', val: false }], callback: function (val)
		{
			if (val == true) {
				var objData = {};
				objData["indice"] = 4;
				objData["id_nivel"] = id_nivel;
				 
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
						 ;
						var obj = response.d;

						if (obj[0].in_result >= 1) {
							new Messi("Nivel eliminado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
							var in_categoria = 0;
							 ;
							in_categoria = $('#lbl_id_categoria').text()

							GetNiveles((in_dpndncia_idnivel), 1, '/tb_' + in_dpndncia_idnivel + '/', '/reg/');
						}
					}
				});
			} //endif (val == true)
		} // Fin title
	});    // Fin Messi
}

/*###
    Open #plazo modal for both: Process/Category (x001)
*/
function fnc_nuevaCategoria(in_nivel, in_cate) {
    //alert("in_nivel: [" + in_nivel + "] in_cate: [" + in_cate + "]");

    var title = (in_nivel == in_cate && in_cate == 0) ? 'NUEVA CATEGORÍA' : 'NUEVO PROCESO';
    fnc_clear();

	$('#hdIddescarte').val(in_nivel);
	$('#lbl_id_nivel').text(in_nivel);
	$('#lbl_id_categoria').text(in_cate);
	$('#Textarea_alerta').text('');


	$('#plazo').dialog({
		title: title,
		/*buttons: buttons,		*/
		buttons: [{
			text: 'GUARDAR',
			click: function () {
				fnc_guardar(2, 0);
			},
			class: 'btn btn-primary btn-md'
		}],
		width: 500
	});
}

function fnc_EditarNivel(id_nivel, in_cate, vc_titulo, vc_descripcion, vc_url_img, in_rpta, in_tipo_rpta, in_dpndncia_idnivel, vc_alerta, vc_color_alerta) {

	if (vc_alerta == '/-/') {
		vc_alerta = '';
	}
	//PL
	vc_color_alerta = JQ_reemplazar(vc_color_alerta);
	if (vc_color_alerta == 'green')	{
		$('#chk_ve').prop("checked", true);
	} else if (vc_color_alerta == 'yellow')  {
		$('#chk_am').prop("checked", true);
	} else if (vc_color_alerta == 'red')  {
		$('#chk_ro').prop("checked", true);
	}
	 
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
			click: function () {
				fnc_guardar(3, in_dpndncia_idnivel);
			},
			class: 'btn btn-primary btn-md'
		}],
		width: 500
	});
}
function img_vista() {
	$('#output_img').dialog();
}
$(document).ready(function () {
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

/*
	function archivo(evt)
	{
		 ;
		var files = evt.target.files; // FileList object
		 ;
		// Obtenemos la imagen del campo "file".
		for (var i = 0, f; f = files[i]; i++)
		{
			//Solo admitimos imágenes.
			if (!f.type.match('image.*'))
			{
				continue;
			}

			var reader = new FileReader();

			reader.onload = (function (theFile)
			{
				return function (e)
				{
					// Insertamos la imagen
		
					document.getElementById("output_img").innerHTML = ['<img class="thumb" src="', e.target.result, '" title="', escape(theFile.name), '" style="width:100%"/>'].join('');
				};
			})(f);

			reader.readAsDataURL(f);
		}
	}
	*/

/*###
    Save data into DB (x002)
*/
function fnc_guardar(in_gestion, in_dpndncia_idnivel) {

    var color = $("input[name=rdColor]:checked").val() || 'noselected';    
	
	var id_nivel = 0;
	if ($('#lbl_id_nivel').text() != '') {
		id_nivel = $('#lbl_id_nivel').text();
	} if ($('#txtTitulo').val() == '' || $('#txtarea_desc').val() == '') {
		new Messi("Ingresar todos los datos", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
	} else {
		var objData = {};
		objData["indice"] = in_gestion;
		objData["in_cate"] = $('#lbl_id_categoria').text();
		objData["vc_titulo"] = $('#txtTitulo').val();
		objData["vc_descripcion"] = $("#txtArea_desc").val();

		if ($("#fileupload").val() != '') {
		    //objData["vc_url_img"] = $("#fileupload").val();
		    objData["vc_url_img"] = $("#fileupload")[0].files[0].name;
		}
		
		objData["in_rpta"] = $('#ddl_rpta').val();

		if ($('#ddl_rpta').val() == 7) {
			var ellink = parseInt($("#mismatrices").val()) * 1000000 + parseInt($("#misprocesos").val());
			objData["in_link"] = ellink;
		} else objData["in_link"] = 0;

		objData["in_dpndncia_idnivel"] = (in_gestion == 2 ? $('#lbl_id_nivel').text() : in_dpndncia_idnivel);
		objData["vc_alerta"] = $("#Textarea_alerta").val();
		objData["id_nivel"] = id_nivel;
		objData["vc_color_alerta"] = color;
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
			success: function (response) {				 
				var obj = response.d;

				if (obj[0].in_result >= 1) {
					if (in_gestion == 2) {
						new Messi("Nivel registrado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
						id_nivel = $('#lbl_id_nivel').text()
						GetNiveles((id_nivel), 1, '/tb_' + $('#lbl_id_nivel').text() + '/', '/reg/');
					} else {
						new Messi("Nivel Actualizado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
						GetNiveles((in_dpndncia_idnivel), 1, '/tb_' + in_dpndncia_idnivel + '/', '/reg/');
					}
					var in_categoria = 0;					 
					$('#plazo').dialog("close");
				}
			}
		});
	}
}

function JQ_Grabar_Nivel(vc_filename) {
	alert('grabando');
}

//window.opener.updateValue("[YOUR_INPUT_IN_CKEDITOR]", [URL_OF_THE_IMAGE]);
function Carga_Img() {	 
	//alert('cargar imAG');
	$("#fileupload").fileupload({
		replaceFileInput: false,
		dataType: 'json',
		url: 'UploadHandler.ashx',
		add: function (e, data) {
			var valid = true;
			//var re = /^.+\.((txt))$/i;
			var re = /^.+\.((jpg)|(png)|(gif))$/i;
			$.each(data.files, function (index, file) {
				if (!re.test(file.name)) {
					valid = false;
				}
			});
			 
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
			} else {
				$('#dvProgressBarDown').fadeOut(400, function () {
					$('#dvProgressBarDown').css("display", "none");
				});
				new Messi("Seleccionar Archivos txt con el formato correcto", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
			}
		},
		done: function (e, data) {;
			$.each(data.result, function (index, file) {
				$('#dvProgressBarDown').fadeOut(400, function () {
					$('#dvProgressBarDown').css("display", "none");
				});		               
				
				//setCargaAgentesFile(file.fileName);
				//fnc_guardar(file.fileName);
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
};

$(document).ready(function () {

    $("#fileupload").click("change", function () {
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
function JQ_reemplazar(vc_cadena) {

	var result = "" + vc_cadena;
	while (result.indexOf("/") != -1)  {
		result = result.replace("/", "");
	}
	return result;
}

function JQ_reemplazarTbody(vc_cadena) {

	var result = "" + vc_cadena;
	while (result.indexOf("tbody#") != -1) {
		result = result.replace("tbody#", "");
	}
	return result;
}

function ajustar(id) {
	//alert(id);
	var texto = document.getElementById(id);
	var txt = texto.value;
	var tamano = txt.length + 1;

	tamano *= 8.1; //el valor multiplicativo debe cambiarse dependiendo del tamaño de la fuente

	if (tamano > 100) {
		texto.style.width = tamano + "px";
	} else {
		texto.style.width = "100px";
	}
}

function fnc_clear() {
	$('#txtTitulo').val('');
	$('#txtArea_desc').val('');
	$('#Textarea_alerta').val('');
	$('#fileupload').val('');
}
/*</UTILITARIOS>*/

$(document).ready(function () {
	$('#lbl_time').hide();
});


/*ARMAR VISTA PREVIA*/

function fnc_preview(id_nivel) {
	$('#lblSecuencia').text('');
	$('#div_plazo').modal();
	$('#td_secuencia').empty().html;
	//$('#div_plazo').dialog({
	//	title: 'VISTA PREVIA',
	//	width: 710,
	//show: "scale",
	//hide: "scale",
	//resizable: "false",
	//position: { my: "center", at: "center", of: window },
	////modal: "true",
	//});
	 ;

	for (var i = 0; i < 9999; i++) {
		//recorrer los controles de tipo href para eliminar los que son superirores al actual,
		//ya que si estoy en un nivel superior(1,2,3,4,5,6,7,8,9,10)  y quiero regresar a un nivel inferior(2), el seguimiento de proceso
		//debe indicar: 1,2, eliminando lo restante.		

		if ($('#href_v_' + i + '').length)  {			 
			$('#href_v_' + i + '').remove();
			$('#tr_ref_' + i + '').remove();
		}
	}

	fnc_listar_niveles(1, id_nivel);
}

function muestrate(imagen) {	 
	$('#div_secuencia').empty().html("");
	for (var i = 0; i < 999; i++) {
		$('#href_v_' + i + '').remove();
		$('#tr_ref_' + i + '').remove();
	}
	 
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
function muestraPaso(imagen){
//FALTA!!!!!!!!
	 ;
	var cadena = JQ_reemplazar(imagen);
	/*if (mipaso == 0) {
		$('#' + cadena + '').show();
		mipaso++;
	} else if(mipaso==1) {
		$('#' + cadena + '').hide();
		mipaso = 0;
	}*/
	if (cadena != pasoAnterior)	{
		$('#' + pasoAnterior + '').hide();
		$('#' + pasoAnterior + 'li').css("background-color", "#959595");
		$('#' + pasoAnterior + 'li').css("color", "black");
		mipaso = 0;
	} if (mipaso == 0) {
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
	 ;
	var cadena = JQ_reemplazar(imagen);
	if (miimagen == 0) {
		$('#' + cadena + '').show();
		miimagen++;
	} else {
		$('#' + cadena + '').hide();
		miimagen = 0;
	}
}

var caraPrincipal = 0;

var inicioOperacion;
var horaActual;
var tituloProceso;

function fnc_listar_niveles(in_listar, in_dpndncia_idnivel) {
	var cadena = "#" + in_dpndncia_idnivel;
	$('#tb_imagenes').hide();
	$("#div_contenido").hide();
	$('#div_plazo').show();
	$(cadena).css("visibility", "visible");
	var d = new Date();
	//alert(d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds());
	//$('#lbl_time').text(d.getHours()+':'+ d.getMinutes()+':' +d.getSeconds());
	//$('#tb_contenido_nivel').empty().html;

	var objResult = {};
	objResult.hora = d.getHours();
	objResult.min = d.getMinutes();
	objResult.sec = d.getSeconds();
	objResult.horaactual = d.getTime();

	var objJson = JSON.stringify(objResult);
	sessionStorage.setItem("hora", objJson);

	//Armar le proceso de descarte
	var objData = {};
	objData["indice"] = in_listar;
	objData["in_dpndncia_idnivel"] = in_dpndncia_idnivel;

	var DTA = {};
	DTA.objData = objData;

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
			    if (in_listar == 1) {
			        //alert("when 1");
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

					if (data[0].id_nivel == "954") {
					    alert("when [data[0].id_nivel] 954");					    
						for (var j = 1; j < 8; j++) {
							if (j == 1) {
								vc_secuencia += "<a href='javascript:fnc_listar_niveles(1,1133)' style='color:#fff;font-weight: bold;'><button id='tr_ref_" + data[0].id_nivel + j + "' type='button' class='btn btn-danger btn-lg btn-block' style='margin-bottom:3px;background-color:#4C4A4A;border:#4C4A4A'>Locucion " + j + "</button></a>";
							} else if (j == 2) {
								vc_secuencia += "<a href='javascript:fnc_listar_niveles(1,1134)' style='color:#fff;font-weight: bold;'><button id='tr_ref_" + data[0].id_nivel + j + "' type='button' class='btn btn-danger btn-lg btn-block' style='margin-bottom:3px;background-color:#4C4A4A;border:#4C4A4A'>Locucion " + j + "</button></a>";
							} else {
								vc_secuencia += "<a style='color:#fff;font-weight: bold;'><button id='tr_ref_" + data[0].id_nivel + j + "' type='button' class='btn btn-danger btn-lg btn-block' style='margin-bottom:3px;background-color:#4C4A4A;border:#4C4A4A'>Locucion " + j + "</button></a>";
							}
						}
					}

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
					$('#lblAlerta_plazo').text(data[0].vc_alerta);
					$('#lblAlerta_plazo').css('color', '');
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
					//$('#lblSecuencia').text($('#lblSecuencia').text() + ' > ' + $('#lblTitulo_plazo').text());

					fnc_listar_niveles(2, data[0].id_nivel);

			    } else if (in_listar == 2) {
			        //alert("when 2");
			        //debugger;
			        //alert("when 2: " + " data[i].in_rpta [" + data[i].in_rpta + "] data[i].vc_titulo: ["+ data[i].vc_titulo + "]");
					for (var i = 0; i <= data.length - 1; i++) {
					    //var url = data[i].vc_url_img.substr(12, data[i].vc_url_img.length);
					    var url = data[0].vc_url_img;
						var in_rpta = data[i].in_rpta;
						var in_link = data[i].in_link;
						var img = '';
						//alert(data[i].in_link);
						
						if (in_rpta == 2) {
						    //<button type="button" class="btn btn-primary btn-lg btn-block">Block level button</button>
							//if (numImagenes == 1) {
							$("#div_contenido").hide();
							if (data[i].vc_titulo == '(Ver imagen)') {
								strRows += "<div class='col-lg-7' style='margin-left:150px'>" +
									"<p style='cursor:pointer;color:#337ab7;font-weight:bold;font-size:18px;margin-top:-20px;margin-right:280px' onclick = 'muestraImagen(/div_" + data[i].id_nivel + "/)'>" + data[i].vc_titulo + "</p>" +
									"<div id='div_" + data[i].id_nivel + "' class='thumbnail' ><script>$('#div_" + data[i].id_nivel + "').hide()</script>" +
										"<img src='Archivos_Carga/" + url + "' width='500px' height='300px'style=''/>" +
									"</div>" +
									"</div>" +
									"</br>";
							} else {
								strRows += "<div class='col-lg-12'>" +
												"<b><SPAN>TITULO</SPAN>" + (i + 1) + " : </b>" + data[i].vc_titulo + "</br>" +
												"<div class='thumbnail' id='div_" + data[i].id_nivel + "' style='border-radius:40px' >" +
													"<img src='Archivos_Carga/" + url + "' width='960px' height='620px'style='border-radius:40px'/ onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");'>" +
												"</div>" +
											"</div>" +
									"</div>" +
									"</br>";
							}
						} else if (in_rpta == 3) {
							$("#div_contenido").hide();
							if (data[i].vc_titulo == "Si") {
								strRows += "<input type='radio' style='width:25px;height:25px;margin-left:40px' onclick='fnc_solucion(1);' name='1'/>" +
										   "<label style='font-size:13px;vertical-align:middle;margin-top:-12px;padding-left:15px'> " + "hola" + "</label></br>";
							} else {
								strRows += "<li class='si' style='display: inline-block; margin-left:250px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>Finalizar</span></li>";
							}
							//$("#lblDescripcion_plazo").hide();
						} else if (in_rpta == 4) {
							$("#div_contenido").hide();
							strRows += "<li class='si' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:100px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";

						} else if (in_rpta == 5) {
							$("#div_contenido").hide();
							strRows += "<li class='no' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:50px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";

						} else if (in_rpta == 6) {
							$("#div_contenido").hide();
							contenidoul += "<li id='div_" + data[i].id_nivel + "li' class='pasitos' style='display: inline-block;font-weight:bold;padding:10px 40px;font-size:12px;margin-right:3px;border-radius:5px;background-color:rgb(149,149,149);' onclick = 'muestraPaso(/div_" + data[i].id_nivel + "/)'>" + data[i].vc_titulo + "</li>"
							imagenespasos += "<div class='col-lg-8 thumbnail' style='margin-left:40px;margin-top:-" + existencipasos * 20 + "px;' id='div_" + data[i].id_nivel + "'><script>$('#div_" + data[i].id_nivel + "').hide()</script>" +
									"<img src='Archivos_Carga/" + url + "' width='800px' height='480px'style=''/>" +
								"</div>" +
								"</br>";

							existencipasos++;
						} else if (in_rpta == 8) {
							//$("#div_contenido").show();
							//Cargar los comentarios
							//Armar_contenido_Nivel(data[i].id_nivel);
							getContentOfNivel(data[i].id_nivel);
						} else {
							if (data[i].vc_titulo == "SI") {
								//alert(data[i].in_id_link);
								//"<li class='desactivado' role='presentation' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-right:5px;margin-top:5px;padding:10px 20px;border-radius:6px;font-size:18px'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
								strRows += "<li class='si' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:150px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";

							} else if (data[i].vc_titulo == "NO") {

								strRows += "<li class='no' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:90px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";

							} else if (data[i].vc_titulo == "Crear Caso") {
								strRows += "<li class='caso' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:100px;margin-top:5px;padding:20px 60px;border-radius:10px;border:2px solid black;font-size:18px;font-weight:bold'><span style='color:black;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
							} else if (data[i].vc_titulo == "Generar Reclamo") {
								strRows += "<li class='reclamo' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:40px;margin-top:5px;padding:20px 50px;border-radius:10px;border:2px solid black;font-size:18px;font-weight:bold'><span style='color:black;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
							} else if (data[i].vc_titulo == "Interiores") {
								strRows += "<li class='no' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:100px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:32px;border:2px solid black;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
							} else if (data[i].vc_titulo == "Exteriores") {
								strRows += "<li class='si' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:40px;margin-top:5px;padding:20px 50px;border-radius:10px;font-size:32px;border:2px solid black;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
							} else if (data[i].vc_titulo == "Si") {
								strRows += "<li class='ultimosi' style='display: inline-block; margin-left:280px;margin-top:5px;padding:20px 60px;border-radius:10px;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
							} else if (data[i].vc_titulo.substring(0, 8) == 'Locución') {
								strRows += "";
							} else {
								strRows += "<li class='si' onclick='fnc_listar_niveles(1," + (data[i].in_link == 0 ? data[i].id_nivel : data[i].in_link) + ");' style='display: inline-block; margin-left:250px;margin-top:5px;padding:20px 60px;border-radius:10px;border:2px solid black;font-size:32px;font-weight:bold'><span style='color:#fff;font-weight:bold;'>" + data[i].vc_titulo + "</span></li>";
							}
						}

					}//end for

					$('#tb_plazo').empty().html(strRows);
					if (existencipasos != 0) {
						$('#tb_plazo').empty().html("<ul>" + contenidoul + "</ul>" + imagenespasos + strRows);
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
			} else {
				//alert('nodatos');
				$('#tb_plazo').empty().html(strRows);
				//$('#' + vc_id_control + '').empty().html("<tr><td style='text-align:center;' colspan='10'>No hay Niveles registrados</td></tr>");
				//$("#" + vc_id_control + "").append();
			}

		}//Fin Success
	}); //Fin Ajax
}

function getContentOfNivel(idNivel) {
    ajax(urlFrm_MantNivel + "getContentOfNivel", { opc: 6, idNivel: idNivel }, getContentOfNivelHandler);
}

function getContentOfNivelHandler(data) {    
    var json = eval('(' + data.d + ')');
    var rawStr = ""
    $.each(json, function (k,v) {
        //alert(v.vc_contenido);
        rawStr += v.vc_contenido;
    });
    //alert(json.vc_contenido);
    $("#div_contenido").html(rawStr).show();
}

function Armar_contenido_Nivel(in_idnivel) {

	var objData = {};
	objData["op"] = 6;
	objData["in_idnivel"] = in_idnivel;

	$.ajax({
		async: false,
		type: "POST",
		url: urlFrm_MantNivel + "Armar_Contenidos",
		data: JSON.stringify(objData),
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function (response) {
			var data = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
			var pageCount = 0;
			var StrPager; var strRows;
			$('#tb_contenido_nivel tr:not(:first)').remove();
			if (data.length > 0) {
				for (var i = 0; i <= data.length; i++) {
					if (data.length == i) {
						pageCount = data[0].total;
						var StrPager = "";
						if (pageCount > 1) {
							for (var x = 1; x <= pageCount; x++) {
								if (x == 1) {
									//StrPager = "<tr class='pgr'><td colspan='10' style='text-align:left;padding:6px;'>";
								}
								//StrPager = StrPager + "<label style='line-height: 12px;border-width: 0;padding: 0 6px;border-left: solid 1px #0A0A0A;font-weight: bold;" + (x == pgnum ? "color: #F4FAF4;" : "color: #080809;cursor:pointer;" + "'  onclick='GetGridUsuario(" + x + ");") + "'>" + x + "</label>";
								if (x == pageCount) {
									//StrPager = StrPager + "</td></tr>";
								}
							}
						} else {
						    StrPager = "<tr class='pgr'><td colspan='10' style='text-align:left;padding:10px;'></td></tr>";
						}
					} else {
						if (i % 2 == 0) { strRows = strRows + "<tr>"; } else { strRows = strRows + "<tr class='alt'>"; }
						strRows +=
								   "<td><textarea id='txt_contenido'>" + data[i].vc_contexto + "</textarea></td>"
									//"<td><textarea id='txt_contenido" + data[i].in_idcontenido + "'>" + data[i].vc_contexto + "</textarea></td>" +
						"</td></tr>"
						//style='width:200px;max-Height:300px;'

					}
				}
				$("#tb_contenido_nivel").append(strRows + StrPager);

			} else {
			    $("#tb_contenido_nivel").append("<tr><td style='text-align:center;' colspan='10'>No hay datos para mostrar</td></tr>");
			}
		}//Fin Success
	}); //Fin Ajax
}

function fnc_solucion(in_gestion) {	 
	$('#div_resultado').show();
	$('#div_resultado').modal();

	var hora;
	var min;
	var sec;
	var horaactual;
	 
	if (sessionStorage.getItem("hora") != null) {
		 ;
		var objPreg = sessionStorage.getItem("hora");
		var objPreg = JSON.parse(objPreg);
		hora = objPreg.hora;
		min = objPreg.min;
		sec = objPreg.sec;
		horaactual = objPreg.horaactual;

	}
	 
	var d = new Date();
	var tiempo = new Date();
	tiempo = horaactual;


	//alert(d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds());
	var h = d.getHours();
	var m = d.getMinutes();
	var s = d.getSeconds();

	//restaFechas = function (f1, f2)
	//{
	//	 ;
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

	if (in_gestion == 1) {
		$('#lblSolucion').text('NO REQUIERE VISITA TECNICA');
		$('#lblSolucion').css('color', 'black');
		$('#txt_hora').prop('readonly', true);
		$('#txt_hora').css('background-color', '#B0B0B0');
		$('#txt_date').prop('readonly', true);
		$('#txt_date').css('background-color', '#B0B0B0');
		$('#txtarea').focus();
	} else {
		$('#lblSolucion').text('REQUIERE VISITA TECNICA');
		$('#lblSolucion').css('color', 'red');
		$('#txt_hora').prop('readonly', false);
		$('#txt_date').prop('readonly', false);
		$('#txt_hora').css('background-color', 'white');
		$('#txt_date').css('background-color', 'white');
		$('#txtarea').focus();
	}
}
$(document).ready(function () {
	$('#div_resultado').hide();
	$("#div_menu").hide();
	$('#div_menu').hide();

	//$('#lbl_time').hide();

	//$('#222').on("click", function (e)
	//{
	//	//alert($(this).prop('id'));
	//	$("#div_menu").css({ 'display': '', 'left': (e.pageX), 'top': (e.pageY)-50 });
	//	return false;
	//});	


	$(document).click(function (e) {
		if (e.button == 0) {
			$("#div_menu").css("display", "none");
		}
	});

	//si pulsamos escape, el menú desaparecerá

	$(document).keydown(function (e) {
		if (e.keyCode == 27) {
			$("#div_menu").css("display", "none");
		}
	});
});

function fnc_close(vc_control) {
	//alert(vc_control);
	$('#' + vc_control + '').modal('hide');
}
function fnc_click(id_nivel) {
	 
	$('#div_menu').show();
	$('#div_menu').modal();

	//alert(id_nivel);

	//$('#' + id_nivel + '').click(function(e) 
	//{
	//	 ;
	//	//alert($(this).prop('id'));
	//	$("#div_menu").css({ 'display': '', 'left': (e.pageX), 'top': (e.pageY) - 50 });
	//	return false;
	//});

	//$('#' + id_nivel + '').on("click", function (e)
	//{
	//	 ;
	//	//alert($(this).prop('id'));
	//	$("#div_menu").css({ 'display': '', 'left': (e.pageX), 'top': (e.pageY) - 50 });
	//	return false;
	//});
}

function jq_shadow(id) {
	//alert(id);
	//PLL
	var vc_id_div = JQ_reemplazar(id);
	if ($('#' + vc_id_div + '').hasClass("shadow"))	{
		$('#' + vc_id_div + '').removeClass("shadow");
	} else {
		$('#' + vc_id_div + '').addClass("shadow");
	}
}
/*END ARMAR VISTA PREVIA*/
/*
$.fn.modal.Constructor.prototype.enforceFocus = function () {
    modal_this = this
    $(document).on('focusin.modal', function (e) {
        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
        && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select')
        && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
            modal_this.$element.focus()
        }
    })
}; //*/
/*
$.fn.modal.Constructor.prototype.enforceFocus = function () {
    var $modalElement = this.$element;
    $(document).on('focusin.modal', function (e) {
        var $parent = $(e.target.parentNode);
        if ($modalElement[0] !== e.target
                        && !$modalElement.has(e.target).length
                        && $(e.target).parentsUntil('*[role="dialog"]').length === 0) {
            $modalElement.focus();
        }
    });
}; //*/
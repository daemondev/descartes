$(function () {
	$("#username").focus();
});

var GC_LOGIN = (function (obj)
{
	//debugger;
	obj.url = "Login.aspx/";
	obj.Ingresar_login = function (event) {
		if (event.which == 13) { GC_LOGIN.fcLogin(); }
	};
	//debugger;
	//Proceso de Validacion
	obj.fcLogin = function () {
		usuario = $("#username").val();
		pwd = $("#password").val();
		if (usuario == "") {
		    new Messi("Ingrese el usuario.", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1000, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
			return false;
		}
		if (pwd == "") {
			new Messi("Ingrese la Clave.", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1000, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
			return false;
		}
		$.ajax({
			async: false,
			type: "POST",
			url: obj.url + "LoginUsuario",
			data: '{vc_Usuario:"' + usuario + '",vc_Clave:"' + pwd + '"}',
			dataType: "json",   
			contentType: "application/json; charset=utf-8",
			success: function (data)
			{
				//debugger;
				var obj = data.d;
				if (obj != "") {
				    var objPerfil = {
				        inPerfil: obj,
				    };
				    var objSim = JSON.stringify(objPerfil);
				    sessionStorage.setItem("sePerfil", objSim);
				    location.href = "Frm_Principal.aspx";
				    
				}
				else {
				    new Messi("Acceso Denegado - Usuario no Registrado", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
				} // IF
			}, //Fin Success
			error: function (data) {
			    new Messi("Error al conectarce con el servidor", { modal: true, center: true, title: 'Informacion', titleClass: 'anim error', autoclose: 1500, buttons: [{ id: 0, label: 'Ok', val: 'X' }] });
			}// fin del error
		});  // Fin del ajax
	};

	return obj;
}(GC_LOGIN || {}));
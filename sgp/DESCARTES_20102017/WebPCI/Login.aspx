 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>. : Ingreso : .</title>
    <link href="Libreria/js/jquery-ui-1.10.3.custom/css/green-theme/jquery-ui-1.10.3.custom.css" rel="stylesheet" />
    <script src="Libreria/js/jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
    
    <link href="Libreria/js/messiAlert/css/messi.css" rel="stylesheet" />
    <script src="Libreria/js/messiAlert/js/messi.min.js"></script>

   <link href="Libreria/css/Login.css" rel="stylesheet" />
<%--	<link href="Libreria/css/Login_sty.css" rel="stylesheet" />--%>

    <script src="Libreria/js/Login.js"></script>

</head>
	
<script>

	$(".ursername").focusin(function ()
	{
		$(".inputUserIcon").css("color", "#e74c3c");
	}).focusout(function ()
	{
		$(".inputUserIcon").css("color", "white");
	});

	$(".password").focusin(function ()
	{
		$(".inputPassIcon").css("color", "#e74c3c");
	}).focusout(function ()
	{
		$(".inputPassIcon").css("color", "white");
	});
</script>
<body  oncontextmenu="return false;">
	<div class="container">
		<div class="info">
			<h1>SISTEMA GESTIÓN DE PROCESOS</h1>
		</div>
	</div>
	<div class="form"><!--!!!!!!!!!!!!!!!!!!!-->
		<div class="thumbnail"><img src="images/claro.jpg"/></div>
		<form id="form1" runat="server" class="login-form">
		<div id="global">
			<div id="div_login">
				<div id="id_usuario">
					<input id="username" onkeypress="GC_LOGIN.Ingresar_login(event);" name="username" required="" type="text" class="user" placeholder="usuario" />
				</div>
				<div id="id_clave">
					<input id="password" name="password" onkeypress="GC_LOGIN.Ingresar_login(event);" required="" type="password" class="pass" placeholder="contraseña" />
				</div>
			</div>
		</div>
		
		</form>
	</div>
</body>
</html>


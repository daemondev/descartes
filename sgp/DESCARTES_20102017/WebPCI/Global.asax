<%@ Application Language="C#" %>
<%@ Import Namespace="WebPCI" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Código que se ejecuta al iniciarse la aplicación
        AuthConfig.RegisterOpenAuth();
    }
    
    void Application_End(object sender, EventArgs e)
    {
        //  Código que se ejecuta al cerrarse la aplicación
        HttpContext.Current.Session["ready"] = null;
    }

    void Application_Error(object sender, EventArgs e)
    {
        // Código que se ejecuta cuando se produce un error sin procesar
        HttpContext.Current.Session["ready"] = null;

    }

</script>

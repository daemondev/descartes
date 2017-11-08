﻿<%@ WebHandler Language="C#" Class="UploadHandler" %>

using System.Collections.Generic;
using System;
using System.Drawing;
using System.Web;
using System.IO;

public class UploadHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        //Uploaded File Deletion
        if (context.Request.QueryString.Count > 0) {

            string cke = context.Request.QueryString.AllKeys[0];
            
            if (cke.Equals("CKEditor")) {
                int num = Convert.ToInt32( context.Request.QueryString["CKEditorFuncNum"]);
                var ext = System.IO.Path.GetExtension(context.Request.Files[0].FileName);
                var fileName = Path.GetFileName(context.Request.Files[0].FileName);
                // /*
                if (context.Request.Files[0].FileName.LastIndexOf("\\") != -1)
                {
                    fileName = context.Request.Files[0].FileName.Remove(0, context.Request.Files[0].FileName.LastIndexOf("\\")).ToLower();
                }
                fileName = GetUniqueFileName(fileName, HttpContext.Current.Server.MapPath("Archivos_Carga/"), ext).ToLower(); //*/
                string location = HttpContext.Current.Server.MapPath("Archivos_Carga/") + fileName + ext;               

                if (File.Exists(location))
                    File.Delete(location);

                context.Request.Files[0].SaveAs(location);
                //context.Response.ContentType = "application/json"; //

                var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                Dictionary<string, object> dict = new Dictionary<string, object>();
                Dictionary<string, object> dict2 = new Dictionary<string, object>();
                dict2.Add("fileName", fileName + ext);
                dict.Add("d", dict2);
                var res = "<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction(" + num.ToString() +", '" + "Archivos_Carga/" + fileName + ext +"', 'La imágen ["+ fileName+ext +"] se guardó satisfactoriamente en el servidor');</script>";
                //window.parent.CKEDITOR.tools.callFunction($funcNum, $url, $message)
                //context.Response.Write(serializer.Serialize(dict));
                context.Response.Write(res);
                //context.Response.Write(fileName + ext);
                context.Response.End();
            }


            string filePath = HttpContext.Current.Server.MapPath("Archivos_Carga") + "//" + context.Request.QueryString[0].ToString();

            if (File.Exists(filePath))
                File.Delete(filePath);
        }
        //File Upload
        else
        {
            var ext = System.IO.Path.GetExtension(context.Request.Files[0].FileName);
            var fileName = Path.GetFileName(context.Request.Files[0].FileName);
            if (context.Request.Files[0].FileName.LastIndexOf("\\") != -1)
            {
                fileName = context.Request.Files[0].FileName.Remove(0, context.Request.Files[0].FileName.LastIndexOf("\\")).ToLower();
            }
            fileName = GetUniqueFileName(fileName, HttpContext.Current.Server.MapPath("Archivos_Carga/"), ext).ToLower();
            string location = HttpContext.Current.Server.MapPath("Archivos_Carga/") + fileName + ext;
            context.Request.Files[0].SaveAs(location);
            context.Response.ContentType = "application/json"; //

            var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            Dictionary<string, object> dict = new Dictionary<string, object>();
            Dictionary<string, object> dict2 = new Dictionary<string, object>();
            dict2.Add("fileName", fileName + ext);
            dict.Add("d", dict2);
            context.Response.Write(serializer.Serialize(dict));
            //context.Response.Write(fileName + ext);
            context.Response.End();
        }
    }

    public static string GetUniqueFileName(string name, string savePath, string ext)
    {
        name = name.Replace(ext, "").Replace(" ", "_");
        name = System.Text.RegularExpressions.Regex.Replace(name, @"[^\w\s]", "");
        var newName = name;
        var i = 0;
        if (System.IO.File.Exists(savePath + newName + ext))
        {
            do
            {
                i++;
                newName = name + "_" + i;
            }
            while (System.IO.File.Exists(savePath + newName + ext));
        }
        return newName;
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
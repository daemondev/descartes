<%@ WebHandler Language="C#" Class="ImgUploadHandler" %>

using System.Collections.Generic;
using System;
using System.Drawing;
using System.Web;
using System.IO;

public class ImgUploadHandler : IHttpHandler {
	
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
		if (context.Request.QueryString.Count > 0)
		{
			string filePath = HttpContext.Current.Server.MapPath("Archivos_Carga/Upload_img") + "//" + context.Request.QueryString[0].ToString();
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
			fileName = GetUniqueFileName(fileName, HttpContext.Current.Server.MapPath("Archivos_Carga/Upload_img/"), ext).ToLower();
			string location = HttpContext.Current.Server.MapPath("Archivos_Carga/Upload_img/") + fileName + ext;
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
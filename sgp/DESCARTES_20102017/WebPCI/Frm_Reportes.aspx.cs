using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Web.Services;
using Entidad;
using Negocio;
using System.Data;
using System.Drawing;
using System.IO;
using SpreadsheetGear;

/*
quitar avanzado
quitar form
quitar id de subprocesos
z-index modal
reporte correcto
dos procesos demo - 4 pasos - inicio - fin
agregar columna usuario - rpt general
R2 - iis 7
     */

public partial class Frm_Reportes : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Campania> mantCampania(int in_Opc, int in_SedeID)
    {
        List<Etb_Campania> lst = new List<Etb_Campania>();
        Ntb_Campania neg = new Ntb_Campania();
        Etb_Campania ent = new Etb_Campania();
        Etb_Usuario entUsu = new Etb_Usuario();
        ent.in_Opc = in_Opc;
        ent.in_SedeID = in_SedeID;
        return lst = neg.N_MantCampania(ent);
    }

    [WebMethod]
    public static string ExportarReporte(string f1, string f2, string in_sede, string in_camp, string vc_sede, string vc_camp)
    {

        DataSet ds = new DataSet();
        Ntb_Reportes ng = new Ntb_Reportes();
        ds = ng.N_Reportes(f1, f2, in_sede, in_camp);
        //EXPORTAR REPORTE

        //Proceso de exportacion
        string exclName = "";
        IWorkbook Libro = Factory.GetWorkbook(System.Globalization.CultureInfo.CurrentCulture);
        IWorksheet Hoja = Libro.Worksheets[0];
        IRange celda = Hoja.Cells;
        Int32 Fila_Inicio = 4;

        //  *********************** REPORTE DE CREACION DE PLANTILLA

        if ((ds.Tables.Count > 0))
        {
            //worksheet.Name = "Reporte de Penalidad";
            celda["A1:DZ5000"].Interior.Color = Color.FromArgb(255, 255, 255);

            celda["A2:F2"].Merge();
            celda["A2:F2"].Value = "Reporte General: " + vc_sede + " => " + vc_camp;
            celda["A2:F2"].Font.Size = 16;
            celda["A2:F2"].Font.Bold = true;

            celda["A3:F3"].Merge();
            celda["A3:F3"].Value = "Rango fechas: " + f1 + " => " + f2;
            celda["A3:F3"].Font.Size = 12;
            celda["A3:F3"].Font.Bold = true;

            Hoja.Name = "Rpt Descartes";

            Fila_Inicio++;

            //  *********************** tabla capacitaciones
            celda[Fila_Inicio, 1].ColumnWidth = 10;
            celda[Fila_Inicio, 1].Value = "";

            celda[Fila_Inicio, 2].ColumnWidth = 15;
            celda[Fila_Inicio, 2].Value = "SEDE";

            celda[Fila_Inicio, 3].ColumnWidth = 15;
            celda[Fila_Inicio, 3].Value = "CAMPAÑA";

            celda[Fila_Inicio, 4].ColumnWidth = 15;
            celda[Fila_Inicio, 4].Value = "USUARIO";

            celda[Fila_Inicio, 5].ColumnWidth = 10;
            celda[Fila_Inicio, 5].Value = "USER LOGIN";

            celda[Fila_Inicio, 6].ColumnWidth = 25;
            celda[Fila_Inicio, 6].Value = "PROCESO";

            celda[Fila_Inicio, 7].ColumnWidth = 45;
            celda[Fila_Inicio, 7].Value = "TIPIFICACION";

            celda[Fila_Inicio, 8].ColumnWidth = 15;
            celda[Fila_Inicio, 8].Value = "HORA INICIO";

            celda[Fila_Inicio, 9].ColumnWidth = 15;
            celda[Fila_Inicio, 9].Value = "DURACION";

            celda[Fila_Inicio, 10].ColumnWidth = 15;
            celda[Fila_Inicio, 10].Value = "FEC. REGISTRO";



            Fila_Inicio += 1;
            int fila = 1;
            Int32 num = 1;

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                celda[Fila_Inicio, num].HorizontalAlignment = HAlign.Left;
                celda[Fila_Inicio, num].Font.Name = "Calibri";
                celda[Fila_Inicio, num].Font.Size = 8;
                celda[Fila_Inicio, num].Value = fila;
                num += 1;
                foreach (DataColumn colum in ds.Tables[0].Columns)
                {

                    celda[Fila_Inicio, num].HorizontalAlignment = HAlign.Left;
                    celda[Fila_Inicio, num].Font.Name = "Calibri";
                    celda[Fila_Inicio, num].Font.Size = 8;
                    celda[Fila_Inicio, num].Value = row[colum].ToString();                  

                    num++;
                }
                num = 1;
                Fila_Inicio++;
                fila += 1;
            }

            num = 9;
            for (Int32 j = 5; j < Fila_Inicio; j++)
            {
                for (Int32 x = 1; x <= num + 1; x++)
                {
                    celda[j, x].Borders[BordersIndex.EdgeRight].LineStyle = LineStyle.Continuous;
                    celda[j, x].Borders[BordersIndex.EdgeRight].Color = Color.FromArgb(200, 200, 200);
                    celda[j, x].Borders[BordersIndex.EdgeTop].LineStyle = LineStyle.Continuous;
                    celda[j, x].Borders[BordersIndex.EdgeTop].Color = Color.FromArgb(200, 200, 200);
                    celda[j, x].Borders[BordersIndex.EdgeBottom].LineStyle = LineStyle.Continuous;
                    celda[j, x].Borders[BordersIndex.EdgeBottom].Color = Color.FromArgb(200, 200, 200);
                    celda[j, x].Borders[BordersIndex.EdgeLeft].LineStyle = LineStyle.Continuous;
                    celda[j, x].Borders[BordersIndex.EdgeLeft].Color = Color.FromArgb(200, 200, 200);

                }
            }



            celda[5, 1, 5, num + 1].Font.Bold = true;
            celda[5, 1, 5, num + 1].Interior.Color = Color.FromArgb(56, 96, 146);
            celda[5, 1, 5, num + 1].Font.Color = Color.FromArgb(255, 255, 255);
            celda[5, 1, 5, num + 1].Font.Name = "Arial";
            celda[5, 1, 5, num + 1].HorizontalAlignment = HAlign.Center;
            celda[5, 1, 5, num + 1].VerticalAlignment = VAlign.Center;
            celda[5, 1, 5, num + 1].Font.Size = 9;

            //Fila_Inicio += 3;
            //int inicioFila = Fila_Inicio;
            //num = 4;

            exclName = "Reporte_" + string.Format("{0:yyyy_MM_dd}", DateTime.Now) + ".xls";
            Libro.SaveAs(HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["path_xls"]) + exclName, SpreadsheetGear.FileFormat.Excel8);
            return ConfigurationManager.AppSettings["path_xls"].Replace("~/", "") + exclName;
        }
        else
        {
            return null;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Entidad.Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        //Session.Timeout = 30;
    }

    //protected void Page_Init(object sender, EventArgs e)
    //{
    //    Page.Server.ScriptTimeout = 9000;
    //}

    [WebMethod]
    public static string ExportarReporteGeneral(string f1, string f2, string in_sede, string in_camp, string vc_sede, string vc_camp)
    {

        DataSet ds = new DataSet();
        Ntb_Reportes ng = new Ntb_Reportes();
        ds = ng.N_ReportesG(f1, f2, in_sede, in_camp);

        DataSet ds1 = new DataSet();
        Ntb_Reportes ng1 = new Ntb_Reportes();
        ds1 = ng1.N_Reportes(f1, f2, in_sede, in_camp);
        //EXPORTAR REPORTE

        //Proceso de exportacion
        string exclName = "";
        IWorkbook Libro = Factory.GetWorkbook(System.Globalization.CultureInfo.CurrentCulture);
        IWorksheet Hoja = Libro.Worksheets[0];
        IRange celda = Hoja.Cells;
        Int32 Fila_Inicio = 4;

        //  *********************** REPORTE DE CREACION DE PLANTILLA

        if ((ds.Tables.Count > 0))
        {
            //worksheet.Name = "Reporte de Penalidad";
            celda["A1:DZ5000"].Interior.Color = Color.FromArgb(255, 255, 255);

            celda["A2:F2"].Merge();
            celda["A2:F2"].Value = "Reporte General: " + vc_sede + " => " + vc_camp;
            celda["A2:F2"].Font.Size = 16;
            celda["A2:F2"].Font.Bold = true;

            celda["A3:F3"].Merge();
            celda["A3:F3"].Value = "Rango fechas: " + f1 + " => " + f2;
            celda["A3:F3"].Font.Size = 12;
            celda["A3:F3"].Font.Bold = true;

            Hoja.Name = "Rpt General";

            Fila_Inicio++;
            //celda["B5:F5"].Merge();
            //celda["B5:F5"].Value =
            //celda["B5:F5"].Font.Size = 14;
            //celda["B5:F5"].Font.Bold = true;

            //  *********************** tabla capacitaciones
            celda[Fila_Inicio, 1].ColumnWidth = 10;
            celda[Fila_Inicio, 1].Value = "";

            celda[Fila_Inicio, 2].ColumnWidth = 25;
            celda[Fila_Inicio, 2].Value = "PROCESO";

            celda[Fila_Inicio, 3].ColumnWidth = 20;
            celda[Fila_Inicio, 3].Value = "# PROCESOS";

            celda[Fila_Inicio, 4].ColumnWidth = 15;
            celda[Fila_Inicio, 4].Value = "TIEMPO TOTAL";

            celda[Fila_Inicio, 5].ColumnWidth = 15;
            celda[Fila_Inicio, 5].Value = "FEC. REGISTRO";

            /* celda[Fila_Inicio, 11].ColumnWidth = 15;
             celda[Fila_Inicio, 11].Value = "HORA. VISITA";


             celda[Fila_Inicio, 12].ColumnWidth = 15;
             celda[Fila_Inicio, 12].Value = "SOLUCION";

             celda[Fila_Inicio, 13, Fila_Inicio, 15].MergeCells = true;
             celda[Fila_Inicio, 13].ColumnWidth = 15;
             celda[Fila_Inicio, 13].Value = "SECUENCIA RESOLUCION";

             celda[Fila_Inicio, 16, Fila_Inicio, 18].MergeCells = true;
             celda[Fila_Inicio, 16].ColumnWidth = 15;
             celda[Fila_Inicio, 16].Value = "OBSERVACION";
             */



            Fila_Inicio += 1;
            int fila = 1;
            Int32 num = 1;

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                celda[Fila_Inicio, num].HorizontalAlignment = HAlign.Left;
                celda[Fila_Inicio, num].Font.Name = "Calibri";
                celda[Fila_Inicio, num].Font.Size = 8;
                celda[Fila_Inicio, num].Value = fila;
                num += 1;
                foreach (DataColumn colum in ds.Tables[0].Columns)
                {
                    /*celda[Fila_Inicio, 13, Fila_Inicio, 15].MergeCells = true;
                    celda[Fila_Inicio, 16, Fila_Inicio, 18].MergeCells = true;
                    if (num == 14)
                    {
                        num += 2;
                        celda[Fila_Inicio, num].HorizontalAlignment = HAlign.Left;
                        celda[Fila_Inicio, num].Font.Name = "Calibri";
                        celda[Fila_Inicio, num].Font.Size = 8;
                        celda[Fila_Inicio, num].Value = row[colum].ToString();
                        num -= 2;
                    }else{*/
                    celda[Fila_Inicio, num].HorizontalAlignment = HAlign.Left;
                    celda[Fila_Inicio, num].Font.Name = "Calibri";
                    celda[Fila_Inicio, num].Font.Size = 8;
                    celda[Fila_Inicio, num].Value = row[colum].ToString();
                    //}


                    //celda[Fila_Inicio, num].HorizontalAlignment = HAlign.Left;
                    //   celda[Fila_Inicio, num].Font.Name = "Calibri";
                    //   celda[Fila_Inicio, num].Font.Size = 8;
                    //   celda[Fila_Inicio, num].Value = row[colum].ToString();                    

                    num++;
                }
                num = 1;
                Fila_Inicio++;
                fila += 1;
            }

            num = 4;
            for (Int32 j = 5; j < Fila_Inicio; j++)
            {
                for (Int32 x = 1; x <= num + 1; x++)
                {
                    celda[j, x].Borders[BordersIndex.EdgeRight].LineStyle = LineStyle.Continuous;
                    celda[j, x].Borders[BordersIndex.EdgeRight].Color = Color.FromArgb(200, 200, 200);
                    celda[j, x].Borders[BordersIndex.EdgeTop].LineStyle = LineStyle.Continuous;
                    celda[j, x].Borders[BordersIndex.EdgeTop].Color = Color.FromArgb(200, 200, 200);
                    celda[j, x].Borders[BordersIndex.EdgeBottom].LineStyle = LineStyle.Continuous;
                    celda[j, x].Borders[BordersIndex.EdgeBottom].Color = Color.FromArgb(200, 200, 200);
                    celda[j, x].Borders[BordersIndex.EdgeLeft].LineStyle = LineStyle.Continuous;
                    celda[j, x].Borders[BordersIndex.EdgeLeft].Color = Color.FromArgb(200, 200, 200);

                }
                /*   celda[j, 16, j, 18].MergeCells = true;

                   celda[j, 16, j, 18].Borders[BordersIndex.EdgeRight].LineStyle = LineStyle.Continuous;
                   celda[j, 16, j, 18].Borders[BordersIndex.EdgeRight].Color = Color.FromArgb(200, 200, 200);
                   celda[j, 16, j, 18].Borders[BordersIndex.EdgeTop].LineStyle = LineStyle.Continuous;
                   celda[j, 16, j, 18].Borders[BordersIndex.EdgeTop].Color = Color.FromArgb(200, 200, 200);

                   celda[j, 16, j, 18].Borders[BordersIndex.EdgeBottom].LineStyle = LineStyle.Continuous;
                   celda[j, 16, j, 18].Borders[BordersIndex.EdgeBottom].Color = Color.FromArgb(200, 200, 200);
                   celda[j, 16, j, 18].Borders[BordersIndex.EdgeLeft].LineStyle = LineStyle.Continuous;
                   celda[j, 16, j, 18].Borders[BordersIndex.EdgeLeft].Color = Color.FromArgb(200, 200, 200);*/
            }



            celda[5, 1, 5, num + 1].Font.Bold = true;
            celda[5, 1, 5, num + 1].Interior.Color = Color.FromArgb(56, 96, 146);
            celda[5, 1, 5, num + 1].Font.Color = Color.FromArgb(255, 255, 255);
            celda[5, 1, 5, num + 1].Font.Name = "Arial";
            celda[5, 1, 5, num + 1].HorizontalAlignment = HAlign.Center;
            celda[5, 1, 5, num + 1].VerticalAlignment = VAlign.Center;
            celda[5, 1, 5, num + 1].Font.Size = 9;
            // ************************tabla detalle capacitacion
            //celda["B10:F10"].Merge();
            //celda["B10:F10"].Value = "Asistencias";
            //celda["B10:F10"].Font.Size = 14;
            //celda["B10:F10"].Font.Bold = true;
            //*********************** tabla asistencias
            //Fila_Inicio += 3;
            //int inicioFila = Fila_Inicio;
            //num = 4;
            IWorksheet Hoja_R = Libro.Worksheets.Add();
            IWorksheet Hoja_new = Libro.Worksheets[Hoja_R.Index];
            IRange celda_R = Hoja_R.Cells;
            Fila_Inicio = 4;

            //worksheet.Name = "Reporte de Penalidad";
            celda_R["A1:DZ5000"].Interior.Color = Color.FromArgb(255, 255, 255);

            celda_R["A2:F2"].Merge();
            celda_R["A2:F2"].Value = "Reporte Detallado: " + vc_sede + " => " + vc_camp;
            celda_R["A2:F2"].Font.Size = 16;
            celda_R["A2:F2"].Font.Bold = true;

            celda_R["A3:F3"].Merge();
            celda_R["A3:F3"].Value = "Rango fechas: " + f1 + " => " + f2;
            celda_R["A3:F3"].Font.Size = 12;
            celda_R["A3:F3"].Font.Bold = true;

            Hoja_R.Name = "Rpt Detallado";

            Fila_Inicio++;

            //  *********************** tabla capacitaciones
            celda_R[Fila_Inicio, 1].ColumnWidth = 10;
            celda_R[Fila_Inicio, 1].Value = "";

            celda_R[Fila_Inicio, 2].ColumnWidth = 15;
            celda_R[Fila_Inicio, 2].Value = "SEDE";

            celda_R[Fila_Inicio, 3].ColumnWidth = 15;
            celda_R[Fila_Inicio, 3].Value = "CAMPAÑA";

            celda_R[Fila_Inicio, 4].ColumnWidth = 15;
            celda_R[Fila_Inicio, 4].Value = "USUARIO";

            celda_R[Fila_Inicio, 5].ColumnWidth = 10;
            celda_R[Fila_Inicio, 5].Value = "USER LOGIN";

            celda_R[Fila_Inicio, 6].ColumnWidth = 55;
            celda_R[Fila_Inicio, 6].Value = "SEGUIMIENTO DE TIPIFICACION DE DESCARTE";

			 celda_R[Fila_Inicio, 7].ColumnWidth = 25;
            celda_R[Fila_Inicio, 7].Value = "DESCARTE PROCESO FINAL";

            celda_R[Fila_Inicio, 8].ColumnWidth = 15;
            celda_R[Fila_Inicio, 8].Value = "HORA INICIO";

            celda_R[Fila_Inicio, 9].ColumnWidth = 15;
            celda_R[Fila_Inicio, 9].Value = "DURACION";

            celda_R[Fila_Inicio, 10].ColumnWidth = 15;
            celda_R[Fila_Inicio, 10].Value = "FEC. REGISTRO";



            Fila_Inicio += 1;
            fila = 1;
            num = 1;

            foreach (DataRow row in ds1.Tables[0].Rows)
            {
                celda_R[Fila_Inicio, num].HorizontalAlignment = HAlign.Left;
                celda_R[Fila_Inicio, num].Font.Name = "Calibri";
                celda_R[Fila_Inicio, num].Font.Size = 8;
                celda_R[Fila_Inicio, num].Value = fila;
                num += 1;
                foreach (DataColumn colum in ds1.Tables[0].Columns)
                {

                    celda_R[Fila_Inicio, num].HorizontalAlignment = HAlign.Left;
                    celda_R[Fila_Inicio, num].Font.Name = "Calibri";
                    celda_R[Fila_Inicio, num].Font.Size = 8;
                    celda_R[Fila_Inicio, num].Value = row[colum].ToString();

                    num++;
                }
                num = 1;
                Fila_Inicio++;
                fila += 1;
            }

            num = 9;
            for (Int32 j = 5; j < Fila_Inicio; j++)
            {
                for (Int32 x = 1; x <= num + 1; x++)
                {
                    celda_R[j, x].Borders[BordersIndex.EdgeRight].LineStyle = LineStyle.Continuous;
                    celda_R[j, x].Borders[BordersIndex.EdgeRight].Color = Color.FromArgb(200, 200, 200);
                    celda_R[j, x].Borders[BordersIndex.EdgeTop].LineStyle = LineStyle.Continuous;
                    celda_R[j, x].Borders[BordersIndex.EdgeTop].Color = Color.FromArgb(200, 200, 200);
                    celda_R[j, x].Borders[BordersIndex.EdgeBottom].LineStyle = LineStyle.Continuous;
                    celda_R[j, x].Borders[BordersIndex.EdgeBottom].Color = Color.FromArgb(200, 200, 200);
                    celda_R[j, x].Borders[BordersIndex.EdgeLeft].LineStyle = LineStyle.Continuous;
                    celda_R[j, x].Borders[BordersIndex.EdgeLeft].Color = Color.FromArgb(200, 200, 200);

                }
            }



            celda_R[5, 1, 5, num + 1].Font.Bold = true;
            celda_R[5, 1, 5, num + 1].Interior.Color = Color.FromArgb(56, 96, 146);
            celda_R[5, 1, 5, num + 1].Font.Color = Color.FromArgb(255, 255, 255);
            celda_R[5, 1, 5, num + 1].Font.Name = "Arial";
            celda_R[5, 1, 5, num + 1].HorizontalAlignment = HAlign.Center;
            celda_R[5, 1, 5, num + 1].VerticalAlignment = VAlign.Center;
            celda_R[5, 1, 5, num + 1].Font.Size = 9;

            exclName = "Reporte_" + string.Format("{0:yyyy_MM_dd}", DateTime.Now) + ".xls";
            Libro.SaveAs(HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["path_xls"]) + exclName, SpreadsheetGear.FileFormat.Excel8);
            return ConfigurationManager.AppSettings["path_xls"].Replace("~/", "") + exclName;
        }
        else
        {
            return null;
        }
    }
}
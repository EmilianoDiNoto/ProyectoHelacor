using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApplication.ApiAdo.Models
{
    public class ProductionOrders
    {
        #region Atributo


        // Conexión a Base de Datos EMI
        //string conectionString = @"Data Source=EMI-PC\EMI_PC_SERVER;Initial Catalog=GridoTechAdvance ; Integrated Security= True ";

        // Conexión a Base de Datos EMMA
        string conectionString = @"Data Source=LAPTOP-OJ158TC8 ;Initial Catalog=GridoTech ; Integrated Security= True ";

        // Conexión a Base de Datos DIANA
        //string conectionString = @"Data Source=;Initial Catalog=GridoTechAdvance ; Integrated Security= True ";

        // Conexión a Base de Datos SOFIA
        //string conectionString = @"Data Source=;Initial Catalog=GridoTechAdvance ; Integrated Security= True ";

        #endregion

        #region Propiedades

        public int OrderID { get; set; }


        public string ProductName { get; set; }

        public DateTime Date { get; set; }

        public string Status { get; set; }

        
        #endregion

        #region Metodos

        public DataTable SelectAll()
        {
            string sqlSentencia = "SP_GetAllMovMat";

            SqlConnection sqlCnn = new SqlConnection();
            sqlCnn.ConnectionString = conectionString;

            sqlCnn.Open();

            SqlCommand sqlCom = new SqlCommand(sqlSentencia, sqlCnn);
            sqlCom.CommandType = CommandType.StoredProcedure;

            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = sqlCom;
            da.Fill(ds);

            sqlCnn.Close();

            return ds.Tables[0];
        }

        public void Insert()
        {
            string sqlSentencia = "SP_PostMovMat";

            SqlConnection sqlCnn = new SqlConnection();
            sqlCnn.ConnectionString = conectionString;

            SqlCommand sqlCom = new SqlCommand(sqlSentencia, sqlCnn);
            sqlCom.CommandType = CommandType.StoredProcedure;
            sqlCom.Parameters.Add("@idMaterial", SqlDbType.NVarChar).Value = idMaterial;

            sqlCom.Parameters.Add("@EstadoAnterior", SqlDbType.NVarChar).Value = estado_anterior;
            sqlCom.Parameters.Add("@EstadoNuevo", SqlDbType.NVarChar).Value = estado_nuevo;
            sqlCom.Parameters.Add("@cantidad", SqlDbType.Int).Value = cantidad;
            sqlCom.Parameters.Add("@tipoMovimiento", SqlDbType.NVarChar).Value = tipo_movimiento;
            sqlCom.Parameters.Add("@usuario", SqlDbType.NVarChar).Value = usuario;
            sqlCom.Parameters.Add("@comentarios", SqlDbType.NVarChar).Value = comentario;

            sqlCnn.Open();

            var res = sqlCom.ExecuteNonQuery();

            sqlCnn.Close();

        }

        public void Update()
        {
            string sqlSentencia = "SP_PutMovMat";

            SqlConnection sqlCnn = new SqlConnection();
            sqlCnn.ConnectionString = conectionString;

            SqlCommand sqlCom = new SqlCommand(sqlSentencia, sqlCnn);
            sqlCom.CommandType = CommandType.StoredProcedure;

            sqlCom.Parameters.Add("@idMovimiento", SqlDbType.Int).Value = id_movimiento;
            sqlCom.Parameters.Add("@idMaterial", SqlDbType.NVarChar).Value = idMaterial;
            sqlCom.Parameters.Add("@EstadoAnterior", SqlDbType.NVarChar).Value = estado_anterior;
            sqlCom.Parameters.Add("@EstadoNuevo", SqlDbType.NVarChar).Value = estado_nuevo;
            sqlCom.Parameters.Add("@cantidad", SqlDbType.Int).Value = cantidad;
            sqlCom.Parameters.Add("@tipoMovimiento", SqlDbType.NVarChar).Value = tipo_movimiento;
            sqlCom.Parameters.Add("@usuario", SqlDbType.NVarChar).Value = usuario;
            sqlCom.Parameters.Add("@comentarios", SqlDbType.NVarChar).Value = comentario;


            sqlCnn.Open();

            var res = sqlCom.ExecuteNonQuery();

            sqlCnn.Close();

        }



        #endregion





    }
}
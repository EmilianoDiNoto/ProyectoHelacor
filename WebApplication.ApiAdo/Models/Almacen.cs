using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApplication.ApiAdo.Models
{
    public class Almacen
    {

        #region Atributo


        // Conexión a Base de Datos EMI
        //string conectionString = @"Data Source=EMI-PC\EMI_PC_SERVER;Initial Catalog=GridoTechAdvance ; Integrated Security= True ";

        // Conexión a Base de Datos EMMA
        string conectionString = @"Data Source=LAPTOP-OJ158TC8 ;Initial Catalog=GridoTechAdvance1 ; Integrated Security= True ";

        // Conexión a Base de Datos DIANA
        string conectionString = @"Data Source=DIANA\SQLEXPRESS01;Initial Catalog=GridoTech ; Integrated Security= True ";

        // Conexión a Base de Datos SOFIA
        //string conectionString = @"Data Source=;Initial Catalog=GridoTechAdvance ; Integrated Security= True ";

        #endregion


        #region Propiedades
        public int idMaterial { get; set; }

        public string Material { get; set; }

        public decimal Stock { get; set; }

        public decimal IngMaterial { get; set; }

        public decimal DevMaterial { get; set; }

       
        #endregion


        #region Metodos
        public DataTable SelectAll()
        {
            string sqlSentencia = "SP_AlmacenGetAll";


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

        public DataTable SelectById(int idMaterial)
        {
            string sqlSentencia = "SP_GetAlmacenPorId";

            SqlConnection sqlCnn = new SqlConnection();
            sqlCnn.ConnectionString = conectionString;

            SqlCommand sqlCom = new SqlCommand(sqlSentencia, sqlCnn);
            sqlCom.CommandType = CommandType.StoredProcedure;
            sqlCom.Parameters.AddWithValue("@Id", idMaterial);

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = sqlCom;
            da.Fill(ds);

            sqlCnn.Close();

            return ds.Tables[0];
        }

        public void Modificar()
        {
            string sqlSentencia = "SP_AlmacenIng";


            SqlConnection sqlCnn = new SqlConnection();
            sqlCnn.ConnectionString = conectionString;



            SqlCommand sqlCom = new SqlCommand(sqlSentencia, sqlCnn);
            sqlCom.CommandType = CommandType.StoredProcedure;
            sqlCom.Parameters.Add("@idMaterial", SqlDbType.Int).Value = idMaterial;
            sqlCom.Parameters.Add("@IngMaterial", SqlDbType.Decimal).Value = IngMaterial;
           


            sqlCnn.Open();


            var res = sqlCom.ExecuteNonQuery();


            sqlCnn.Close();

        }

        public void ModificarDev()
        {
            string sqlSentencia = "SP_AlmacenDev";


            SqlConnection sqlCnn = new SqlConnection();
            sqlCnn.ConnectionString = conectionString;



            SqlCommand sqlCom = new SqlCommand(sqlSentencia, sqlCnn);
            sqlCom.CommandType = CommandType.StoredProcedure;
            sqlCom.Parameters.Add("@idMaterial", SqlDbType.Int).Value = idMaterial;
            sqlCom.Parameters.Add("@DevMaterial", SqlDbType.Decimal).Value = DevMaterial;



            sqlCnn.Open();


            var res = sqlCom.ExecuteNonQuery();


            sqlCnn.Close();

        }


       




        #endregion




    }
}
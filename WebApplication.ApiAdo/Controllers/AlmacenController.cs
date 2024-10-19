using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication.ApiAdo.Models;
using Newtonsoft.Json;

namespace WebApplication.ApiAdo.Controllers
{
    public class AlmacenController : ApiController
    {
        // GET: api/Almacen
        [HttpGet]
        public List<Almacen> ListarTodos()
        {
            Almacen oAlmacen = new Almacen();
            var dt = oAlmacen.SelectAll();

            var ListaJsom = JsonConvert.SerializeObject(dt);

            var Lista = JsonConvert.DeserializeObject<List<Almacen>>(ListaJsom);

            return Lista;


        }

        [HttpGet]
        public IHttpActionResult GetAlumnoPorId(int id)
        {
            Almacen oAlmacen = new Almacen();
            var dt = oAlmacen.SelectById(id);

            if (dt.Rows.Count == 0)
            {
                return NotFound();
            }

            var almacen = new Almacen
            {
                idMaterial = Convert.ToInt32(dt.Rows[0]["idMaterial"]),
                Material = dt.Rows[0]["Material"].ToString(),
                Stock = Convert.ToDecimal(dt.Rows[0]["Stock"])
            };

            return Ok(almacen);
        }




        // PUT: api/Mantenimiento/5

        [HttpPut]
        public void Put(int id, [FromBody] Almacen value)
        {
            Almacen oAlmacen = new Almacen();
            oAlmacen.idMaterial = id;
            oAlmacen.IngMaterial = value.IngMaterial;

            oAlmacen.Modificar();



        }


        // PUT: api/Mantenimiento/5

        [HttpPut]
        public void PutDev(int id, [FromBody] Almacen value)
        {
            Almacen oAlmacen = new Almacen();
            oAlmacen.idMaterial = id;
            oAlmacen.DevMaterial = value.DevMaterial;

            oAlmacen.ModificarDev();

        }

    }
}

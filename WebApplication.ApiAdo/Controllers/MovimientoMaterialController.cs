using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using WebApplication.ApiAdo.Models;

namespace WebApplication.ApiAdo.Controllers
{
    public class MovimientoMaterialController : ApiController
    {
        // GET: api/MovimientoMaterial
        public DataTable Get()
        {
            MovimientoMaterial omovimientoMaterial = new MovimientoMaterial();

            var dt = omovimientoMaterial.SelectAll();

            return dt;

        }

        // GET: api/MovimientoMaterial/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/MovimientoMaterial
        public void Post([FromBody] MovimientoMaterial value)
        {
            MovimientoMaterial omovimientoMaterial = new MovimientoMaterial();
            omovimientoMaterial.idMaterial = value.idMaterial;          
            omovimientoMaterial.estado_anterior = value.estado_anterior;
            omovimientoMaterial.estado_nuevo = value.estado_nuevo;
            omovimientoMaterial.cantidad = value.cantidad;
            omovimientoMaterial.tipo_movimiento = value.tipo_movimiento;
            omovimientoMaterial.usuario = value.usuario;
            omovimientoMaterial.comentario = value.comentario;

            omovimientoMaterial.Insert();
        }

        // PUT: api/MovimientoMaterial/5
        public void Put(int id, [FromBody] MovimientoMaterial value)
        {
            MovimientoMaterial omovimientoMaterial = new MovimientoMaterial();
            omovimientoMaterial.id_movimiento = id;
            omovimientoMaterial.idMaterial = value.idMaterial;
            omovimientoMaterial.estado_anterior = value.estado_anterior;
            omovimientoMaterial.estado_nuevo = value.estado_nuevo;
            omovimientoMaterial.cantidad = value.cantidad;
            omovimientoMaterial.tipo_movimiento = value.tipo_movimiento;
            omovimientoMaterial.usuario = value.usuario;
            omovimientoMaterial.comentario = value.comentario;

            omovimientoMaterial.Update();
        }



        // DELETE: api/MovimientoMaterial/5
        public void Delete(int id)
        {
        }
    }
}

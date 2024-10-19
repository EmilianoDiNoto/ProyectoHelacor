using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication.ApiAdo.Models;

namespace WebApplication.ApiAdo.Controllers
{
    public class MaterialController : ApiController
    {
        // GET: api/Material
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Material/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Material
        public void Post([FromBody] Material value)
        {

           

        }

        // PUT: api/Material/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Material/5
        public void Delete(int id)
        {
        }
    }
}

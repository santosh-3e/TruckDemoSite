using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using TrafficVisualization.Helpers;
using TrafficVisualization.DbContexts;

namespace TrafficVisualization
{
    public class TruckDetailsController : ApiController
    {
        private TrafficVisualizationContext db = new TrafficVisualizationContext();

        // GET api/TruckDetails
        public IHttpActionResult GetTruckDetails()
        {

            var truckdetails = from item in db.TruckDetails
                select new
                {
                    timestamp = item.TimeStamp,
                    driver_id=item.DriverId,
                    route_id=item.RouteId,
                    route_name=item.RouteName,
                    truck_id=item.TruckId,
                    longitude=item.Longitude,
                    latitude=item.Latitude,
                    violation=item.Violation,
                    driver_name=item.DriverId,
                    total_violations=item.TotalViolation
                };

            return Json(truckdetails.ToList());
            //return db.TruckDetails;
        }

        // GET api/TruckDetails/5
        [ResponseType(typeof(TruckDetail))]
        public IHttpActionResult GetTruckDetail(int id)
        {
            TruckDetail truckdetail = db.TruckDetails.Find(id);
            if (truckdetail == null)
            {
                return NotFound();
            }

            return Ok(truckdetail);
        }

        // PUT api/TruckDetails/5
        public IHttpActionResult PutTruckDetail(int id, TruckDetail truckdetail)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != truckdetail.Id)
            {
                return BadRequest();
            }

            db.Entry(truckdetail).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TruckDetailExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST api/TruckDetails
        [ResponseType(typeof(TruckDetail))]
        public IHttpActionResult PostTruckDetail(TruckDetail truckdetail)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.TruckDetails.Add(truckdetail);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = truckdetail.Id }, truckdetail);
        }

        // DELETE api/TruckDetails/5
        [ResponseType(typeof(TruckDetail))]
        public IHttpActionResult DeleteTruckDetail(int id)
        {
            TruckDetail truckdetail = db.TruckDetails.Find(id);
            if (truckdetail == null)
            {
                return NotFound();
            }

            db.TruckDetails.Remove(truckdetail);
            db.SaveChanges();

            return Ok(truckdetail);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool TruckDetailExists(int id)
        {
            return db.TruckDetails.Count(e => e.Id == id) > 0;
        }
    }
}
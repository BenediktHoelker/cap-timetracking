const cds = require("@sap/cds");
const { Leaves, Travels } = cds.entities;

module.exports = srv => {
  srv.after(["CREATE", "UPDATE"], "Employees", _updateDependents);
};

async function _updateDependents({ leaves, travels }) {
  _updateLeaves(leaves);
  _updateTravels(travels);
}

/** Update daysOfLeave depending on dateFrom and dateTo **/
async function _updateLeaves(leaves) {
  if(!Array.isArray(leaves)){
    return;
  }

  return leaves.map(leave => {
    const oneDay = 24 * 60 * 60 * 1000;
    const firstDate = new Date(leave.dateFrom);
    const secondDate = new Date(leave.dateTo);
    const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));

    UPDATE(Leaves)
      .set({ daysOfLeave: diffDays })
      .where({ ID: leave.ID });
  });
}

/** Update daysOfLeave depending on dateFrom and dateTo **/
async function _updateTravels(travels) {
  if(!Array.isArray(travels)){
    return;
  }

  return travels.map(travel => {
    const oneDay = 24 * 60 * 60 * 1000;
    const firstDate = new Date(travel.dateFrom);
    const secondDate = new Date(travel.dateTo);
    const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));

    UPDATE(Travels)
      .set({ daysOfTravel: diffDays })
      .where({ ID: travel.ID });
  });
}

// https://github.com/gregorwolf/cloud-cap-samples/blob/master/packages/reviews-service/srv/reviews-service.js

// Emit an event to inform subscribers about new avg ratings for reviewed subjects
// ( Note: req.on.succeeded ensures we only do that if there's no error )
// this.after(["CREATE", "UPDATE", "DELETE"], "Reviews", async (_, req) => {
//   const { subject } = req.data;
//   const { rating } = await cds.transaction(req).run(
//     SELECT.one(["round(avg(rating),2) as rating"])
//       .from(Reviews)
//       .where({ subject })
//   );
//   req.on("succeeded", () => {
//     console.log("< emitting:", "reviewed", { subject, rating });
//     this.emit("reviewed", { subject, rating });
//   });
// });

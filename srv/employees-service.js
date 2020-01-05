const cds = require("@sap/cds");
const { Leaves, Travels } = cds.entities;

module.exports = srv => {
  srv.before(["CREATE", "UPDATE"], "Employees", _updateDependents);
};

async function _updateDependents(req) {
  _updateLeaves(req);
  // _updateTravels(req);
}

/** Update daysOfLeave depending on dateFrom and dateTo **/
async function _updateLeaves(req) {
  const { leaves } = req.data;

  return cds.transaction(req).run(() => {
    leaves.map(leave => {
      const oneDay = 24 * 60 * 60 * 1000;
      const firstDate = new Date(leave.dateFrom);
      const secondDate = new Date(leave.dateTo);
      const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));
      UPDATE(Leaves)
        .set({ daysOfLeave: diffDays })
        .where({ ID: leave.ID });
    });
  });
}

/** Update daysOfLeave depending on dateFrom and dateTo **/
async function _updateTravels(req) {
  const { travels } = req.data;

  return cds.transaction(req).run(() => {
    travels.map(travel => {
      const oneDay = 24 * 60 * 60 * 1000;
      const firstDate = new Date(travel.dateFrom);
      const secondDate = new Date(travel.dateTo);
      const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));
      UPDATE(Travels)
        .set({ daysOfTravel: diffDays })
        .where({ ID: travel.ID });
    });
  });
}

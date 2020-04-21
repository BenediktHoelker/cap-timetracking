const cds = require("@sap/cds");

module.exports = (srv) => {
  srv.after(
    "READ",
    "Leaves",
    (each) => (each.daysOfLeave = getDaysBetween(each))
  );

  srv.after(
    "READ",
    "Travels",
    (each) => (each.daysOfTravel = getDaysBetween(each))
  );
};

function getDaysBetween({ dateFrom, dateTo }) {
  const oneDay = 24 * 60 * 60 * 1000;
  const firstDate = new Date(dateFrom);
  const secondDate = new Date(dateTo);
  const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));

  return Number.isInteger(diffDays) ? diffDays : 0;
}

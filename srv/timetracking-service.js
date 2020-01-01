const cds = require("@sap/cds");
const { Records } = cds.entities;

module.exports = srv => {
  srv.before("DELETE", "Records", req => {
    if (req.data.status !== "INITIAL") {
      req.error("409", "The record status is not initial.");
    }
  });

  srv.before("CREATE", "Invoices", _updateRecords);
};

/** Reduce stock of ordered books if available stock suffices */
async function _updateRecords(req) {
  const { items } = req.data;
  return cds.transaction(req).run(() =>
    items.map(item =>
      UPDATE(Records)
        .set({ status: "BILLED" })
        .where({ ID: item.record_ID })
    )
  );
}

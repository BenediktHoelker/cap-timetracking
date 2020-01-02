const cds = require("@sap/cds");
const { Records, Projects } = cds.entities;

module.exports = srv => {
  srv.on(["CREATE", "PATCH", "UPDATE"], "Projects", req => {
    console.log("Hi");
    const oNewEntry = req.data;
    delete oNewEntry.totalTime;
    INSERT.into(Projects).entries(oNewEntry);
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

module.exports = srv => {
  const { Records } = cds.entities("my.timetracking.Records");

  srv.before("DELETE", "Records", req => {
    if (req.data.status !== "INITIAL") {
      req.error("409", "The record status is not initial.");
    }
  });

  srv.before("CREATE", "Invoices", async req => {
    const tx = cds.transaction(req);
    const invoice = req.data;

    console.log(invoice);

    return cds.read(Records);
  });
};

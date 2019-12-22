module.exports = srv => {
  srv.before("CREATE", "Projects", async ({ data, target, query }) => {
    console.log(data);
    console.log(target);
    console.log(query);
  });
  srv.before("CREATE", "Employees", async ({ data, target, query }) => {
    console.log(data);
    console.log(target);
    console.log(query);
  });
};

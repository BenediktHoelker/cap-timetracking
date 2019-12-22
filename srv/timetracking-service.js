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

  srv.on("UPDATE", "ProjectMembers", async ({ data }) => {
    const member = {
      project_ID: data.projectID,
      employee_ID: data.employeeID
    };

    const members = await SELECT.from(
      "my.timetracking.EmployeesToProjects"
    ).where(member);

    console.log(members);
    return { ...member, isMember: members.length > 0 };
  });

  srv.after("UPDATE", "ProjectMembers", async member => {
    console.log(member);

    if (member.isMember) {
      delete member.isMember;
      const del = await DELETE.from(
        "my.timetracking.EmployeesToProjects"
      ).where(member);
    } else {
      delete member.isMember;
      const ins = await INSERT.into(
        "my.timetracking.EmployeesToProjects"
      ).entries(member);
    }
  });
};

using my.timetracking from '../db/schema';

service EmployeesService {
    entity Employees           as
        select from timetracking.Employees {
            key ID,
                name,
                count(recordsView.ID)               as recordsCount : Integer,
                sum(recordsView.billingTime)        as billingTime :  Double,
                sum(recordsView.billingTime) / 1440 as bonus :        Double,
                projects,
                records
        }
        group by
            ID,
            name;
}

// Temporary workaround -> https://github.wdf.sap.corp/cap/issues/issues/3121
extend service EmployeesService with {
  entity Records as select from timetracking.Records;
  entity Projects as select from timetracking.Projects;
  entity EmployeesToProjects as select from timetracking.EmployeesToProjects;
}
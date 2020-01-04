using my.timetracking from '../db/schema';

service EmployeesService {
    entity Employees         as
        select from timetracking.Employees {
            key ID,
                name,
                count(records.ID)        as recordsCount : Integer,
                sum(records.time)        as billingTime :  Double,
                sum(records.time) / 1440 as bonus :        Double,
                projects,
                records
        }
        group by
            ID,
            name;

    entity Records           as select from timetracking.Records;
    entity Projects          as select from timetracking.Projects;
    entity EmployeesProjects as select from timetracking.EmployeesToProjects;
}
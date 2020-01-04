using {my.timetracking as my} from '../db/schema';

service EmployeesService {
    @odata.draft.enabled
    entity Employees         as
        select from my.Employees {
            * ,
            count(records.ID)                    as recordsCount : Integer,
            round(sum(records.time), 2)          as billingTime :  Double,
            round(sum((records.time) / 1440), 2) as bonus :        Double,
            projects : redirected to EmployeesProjects,
            records
        }
        group by
                       ID,
                       name;

    entity Records           as select from my.Records;
    entity Projects          as select from my.Projects;
    entity EmployeesProjects as select from my.EmployeesToProjects;
}
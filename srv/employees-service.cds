using {my.timetracking as my} from '../db/schema';

service EmployeesService {
    @odata.draft.enabled
    entity Employees         as
        select from my.Employees {
            * ,
            count(records.ID)                    as recordsCount : Integer,
            0                                    as daysOfTravel : Integer,
            0                                    as daysOfLeave :  Integer,
            round(sum(records.time), 2)          as billingTime :  Double,
            round(sum((records.time) / 1440), 2) as bonus :        Double,
            projects : redirected to EmployeesProjects,
            records
        }
        group by
                       Employees.ID,
                       Employees.billingTime,
                       Employees.createdAt,
                       Employees.createdBy,
                       Employees.modifiedAt,
                       Employees.modifiedBy,
                       Employees.name;

    entity Records           as select from my.Records;

    entity Projects          as
        select from my.Projects {
            * ,
            count(records.ID)           as recordsCount : Integer,
            round(sum(records.time), 2) as totalTime :    Double,
            records,
            members
        }
        group by
            Projects.ID,
            Projects.title,
            Projects.description,
            Projects.createdAt,
            Projects.createdBy,
            Projects.modifiedAt,
            Projects.modifiedBy,
            Projects.billingFactor,
            Projects.customer;

    entity Travels           as select from my.Travels;
    entity Leaves            as select from my.Leaves;
    entity EmployeesProjects as select from my.EmployeesToProjects;
}
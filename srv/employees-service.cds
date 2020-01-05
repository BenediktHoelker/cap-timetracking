using {my.timetracking as my} from '../db/schema';

service EmployeesService {
    @odata.draft.enabled
    entity Employees         as
        select from my.Employees {
            * ,
            count(records.ID)                    as recordsCount : Integer,
            sum(travels.daysOfTravel)            as daysOfTravel : Integer,
            sum(leaves.daysOfLeave)              as daysOfLeave :  Integer,
            round(sum(records.time), 2)          as billingTime :  Double,
            round(sum((records.time) / 1440), 2) as bonus :        Double,
            projects : redirected to EmployeesProjects,
            records
        }
        group by
                       ID,
                       name;

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
            ID,
            title,
            description,
            createdAt,
            createdBy,
            billingFactor;

    entity Travels           as select from my.Travels;
    entity Leaves            as select from my.Leaves;
    entity EmployeesProjects as select from my.EmployeesToProjects;
}
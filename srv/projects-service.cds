using {my.timetracking as my} from '../db/schema';

service ProjectsService {
    entity Customers      as select from my.Customers;
    entity Employees      as select from my.Employees;
    entity Records        as select from my.Records;

    @odata.draft.enabled
    entity Projects       as
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

    entity ProjectMembers as select from my.EmployeesToProjects;
}
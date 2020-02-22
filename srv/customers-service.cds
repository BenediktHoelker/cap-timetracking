using {my.timetracking as my} from '../db/schema';

service CustomersService {
    @odata.draft.enabled
    entity Customers as
        select from my.Customers {
            * ,
            count(projects.ID) as projectsCount : Integer
        }
        group by
            Customers.ID,
            Customers.createdAt,
            Customers.createdBy,
            Customers.modifiedAt,
            Customers.modifiedBy,
            Customers.name;

    entity Projects  as
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

    entity Records   as select from my.Records;
}
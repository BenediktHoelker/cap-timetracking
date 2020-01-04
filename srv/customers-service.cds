using {my.timetracking as my} from '../db/schema';

service CustomersService {
    @odata.draft.enabled
    entity Customers as
        select from my.Customers {
            * ,
            count(projects.ID) as projectsCount : Integer
        }
        group by
            ID,
            name;

    entity Projects  as
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
            billingFactor,
            customer;

    entity Records   as select from my.Records;
}
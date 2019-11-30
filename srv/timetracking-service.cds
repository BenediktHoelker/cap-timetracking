using my.timetracking from '../db/schema';

service TimetrackingService {
    entity Records   as select from timetracking.Records;

    entity Projects  as
        select from timetracking.Projects {
            key ID,
                title,
                description,
                billingFactor,
                sum(records.time) as totalTime : Decimal(13, 2)
        }
        group by
            ID,
            title,
            description,
            billingFactor;

    entity Employees as
        select from timetracking.Employees {
            key ID,
                name,
                count(recordsView.ID)               as recordsCount : Integer,
                sum(recordsView.billingTime)        as billingTime :  Double,
                sum(recordsView.billingTime) / 1440 as bonus :        Double,
                records
        }
        group by
            ID,
            name;

    entity Packages  as projection on timetracking.Packages;
}
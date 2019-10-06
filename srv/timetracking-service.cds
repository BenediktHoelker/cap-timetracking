using my.timetracking from '../db/schema';

service TimetrackingService {
    entity Records      as projection on timetracking.Records;
    entity Projects     as projection on timetracking.Projects;

    entity EmployeesAgg as
        select from timetracking.Employees {
            key ID,
                name,
                count(records.ID)                                     as recordsCount :     Integer,
                sum(records.duration * records.project.billingFactor) as billableDuration : Decimal(13, 2),
                records
        }
        group by
            ID,
            name;

    entity Employees    as
        select from EmployeesAgg {
            key ID,
                name,
                recordsCount,
                billableDuration,
                billableDuration / 1440.0 - 1 as bonus : Double
        };

    entity Packages     as projection on timetracking.Packages;
}
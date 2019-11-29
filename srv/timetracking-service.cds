using my.timetracking from '../db/schema';

service TimetrackingService {
    entity Records      as select from timetracking.Records;
    entity Projects     as projection on timetracking.Projects;

    entity Employees as
        select from timetracking.Employees {
            key ID,
                name,
                count(recordsView.ID) as recordsCount :     Integer,
                sum(recordsView.billableDuration) as billableDuration : Double,
                sum(recordsView.billableDuration) / 1440 as bonus : Double,
                records
        }
        group by
            ID,
            name;
            
    entity Packages     as projection on timetracking.Packages;
}
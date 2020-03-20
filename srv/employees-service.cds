using {TimetrackingService as my} from './timetracking-service';

service EmployeesService @(requires : 'admin') {
    @odata.draft.enabled
    entity Employees      as projection on my.Employees;

    entity Projects       as projection on my.Projects;
    entity Records        as projection on my.Records;
    entity Travels        as projection on my.Travels;
    entity Leaves         as projection on my.Leaves;
    entity ProjectMembers as projection on my.ProjectMembers;
}

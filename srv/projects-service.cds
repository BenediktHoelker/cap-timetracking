using {my.timetracking as my} from '../db/schema';

service ProjectsService {
    entity Customers      as select from my.Customers;
    entity Employees      as select from my.Employees;
    entity Records        as select from my.Records;

    @odata.draft.enabled
    entity Projects       as select from my.Projects;

    entity ProjectMembers as select from my.EmployeesToProjects;
}
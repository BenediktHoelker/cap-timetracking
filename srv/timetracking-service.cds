using timetracking as my from '../db/schema';

service Timetracking {
    entity Records as projection on  my.Records;
    entity Projects as projection on my.Projects;
    entity Employees as projection on my.Employees;
    entity Packages as projection on my.Packages;
}
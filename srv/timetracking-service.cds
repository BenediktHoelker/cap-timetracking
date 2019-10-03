using iot.timetracking from '../db/schema';

service Timetracking {
    entity Records as projection on timetracking.Records;
    entity Projects as projection on timetracking.Projects;
    entity Employees as projection on timetracking.Employees;
    entity Packages as projection on timetracking.Packages;
}
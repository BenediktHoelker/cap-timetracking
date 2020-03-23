using {my.timetracking as my} from '../db/schema';

// service TimetrackingService @(requires:'authenticated-user') {
service TimetrackingService {
    entity Records        as projection on my.Records {
        key ID, createdAt, createdBy, date, description, modifiedAt, modifiedBy, status, time, timeUnit, title, projectMember
    };

    entity Projects       as
        select from my.Projects {
            key ID,
                title,
                description,
                billingFactor,
                count(
                    members.records.ID
                ) as recordsCount : Integer,
                sum(
                    members.records.time
                ) as totalTime    : Decimal(13, 2),
                createdAt,
                createdBy,
                modifiedAt,
                modifiedBy,
                customer,
                members           : redirected to ProjectMembers
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

    entity Employees      as
        select from my.Employees {
            key ID,
                createdAt,
                createdBy,
                modifiedAt,
                modifiedBy,
                name,
                daysOfLeave,
                daysOfTravel,
                round(
                    sum(
                        projects.records.time
                    ), 2
                ) as billingTime  : Double,
                count(
                    projects.records.ID
                ) as recordsCount : Integer,
                round(
                    sum(
                        (
                            projects.records.time
                        ) / 1440
                    ), 2
                ) as bonus        : Double,
                projects          : redirected to ProjectMembers,
        }
        group by
            Employees.ID,
            Employees.billingTime,
            Employees.createdAt,
            Employees.createdBy,
            Employees.modifiedAt,
            Employees.modifiedBy,
            Employees.name;

    entity Packages       as projection on my.Packages;

    entity Customers      as
        select from my.Customers {
            *,
            count(
                projects.ID
            ) as projectsCount : Integer,
            invoices           : redirected to Invoices
        }
        group by
            Customers.ID,
            Customers.createdAt,
            Customers.createdBy,
            Customers.modifiedAt,
            Customers.modifiedBy,
            Customers.name;


    entity Invoices       as projection on my.Invoices;

    entity InvoiceItems   as projection on my.InvoiceItems {
        * , invoice : redirected to Invoices
    };

    entity Leaves         as projection on my.Leaves;
    entity Travels        as projection on my.Travels;
    entity InvoicesView   as projection on my.InvoicesView;

    entity ProjectMembers as
        select from my.EmployeesToProjects {
            *,
            project.title,
            project.title || ' - ' || employee.name as projectMember : String,
            employee.username,
            employee.name
        };
}

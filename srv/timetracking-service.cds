using {my.timetracking as my} from '../db/schema';

// service TimetrackingService @(requires:'authenticated-user') {
service TimetrackingService {
    @odata.draft.enabled
    entity Records           as
        select from my.Records {
            *,
            employee : redirected to Employees,
            project  : redirected to EmployeesProjects
        };

    entity Projects          as
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

    entity Employees         as
        select from my.Employees {
            *,
            count(
                records.ID
            ) as recordsCount : Integer,
            0 as daysOfTravel : Integer,
            0 as daysOfLeave  : Integer,
            round(
                sum(
                    records.time
                ), 2
            ) as billingTime  : Double,
            round(
                sum(
                    (
                        records.time
                    ) / 1440
                ), 2
            ) as bonus        : Double,
            projects          : redirected to EmployeesProjects,
            records
        }
        group by
            Employees.ID,
            Employees.billingTime,
            Employees.createdAt,
            Employees.createdBy,
            Employees.modifiedAt,
            Employees.modifiedBy,
            Employees.name;

    entity Packages          as projection on my.Packages;

    entity Customers         as
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


    entity Invoices          as projection on my.Invoices;

    entity InvoiceItems      as projection on my.InvoiceItems {
        * , invoice : redirected to Invoices
    };

    entity Leaves            as projection on my.Leaves;
    entity Travels           as projection on my.Travels;
    entity InvoicesView      as projection on my.InvoicesView;
    entity ProjectMembers    as projection on my.EmployeesToProjects;
    entity EmployeesToProjects    as projection on my.EmployeesToProjects;

    entity EmployeesProjects as
        select from my.EmployeesToProjects {
            *,
            project.title as title
        };
}

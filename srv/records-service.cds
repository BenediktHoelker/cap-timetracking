using {my.timetracking as my} from '../db/schema';

service RecordsService @(requires : 'admin') {
    @odata.draft.enabled
    entity Records             as select from my.Records;

    entity Projects            as
        select from my.Projects {
            key ID,
                title,
                description,
                billingFactor,
                count(
                    records.ID
                ) as recordsCount : Integer,
                sum(
                    records.time
                ) as totalTime    : Decimal(13, 2),
                createdAt,
                createdBy,
                modifiedAt,
                modifiedBy,
                customer,
                records,
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

    entity Employees           as
        select from my.Employees {
            *,
            count(
                records.ID
            ) as recordsCount : Integer,
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
            Employees.daysOfLeave,
            Employees.daysOfTravel,
            Employees.billingTime,
            Employees.createdAt,
            Employees.createdBy,
            Employees.modifiedAt,
            Employees.modifiedBy,
            Employees.name;

    entity Packages            as projection on my.Packages;

    entity Customers           as projection on my.CustomersView {
        * , invoices : redirected to Invoices
    };

    entity Invoices            as projection on my.Invoices;

    entity InvoiceItems        as projection on my.InvoiceItems {
        * , invoice : redirected to Invoices
    };

    entity InvoicesView        as projection on my.InvoicesView;
    entity EmployeesToProjects as projection on my.EmployeesToProjects;
    entity ProjectMembers      as projection on my.EmployeesToProjects;
    entity EmployeesProjects   as projection on my.EmployeesToProjects;
}

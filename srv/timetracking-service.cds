using my.timetracking from '../db/schema';

service TimetrackingService {
    entity Records             as select from timetracking.Records;

    entity Projects            as
        select from timetracking.Projects {
            key ID,
                title,
                description,
                billingFactor,
                sum(records.time) as totalTime : Decimal(13, 2),
                createdAt,
                createdBy,
                modifiedAt,
                modifiedBy,
                customer,
                records,
                members : redirected to ProjectMembers
        }
        group by
            ID,
            title,
            customer,
            description,
            billingFactor,
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy;

    @odata.draft.enabled
    entity Employees           as
        select from timetracking.Employees {
            * ,
            count(records.ID)                    as recordsCount : Integer,
            round(sum(records.time), 2)          as billingTime :  Double,
            round(sum((records.time) / 1440), 2) as bonus :        Double,
            projects : redirected to EmployeesProjects,
            records
        }
        group by
                       ID,
                       name;

    entity Packages            as projection on timetracking.Packages;

    entity Customers           as projection on timetracking.CustomersView {
        * , invoices : redirected to Invoices
    };

    entity Invoices            as projection on timetracking.Invoices;

    entity InvoiceItems        as projection on timetracking.InvoiceItems {
        * , invoice : redirected to Invoices
    };

    entity InvoicesView        as projection on timetracking.InvoicesView;
    entity EmployeesToProjects as projection on timetracking.EmployeesToProjects;
    entity ProjectMembers      as projection on timetracking.EmployeesToProjects;
    entity EmployeesProjects   as projection on timetracking.EmployeesToProjects;
    entity RecordStatus        as projection on timetracking.RecordStatus;
}
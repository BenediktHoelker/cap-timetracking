using {my.timetracking as my} from '../db/schema';

service TimetrackingService {
    @odata.draft.enabled
    entity Records             as select from my.Records;

    entity Projects            as
        select from my.Projects {
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
            description,
            billingFactor,
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy;

    entity Employees           as
        select from my.Employees {
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
    entity RecordStatus        as projection on my.RecordStatus;
}
using my.timetracking from '../db/schema';

service TimetrackingService {
    @odata.draft.enabled
    entity Records             as select from timetracking.Records;

    @odata.draft.enabled
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
                members
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
            key ID,
                name,
                count(recordsView.ID)               as recordsCount : Integer,
                sum(recordsView.billingTime)        as billingTime :  Double,
                sum(recordsView.billingTime) / 1440 as bonus :        Double,
                projects,
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

    @odata.draft.enabled
    entity EmployeesToProjects as projection on timetracking.EmployeesToProjects;

    entity RecordStatus        as projection on timetracking.RecordStatus;

    entity RecordsView         as projection on timetracking.RecordsView {
        * , invoice : redirected to Invoices
    };
}
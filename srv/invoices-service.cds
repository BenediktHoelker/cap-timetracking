using {TimetrackingService as my} from './timetracking-service';

service InvoicesService  {
    entity Customers      as projection on my.Customers;
    entity Employees      as projection on my.Employees;
    entity Records        as projection on my.Records;
    entity Projects       as projection on my.Projects;
    entity ProjectMembers as projection on my.ProjectMembers;

    @odata.draft.enabled
    entity Invoices       as projection on my.Invoices;

    entity InvoiceItems   as projection on my.InvoiceItems;
}


annotate my.Invoices with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Invoice}',
        TypeNamePlural : '{i18n>Invoices}',
        Title          : {Value : title}
    },
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>InvoiceItems}',
        Target : 'items/@UI.LineItem'
    }
    ],
    FieldGroup #General : {Data : [
    {Value : title},
    {Value : description}
    ]},
    SelectionFields     : [
    title,
    customer_ID
    ],
    LineItem            : [
    {Value : title},
    {Value : description},
    {
        Value : customer.name,
        Label : '{i18n>Invoices.customer}'
    }
    ],
});

annotate my.Invoices with {
    ID @UI.Hidden;
    ID @(Common : {
        Text         : title,
        FieldControl : #Mandatory
    })
}

annotate my.InvoiceItems with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>InvoiceItem}',
        TypeNamePlural : '{i18n>InvoiceItems}',
        Title          : {Value : record.title}
    },
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [{Value : record_ID}]},
    LineItem            : [
    {Value : record.title},
    {Value : record.description},
    {
        Value : record.projectMember.title,
        Label : '{i18n>Invoices.project}'
    },
    {
        Value : record.projectMember.name,
        Label : '{i18n>Invoices.employee}'
    }
    ]
});

annotate my.InvoiceItems with {
    ID     @UI.Hidden;
    record @(Common : {
        Text             : record.title,
        ValueList.entity : 'Records',
        FieldControl     : #Mandatory
    })
}

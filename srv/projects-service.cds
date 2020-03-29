using {TimetrackingService as my} from './timetracking-service';

service ProjectsService {
    entity Customers      as projection on my.Customers;
    entity Employees      as projection on my.Employees;
    entity Records        as projection on my.Records;
    entity ProjectMembers as projection on my.ProjectMembers;

    @odata.draft.enabled
    entity Projects       as projection on my.Projects;
}

annotate my.Projects with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
        Title          : {Value : title},
        Description    : {Value : description}
    },
    Identification      : [{Value : title}],
    SelectionFields     : [
    title,
    description
    ],
    LineItem            : [
    {Value : title},
    {Value : description},
    {Value : customer.name},
    {Value : totalTime},
    {Value : recordsCount}
    ],
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Members}',
        Target : 'members/@UI.LineItem'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Admin}',
        Target : '@UI.FieldGroup#Admin'
    }
    ],
    FieldGroup #General : {Data : [
    {Value : title},
    {Value : description},
    {Value : customer_ID},
    {Value : billingFactor}
    ]},
    FieldGroup #Admin   : {Data : [
    {Value : createdBy},
    {Value : createdAt},
    {Value : modifiedBy},
    {Value : modifiedAt}
    ]}
});

annotate my.ProjectMembers with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Members}',
        TypeNamePlural : '{i18n>Members}',
        Title          : {Value : employee.name}
    },
    Identification      : [{Value : employee_ID}],
    SelectionFields     : [employee_ID],
    LineItem            : [{
        Value : employee_ID,
        Label : '{i18n>Employee}'
    }],
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [{Value : employee_ID}]}
});

annotate my.ProjectMembers with {
    ID       @UI.Hidden;
    employee @(
        Common    : {
            Text         : employee.name,
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Employees'},
        title     : '{i18n>Employee}'
    );
}

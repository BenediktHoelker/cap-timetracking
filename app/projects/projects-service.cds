using {ProjectsService as my} from '../../srv/projects-service';

annotate my.ProjectMembers with {
    employee @(
        Common : {
            Text         : employee.name,
            FieldControl : #Mandatory
        },
        ValueList.entity : 'Employees',
        title            : '{i18n>Employee}'
    );
}

annotate my.ProjectMembers with @(UI : {
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [{Value : employee_ID}]}
});

annotate my.ProjectMembers with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Members}',
        TypeNamePlural : '{i18n>Members}',
        Title          : {Value : employee.name}
    },
    Identification  : [{Value : employee_ID}],
    SelectionFields : [employee_ID],
    LineItem        : [{
        Value : employee_ID,
        Label : '{i18n>Employee}'
    }]
});

annotate my.Projects with @(UI : {
    Facets              : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>General}',
            Target : '@UI.FieldGroup#General'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Admin}',
            Target : '@UI.FieldGroup#Admin'
        },
        // {
        //     $Type  : 'UI.ReferenceFacet',
        //     Label  : '{i18n>Records}',
        //     Target : 'records/@UI.LineItem'
        // },
        // {
        //     $Type  : 'UI.ReferenceFacet',
        //     Label  : '{i18n>Members}',
        //     Target : 'members/@UI.LineItem'
        // },
    ],
    FieldGroup #General : {Data : [
        {Value : title},
        {Value : description},
        {Value : customer_ID},
        // {Value : totalTime},
        {Value : billingFactor}
    ]},
    FieldGroup #Admin   : {Data : [
        {Value : createdBy},
        {Value : createdAt},
        {Value : modifiedBy},
        {Value : modifiedAt}
    ]}
});

annotate my.Projects with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
        Title          : {Value : title},
        Description    : {Value : description}
    },
    Identification  : [{Value : title}],
    SelectionFields : [
        title,
        description
    ],
    LineItem        : [
        {Value    : title},
        {Value    : description},
        {
            Value : customer.name,
            Label : '{i18n>ProjectCustomer}'
        }
        // {Value    : totalTime}
    ]
});
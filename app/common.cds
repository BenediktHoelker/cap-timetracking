/*
  Common Annotations shared by all apps
*/

using {TimetrackingService as my} from '../srv/timetracking-service';

annotate my.Records with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Record}',
        TypeNamePlural : '{i18n>Records}',
        Title          : {Value : title},
        Description    : {Value : description}
    },
    Identification  : [{Value : title}],
    SelectionFields : [
    title,
    description,
    projectMember.title,
    projectMember.name,
    date
    ],
    LineItem        : [
    {Value : title},
    {
        Value : projectMember.title,
        Label : '{i18n>Project}'
    },
    {
        Value : projectMember.name,
        Label : '{i18n>Employee}'
    },
    {Value : description},
    {Value : date},
    {Value : time}
    ]
});

annotate my.Records with {
    ID            @UI.Hidden;
    description   @UI.MultiLineText;
    projectMember @(Common : {
        Text             : projectMember.projectMember,
        FieldControl     : #Mandatory,
        ValueList.entity : 'ProjectMembers'
    });
}

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
    {Value : title},
    {Value : description},
    {
        Value : customer.name,
        Label : '{i18n>ProjectCustomer}'
    },
    {Value : totalTime}
    ]
});

annotate my.Projects with {
    ID       @UI.Hidden;
    ID       @(
        Common : {
            Text         : title,
            FieldControl : #Mandatory
        },
        title  : '{i18n>ProjectID}',
    );
    customer @(Common : {
        Text             : customer.name,
        FieldControl     : #Mandatory,
        ValueList.entity : 'Customers'
    });
}

annotate my.Customers with {
    ID @UI.Hidden;
    ID @(
        Common : {
            Text         : name,
            FieldControl : #Mandatory
        },
        title  : '{i18n>ProjectCustomer}',
    )
}

annotate my.Customers with @(UI : {
    Identification  : [name],
    SelectionFields : [name],
    LineItem        : [{Value : name}],
});


annotate my.ProjectMembers with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
        Title          : {Value : project.title}
    },
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [
    {Value : project_ID},
    {Value : employee_ID}
    ]},
    Identification      : [projectMember],
    SelectionFields     : [
    name,
    title
    ],
    LineItem            : [
    {Value : employee.name},
    {Value : project.title}
    ]
});

annotate my.ProjectMembers with {
    ID       @UI.Hidden;
    employee @(
        Common : {
            Text             : employee.name,
            FieldControl     : #Mandatory,
            ValueList.entity : 'Employees'
        },
        title  : '{i18n>Employee}'
    );
    project  @(
        Common : {
            Text             : project.title,
            FieldControl     : #Mandatory,
            ValueList.entity : 'Projects'
        },
        title  : '{i18n>Project}'
    );
}

annotate my.Employees with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Employee}',
        TypeNamePlural : '{i18n>Employees}',
        Title          : {Value : name}
    },
    Identification  : [{Value : name}],
    SelectionFields : [name],
    LineItem        : [
    {Value : name},
    {Value : recordsCount},
    {Value : billingTime},
    {Value : bonus}
    ]
});

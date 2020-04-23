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
    {Value : time},
    {Value : status},
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

annotate my.Projects with @(UI : {
    Identification  : [{Value : title}],
    SelectionFields : [title],
    LineItem        : [
    {Value : title},
    {Value : description}
    ]
});

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
    {Value : bonus},
    {
        Value : manager.name,
        Label : '{i18n>Employee.manager}'
    },
    {Value : leaveAggr.daysOfLeave},
    {Value : travelAggr.daysOfTravel}
    ]
});


annotate my.Employees with {
    ID @UI.Hidden;
}

annotate my.Customers with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Customer}',
        TypeNamePlural : '{i18n>Customers}',
        Title          : {Value : name}
    },
    Identification  : [{Value : name}],
    SelectionFields : [name],
    LineItem        : [
    {Value : name},
    {Value : projectsCount}
    ]
});

annotate my.Customers with {
    ID @UI.Hidden;
}

annotate my.ProjectMembers with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>ProjectMember}',
        TypeNamePlural : '{i18n>ProjectMembers}',
        Title          : {Value : projectMember}
    },
    Identification      : [{Value : projectMember}],
    SelectionFields     : [projectMember],
    LineItem            : [{
        Value : projectMember,
        Label : '{i18n>Project}'
    }],
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [
    {Value : project_ID},
    {Value : employee_ID}
    ]}
});

annotate my.ProjectMembers with {
    ID       @UI.Hidden;
    project  @(
        Common    : {
            Text         : title,
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Projects'},
        title     : '{i18n>Project}'
    );
    employee @(
        Common    : {
            Text         : name,
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Employees'},
        title     : '{i18n>Employee}'
    );
}

annotate my.Leaves with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Leave}',
        TypeNamePlural : '{i18n>Leaves}',
        Title          : {Value : reason}
    },
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    },
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Leaves.Dates}',
        Target : '@UI.FieldGroup#Dates'
    }
    ],
    FieldGroup #General : {Data : [{Value : reason}, ]},
    FieldGroup #Dates   : {Data : [
    {Value : dateFrom},
    {Value : dateTo},
    {Value : daysOfLeave},
    ]},
    LineItem            : [
    {Value : reason},
    {Value : daysOfLeave},
    {Value : dateFrom},
    {Value : dateTo}
    ]
});

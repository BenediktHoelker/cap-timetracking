/*
  Common Annotations shared by all apps
*/

using {my.timetracking as my} from '../db/schema';

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
        project_ID,
        employee_ID,
        date
    ],
    LineItem        : [
        {Value    : title},
        {
            Value : project.title,
            Label : '{i18n>Project}'
        },
        {
            Value : employee.name,
            Label : '{i18n>Employee}'
        },
        {Value    : description},
        {Value    : date},
        {Value    : time}
    ]
});

annotate my.Records with {
    ID          @title : '{i18n>RecordID}'  @UI.Hidden;
    title       @title : '{i18n>RecordTitle}';
    date        @title : '{i18n>Date}';
    time        @title : '{i18n>Duration}';
    description @title : '{i18n>RecordDescription}'  @UI.MultiLineText;
    project     @(
        Common         : {
            Text         : project.title,
            FieldControl : #Mandatory
        },
        ValueList.entity : 'Projects',
        title            : '{i18n>Project}'
    );
    employee    @(
        Common         : {
            Text         : employee.name,
            FieldControl : #Mandatory
        },
        ValueList.entity : 'Employees',
        title            : '{i18n>Employee}'
    );
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
        {Value : description}
    ]
});

annotate my.Projects with {
    ID          @(
        Common         : {
            Text         : title,
            FieldControl : #Mandatory
        },
        title : '{i18n>ProjectID}',
        UI    : Hidden
    );
    title       @title : '{i18n>ProjectTitle}';
    customer    @title : '{i18n>ProjectCustomer}';
    members     @title : '{i18n>ProjectMembers}';
    description @title : '{i18n>ProjectDescription}';
}

annotate my.Employees with {
    ID   @title : '{i18n>EmployeeID}'  @UI.HiddenFilter;
    name @title : '{i18n>EmployeeName}';
}

annotate my.Employees with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Employee}',
        TypeNamePlural : '{i18n>Employees}',
        Title          : {Value : name}
    },
    Identification  : [{Value : name}],
    SelectionFields : [name],
    LineItem        : [{value : name}]
});

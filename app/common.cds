/*
  Common Annotations shared by all apps
*/

using {my.timetracking as my} from '../srv/timetracking-service';

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
        {Value    : time},
        {Value    : timeUnit}
    ]
});

annotate my.Records with {
    ID          @title : '{i18n>RecordID}'  @UI.Hidden;
    title       @title : '{i18n>RecordTitle}';
    date        @title : '{i18n>Date}';
    time        @title : '{i18n>Duration}';
    timeUnit    @title : '{i18n>DurationUnit}';
    description @title : '{i18n>RecordDescription}'  @UI.MultiLineText;
    project     @(
        Common         : {
            Text             : project.title,
            FieldControl     : #Mandatory,
            ValueList.entity : 'Projects'
        },
        title : '{i18n>Project}'
    );
    employee    @(
        Common         : {
            Text             : employee.name,
            FieldControl     : #Mandatory,
            ValueList.entity : 'Employees'
        },
        title : '{i18n>Employee}'
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
        {Value    : title},
        {Value    : description},
        {
            Value : customer.name,
            Label : '{i18n>ProjectCustomer}'
        },
        {Value    : totalTime}
    ]
});

annotate my.Projects with {
    ID            @(
        Common           : {
            Text         : title,
            FieldControl : #Mandatory
        },
        title : '{i18n>ProjectID}',
        UI    : Hidden
    );
    customer      @(
        Common           : {
            Text         : customer.name,
            FieldControl : #Mandatory
        },
        ValueList.entity : 'Customers',
        title            : '{i18n>ProjectCustomer}'
    );
    title         @title : '{i18n>ProjectTitle}';
    totalTime     @title : '{i18n>ProjectTotalTime}';
    billingFactor @title : '{i18n>ProjectBillingFactor}';
    members       @title : '{i18n>ProjectMembers}';
    description   @title : '{i18n>ProjectDescription}';
}

annotate my.Employees with {
    ID           @title : '{i18n>EmployeeID}'  @UI.HiddenFilter;
    name         @title : '{i18n>EmployeeName}';
    recordsCount @title : '{i18n>RecordsCount}';
    billingTime  @title : '{i18n>BillingTime}';
    bonus        @title : '{i18n>Bonus}';
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
        {
            Value : name,
            Label : '{i18n>EmployeeName}'
        },
        {
            Value : recordsCount,
            Label : '{i18n>RecordsCount}'
        },
        {
            Value : billingTime,
            Label : '{i18n>BillingTime}'
        },
        {
            Value : bonus,
            Label : '{i18n>Bonus}'
        }
    ]
});

annotate my.Customers with {
    ID            @title : '{i18n>CustomerID}'  @UI.HiddenFilter;
    name          @title : '{i18n>CustomerName}';
    projectsCount @title : '{i18n>ProjectsCount}';
}

annotate my.Customers with @(UI : {
    HeaderInfo     : {
        TypeName       : '{i18n>Customer}',
        TypeNamePlural : '{i18n>Customers}',
        Title          : {Value : name}
    },
    Identification : [{Value : name}],
    // SelectionFields : [name],
    LineItem       : [{Value : name}]
});
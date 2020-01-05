using {EmployeesService as my} from '../../srv/employees-service';

annotate my.Employees with @(UI : {
    Facets              : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>General}',
            Target : '@UI.FieldGroup#General'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Records}',
            Target : 'records/@UI.LineItem'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Projects}',
            Target : 'projects/@UI.LineItem'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Travels}',
            Target : 'travels/@UI.LineItem'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Leaves}',
            Target : 'leaves/@UI.LineItem'
        }
    ],
    FieldGroup #General : {Data : [{Value : name}]}
});

annotate my.EmployeesProjects with @(UI : {
    Facets              : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>General}',
            Target : '@UI.FieldGroup#General'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Records}',
            Target : 'records/@UI.LineItem'
        }
    ],
    FieldGroup #General : {Data : [{Value : project_ID}]}
});

annotate my.EmployeesProjects with @(UI : {
    HeaderInfo      : {
        TypeName       : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
        Title          : {Value : project.title}
    },
    Identification  : [
        {Value : project_ID},
        {Value : employee_ID}
    ],
    SelectionFields : [project_ID],
    LineItem        : [{Value : project_ID}]
});

annotate my.EmployeesProjects with {
    project_ID @(
        Common : {
            Text             : project.title,
            FieldControl     : #Mandatory,
            ValueList.entity : 'Projects'
        },
        title : '{i18n>Project}'
    );
}
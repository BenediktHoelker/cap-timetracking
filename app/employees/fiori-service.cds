using {TimetrackingService as my} from '../../srv/timetracking-service';

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
        }
    ],
    FieldGroup #General : {Data : [{Value : name}]}
});

annotate my.EmployeesProjects with @(UI : {
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
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
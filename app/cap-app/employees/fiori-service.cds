using {EmployeesService as my} from '../../../srv/employees-service';

annotate my.Employees with @(UI : {
    Facets              : [
    {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
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

annotate my.ProjectMembers with @(UI : {
    FieldGroup #General : {Data : [{Value : project_ID}]},
    LineItem            : [{Value : project.title}]
});

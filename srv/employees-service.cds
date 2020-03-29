using {TimetrackingService as my} from './timetracking-service';

service EmployeesService {
    @odata.draft.enabled
    entity Employees      as projection on my.Employees;

    entity Projects       as projection on my.Projects;
    entity Records        as projection on my.Records;
    entity Travels        as projection on my.Travels;
    entity Leaves         as projection on my.Leaves;
    entity ProjectMembers as projection on my.ProjectMembers;
}

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

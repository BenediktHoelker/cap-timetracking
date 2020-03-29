using {TimetrackingService as my} from './timetracking-service';

service CustomersService  {
    entity Records   as select from my.Records;

    @odata.draft.enabled
    entity Customers as projection on my.Customers;

    entity Projects  as projection on my.Projects;
}

annotate my.Customers with @(UI : {
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
    }
    ],
    FieldGroup #General : {Data : [
    {Value : name},
    {Value : projectsCount}
    ]}
});

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
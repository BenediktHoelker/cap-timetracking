using {RecordsService as my} from '../../../srv/records-service';

annotate my.Records with @(UI : {
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
    ],
    FieldGroup #General : {Data : [
    {Value : title},
    {Value : description},
    {Value : projectMember_ID},
    {Value : date},
    {Value : time},
    {Value : timeUnit},
    ]},
    FieldGroup #Admin   : {Data : [
    {Value : createdBy},
    {Value : createdAt},
    {Value : modifiedBy},
    {Value : modifiedAt}
    ]}
});

annotate my.ProjectMembers with @(UI : {
    HeaderInfo          : {
        TypeName       : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
        Title          : {Value : project.title}
    },
    Identification      : [{Value : title}],
    SelectionFields     : [title],
    LineItem            : [{
        Value : project.title,
        Label : '{i18n>Project}'
    }],
    Facets              : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>General}',
        Target : '@UI.FieldGroup#General'
    }],
    FieldGroup #General : {Data : [{Value : project_ID}]}
});

annotate my.ProjectMembers with {
    ID      @UI.Hidden;
    project @(
        Common    : {
            Text         : project.title,
            FieldControl : #Mandatory
        },
        ValueList : {entity : 'Projects'},
        title     : '{i18n>Project}'
    );
}

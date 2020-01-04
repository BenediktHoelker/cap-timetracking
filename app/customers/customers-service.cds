using {CustomersService as my} from '../../srv/customers-service';

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
        {Value    : name},
        {
            Value : projectsCount,
            Label : '{i18n>ProjectsCount}'
        }
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
        {
            Value : name,
            Label : '{i18n>Customer}'
        },
        {
            Value : projectsCount,
            Label : '{i18n>ProjectsCount}'
        }
    ]
});

annotate my.Projects with @(UI : {
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
        }
    ],
    HeaderInfo      : {
        TypeName       : '{i18n>Project}',
        TypeNamePlural : '{i18n>Projects}',
        Title          : {Value : title},
        Description    : {Value : description}
    },
    FieldGroup #General : {Data : [
        {Value : title},
        {Value : description},
        {Value : billingFactor}
    ]},
    FieldGroup #Admin   : {Data : [
        {Value : createdBy},
        {Value : createdAt},
        {Value : modifiedBy},
        {Value : modifiedAt}
    ]}
});
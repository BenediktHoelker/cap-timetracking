/*
  Common Annotations shared by all apps
*/

using {my.timetracking as my} from '../db/schema';


////////////////////////////////////////////////////////////////////////////
//
//	Books Lists
//
annotate my.Records with @(UI : {
    Identification  : [{Value : title}],
    SelectionFields : [
        title,
        description,
        date
    ],
    LineItem        : [
        {Value    : title},
        {
            Value : project.title,
            Label : 'Projekt'
        },
        {Value    : description},
        {Value    : date},
        {Value    : time}
    ]
}) {
    project @ValueList.entity : 'Projects';
};

annotate my.Projects with @(UI : {Identification : [{Value : title}]});


////////////////////////////////////////////////////////////////////////////
//
//	Books Details
//
annotate my.Records with @(UI : {HeaderInfo : {
    TypeName       : 'Record',
    TypeNamePlural : 'Records',
    Title          : {Value : title},
    Description    : {Value : project.title}
}, });


////////////////////////////////////////////////////////////////////////////
//
//	Books Elements
//
annotate my.Records with {
    ID          @title : 'ID'  @UI.HiddenFilter;
    title       @title : 'Titel';
    project     @title : 'Projekt';
    date        @title : 'Datum';
    description @UI.MultiLineText;
}


////////////////////////////////////////////////////////////////////////////
//
//	Authors Elements
//
annotate my.Project with {
    ID    @title : 'ID'  @UI.HiddenFilter;
    title @title : 'Projektname';
}
using from './timetracking-service';

annotate iot.timetracking.Employees with @(
    UI: {
        Identification: [ {Value: name} ],
        SelectionFields: [ name ],
        LineItem: [
            {Value: name}
        ],
        HeaderInfo: {
            TypeName: '{i18n>Employee}',
            TypeNamePlural: '{i18n>Employees}',
            Title: {Value: name},
            Description: {Value: name}
        }
    }
);

annotate iot.timetracking.Employees with {
    ID @title:'{i18n>ID}' @UI.HiddenFilter;
    name @title:'{i18n>Name}';
}
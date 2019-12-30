using from './timetracking-service';

annotate timetracking.Employees with @(
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

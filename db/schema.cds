namespace my.timetracking;

using {
  managed,
  cuid
} from '@sap/cds/common';

entity Records : cuid, managed {
  title         : String;
  description   : String;
  time          : Decimal(4, 2);
  timeUnit      : String;
  date          : Date;
  status        : String enum {
    INITIAL;
    BILLED;
  };
  projectMember : Association to one EmployeesToProjects;
  employee      : Association to one Employees;
}

entity Projects : cuid, managed {
  title         : String;
  description   : String;
  billingFactor : Decimal(5, 2);
  recordsCount  : Integer;
  totalTime     : Integer;
  packages      : Association to many Packages
                    on packages.project = $self;
  members       : Association to many EmployeesToProjects
                    on members.project = $self;
  customer      : Association to one Customers;
}

entity Employees : cuid, managed {
  name          : String;
  username      : String;
  projectsCount : Integer;
  travels       : Composition of many Travels
                    on travels.employee = $self;
  leaves        : Composition of many Leaves
                    on leaves.employee = $self;
  projects      : Composition of many EmployeesToProjects
                    on projects.employee = $self;
  records       : Association to many Records
                    on records.employee = $self;
  recordsCount  : Integer;
  daysOfTravel  : Integer @title : '{i18n>Employees.DaysOfTravel}';
  daysOfLeave   : Integer @title : '{i18n>Employees.DaysOfLeave}';
  billingTime   : Integer;
  bonus         : Integer;
}

entity EmployeesToProjects : cuid, managed {
  // project_ID  : UUID;
  // employee_ID : UUID;
  title    : String;
  username : String;
  name     : String;
  records  : Association to many Records
               // and records.employee = $self
               on records.projectMember = $self;
  project  : Association to one Projects;
  // on project.ID = project_ID;
  employee : Association to one Employees;
// on employee.ID = employee_ID;
}

entity Customers : cuid, managed {
  name          : String;
  projectsCount : Integer;
  projects      : Association to many Projects
                    on projects.customer = $self;
  invoices      : Association to many Invoices
                    on invoices.customer = $self;
}

view CustomersView as
  select from timetracking.Customers {
    *,
    count(
      projects.ID
    ) as projectsCount : Integer
  }
  group by
    Customers.ID,
    Customers.createdAt,
    Customers.createdBy,
    Customers.modifiedAt,
    Customers.modifiedBy,
    Customers.name;

entity Invoices : cuid, managed {
  customer : Association to one Customers;
  items    : Composition of many InvoiceItems
               on items.invoice = $self;
}

entity InvoiceItems : cuid, managed {
  invoice   : Association to one Invoices;
  record_ID : UUID;
  record    : Association to one Records
                on record.ID = record_ID;
}

entity InvoicesView as
  select from timetracking.Invoices {
    *,
    sum(
      items.record.time
    ) as amount : Double
  }
  group by
    Invoices.ID,
    Invoices.customer,
    Invoices.createdAt,
    Invoices.createdBy,
    Invoices.modifiedAt,
    Invoices.modifiedBy;

entity Packages : cuid, managed {
  title       : String;
  description : String;
  project     : Association to one Projects;
}

entity Travels : cuid, managed {
  project       : Association to Projects;
  employee      : Association to Employees;
  daysOfTravel  : Integer      @readonly;
  dateFrom      : Date         @title : '{i18n>Travels.DateFrom}';
  dateTo        : Date         @title : '{i18n>Travels.DateTo}';
  journey       : Decimal(4, 2)@title : '{i18n>Travels.Journey}';
  returnJourney : Decimal(4, 2)@title : '{i18n>Travels.ReturnJourney}';
  durationUnit  : String enum {
    h;
    m;
  };
}

entity Leaves : cuid, managed {
  reason      : String enum {
    ILLNESS;
    VACATION;
  };
  dateFrom    : Date    @title : '{i18n>Leaves.DateFrom}';
  dateTo      : Date    @title : '{i18n>Leaves.DateTo}';
  daysOfLeave : Integer @readonly;
  employee    : Association to Employees;
}

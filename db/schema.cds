namespace my.timetracking;

using {
  managed,
  cuid
} from '@sap/cds/common';

entity Records : cuid, managed {
  title         : String                                 @title : '{i18n>Records.title}';
  description   : String                                 @title : '{i18n>Records.description}';
  time          : Decimal(4, 2)                          @title : '{i18n>Records.time}';
  timeUnit      : String                                 @title : '{i18n>Records.timeUnit}';
  date          : Date                                   @title : '{i18n>Records.date}';
  status        : String                                 @title : '{i18n>Records.status}'
  enum {
    INITIAL;
    BILLED;
  };
  invoiceItem   : Association to one InvoiceItems
                    on invoiceItem.record = $self        @title : '{i18n>Records.invoiceItem}';
  projectMember : Association to one EmployeesToProjects @title : '{i18n>Records.projectMember}';
  employee      : Association to one Employees           @title : '{i18n>Records.employee}';
}

entity Projects : cuid, managed {
  title         : String                       @title : '{i18n>Projects.title}';
  description   : String                       @title : '{i18n>Projects.description}';
  billingFactor : Decimal(5, 2)                @title : '{i18n>Projects.billingFactor}';
  recordsCount  : Integer                      @title : '{i18n>Projects.recordsCount}';
  totalTime     : Integer                      @title : '{i18n>Projects.totalTime}';
  customer      : Association to one Customers @title : '{i18n>Projects.customer}';
  packages      : Association to many Packages
                    on packages.project = $self;
  members       : Composition of many EmployeesToProjects
                    on members.project = $self;
}

entity Employees : cuid, managed {
  name          : String  @title : '{i18n>Employees.name}';
  username      : String  @title : '{i18n>Employees.username}';
  projectsCount : Integer @title : '{i18n>Employees.projectsCount}';
  recordsCount  : Integer @title : '{i18n>Employees.recordsCount}';
  daysOfTravel  : Integer @title : '{i18n>Employees.daysOfTravel}';
  daysOfLeave   : Integer @title : '{i18n>Employees.daysOfLeave}';
  billingTime   : Integer @title : '{i18n>Employees.billingTime}';
  bonus         : Integer @title : '{i18n>Employees.bonus}';
  travels       : Composition of many Travels
                    on travels.employee = $self;
  leaves        : Composition of many Leaves
                    on leaves.employee = $self;
  projects      : Composition of many EmployeesToProjects
                    on projects.employee = $self;
  records       : Association to many Records
                    on records.employee = $self;
}

entity EmployeesToProjects : cuid, managed {
  title         : String                       @title : '{i18n>EmployeesToProjects.title}';
  username      : String                       @title : '{i18n>EmployeesToProjects.username}';
  name          : String                       @title : '{i18n>EmployeesToProjects.name}';
  projectMember : String                       @title : '{i18n>EmployeesToProjects.projectMember}';
  project       : Association to one Projects  @title : '{i18n>EmployeesToProjects.project}';
  employee      : Association to one Employees @title : '{i18n>EmployeesToProjects.employee}';
  records       : Association to many Records
                    on records.projectMember = $self;
}

entity Customers : cuid, managed {
  name          : String  @title : '{i18n>Customers.name}';
  projectsCount : Integer @title : '{i18n>Customers.projectsCount}';
  projects      : Association to many Projects
                    on projects.customer = $self;
  invoices      : Association to many Invoices
                    on invoices.customer = $self;
}

entity Packages : cuid, managed {
  title       : String                      @title : '{i18n>Packages.title}';
  description : String                      @title : '{i18n>Packages.description}';
  project     : Association to one Projects @title : '{i18n>Packages.project}';
}

entity Travels : cuid, managed {
  daysOfTravel  : Integer                      @readonly  @title : '{i18n>Travels.daysOfTravel}';
  dateFrom      : Date                         @title :            '{i18n>Travels.dateFrom}';
  dateTo        : Date                         @title :            '{i18n>Travels.dateTo}';
  returnJourney : Decimal(4, 2)                @title :            '{i18n>Travels.returnJourney}';
  journey       : Decimal(4, 2)                @title :            '{i18n>Travels.journey}';
  durationUnit  : String                       @title :            '{i18n>Travels.durationUnit}';
  project       : Association to one Projects  @title :            '{i18n>Travels.project}';
  employee      : Association to one Employees @title :            '{i18n>Travels.employee}';
}

entity Leaves : cuid, managed {
  reason      : String                       @title :            '{i18n>Leaves.reason}' enum {
    ILLNESS;
    VACATION;
  };
  dateFrom    : Date                         @title :            '{i18n>Leaves.dateFrom}';
  dateTo      : Date                         @title :            '{i18n>Leaves.dateTo}';
  daysOfLeave : Integer                      @readonly  @title : '{i18n>Leaves.daysOfLeave}';
  employee    : Association to one Employees @title :            '{i18n>Leaves.employee}';
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
  title       : String                       @title : '{i18n>Invoices.title}';
  description : String                       @title : '{i18n>Invoices.description}';
  customer    : Association to one Customers @title : '{i18n>Invoices.customer}';
  items       : Composition of many InvoiceItems
                  on items.invoice = $self;
}

entity InvoiceItems : cuid, managed {
  invoice : Association to one Invoices;
  record  : Association to one Records;
}

entity InvoicesView as
  select from timetracking.Invoices {
    *,
    sum(
      items.record.time
    ) as amount : Double
  }
  group by
    Invoices.createdAt,
    Invoices.createdBy,
    Invoices.customer,
    Invoices.description,
    Invoices.ID,
    Invoices.modifiedAt,
    Invoices.modifiedBy,
    Invoices.title;

namespace my.timetracking;

using {
  managed,
  cuid
} from '@sap/cds/common';

entity Records : cuid, managed {
  title       : String;
  description : String;
  time        : Decimal(4, 2);
  timeUnit    : String;
  date        : Date;
  status      : String;
  employee    : Association to one Employees;
  project     : Association to one Projects;
}

entity RecordStatus : cuid {
  text     : String;
  editable : Boolean;
}

entity Customers : cuid, managed {
  name     : String;
  projects : Association to many Projects
               on projects.customer = $self;
  invoices : Association to many Invoices
               on invoices.customer = $self;
}

view CustomersView as
  select from timetracking.Customers {
    * ,
    count(projects.ID) as projectsCount : Integer
  }
  group by
    ID,
    name;

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
    * ,
    sum(items.record.time) as amount : Double
  }
  group by
    ID,
    customer;

entity Projects : cuid, managed {
  title         : String;
  description   : String;
  billingFactor : Decimal(5, 2);
  packages      : Association to many Packages
                    on packages.project = $self;
  records       : Composition of many Records
                    on records.project = $self;
  members       : Association to many EmployeesToProjects
                    on members.project = $self;
  customer      : Association to one Customers;
}

entity EmployeesToProjects : cuid, managed {
  project_ID  : UUID;
  employee_ID : UUID;
  project     : Association to one Projects
                  on project.ID = project_ID;
  employee    : Association to one Employees
                  on employee.ID = employee_ID;
}

entity Packages : cuid, managed {
  title       : String;
  description : String;
  project     : Association to one Projects;
}

entity Employees : cuid, managed {
  name        : String;
  projects    : Composition of many EmployeesToProjects
                  on projects.employee = $self;
  records     : Composition of many Records
                  on records.employee = $self;
}
using {my.timetracking as my} from '../db/schema';

service CustomersService {
    @odata.draft.enabled
    entity Customers as select from my.Customers;
    entity Projects as select from my.Projects;
}
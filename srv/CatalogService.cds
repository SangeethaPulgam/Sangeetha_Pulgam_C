// using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
// using { cappo.cds } from '../db/CDSViews';
 
 
// service CatalogService @(path: 'CatalogService') {
 
//     entity EmployeeSet as projection on master.employees;
//     entity OrderItems as projection on cds.CDSViews.ItemView;
//     entity Products as projection on cds.CDSViews.ProductView;
 
// }

// using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
// using { cappo.cds } from '../db/CDSViews';
 
 
// service CatalogService @(path: 'CatalogService') {
 
//     entity ProductSet as projection on master.product;
//     entity BusinessPartnerSet as projection on master.businesspartner;
//     entity BusinessAddressSet as projection on master.address;
//     entity EmployeeSet as projection on master.employees;
//     entity POs as projection on transaction.purchaseorder;
//     entity POItems as projection on transaction.poitems;
//     // entity OrderItems as projection on cds.CDSViews.ItemView;
//     // entity Products as projection on cds.CDSViews.ProductView;
 
// }
using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';
 
 
service CatalogService @(path: 'CatalogService') {
 
    entity ProductSet as projection on master.product;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity BusinessAddressSet as projection on master.address;
    entity EmployeeSet as projection on master.employees;
    entity POs as projection on transaction.purchaseorder{
        *,
        Items,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            end as OverallStatus: String(20),
        case OVERALL_STATUS
            when 'N' then 2
            when 'P' then 2
            when 'X' then 1
            when 'A' then 3
             end as ColorCode: Integer,
           

    }
    actions{
        action boost() returns POs
    };

    function largestOrder() returns POs;
    entity POItems as projection on transaction.poitems;
    // entity OrderItems as projection on cds.CDSViews.ItemView;
    // entity Products as projection on cds.CDSViews.ProductView;
 
}
    // entity OrderItems as projection on cds.CDSViews.ItemView;
    // entity Products as projection on cds.CDSViews.ProductView;
 

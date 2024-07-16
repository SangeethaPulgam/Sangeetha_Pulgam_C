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
 
 
service CatalogService @(path: 'CatalogService', requires: 'authenticated-user') {
 
    entity ProductSet as projection on master.product;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity BusinessAddressSet as projection on master.address;
   // @readonly
    entity EmployeeSet @(restrict: [
                        { grant: ['READ'], to: 'Viewer', where: 'bankName = $user.BankName' },
                        { grant: ['WRITE'], to: 'Admin' }
                        ])
                        as projection on master.employees;
    //@Capabilities : { Deletable: false }
    entity POs @(odata.draft.enabled: true) as projection on transaction.purchaseorder{
        *,
        Items,
        case OVERALL_STATUS
            when 'P' then 'Pending'
            when 'N' then 'New'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            end as OverallStatus : String(10),
        case OVERALL_STATUS
            when 'P' then 2
            when 'N' then 2
            when 'A' then 3
            when 'X' then 1
            end as ColorCode : Integer,
    }
    actions{
        @Common.SideEffects : {
            TargetProperties : [
                'in/GROSS_AMOUNT',
            ]
        }
        action boost() returns POs
    };
    function largestOrder() returns array of  POs;
    //definition of the function
    function getOrderDefaults() returns POs;
    entity POItems as projection on transaction.poitems;
    // entity OrderItems as projection on cds.CDSViews.ItemView;
    // entity Products as projection on cds.CDSViews.ProductView;
 
}

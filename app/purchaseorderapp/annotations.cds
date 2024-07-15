using CatalogService as service from '../../srv/CatalogService';
annotate service.POs with @(
   
    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        GROSS_AMOUNT,
        OVERALL_STATUS,
        CURRENCY_code
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality: ColorCode
        },
    ],
    UI.HeaderInfo:
    {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders'
    },
   UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Info',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Order Details',
                    Target : '@UI.Identification',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Configuration Details',
                    Target : '@UI.FieldGroup#MoreInfo',
                },
            ],
        },
       
    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value: OVERALL_STATUS,
        },
        {
            $Type : 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY,

        },
        {
            $Type : 'UI.DataField',
            Value: PO_ID,

        }
    ],

    UI.FieldGroup #MoreInfo: {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            }
        ],
    },
     
);
 
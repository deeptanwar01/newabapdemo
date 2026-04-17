@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Topic 4 Step 2 Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZT4N_C_Customer as select from zt4ncustomer
{
    key id as Id,
    first_name as FirstName,
    last_name as LastName,
    email as Email,
    phone_number as PhoneNumber,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt,
    created_at as CreatedAt,
    created_by as CreatedBy
}

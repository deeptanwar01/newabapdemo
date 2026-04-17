@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Customer Data'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZT3_Customer_date
  as select from zt4customer

{
  key id                    as Id,

      first_name            as FirstName,
      last_name             as LastName,
      email                 as Email,
      phone_number          as PhoneNumber,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      created_at            as CreatedAt,
      created_by            as CreatedBy
}

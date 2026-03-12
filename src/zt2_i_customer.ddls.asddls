/* This is a Basic Interface View created for table CUSTOMER
    to demo how VDM set-up is done. As interface views in stadard
    start with I_, and we are creating custom, I is added in the name
*/
@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Basic Interface View for Customer'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZT2_I_CUSTOMER
  as select from /dmo/customer

{
  key customer_id           as CustomerId,
      first_name            as FirstName,
      last_name             as LastName,
      title                 as Title,
      street                as Street,
      postal_code           as PostalCode,
      city                  as City,
      country_code          as CountryCode,
      phone_number          as PhoneNumber,
      email_address         as EmailAddress,
      local_created_by      as LocalCreatedBy,
      local_created_at      as LocalCreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}

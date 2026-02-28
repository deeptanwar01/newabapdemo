@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'CASE Syntax'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZDKST_CDS_CASE
  with parameters
    p_country : land1

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

      case country_code
      when 'DE' then 'Germany'
      when 'US' then 'USA'
      else 'Unkown'
      end                   as CountryName,

      phone_number          as PhoneNumber,
      email_address         as EmailAddress,
      local_created_by      as LocalCreatedBy,
      local_created_at      as LocalCreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
}

where country_code = $parameters.p_country

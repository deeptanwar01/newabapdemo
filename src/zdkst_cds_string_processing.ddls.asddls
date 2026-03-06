@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'String Processing'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZDKST_CDS_STRING_PROCESSING
  as select from /dmo/customer

{
  key customer_id                                        as CustomerId,

      first_name                                         as FirstName,
      last_name                                          as LastName,
      // Concat Example      
      concat(first_name, last_name)                      as FullName,
      // Contact with Space      
      concat_with_space(first_name, last_name, 1)        as FullNameWithSpace,

      // Conact to handel Null values
      concat(
          concat(coalesce(first_name, ' '), ' '),
          coalesce(last_name, ' ')
      )                                                  as FullNameAnother,

      // Convert to Upper Case
      upper(concat_with_space(first_name, last_name, 1)) as FullNameInUpper,
      title                                              as Title,
      street                                             as Street,
      postal_code                                        as PostalCode,
      city                                               as City,
      country_code                                       as CountryCode,
      phone_number                                       as PhoneNumber,
      email_address                                      as EmailAddress,
      local_created_by                                   as LocalCreatedBy,
      local_created_at                                   as LocalCreatedAt,
      local_last_changed_by                              as LocalLastChangedBy,
      local_last_changed_at                              as LocalLastChangedAt,   
      last_changed_at                                    as LastChangedAt
}

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Projection View Topic 4 Customer'

@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true

define root view entity ZT4_C_Customer
  provider contract transactional_query
  as projection on ZT4CustomerData

{
  key Id,

      FirstName,
      LastName,
      Email,
      PhoneNumber,
      LastChangedAt,
      LocalLastChangedAt,
      CreatedAt,
      CreatedBy
}

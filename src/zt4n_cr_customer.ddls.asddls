@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Topic 4 Step 3 Proj View Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZT4N_CR_Customer
provider contract transactional_query 
as projection on ZT4N_C_Customer
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

@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZZT3Customer'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZZT3R_CUSTOMER
  as select from ZZT3CUSTOMER as Customer
{
  key uuid as UUID,
  business_partner as BusinessPartner,
  first_name as FirstName,
  last_name as LastName,
  date_of_birth as DateOfBirth,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZZT3Customer'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZZT3C_CUSTOMER
  provider contract TRANSACTIONAL_QUERY
  as projection on ZZT3R_CUSTOMER
  association [1..1] to ZZT3R_CUSTOMER as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  BusinessPartner,
  FirstName,
  LastName,
  DateOfBirth,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}

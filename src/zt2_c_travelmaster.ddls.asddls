/* This is a Consumption View created for Travel Master Composit View
    to demo how VDM set-up is done. As Consumption views in stadard
    start with C_, and we are creating custom, C is added in the name.
    This will also contain annotation for ALV, Fiori, ODATA etc.
*/
@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel Master'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZT2_C_TRAVELMASTER
  as select from ZT2_I_TRAVELMASTER

{
  key TravelId,

      BeginDate,
      EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,

      CurrencyCode,
      Description,
      Status,
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      FirstName,
      LastName,
      Title,
      Street,
      PostalCode,
      City,
      CountryCode,
      PhoneNumber,
      EmailAddress
}

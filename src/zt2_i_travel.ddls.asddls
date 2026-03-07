/* This is a Basic Interface View created for table TRAVEL
    to demo how VDM set-up is done. As interface views in stadard
    start with I_, and we are creating custom, I is added in the name
*/
@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Interface View for Travel Table'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZT2_I_TRAVEL
  as select from /dmo/travel

{
  key travel_id     as TravelId,

      agency_id     as AgencyId,
      customer_id   as CustomerId,
      begin_date    as BeginDate,
      end_date      as EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee   as BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price   as TotalPrice,

      currency_code as CurrencyCode,
      description   as Description,
      status        as Status,
      createdby     as Createdby,
      createdat     as Createdat,
      lastchangedby as Lastchangedby,
      lastchangedat as Lastchangedat
}

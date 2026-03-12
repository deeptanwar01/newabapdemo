@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'DCL Demo'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZT2_BOOKING_DCL
  as select from /dmo/booking

{
  key travel_id     as TravelId,
  key booking_id    as BookingId,

      booking_date  as BookingDate,
      customer_id   as CustomerId,
      carrier_id    as CarrierId,
      connection_id as ConnectionId,
      flight_date   as FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price  as FlightPrice,

      currency_code as CurrencyCode
}

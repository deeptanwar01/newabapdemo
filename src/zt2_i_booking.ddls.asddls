/* This is a Basic Interface View created for table BOOKING
    to demo how VDM set-up is done. As interface views in stadard
    start with I_, and we are creating custom, I is added in the name
*/
@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Basic Interface View for Booking'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZT2_I_BOOKING
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

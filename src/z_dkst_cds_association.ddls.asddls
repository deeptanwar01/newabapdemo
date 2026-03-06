@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Association Demo'

@Metadata.ignorePropagatedAnnotations: true

define view entity Z_DKST_CDS_ASSOCIATION
  as select from /dmo/booking

  association to        /dmo/customer as _Customer on $projection.CustomerId = _Customer.customer_id
  association [1..*] to /dmo/flight   as _Flight   on $projection.CarrierId = _Flight.carrier_id

{
  key /dmo/booking.travel_id     as TravelId,
  key /dmo/booking.booking_id    as BookingId,

      /dmo/booking.booking_date  as BookingDate,
      /dmo/booking.customer_id   as CustomerId,
      /dmo/booking.carrier_id    as CarrierId,
      /dmo/booking.connection_id as ConnectionId,
      /dmo/booking.flight_date   as FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      /dmo/booking.flight_price  as FlightPrice,

      /dmo/booking.currency_code as CurrencyCode,

      _Customer,
      _Flight
}

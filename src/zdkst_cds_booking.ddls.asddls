@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking and Customer Union'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZDKST_CDS_BOOKING as select from /dmo/booking
inner join /dmo/customer
on /dmo/booking.customer_id = /dmo/customer.customer_id
{
    key /dmo/booking.travel_id as TravelId,
    key /dmo/booking.booking_id as BookingId,
    key /dmo/customer.customer_id as CustomerId,
    /dmo/booking.booking_date as BookingDate,
    /dmo/booking.carrier_id as CarrierId,
    /dmo/booking.connection_id as ConnectionId,
    /dmo/booking.flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    /dmo/booking.flight_price as FlightPrice,
    /dmo/booking.currency_code as CurrencyCode,
    /dmo/customer.first_name as FirstName,
    /dmo/customer.last_name as LastName,
    /dmo/customer.title as Title,
    /dmo/customer.street as Street,
    /dmo/customer.postal_code as PostalCode,
    /dmo/customer.city as City,
    /dmo/customer.country_code as CountryCode,
    /dmo/customer.phone_number as PhoneNumber,
    /dmo/customer.email_address as EmailAddress
}

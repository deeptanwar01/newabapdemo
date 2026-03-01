// View Level Annotations
@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'CDS First'

@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true

define view entity ZDKST_CDS
  as select from /dmo/flight // data source, this can also have alias by using as

{
      // Key Elements
  key carrier_id     as CarrierId,
  key connection_id  as ConnectionId,
  key flight_date    as FlightDate,

      // Element Annotations
      @Semantics.amount.currencyCode: 'CurrencyCode' // Remove and see what happens
      price          as Price,

      currency_code  as CurrencyCode,
      plane_type_id  as PlaneTypeId,
      seats_max      as SeatsMax, // Alias
      seats_occupied as SeatsOccupied
/* Protected Word example
    creation_date as date  */
}

@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'PARAMETER Syntax'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZDKST_CDS_PARAMATER
  with parameters
    @Environment.systemField: #SYSTEM_DATE // Annotaition to file this paramater with system date
    p_date : /dmo/flight_date //Data Element reference

  as select from /dmo/flight

{
  key carrier_id     as CarrierId,
  key connection_id  as ConnectionId,
  key flight_date    as FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,

      currency_code  as CurrencyCode,
      plane_type_id  as PlaneTypeId,
      seats_max      as SeatsMax,
      seats_occupied as SeatsOccupied
}

where flight_date > $parameters.p_date // Will make it input

@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'HAVING Syntax example'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZDKST_CDS_HAVING
  as select from /dmo/flight

{
  key carrier_id     as CarrierId,
  key connection_id  as ConnectionId,
  key flight_date    as FlightDate,

      plane_type_id  as PlaneTypeId,
      seats_occupied as SeatsOccupied
}

group by carrier_id,
         connection_id,
         flight_date,
         plane_type_id,
         seats_occupied

having sum(seats_occupied) > 200

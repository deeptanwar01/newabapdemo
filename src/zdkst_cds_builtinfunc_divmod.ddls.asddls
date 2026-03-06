@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Built In Function Div, Mod and Division'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZDKST_CDS_BUILTINFUNC_DIVMOD as select from /dmo/flight
{
    key carrier_id as CarrierId,
    key connection_id as ConnectionId,
    seats_max as SeatsMax,
    seats_occupied as SeatsOccupied,
    
    div( seats_max, seats_occupied ) as SeatsRatio,
    mod( seats_max, seats_occupied ) as SeatsRemainder,
    division( seats_occupied,  seats_max, 2 ) as DecimalRatio
    
    
}

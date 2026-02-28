@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CAST Syntax'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZDKST_CDS_CAST as select from /dmo/flight
{
    '19891109' as col_char,
    cast( '19891109' as abap.int4) as col_int4,
    cast( '19891109' as abap.dec(16,2)) as col_dec
    
}

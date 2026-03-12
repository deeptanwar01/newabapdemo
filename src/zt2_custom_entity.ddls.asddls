@EndUserText.label: 'DEMO Custom Entity'

@ObjectModel.query.implementedBy: 'ABAP:ZCL_T2_CUSTOMER'
define root custom entity ZT2_Custom_Entity

// with parameters parameter_name : parameter_type
{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZT2_I_CUSTOMER', element: 'CustomerId' } } ]
      @UI.selectionField: [ { position: 10 } ]
      @UI.lineItem: [ { position: 10 } ]
  key CustomerId       : /dmo/customer_id;

      @UI.lineItem: [ { position: 20 } ]
      FirstName            : /dmo/first_name;

      @UI.lineItem: [ { position: 30 } ]
      LastName             : /dmo/last_name;
}

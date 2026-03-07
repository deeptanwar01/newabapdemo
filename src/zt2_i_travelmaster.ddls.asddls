/* This is a Composit View created for table TRAVEL and CUSTOMER with JOIN
    Interface view is only for projection on table and composit views will 
    have JOINS and Aggregations. As composit views in stadard
    start with I_, and we are creating custom, I is added in the name.
    Both Interface and Composit view will have I in name. 
*/
@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Composit View Traval and Customer Data'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZT2_I_TRAVELMASTER
  as select from ZT2_I_TRAVEL   as Travel // Interface face is used in Composit as data source and not DB table

    inner join   ZT2_I_CUSTOMER as Customer on Travel.CustomerId = Customer.CustomerId

{
  key Travel.TravelId,

      Travel.BeginDate,
      Travel.EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.TotalPrice,

      Travel.CurrencyCode,
      Travel.Description,
      Travel.Status,
      Travel.Createdby,
      Travel.Createdat,
      Travel.Lastchangedby,
      Travel.Lastchangedat,
      Customer.FirstName,
      Customer.LastName,
      Customer.Title,
      Customer.Street,
      Customer.PostalCode,
      Customer.City,
      Customer.CountryCode,
      Customer.PhoneNumber,
      Customer.EmailAddress
}

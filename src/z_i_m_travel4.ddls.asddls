@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel4'
@Metadata.ignorePropagatedAnnotations: true
define root view entity z_i_m_travel4
  as select from /dmo/travel as _travel
  association [0..1] to /DMO/I_Agency   as _agency   on $projection.agency_id = _agency.AgencyID
  association [1]    to /DMO/I_Customer as _customer on $projection.customer_id = _customer.CustomerID

  composition [0..*] of z_i_m_book4     as _booking
{
  key travel_id,
      agency_id,
      customer_id,
      begin_date,
      end_date,

      @Semantics.amount.currencyCode: 'currency_code'
      booking_fee,

      @Semantics.amount.currencyCode: 'currency_code'
      total_price,

      currency_code,
      description,
      status,
      createdby,
      createdat,
      lastchangedby,
      lastchangedat,

      _agency,
      _customer,
      _booking
}


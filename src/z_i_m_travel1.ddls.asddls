@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity z_i_m_travel1
  as select from /dmo/travel as _travel
  association [1] to /DMO/I_Agency                as _agency     on  $projection.AgencyId = _agency.AgencyID
  association [1] to /DMO/I_Customer              as _customer   on  $projection.CustomerId = _customer.CustomerID
  composition [0..*] of z_i_m_book1               as _book
  association [1] to /DMO/I_Travel_Status_VH_Text as _statustext on  $projection.Status   = _statustext.TravelStatus
                                                                 and _statustext.Language = 'E'
{
  key travel_id        as TravelId,
      agency_id        as AgencyId,
      customer_id      as CustomerId,
      begin_date       as BeginDate,
      end_date         as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee      as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price      as TotalPrice,
      currency_code    as CurrencyCode,
      description      as Description,
      status           as Status,
      _statustext.Text as statustext,
      createdby        as Createdby,
      createdat        as Createdat,
      lastchangedby    as Lastchangedby,
      lastchangedat    as Lastchangedat,


      _agency,
      _customer,
      _book,
      _statustext

}

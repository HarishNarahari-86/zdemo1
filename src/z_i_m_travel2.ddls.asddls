@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel2'
@Metadata.ignorePropagatedAnnotations: true
define root view entity z_i_m_travel2
  as select from /dmo/travel
  association [1] to /DMO/I_Agency                as _agency     on  $projection.AgencyId = _agency.AgencyID
  association [1] to /DMO/I_Customer              as _customer   on  $projection.CustomerId = _customer.CustomerID
  association [1] to I_Currency                   as _currency   on  $projection.CurrencyCode = _currency.Currency
  association [1] to /DMO/I_Travel_Status_VH_Text as _statustext on  $projection.Status   = _statustext.TravelStatus
                                                                 and _statustext.Language = 'E'
  composition [0..*] of z_i_m_book2                  as _book
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
      case
      when status = 'X' then 2
      when status = 'N' then 3
      when status = 'P' then 1
      else 0
      end              as StatusCriticality,
      _statustext.Text as statustext,
      @Semantics.user.createdBy: true
      createdby        as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat        as Createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby    as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat    as Lastchangedat,

      _agency,
      _customer,
      _currency,
      _statustext,
      _book
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_m_book2
  as select from /dmo/booking as _book
  association [1] to /DMO/I_Customer      as _customer on  $projection.CustomerId = _customer.CustomerID
  association [1] to /DMO/I_Carrier       as _carrier  on  $projection.CarrierId = _carrier.AirlineID
  association [1] to /DMO/I_Connection    as _connect  on  $projection.ConnectionId = _connect.ConnectionID
                                                       and $projection.CarrierId    = _connect.AirlineID
  association     to parent z_i_m_travel2 as _travel   on  $projection.TravelId = _travel.TravelId
{
  key travel_id     as TravelId,
  key booking_id    as BookingId,
      booking_date  as BookingDate,
      customer_id   as CustomerId,
      carrier_id    as CarrierId,
      connection_id as ConnectionId,
      flight_date   as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price  as FlightPrice,
      currency_code as CurrencyCode,
      _travel.Lastchangedat as lastchangedat,


      _customer,
      _carrier,
      _connect,
      _travel
}

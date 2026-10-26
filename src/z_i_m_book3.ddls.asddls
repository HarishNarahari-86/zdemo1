@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking 3'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_m_book3
  as select from /dmo/booking as _book

  association [1] to /DMO/I_Customer      as _Customer on  $projection.CustomerId = _Customer.CustomerID
  association [1] to /DMO/I_Carrier       as _carrier  on  $projection.CarrierId = _carrier.AirlineID
  association [1] to /DMO/I_Connection    as _connect  on  $projection.CarrierId    = _connect.AirlineID
                                                       and $projection.ConnectionId = _connect.ConnectionID

  association     to parent z_i_m_travel3 as _travel   on  $projection.TravelId = _travel.TravelId
  composition [0..*] of z_i_m_book_s3     as _suppliment
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

      _Customer,
      _carrier,
      _connect,
      _travel,
      _suppliment

}

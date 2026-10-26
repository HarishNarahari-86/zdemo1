@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking 1'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_m_book1
  as select from /dmo/booking as booking
  association [1] to /DMO/I_Customer   as _Customer on  $projection.CustomerId = _Customer.CustomerID
  association [1] to /DMO/I_Carrier    as _carrier  on  $projection.CarrierId = _carrier.AirlineID
  association [1] to /DMO/I_Connection as _Connect  on  $projection.CarrierId    = _Connect.AirlineID
                                                    and $projection.ConnectionId = _Connect.ConnectionID

  association     to parent z_i_m_travel1     as _travel   on  $projection.TravelId = _travel.TravelId
  composition [0..*] of z_i_m_book_s1 as _booksuppl
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
      _Connect,
      _travel,
      _booksuppl
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking 4'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_m_book4
  as select from /dmo/booking as _booking
  association [0..1] to /DMO/I_Customer      as _customer      on  $projection.customer_id = _customer.CustomerID
  association [1]    to /DMO/I_Carrier       as _carrier       on  $projection.carrier_id = _carrier.AirlineID
  association [1]    to /DMO/I_Connection    as _connect       on  $projection.carrier_id    = _connect.AirlineID
                                                               and $projection.connection_id = _connect.ConnectionID


  association        to parent z_i_m_travel4 as _travel        on  $projection.travel_id = _travel.travel_id
  composition [0..*] of z_i_m_book_s4        as _suppl

{

  key travel_id,
  key booking_id,
      booking_date,
      customer_id,
      carrier_id,
      connection_id,
      flight_date,
      @Semantics.amount.currencyCode: 'currency_code'
      flight_price,
      currency_code,
      _connect.DepartureAirport,
      _connect.DestinationAirport,



      _customer,
      _carrier,
      _connect,
      _travel,
      _suppl
}

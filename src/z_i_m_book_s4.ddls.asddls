@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Suppliment 4'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_m_book_s4
  as select from /dmo/booksuppl_m as _suppliment
  association [1]    to /DMO/I_Supplement    as _suppl     on  $projection.BookingId = _suppl.SupplementID
  association [0..*] to /DMO/I_BookSuppl_M   as _booksuppl on  $projection.BookingId           = _booksuppl.booking_id
                                                           and $projection.BookingSupplementId = _booksuppl.booking_supplement_id
  association        to parent z_i_m_book4   as _booking   on  $projection.TravelId  = _booking.travel_id
                                                           and $projection.BookingId = _booking.booking_id
  association        to z_i_m_travel4 as _travel    on  $projection.TravelId = _travel.travel_id
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      last_changed_at       as LastChangedAt,

      _suppl,
      _booksuppl,
      _booking,
      _travel
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Suppliment 3'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_m_book_s3
  as select from /dmo/booksuppl_m as _suppliment

  association [1]    to /DMO/I_Supplement  as _suppl     on  $projection.BookingId = _suppl.SupplementID
  association [0..*] to /DMO/I_BookSuppl_M as _booksuppl on  $projection.BookingId           = _booksuppl.booking_id
                                                         and $projection.BookingSupplementId = _booksuppl.booking_supplement_id

  association        to parent z_i_m_book3 as _book      on  $projection.TravelId  = _book.TravelId
                                                         and $projection.BookingId = _book.BookingId
  association        to z_i_m_travel3      as _travel    on  $projection.TravelId = _travel.TravelId
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
      _book,
      _travel
}

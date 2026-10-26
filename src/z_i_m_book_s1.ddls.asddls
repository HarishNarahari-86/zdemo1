@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Suppliment 1'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_m_book_s1
  as select from /dmo/booksuppl_m as _booksuppl
  association [1] to /DMO/I_Supplement     as _suppl     on  $projection.SupplementId = _suppl.SupplementID
  association [1] to /DMO/I_SupplementText as _suppltext on  $projection.SupplementId = _suppltext.SupplementID
                                                         and _suppltext.LanguageCode  = 'E'

  association     to parent z_i_m_book1    as _book      on  $projection.TravelId  = _book.TravelId
                                                         and $projection.BookingId = _book.BookingId
  association     to z_i_m_travel1         as _travel    on  $projection.TravelId = _travel.TravelId

{
  key travel_id                 as TravelId,
  key booking_id                as BookingId,
  key booking_supplement_id     as BookingSupplementId,
      supplement_id             as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                     as Price,
      currency_code             as CurrencyCode,
      last_changed_at           as LastChangedAt,
      _suppl.SupplementCategory as SUPPLCAT,
      _suppltext.Description    as suppldesc,

      _suppl,
      _suppltext,
      _book,
      _travel
}

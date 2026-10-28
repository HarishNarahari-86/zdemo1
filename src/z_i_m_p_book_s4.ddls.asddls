@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor book suppliment 4'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo.typeName: 'Suppliment'
@UI.headerInfo.typeNamePlural: 'Suppliment Details'


define view entity z_i_m_p_book_s4
  as projection on z_i_m_book_s4
{
      @UI.facet: [{ type: #IDENTIFICATION_REFERENCE, purpose: #STANDARD, position: 10, label: 'Suppliment' }]

      @UI.identification: [{ position: 10 }]
      @UI.lineItem: [{ position: 10 }]
  key TravelId,

      @UI.identification: [{ position: 20 }]
      @UI.lineItem: [{ position: 20 }]
  key BookingId,

      @UI.identification: [{ position: 30 }]
      @UI.lineItem: [{ position: 30 }]
  key BookingSupplementId,

      @UI.identification: [{ position: 40 }]
      @UI.lineItem: [{ position: 40 }]
      SupplementId,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 50 }]
      @UI.lineItem: [{ position: 50 }]
      Price,


      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _booking : redirected to parent z_i_m_p_book4,
      _booksuppl,
      _suppl,
      _travel  : redirected to z_i_m_p_travel4
}

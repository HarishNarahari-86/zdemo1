@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor book 4'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo.typeName: 'Booking'
@UI.headerInfo.typeNamePlural: 'Booking Details'


define view entity z_i_m_p_book4
  as projection on z_i_m_book4
{
      @UI.facet: [{ position: 10, label: 'Bookings', type: #IDENTIFICATION_REFERENCE, purpose: #STANDARD },
      {id:'suppl', targetElement: '_suppl', position: 20, label: 'Suppliments', type: #LINEITEM_REFERENCE, purpose: #STANDARD}]

      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
  key travel_id,

      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
  key booking_id,

      @UI.identification: [{ position: 30 }]
      booking_date,

      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 40 }]
      customer_id,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 50 }]
      carrier_id,

      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 60 }]
      connection_id,

      @UI.identification: [{ position: 70 }]
      flight_date,

      @Semantics.amount.currencyCode: 'currency_code'
      @UI.identification: [{ position: 80 }]
      flight_price,

      currency_code,
      /* Associations */
      _carrier,
      _connect,
      _customer,
      _suppl  : redirected to composition child z_i_m_p_book_s4,
      _travel : redirected to parent z_i_m_p_travel4
}

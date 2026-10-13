@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor book 1'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Booking',
    typeNamePlural: 'Booking Details',

    title: {
        type: #STANDARD,
        label: 'Booking',
        criticalityRepresentation: #WITHOUT_ICON,
        value: 'BookingId'

    },
    description: {
        type: #STANDARD,
        label: 'Booking Details',
        criticality: 'BookingId',
        criticalityRepresentation: #WITH_ICON,
        value: 'BookingId'
    }
}
define view entity Z_I_M_A_BOOK1
  as projection on z_i_m_book1
{
      @UI.facet: [{ id:'Book', type: #IDENTIFICATION_REFERENCE, purpose: #STANDARD, label: 'Booking', position: 10 },
      {id:'suppl', type: #LINEITEM_REFERENCE, purpose: #STANDARD, label: 'Suppliment', position: 20, targetElement: '_booksuppl'}]

      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
  key TravelId,

      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
  key BookingId,

      @UI.identification: [{ position: 30 }]
      BookingDate,

      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 40 }]
      @ObjectModel.text.element: [ 'Customer' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_CUSTOMER',element: 'CustomerID'} }]
      CustomerId,
      _Customer.FirstName as customer,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 50 }]
      @ObjectModel.text.element: [ 'Carrier' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/dmo/i_carrier',element: 'AirlineID'} }]
      CarrierId,
      _carrier.Name       as Carrier,

      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 60 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Connection',element: 'ConnectionID'},
      additionalBinding: [{ element: 'AirlineID', localElement: 'CarrierId', usage: #FILTER }] }]
      ConnectionId,

      @UI.identification: [{ position: 70 }]
      FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 80 }]
      FlightPrice,

      CurrencyCode,
      /* Associations */
      _carrier,
      _Connect,
      _Customer,
      _travel    : redirected to parent z_i_m_a_travel1,
      _booksuppl : redirected to composition child z_i_m_a_book_s1
}

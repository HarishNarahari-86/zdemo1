@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor book 2'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Booking',
    typeNamePlural: 'Bookings',

    title: {
        type: #STANDARD,
        label: 'Travel Booking',
        value: 'BookingId'
    },
    description: {
        type: #STANDARD,
        label: 'Travel Booking',
        value: 'BookingId'
    }
}

@UI.presentationVariant: [{ sortOrder: [{ by: 'TravelId',direction: #ASC },
                                        { by: 'BookingId',direction: #ASC },
                                        { by: 'CustomerId',direction: #ASC }], visualizations: [{type: #AS_LINEITEM}] }]
define view entity z_i_m_p_book2
  as projection on z_i_m_book2
{

      @UI.facet: [{id:'Book', type:#IDENTIFICATION_REFERENCE, purpose: #STANDARD, position: 10, label: 'Booking Details'  }]


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
      @ObjectModel.text.element: [ 'customer' ]
      CustomerId,
      _customer.FirstName as customer,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 50 }]
      @ObjectModel.text.element: [ 'carrier' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/dmo/i_carrier',element: 'AirlineID'} }]
      CarrierId,
      _carrier.Name       as carrier,

      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 60 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Connection',element: 'ConnectionID'},
                additionalBinding: [{localElement: 'CarrierId',element: 'AirlineID',usage: #FILTER}] }]
      ConnectionId,


      @UI.identification: [{ position: 70 }]
      FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 80 }]
      FlightPrice,

      lastchangedat,

      CurrencyCode,
      /* Associations */
      _carrier,
      _connect,
      _customer,
      _travel : redirected to parent z_i_m_p_travel2
}

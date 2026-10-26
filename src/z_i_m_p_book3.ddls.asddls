@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor book 3'
@Metadata.ignorePropagatedAnnotations: true
@Search: {
    searchable: true
}

@UI.headerInfo: {
    typeName: 'Travel',
    typeNamePlural: 'Travel Details',
    title: {
        type: #STANDARD,
        label: 'Booking ID',
        value: 'BookingId'
    },
    description: {
        type: #STANDARD,
        label: 'Airline',
        value: 'CarrierId'
    }
}
@UI.presentationVariant: [{ sortOrder: [{by: 'TravelId',direction: #ASC},
                                        {by: 'BookingId',direction: #ASC},
                                        {by: 'CustomerId',direction: #ASC}],
                            visualizations: [{type: #AS_LINEITEM}] }]
define view entity z_i_m_p_book3
  as projection on z_i_m_book3
{

      @UI.facet: [{ type:#IDENTIFICATION_REFERENCE, purpose: #STANDARD, label: 'Booking', position: 10},
                  {type: #LINEITEM_REFERENCE, purpose: #STANDARD, label: 'Suppliments', position: 20, targetElement: '_suppliment'}]

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
      @Consumption.valueHelpDefinition: [{ entity: {name: '/dmo/i_customer',element: 'CustomerID'} }]
      CustomerId,
      _Customer.FirstName as Customer,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 50 }]
      @ObjectModel.text.element: [ 'Airline' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/dmo/i_carrier',element: 'AirlineID'} }]
      CarrierId,
      _carrier.AirlineID  as Airline,

      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 60 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Connection',element: 'ConnectionID'}, 
      additionalBinding: [{ localElement: 'CarrierId', element: 'AirlineID' }] }]
      ConnectionId,

      @UI.identification: [{ position: 70 }]
      FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 80 }]
      FlightPrice,

      @Search.defaultSearchElement: true
      CurrencyCode,

      /* Associations */
      _carrier,
      _connect,
      _Customer,
      _suppliment : redirected to composition child z_i_m_p_book_s3,
      _travel     : redirected to parent z_i_m_p_travel3
}

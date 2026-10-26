@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor travel 3'
@Metadata.ignorePropagatedAnnotations: true
@Search: {
    searchable: true
}

@UI.headerInfo: {
    typeName: 'Travel',
    typeNamePlural: 'Travel Details',
    title: {
        type: #STANDARD,
        label: 'Customer',
        value: 'CustomerId'
    },
    description: {
        type: #STANDARD,
        label: 'Agency',
        value: 'AgencyId'
    }
}
@UI.presentationVariant: [{ sortOrder: [{by: 'TravelId',direction: #ASC},
                                        {by: 'AgencyId',direction: #ASC},
                                        {by: 'CustomerId',direction: #ASC}],
                            visualizations: [{type: #AS_LINEITEM}] }]

define root view entity z_i_m_p_travel3
  as projection on z_i_m_travel3
{
      @UI.facet: [{type: #IDENTIFICATION_REFERENCE, purpose: #STANDARD, label: 'Travel', position: 10 },
      {type: #LINEITEM_REFERENCE, purpose: #STANDARD, targetElement: '_book', label: 'Travel Booking', position: 20}]


      @UI.selectionField: [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: 'z_i_m_travel3',element: 'TravelId'} }]
      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
  key TravelId,

      @UI.selectionField: [{ position: 20 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/dmo/i_agency',element: 'AgencyID'} }]
      @ObjectModel.text.element: [ 'agency' ]
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      AgencyId,
      _agency.Name        as agency,

      @UI.selectionField: [{ position: 30 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/dmo/i_Customer',element: 'CustomerID'} }]
      @ObjectModel.text.element: [ 'customer' ]
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      CustomerId,
      _customer.FirstName as customer,

      @UI.identification: [{ position: 40 }]
      BeginDate,

      @UI.identification: [{ position: 50 }]
      EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 60 }]
      BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 70 }]
      TotalPrice,
      CurrencyCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.70
      @UI.identification: [{ position: 80 }]
      Description,

      @UI.lineItem: [{ position: 40, criticality: 'statuscriticality' }]
      @ObjectModel.text.element: [ 'Text' ]
      @UI.identification: [{ position: 90, criticality: 'statuscriticality' }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Travel_Status_VH',element: 'TravelStatus'} }]
      Status,
      Text,
      statuscriticality,


      @UI.lineItem: [{ type: #FOR_ACTION, dataAction: 'upload', position: 10, label: 'Upload File' }]
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      /* Associations */
      _agency,
      _book : redirected to composition child z_i_m_p_book3,
      _customer,
      _statustext
}

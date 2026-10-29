@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor travel 4'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo.typeName: 'Travel'
@UI.headerInfo.typeNamePlural: 'Travel Details'


@Search: {
    searchable: true
}

@UI.presentationVariant: [{
    qualifier: '',
    id: 'travel_id',
    text: 'Travel',
    maxItems: 100,
    sortOrder: [{
        by: 'customer_id',
        direction:#ASC
    }],

    visualizations: [{
        type: #AS_LINEITEM
    }]

}]

define root view entity z_i_m_p_travel4
  as projection on z_i_m_travel4
{

      @UI.facet: [{ position: 10, label: 'Travel Details', type: #IDENTIFICATION_REFERENCE, purpose: #STANDARD, id: 'travelid' },
      {id: 'bookid', targetElement: '_booking', position: 20, label: 'Bookings', type: #LINEITEM_REFERENCE, purpose: #STANDARD}]

      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: 'z_i_m_travel4',element: 'travel_id'} }]
  key travel_id,

      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Agency',element: 'AgencyID'} }]
      @ObjectModel.text.element: [ 'Agency' ]
      agency_id,
      _agency.Name        as Agency,

      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Customer',element: 'CustomerID'} }]
      @ObjectModel.text.element: [ 'customer' ]
      customer_id,
      _customer.FirstName as customer,

      @UI.identification: [{ position: 40 }]
      begin_date,

      @UI.identification: [{ position: 50 }]
      end_date,

      @Semantics.amount.currencyCode: 'currency_code'
      @UI.identification: [{ position: 60 }]
      booking_fee,

      @Semantics.amount.currencyCode: 'currency_code'
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 70 }]
      total_price,

      currency_code,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @UI.identification: [{ position: 80 }]
      description,

      @UI.selectionField: [{ position: 40 }]
      @UI.lineItem: [{ position: 50, criticality: 'statuscriticality' }]
      @UI.identification: [{ position: 90, criticality: 'statuscriticality' }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Travel_Status_VH_Text',element: 'TravelStatus'} }]
      @ObjectModel.text.element: [ 'statustext' ]
      status,
      _status.Text        as statustext,
      statuscriticality,

      @UI.lineItem: [{ label: 'Copy Travel', position: 130, type: #FOR_ACTION, dataAction: 'copytravel'}]
      createdby,
      createdat,
      lastchangedby,
      lastchangedat,

      /* Associations */
      _agency,
      _customer,
      _booking : redirected to composition child z_i_m_p_book4,
      _status
}

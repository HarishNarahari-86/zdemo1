@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor travel 2'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@UI.headerInfo: {
    typeName: 'Travel',
    typeNamePlural: 'Travels',
    title: {
        type: #STANDARD,
        label: 'Travel ID',
        value: 'TravelId'
    },
    description: {
        type: #STANDARD,
        label: 'Travel ID',
        value: 'TravelId'
    }
}

@UI.selectionPresentationVariant: [{
    qualifier: 'TravelId',
    id: 'TravelId',
    text: 'Travel ID'
}]

@UI.presentationVariant: [{ sortOrder: [{by: 'TravelId',direction:#ASC },
                                        {by: 'AgencyId',direction:#ASC },
                                        {by: 'CustomerId',direction:#ASC}],
                           visualizations: [{type: #AS_LINEITEM}] } ]

define root view entity z_i_m_p_travel2
  as projection on z_i_m_travel2
{

      @UI.facet: [{id:'TravelId',type: #FIELDGROUP_REFERENCE, purpose: #STANDARD, position: 10, label: 'Traveler',targetQualifier: 'Travel'},
                  {id:'Date',type: #FIELDGROUP_REFERENCE, purpose: #STANDARD, position: 20, label: 'Travel Dates',targetQualifier: 'Date'},
                  {id:'Cost',type: #FIELDGROUP_REFERENCE, purpose: #STANDARD, position: 30, label: 'Cost',targetQualifier: 'Cost'},
                  {id:'Status',type: #FIELDGROUP_REFERENCE, purpose: #STANDARD, position: 40, label: 'Status & Description',targetQualifier: 'Status'},
                  {id:'Booking', type: #LINEITEM_REFERENCE, purpose: #STANDARD, position: 50, label: 'Traveler Booking Details', targetElement:'_book'}]

      @UI.lineItem: [{position: 10}]
      @UI.selectionField: [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: 'z_i_m_travel2',element: 'TravelId'} }]
      @UI.fieldGroup: [{ qualifier: 'Travel', position: 10 }]
  key TravelId,

      @UI.lineItem: [{position: 20}]
      @ObjectModel.text.element: [ 'Agency' ]
      @UI.selectionField: [{ position: 20 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/dmo/i_agency',element: 'AgencyID'} }]
      @UI.fieldGroup: [{ qualifier: 'Travel', position: 20 }]
      AgencyId,
      _agency.Name        as Agency,

      @UI.lineItem: [{position: 30}]
      @ObjectModel.text.element: [ 'Customer' ]
      @UI.selectionField: [{ position: 30 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/dmo/i_customer',element: 'CustomerID'} }]
      @UI.fieldGroup: [{ qualifier: 'Travel', position: 20 }]
      CustomerId,
      _customer.FirstName as Customer,

      @UI.fieldGroup: [{ qualifier: 'Date', position: 10 }]
      BeginDate,
      @UI.fieldGroup: [{ qualifier: 'Date', position: 20 }]
      EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.fieldGroup: [{ qualifier: 'Cost', position: 10 }]
      BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.lineItem: [{position: 50}]
      @UI.fieldGroup: [{ qualifier: 'Cost', position: 20 }]
      TotalPrice,

      CurrencyCode,

      @Search.defaultSearchElement: true
      @UI.fieldGroup: [{ qualifier: 'Status', position: 10 }]
      Description,

      @UI.lineItem: [{position: 40, criticality: 'StatusCriticality', label: 'Status'}]
      @ObjectModel.text.element: [ 'statustext' ]
      @UI.fieldGroup: [{ qualifier: 'Status', position: 20, criticality: 'StatusCriticality' }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Travel_Status_VH_Text',element: 'TravelStatus'} }]
      Status,
      StatusCriticality,



      @UI.selectionField: [{ position: 40 }]
      @UI.fieldGroup: [{ qualifier: 'Status', position: 30 }]
      statustext,


      @UI.lineItem: [{ type: #FOR_ACTION, dataAction: 'copytravel', position: 10, label: 'Copy Travel' }]
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      /* Associations */
      _agency,
      _currency,
      _customer,
      _statustext,
      _book : redirected to composition child z_i_m_p_book2
}

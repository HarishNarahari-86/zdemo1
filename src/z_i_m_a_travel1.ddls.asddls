@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor travel 1'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.typeName: 'Travel'
@UI.headerInfo.typeNamePlural: 'Travel Details'
@UI.headerInfo.title: {
    type: #STANDARD,
    label: 'Travel Document',
    value: 'TravelId'
}
@UI.headerInfo.description: {
    type: #STANDARD,
    label: 'Travel Doc',
    value: 'TravelId'
}

@UI.presentationVariant: [{
    sortOrder: [{
        by: 'AgencyId',
        direction: #ASC
    }], visualizations: [{type: #AS_LINEITEM}]}]
@Search: {
    searchable: true
}
define root view entity Z_I_M_A_TRAVEL1
  as projection on z_i_m_travel1
{

      @UI.facet: [{ id:'TravelId', targetQualifier: 'Travel', type: #FIELDGROUP_REFERENCE, purpose: #STANDARD, label: 'Traveler Document', position: 10 },
                  { id:'Date', targetQualifier: 'Dates', type: #FIELDGROUP_REFERENCE, purpose: #STANDARD, label: 'Traveler Dates', position: 20 },
                  { id:'Finance', targetQualifier: 'Finance', type: #FIELDGROUP_REFERENCE, purpose: #STANDARD, label: 'Billing Details', position: 30 },
                  { id:'Addlinfo', targetQualifier: 'Addl', type: #FIELDGROUP_REFERENCE, purpose: #STANDARD, label: 'Status & Addl Info', position: 40 },
                  { id:'Book', type: #LINEITEM_REFERENCE, purpose: #STANDARD, label: 'Booking', position: 50, targetElement: '_book'}]

      @UI.lineItem: [{ position: 10, label: 'Travel Doc' }]
      @UI.fieldGroup: [{ position: 10, qualifier: 'Travel'}]
      @UI.selectionField: [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: 'z_i_m_travel1',element: 'TravelId'} }]
  key TravelId,

      @UI.lineItem: [{ position: 20 }]
      @UI.fieldGroup: [{ position: 20, qualifier: 'Travel'}]
      @UI.selectionField: [{ position: 20 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Agency',element: 'AgencyID'} }]
      @ObjectModel.text.element: [ 'Agency' ]
      AgencyId,
      _agency.Name        as Agency,

      @UI.lineItem: [{ position: 30 }]
      @UI.fieldGroup: [{ position: 30,  qualifier: 'Travel'}]
      @UI.selectionField: [{ position: 30 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Customer',element: 'CustomerID'} }]
      @ObjectModel.text.element: [ 'Customer' ]
      CustomerId,
      _customer.FirstName as Customer,

      //@UI.identification: [{ position: 40 }]
      @UI.fieldGroup: [{ position: 10, qualifier: 'Dates'}]
      BeginDate,

      //@UI.identification: [{ position: 50 }]
      @UI.fieldGroup: [{ position: 20, qualifier: 'Dates'}]
      EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      //@UI.identification: [{ position: 60 }]
      @UI.fieldGroup: [{ position: 10, qualifier: 'Finance'}]
      BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.lineItem: [{ position: 50 }]
      //@UI.identification: [{ position: 70 }]
      @UI.fieldGroup: [{ position: 20, qualifier: 'Finance'}]
      TotalPrice,

      CurrencyCode,

      //@UI.identification: [{ position: 80 }]
      @UI.fieldGroup: [{ position: 10, qualifier: 'Addl' }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.70
      Description,

      @UI.lineItem: [{ position: 40, label: 'Status' }]
      //@UI.identification: [{ position: 90 }]
      @UI.fieldGroup: [{ position: 20, qualifier: 'Addl' }]
      @ObjectModel.text.element: [ 'statustext' ]
      Status,
      _statustext.Text    as statustext,


      @UI.lineItem: [{ type: #FOR_ACTION, dataAction: 'approve', label: 'Approve', position: 10 },
                     { type: #FOR_ACTION, dataAction: 'reject', label: 'Reject', position: 20 }]
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      /* Associations */
      _agency,
      _customer,
      _book : redirected to composition child Z_I_M_A_BOOK1,
      _statustext
}

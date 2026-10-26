@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor book suppliment 1'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'Suppliment',
    typeNamePlural: 'Summpliment Details',

    title: {
        type: #STANDARD,
        label: 'Suppliment',
        value: 'BookingSupplementId'
    },
    description: {
        type: #STANDARD,
        label: 'Suppliment Details'
    }
}
define view entity Z_I_M_A_BOOK_S1
  as projection on z_i_m_book_s1
{
      @UI.facet: [{ id:'Suppl', type: #IDENTIFICATION_REFERENCE, purpose: #STANDARD, label: 'Suppliment Details', position: 10 }]
      @UI.identification: [{ position: 10 }]

  key TravelId,

      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 20 }]
  key BookingId,

      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 30 }]
  key BookingSupplementId,

      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 40 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Supplement',element: 'SupplementID'},
      additionalBinding: [{
          localElement: 'SUPPLCAT',
          element: 'SupplementCategory',
          usage: #FILTER
      }] }]
      SupplementId,

      @UI.lineItem: [{ position:40  }]
      @UI.identification: [{ position: 45 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Supplement',element: 'SupplementCategory'},
      additionalBinding: [{ element: 'Description', localElement: 'suppldesc', usage: #RESULT }] }]
      SUPPLCAT,

      @UI.lineItem: [{ position:50  }]
      @UI.identification: [{ position: 46 }]
      suppldesc,


      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 50 }]
      Price,

      CurrencyCode,
      LastChangedAt,

      /* Associations */
      _book   : redirected to parent z_i_m_a_book1,
      _suppl,
      _suppltext,
      _travel : redirected to z_i_m_a_travel1
}

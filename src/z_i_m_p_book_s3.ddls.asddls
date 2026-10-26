@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project view processor book suppliment 3'
@Metadata.ignorePropagatedAnnotations: true
@Search: {
    searchable: true
}

@UI.headerInfo: {
    typeName: 'Travel',
    typeNamePlural: 'Travel Details',
    title: {
        type: #STANDARD,
        label: 'Supplement',
        value: 'SupplementId'
    },
    description: {
        type: #STANDARD,
        label: 'Supplement',
        value: 'SupplementId'
    }
}
@UI.presentationVariant: [{ sortOrder: [{by: 'TravelId',direction: #ASC},
                                        {by: 'BookingId',direction: #ASC},
                                        {by: 'BookingSupplementId',direction: #ASC}],
                            visualizations: [{type: #AS_LINEITEM}] }]
define view entity z_i_m_p_book_s3
  as projection on z_i_m_book_s3
{
      @UI.facet: [{ type: #IDENTIFICATION_REFERENCE, purpose: #STANDARD, label: 'Suppliment',position: 10  }]

      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
  key TravelId,

      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
  key BookingId,

      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
  key BookingSupplementId,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_BookSuppl_M',element: 'supplement_id'} }]
      SupplementId,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 50 }]
      Price,

      @Search.defaultSearchElement: true
      CurrencyCode,

      LastChangedAt,
      /* Associations */
      _book   : redirected to parent z_i_m_p_book3,
      _booksuppl,
      _suppl,
      _travel : redirected to z_i_m_p_travel3
}

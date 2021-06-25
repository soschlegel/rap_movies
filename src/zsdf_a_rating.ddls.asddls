@EndUserText.label: 'Parameter for Rating'
define abstract entity zsdf_a_rating
{
  @Consumption.valueHelpDefinition: [{
      entity: {
          name: 'ZSDF_I_Ratings',
          element: 'Rating'
      }
  }]
//  @ObjectModel.mandatory: true
  rating : zsdf_rating;
}

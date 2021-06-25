@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forMovie'
@Search.searchable: true
define root view entity ZSDF_C_MOVIE_M
  as projection on ZSDF_I_MOVIE_M
{
  key MovieID,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.90
      Title,

      PersonID,

      ReleaseDate,

      LastChangedAt,

      Category,
      
      CategoryText,

      Rating,

      Watched,
      
      _Category
}

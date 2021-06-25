@EndUserText.label: 'Movies'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZSDF_C_MOVIE_M_Children
  as projection on ZSDF_I_MOVIE_M
{
  key MovieID,
      Title,
      ReleaseDate,
      PersonID,
      LastChangedAt,
      Rating

}
where
  Category = 'KI'

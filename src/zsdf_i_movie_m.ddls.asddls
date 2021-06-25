@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forMovie'
define root view entity ZSDF_I_MOVIE_M
  as select from zsdf_movie
  association [1] to ZSDF_I_Categories as _Category on _Category.Category = $projection.Category
  association [1] to zsdf_I_ratings    as _Ratings  on _Ratings.Rating = $projection.Rating
{
      @UI.hidden: true
  key movie_id        as MovieID,

      title           as Title,

      release_date    as ReleaseDate,

      person_id       as PersonID,

      @ObjectModel.text.element: ['CategoryText']
      category        as Category,
      @UI.textArrangement: #TEXT_ONLY
      _Category.text  as CategoryText,

      watched         as Watched,

      @ObjectModel.text.element: ['RatingText']
      rating          as Rating,
      @UI.textArrangement: #TEXT_ONLY
      _Ratings.text   as RatingText,


      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,

      _Category,

      _Ratings
}

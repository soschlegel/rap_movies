*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_movie DEFINITION INHERITING FROM cl_abap_behavior_handler.


  PRIVATE SECTION.

    METHODS:
*      features FOR FEATURES
*        IMPORTING keys
*                    REQUEST requested_features
*                    FOR Movie
*        RESULT    result,
      mark_as_watched FOR MODIFY
        IMPORTING keys
                    FOR ACTION Movie~markAsWatched
        RESULT    result,
      set_rating FOR MODIFY
        IMPORTING keys
                    FOR ACTION Movie~rateAMovie
        RESULT    result.

ENDCLASS.

CLASS lhc_movie IMPLEMENTATION.

*  METHOD features.
*
*    READ ENTITY zsdf_c_movie_m
*            FIELDS ( Watched )
*              WITH CORRESPONDING #( keys )
*            RESULT DATA(Movies).
*
*    LOOP AT movies ASSIGNING FIELD-SYMBOL(<movie>).
*
*      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<result>).
*      <result>-%key = <movie>-%key.
*
*      <result>-%features-%action-markAsWatched = COND #(  WHEN <movie>-Watched EQ abap_true
*                                                            THEN if_abap_behv=>fc-o-disabled
*                                                            ELSE if_abap_behv=>fc-o-enabled ).
*
*      <result>-%features-%action-rateAMovie = COND #(  WHEN <movie>-Watched EQ abap_true
*                                                          THEN if_abap_behv=>fc-o-enabled
*                                                          ELSE if_abap_behv=>fc-o-disabled ).
*
*
*    ENDLOOP.
*
*
*  ENDMETHOD.

*  METHOD mark_as_watch.
*
*    READ ENTITIES OF zsdf_i_movie_m IN LOCAL MODE
*         ENTITY Movie
*            ALL FIELDS
*            WITH CORRESPONDING #( keys )
*         RESULT DATA(movies)
*         FAILED failed.
*
*    LOOP AT movies ASSIGNING FIELD-SYMBOL(<movie>).
*
*      <movie>-Watched = abap_true.
*
*      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<result>).
*      <result>-%param = CORRESPONDING #( <movie> ).
*      <result>-MovieID = <movie>-MovieID.
*
*    ENDLOOP.
*
*    MODIFY ENTITIES OF zsdf_i_movie_m IN LOCAL MODE
*      ENTITY Movie
*        UPDATE FIELDS ( Watched )
*        WITH CORRESPONDING #( movies ).
*
*  ENDMETHOD.


  METHOD mark_as_watched.

    " Modify in local mode: BO-related updates that are not relevant for authorization checks
    MODIFY ENTITIES OF zsdf_i_movie_m IN LOCAL MODE
           ENTITY Movie
              UPDATE FIELDS ( Watched )
                 WITH VALUE #( FOR key IN keys ( MovieID    = key-MovieID
                                                 Watched    = abap_true ) ) " Accepted
           FAILED   failed
           REPORTED reported.

    " Read changed data for action result
    READ ENTITIES OF zsdf_i_movie_m IN LOCAL MODE
         ENTITY Movie
*           ALL FIELDS
            FIELDS (    MovieID
                        Rating
                        RatingText
                        ReleaseDate
                        Watched
                        Title
                        Category
                        CategoryText )
             WITH VALUE #( FOR key IN keys ( MovieID = key-MovieID ) )
         RESULT DATA(movies).

    result = VALUE #( FOR movie IN movies ( MovieID = movie-MovieID
                                             %param    = movie ) ).

  ENDMETHOD.

  METHOD set_rating.

    MODIFY ENTITIES OF zsdf_i_movie_m IN LOCAL MODE
           ENTITY Movie
              UPDATE FIELDS ( Rating )
                 WITH VALUE #( FOR key IN keys ( MovieID    = key-MovieID
                                                 Watched    = key-%param-rating ) ) " Accepted
           FAILED   failed
           REPORTED reported.

    " Read changed data for action result
    READ ENTITIES OF zsdf_i_movie_m IN LOCAL MODE
         ENTITY Movie
           ALL FIELDS
             WITH CORRESPONDING #( keys )
         RESULT DATA(movies).

    result = VALUE #( FOR movie IN movies ( MovieID = movie-MovieID
                                             %param    = movie ) ).

  ENDMETHOD.

ENDCLASS.

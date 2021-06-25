CLASS lhc_Person DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Person.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Person.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Person.

    METHODS read FOR READ
      IMPORTING keys FOR READ Person RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Person.

ENDCLASS.

CLASS lhc_Person IMPLEMENTATION.

  METHOD create.

     data ls_person_db type zsdf_person.

     loop at entities ASSIGNING field-symbol(<person>).

        ls_person_db = CORRESPONDING #( <person> mapping from entity using control ).

        ls_person_db-person_id = cl_system_uuid=>create_uuid_x16_static( ).

        insert zsdf_person from @ls_person_db.
        if sy-subrc = 0.
          APPEND VALUE #( %cid        = <person>-%cid
                          personid    = <person>-PersonId )
                 TO mapped-person.
        else.
          APPEND VALUE #( %cid        = <person>-%cid
                          personid    = <person>-PersonId )
                 TO failed-person.

          APPEND VALUE #( %msg          = NEW zcx_sdf_person(
                                                 severity  = if_abap_behv_message=>severity-error
                                                 textid    = zcx_sdf_person=>insert_failed )
                          %key-PersonID = <person>-PersonId
                          %cid          = <person>-%cid
                          PersonID      = <person>-PersonId )
                 TO reported-person.
        endif.

     endloop.

  ENDMETHOD.

  METHOD update.

     types: typ_person_db type zsdf_person with indicators ind.

     data ls_person_db type typ_person_db.

     loop at entities ASSIGNING field-symbol(<person>).

        clear: ls_person_db.
        ls_person_db-person_id = <person>-personid.
        ls_person_db-first_name = <person>-FirstName.
        ls_person_db-last_name = <person>-lastname.
        ls_person_db-ind-first_name = <person>-%control-FirstName.
        ls_person_db-ind-last_name = <person>-%control-LastName.

        get time stamp field ls_person_db-last_changed_at.
        ls_person_db-ind-last_changed_at = 1.

        update zsdf_person from @ls_person_db indicators set structure ind.
        if sy-subrc = 0.
          APPEND VALUE #( %cid        = <person>-%cid_ref
                          personid    = <person>-PersonId )
                 TO mapped-person.
        else.
          APPEND VALUE #( %cid        = <person>-%cid_ref
                          personid    = <person>-PersonId )
                 TO failed-person.

          APPEND VALUE #( %msg          = NEW zcx_sdf_person(
                                                 severity  = if_abap_behv_message=>severity-error
                                                 textid    = zcx_sdf_person=>update_failed )
                          %key-PersonID = <person>-PersonId
                          %cid          = <person>-%cid_ref
                          PersonID      = <person>-PersonId )
                 TO reported-person.
        endif.

     endloop.

  ENDMETHOD.

  METHOD delete.

      loop at keys ASSIGNING field-symbol(<person_key>).

         delete from zsdf_person where person_id = @<person_key>-PersonId.
        if sy-subrc = 0.
          APPEND VALUE #( %cid        = <person_key>-%cid_ref
                          personid    = <person_key>-PersonId )
                 TO mapped-person.
          APPEND VALUE #( %msg          = NEW zcx_sdf_person(
                                                 severity  = if_abap_behv_message=>severity-error
                                                 textid    = zcx_sdf_person=>delete_successful )
                          %key-PersonID = <person_key>-PersonId
                          %cid          = <person_key>-%cid_ref
                          PersonID      = <person_key>-PersonId )
                 TO reported-person.
        else.
          APPEND VALUE #( %cid        = <person_key>-%cid_ref
                          personid    = <person_key>-PersonId )
                 TO failed-person.

          APPEND VALUE #( %msg          = NEW zcx_sdf_person(
                                                 severity  = if_abap_behv_message=>severity-error
                                                 textid    = zcx_sdf_person=>delete_failed )
                          %key-PersonID = <person_key>-PersonId
                          %cid          = <person_key>-%cid_ref
                          PersonID      = <person_key>-PersonId )
                 TO reported-person.
        endif.

      endloop.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZSDF_I_PERSON_U DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZSDF_I_PERSON_U IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR travel RESULT result.
    METHODS earlynumbering_create FOR NUMBERING
       entities FOR CREATE travel.

ENDCLASS.

CLASS lhc_travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    SELECT MAX( travel_id ) FROM z_i_m_travel4 INTO @DATA(lv_travel_id).

    DATA : lt_create TYPE TABLE FOR CREATE z_i_m_travel4.

    lv_travel_id += 1.


    LOOP AT entities INTO DATA(ls_entity).


      IF ls_entity-travel_id IS INITIAL.

        APPEND VALUE #(
        %cid = ls_entity-%cid
        travel_id = lv_travel_id
         ) TO mapped-travel.

      ELSE.
        APPEND VALUE #(
       %cid = ls_entity-%cid
       travel_id = ls_entity-travel_id
        ) TO mapped-travel.

      ENDIF.

    ENDLOOP.



  ENDMETHOD.
















ENDCLASS.

CLASS lhc_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR travel RESULT result.
    METHODS copytravel FOR MODIFY
       keys FOR ACTION travel~copytravel RESULT result.
    METHODS travel_dates FOR DETERMINE ON MODIFY
       keys FOR travel~travel_dates.
    METHODS earlynumbering_create FOR NUMBERING
       entities FOR CREATE travel.

ENDCLASS.

CLASS lhc_travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA lv_travel_id_n TYPE z_i_m_travel4-travel_id.

    SELECT MAX( travel_id ) FROM z_i_m_travel4 INTO @DATA(lv_travel_id).

    LOOP AT entities INTO DATA(ls_entity).

      lv_travel_id_n = lv_travel_id + 1.

      APPEND VALUE #(
      %cid = ls_entity-%cid
      %is_draft = ls_entity-%is_draft
      travel_id = lv_travel_id_n
       ) TO mapped-travel.

    ENDLOOP.

  ENDMETHOD.

  METHOD copytravel.

    DATA : lt_create TYPE TABLE FOR CREATE z_i_m_travel4.

    SELECT MAX( travel_id ) FROM z_i_m_travel4 INTO @DATA(lv_travel_id).

    READ ENTITY z_i_m_travel4
    FROM VALUE #( FOR keyval IN keys ( %key = keyval-%key
    %control-travel_id = if_abap_behv=>mk-on
    %control-agency_id = if_abap_behv=>mk-on
    %control-customer_id = if_abap_behv=>mk-on ) )
    RESULT DATA(lt_travel).

    lt_create = VALUE #( FOR row IN lt_travel INDEX INTO idx (
    %cid = |copy{ lv_travel_id }|
    agency_id = row-agency_id
    customer_id = row-customer_id
    %control = VALUE #(
    agency_id = if_abap_behv=>mk-on
    customer_id = if_abap_behv=>mk-on
    )
    ) ).

    MODIFY ENTITIES OF z_i_m_travel4 IN LOCAL MODE
    ENTITY travel
    CREATE FROM lt_create
    MAPPED mapped
    FAILED failed
    REPORTED reported.


    result = VALUE #( FOR source IN keys INDEX INTO idx
    LET new_cid = lt_create[ idx ]-%cid IN (

    %cid_ref = source-%cid_ref
    %key = keys[ idx ]-%key
    %param = VALUE #( travel_id = mapped-travel[ %cid = new_cid ]-travel_id )


    ) ).

  ENDMETHOD.

  METHOD travel_dates.

    READ ENTITIES OF z_i_m_travel4 IN LOCAL MODE
    ENTITY travel
    FIELDS ( begin_Date end_date )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_Dates).

    DATA : lt_begin_Date TYPE TABLE FOR UPDATE z_i_m_travel4.

    LOOP AT lt_dates ASSIGNING FIELD-SYMBOL(<fs_dates>).
      IF <fs_dates>-begin_date IS INITIAL.

        lt_begin_Date = VALUE #( FOR keyval IN keys (
        %tky = keyval-%tky
        begin_date = cl_abap_context_info=>get_system_date( )
        %control = VALUE #(
        begin_date = if_abap_behv=>mk-on )

         ) ).


      ENDIF.
    ENDLOOP.

    IF lt_begin_date IS NOT INITIAL.
      MODIFY ENTITIES OF z_i_m_travel4 IN LOCAL MODE
      ENTITY travel
      UPDATE FROM lt_begin_date
      MAPPED DATA(lt_map)
      FAILED DATA(lt_fail)
      REPORTED DATA(lt_report).
    ENDIF.




  ENDMETHOD.



ENDCLASS.

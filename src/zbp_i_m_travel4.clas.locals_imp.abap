CLASS lhc_booking DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS earlynumbering_cba_Suppl FOR NUMBERING
       entities FOR CREATE booking\_Suppl.

ENDCLASS.




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
    METHODS validate_fees FOR VALIDATE ON SAVE
       keys FOR travel~validate_fees.
    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR travel RESULT result.
    METHODS earlynumbering_cba_booking FOR NUMBERING
       entities FOR CREATE travel\_booking.
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
    FIELDS ( begin_date end_date )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel_dates).

    DATA : lt_travel_update TYPE TABLE FOR UPDATE z_i_m_travel4.

    LOOP AT lt_travel_Dates ASSIGNING FIELD-SYMBOL(<fs_travel_Date>).

      IF <fs_travel_Date>-begin_date IS INITIAL.

        lt_travel_update = VALUE #( FOR keyval IN keys (
        %tky = keyval-%tky
        begin_date = cl_abap_context_info=>get_system_date( )
        end_date = cl_abap_context_info=>get_system_date( ) + 30
        %control = VALUE #(
        begin_date = if_abap_behv=>mk-on
        end_date = if_Abap_behv=>mk-on
        )
        )
        ).

      ENDIF.

    ENDLOOP.

    IF lt_travel_update IS NOT INITIAL.

      MODIFY ENTITIES OF z_i_m_travel4 IN LOCAL MODE
      ENTITY travel
      UPDATE FROM lt_travel_update
      MAPPED DATA(lt_map)
      FAILED DATA(lt_fail)
      REPORTED DATA(lt_report).

    ENDIF.

  ENDMETHOD.


  METHOD earlynumbering_cba_Booking.


    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
      SELECT MAX( booking_id ) FROM z_i_m_book4 WHERE travel_id = @<entity>-travel_id INTO @DATA(lv_book_id).

      LOOP AT <entity>-%target ASSIGNING FIELD-SYMBOL(<booking>).
        APPEND VALUE #(
        %cID = <booking>-%cid
        %is_draft = <booking>-%is_draft
        travel_id = <booking>-travel_id
        booking_id = lv_book_id + 1

        ) TO mapped-booking.
      ENDLOOP.

    ENDLOOP.


  ENDMETHOD.

  METHOD validate_fees.

    READ ENTITIES OF z_i_m_travel4 IN LOCAL MODE
    ENTITY travel
    FIELDS ( booking_fee total_price )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_fees).

    LOOP AT lt_fees ASSIGNING FIELD-SYMBOL(<fs_fees>).

      DATA(lv_failed) = abap_false.

      IF <fs_fees>-booking_fee IS INITIAL.

        lv_failed = abap_true.

        APPEND VALUE #(
           %tky = <fs_fees>-%tky
          %msg = new_message(
                   id       = 'ZMESSAGE'
                   number   = 003
                   severity = if_abap_behv_message=>severity-error
*                   v1       =
*                   v2       =
*                   v3       =
*                   v4       =
                 )

        %element-booking_fee = if_abap_behv=>mk-on
        ) TO reported-travel
        .


      ENDIF.
      IF <fs_fees>-total_price IS INITIAL OR <fs_fees>-booking_fee > <fs_fees>-total_price.

        lv_failed = abap_true.
        APPEND VALUE #(
           %tky = <fs_fees>-%tky
          %msg = new_message(
                   id       = 'ZMESSAGE'
                   number   = 004
                   severity = if_abap_behv_message=>severity-error
*                   v1       =
*                   v2       =
*                   v3       =
*                   v4       =
                 )

        %element-total_price = if_abap_behv=>mk-on
        ) TO reported-travel
        .


      ENDIF.

      IF lv_failed = abap_true.
        APPEND VALUE #(
        %tky = <fs_fees>-%tky

         ) TO failed-travel.


      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD get_instance_features.


    READ ENTITIES OF z_i_m_travel4 IN LOCAL MODE
    ENTITY travel
    FIELDS ( agency_id customer_id )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_customer).


    result = VALUE #( FOR ls_Customer IN lt_customer
    (
    %tky = ls_customer-%tky

   %features-%field-customer_id = COND #( WHEN ls_customer-customer_id IS INITIAL THEN if_abap_behv=>fc-f-unrestricted
   ELSE if_abap_behv=>fc-f-read_only )

   %features-%field-agency_id = COND #( WHEN ls_customer-agency_id IS INITIAL THEN if_abap_behv=>fc-f-unrestricted
   ELSE if_abap_behv=>fc-f-read_only )


    )

     ).


  ENDMETHOD.

ENDCLASS.

CLASS lhc_booking IMPLEMENTATION.

  METHOD earlynumbering_cba_Suppl.


    LOOP AT entities ASSIGNING FIELD-SYMBOL(<booking>).

      SELECT MAX( BookingSupplementId ) FROM z_i_m_book_s4 WHERE TravelId = @<booking>-travel_id AND BookingId = @<booking>-booking_id
      INTO @DATA(lV_suppliment).

      LOOP AT <booking>-%target ASSIGNING FIELD-SYMBOL(<suppliment>).

        APPEND VALUE #(
        %cid = <suppliment>-%cid
        %is_draft = <suppliment>-%is_draft
        travelid = <suppliment>-TravelId
        bookingid = <suppliment>-BookingId
        BookingSupplementId = lv_suppliment + 1
        ) TO mapped-suppl.

      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_z_i_m_travel1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR z_i_m_travel1 RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR z_i_m_travel1 RESULT result.
    METHODS validation FOR VALIDATE ON SAVE
       keys FOR travel~validation.
    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR travel RESULT result.

    METHODS approve FOR MODIFY
       keys FOR ACTION travel~approve RESULT result.

    METHODS reject FOR MODIFY
       keys FOR ACTION travel~reject RESULT result.

ENDCLASS.

CLASS lhc_z_i_m_travel1 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.



  METHOD validation.

    READ ENTITY z_i_m_travel1
    FIELDS ( AgencyId CustomerId BookingFee TotalPrice )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel).


    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).

*      IF <fs_travel>-AgencyId IS INITIAL.
*        APPEND VALUE #( %tky = <fs_travel>-%tky ) TO failed-travel.
*
*        APPEND VALUE #( %tky = <fs_travel>-%tky
*                        %msg = new_message(
*                                 id       = 'ZMESSAGE'
*                                 number   = 001
*                                 severity = if_abap_behv_message=>severity-error
**                                 v1       =
**                                 v2       =
**                                 v3       =
**                                 v4       =
*                               )
*                               %element-AgencyId = if_abap_behv=>mk-on
*         ) TO reported-travel.
*
*
*      ENDIF.
      IF <fs_travel>-CustomerId IS INITIAL.
        APPEND VALUE #( %tky = <fs_travel>-%tky ) TO failed-travel.

        APPEND VALUE #( %tky = <fs_travel>-%tky
                        %msg = new_message(
                                 id       = 'ZMESSAGE'
                                 number   = 002
                                 severity = if_abap_behv_message=>severity-error
*                                 v1       =
*                                 v2       =
*                                 v3       =
*                                 v4       =
                               )
                               %element-cUSTOMERID = if_abap_behv=>mk-on
                               ) TO reported-travel.

      ENDIF.
      IF <fs_travel>-BookingFee < 0.

        APPEND VALUE #( %tky = <fs_travel>-%tky ) TO failed-travel.

        APPEND VALUE #( %tky = <fs_travel>-%tky
                        %msg = new_message(
                                 id       = 'ZMESSAGE'
                                 number   = 003
                                 severity = if_abap_behv_message=>severity-error
*                         v1       =
*                         v2       =
*                         v3       =
*                         v4       =
                               )
        %element-bookingfee = if_abap_behv=>mk-on
        ) TO reported-travel.

      ENDIF.
      IF <fs_travel>-TotalPrice < 0.
        APPEND VALUE #( %tky = <fs_travel>-%tky ) TO failed-travel.

        APPEND VALUE #( %tky = <fs_travel>-%tky
                        %msg = new_message(
                                 id       = 'ZMESSAGE'
                                 number   = 004
                                 severity = if_abap_behv_message=>severity-error
*                         v1       =
*                         v2       =
*                         v3       =
*                         v4       =
                               )
                               %element-totalprice = if_abap_behv=>mk-on
        ) TO reported-travel.

      ENDIF.


    ENDLOOP.

  ENDMETHOD.




  METHOD get_instance_features.

    READ ENTITIES OF z_i_m_travel1 IN LOCAL MODE
    ENTITY travel
    FIELDS ( status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_status).


    resUlt = VALUE #( FOR ls_status IN lt_status (
                %tky = ls_status-%tky
                %action-approve = COND #( WHEN ls_status-Status = 'N' THEN if_abap_behv=>fc-o-disabled
                ELSE if_abap_behv=>fc-o-enabled )
    ) ).

    resUlt = VALUE #( FOR ls_status IN lt_status (
                 %tky = ls_status-%tky
                 %action-reject = COND #( WHEN ls_status-Status = 'B' THEN if_abap_behv=>fc-o-disabled
                 ELSE if_abap_behv=>fc-o-enabled )
     ) ).

  ENDMETHOD.

  METHOD approve.

  ENDMETHOD.

  METHOD reject.

  ENDMETHOD.

ENDCLASS.

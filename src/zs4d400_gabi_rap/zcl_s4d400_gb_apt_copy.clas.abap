CLASS zcl_s4d400_gb_apt_copy DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_S4D400_GB_APT_COPY IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA tt TYPE TABLE OF zgb_flight.

    SELECT FROM /dmo/flight FIELDS *
        INTO CORRESPONDING FIELDS OF TABLE @tt.

    LOOP AT tt INTO DATA(row).
      INSERT zgb_flight FROM @row.
    ENDLOOP.

    IF sy-subrc = 0.
      out->write( `Database table zgb_flight was filled with data!`  ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

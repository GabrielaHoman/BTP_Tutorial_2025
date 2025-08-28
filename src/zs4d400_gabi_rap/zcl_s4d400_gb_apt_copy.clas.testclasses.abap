*"* use this source file for your ABAP unit test classes
CLASS ltcl_find_flights DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_find_cargo_flight FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_find_flights IMPLEMENTATION.

  METHOD test_find_cargo_flight.
    SELECT SINGLE FROM /dmo/flight FIELDS carrier_id, connection_id, flight_date INTO @DATA(flight_data).
    IF sy-subrc <> 0.
      cl_abap_unit_assert=>fail( `NO DATA.` ).
    ENDIF.
    TRY.
        DATA(carrier) = NEW /dmo/carrier( carrier_id = flight_data-carrier_id ).
      CATCH cx_abap_invalid_value.
        cl_abap_unit_assert=>fail( `UNABLE TO INSTANTIATE.` ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

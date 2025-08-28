*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-DATA conn_counter TYPE i READ-ONLY.

    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
      RAISING
        cx_abap_invalid_value.

    " Functional Method
    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: carrier_id            TYPE /dmo/carrier_id,
          connection_id         TYPE /dmo/connection_id,
          airport_from_id       TYPE /dmo/airport_from_id,
          airport_to_id         TYPE /dmo/airport_to_id,
          carrier_name          TYPE /dmo/carrier_name.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.

*    SELECT SINGLE
*        FROM /dmo/connection
*        FIELDS airport_from_id, airport_to_id   "DepartureAirport, DestinationAirport
*        WHERE carrier_id    = @i_carrier_id
*          AND connection_id = @i_connection_id
*        INTO ( @airport_from_id, @airport_to_id ).

* Create a SELECT statement that reads from CDS view entity /DMO/I_Connection.
    SELECT SINGLE
        FROM /DMO/I_Connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
        WHERE AirlineID     = @i_carrier_id
          AND ConnectionID  = @i_connection_id
        INTO ( @airport_from_id, @airport_to_id, @carrier_name ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    conn_counter    = conn_counter + 1.

  ENDMETHOD.

  METHOD get_output.

    APPEND |------------------------------|               TO r_output.
    APPEND |Carrier:     { carrier_id } { carrier_name }| TO r_output.
    APPEND |Connection:  { connection_id }|               TO r_output.
    APPEND |Departure:   { airport_from_id }|             TO r_output.
    APPEND |Destination: { airport_to_id   }|             TO r_output.


  ENDMETHOD.

ENDCLASS.
.

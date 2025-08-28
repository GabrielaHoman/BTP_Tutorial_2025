*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.

     TYPES:
      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE   /dmo/airport_to_id,
        AirlineName        TYPE   /dmo/carrier_name,
      END OF st_details.


    METHODS constructor
      IMPORTING
        i_carrier_id TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id.

 " Functional Method
    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

    PROTECTED SECTION.

  PRIVATE SECTION.

    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    DATA details TYPE st_details.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.

    me->details         = details.
    me->carrier_id      = i_carrier_id.
    me->connection_id   = i_connection_id.

    SELECT SINGLE
        FROM /DMO/I_Connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name AS AirlineName
        WHERE AirlineID    = @i_carrier_id
          AND ConnectionID = @i_connection_id
        INTO CORRESPONDING FIELDS OF @details.


  ENDMETHOD.

  METHOD get_output.

    APPEND |--------------------------------|                    TO r_output.
    APPEND |Carrier:     { carrier_id } { details-airlinename }| TO r_output.
    APPEND |Connection:  { connection_id   }|                    TO r_output.
    APPEND |Departure:   { details-departureairport     }|       TO r_output.
    APPEND |Destination: { details-destinationairport   }|       TO r_output.

  ENDMETHOD.

ENDCLASS.

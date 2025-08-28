*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION CREATE PUBLIC.

PUBLIC SECTION.

    CLASS-DATA conn_counter TYPE i READ-ONLY.

    CLASS-METHODS class_constructor.


*    METHODS constructor
*      IMPORTING
*        i_carrier_id    TYPE /dmo/carrier_id
*        i_connection_id TYPE /dmo/connection_id
*      RAISING
*        cx_abap_invalid_value.

    " Functional Method
    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

PROTECTED SECTION.

  PRIVATE SECTION.
*    DATA carrier_id    TYPE /dmo/carrier_id.
*    DATA connection_id TYPE /dmo/connection_id.


    TYPES:
      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName        TYPE /dmo/carrier_name,
      END OF st_details.

    TYPES:
      BEGIN OF st_airport,
        AirportId TYPE /dmo/airport_id,
        Name      TYPE /dmo/airport_name,
      END OF st_airport.

      TYPES tt_airports TYPE STANDARD TABLE OF st_airport
                           WITH NON-UNIQUE DEFAULT KEY.

      CLASS-DATA: airports TYPE tt_airports,
                  details  TYPE st_details.

  ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD class_constructor.

    SELECT FROM /DMO/I_Airport
            FIELDS AirportID, Name
              INTO TABLE @airports.

    SELECT SINGLE
        FROM /DMO/I_Connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name AS AirlineName
        WHERE   AirlineID    = 'LH'
            AND ConnectionID = '0400'
        INTO CORRESPONDING FIELDS OF @details.

  ENDMETHOD.

  METHOD get_output.

    DATA(departure)   = airports[ airportID = details-departureairport ].
    DATA(destination) = airports[ airportID = details-destinationairport ].

    APPEND |------------------------------| TO r_output.
    APPEND |Departure:   { details-departureairport   } { departure-name   }| TO r_output.
    APPEND |Destination: { details-destinationairport } { destination-name }| TO r_output.

  ENDMETHOD.

ENDCLASS.

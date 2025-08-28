CLASS zcl_gabi_read_structured_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gabi_read_structured_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


* Example 1 : Motivation for Structured Variables
**********************************************************************

    DATA connection_full TYPE /DMO/I_Connection.

    SELECT SINGLE
     FROM /dmo/I_Connection
     FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport,
          DepartureTime, ArrivalTime, Distance, DistanceUnit
     WHERE AirlineId    = 'LH'
       AND ConnectionId = '0400'
     INTO @connection_full.

    out->write(  `--------------------------------------` ).
    out->write(  `Example 1: CDS View as Structured Type` ).
    out->write( connection_full ).

* Example 2: Global Structured Type
**********************************************************************

    DATA message TYPE symsg.

    out->write(  `---------------------------------` ).
    out->write(  `Example 2: Global Structured Type` ).
    out->write( message ).

* Example 3 : Local Structured Type
**********************************************************************

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    DATA connection TYPE st_connection.

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
     WHERE AirlineID = 'LH'
       AND ConnectionID = '0400'
      INTO @connection.

    out->write(  `---------------------------------------` ).
    out->write(  `Example 3: Local Structured Type` ).
    out->write( connection ).

* Example 4 : Nested Structured Type
**********************************************************************

    TYPES: BEGIN OF st_nested,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             message         TYPE symsg,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_nested.

    DATA connection_nested TYPE st_nested.

    out->write(  `---------------------------------` ).
    out->write(  `Example 4: Nested Structured Type` ).
    out->write( connection_nested ).

**********************************************************************
**********************************************************************
**********************************************************************
* Example 1: Access to structure components
**********************************************************************

    connection-airport_from_id = 'ABC'.
    connection-airport_to_id   = 'XYZ'.
    connection-carrier_name    = 'My Airline'.

    "Access to sub-components of nested structure
    connection_nested-message-msgty = 'E'.
    connection_nested-message-msgid = 'ABC'.
    connection_nested-message-msgno = '123'.

* Example 2: Filling a structure with VALUE #(    ).
**********************************************************************

    CLEAR connection.

    connection = VALUE #( airport_from_id = 'ABC'
                          airport_to_id   = 'XYZ'
                          carrier_name    = 'My Airline'
                        ).

    " Nested VALUE to fill nested structure
    connection_nested = VALUE #( airport_from_id = 'ABC'
                                 airport_to_id   = 'XYZ'
                                 message         = VALUE #( msgty = 'E'
                                                            msgid = 'ABC'
                                                            msgno = '123' )
                                 carrier_name    = 'My Airline'
                         ).

* Example 3: Wrong result after direct assignment
**********************************************************************

    connection_nested = connection.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 3: Wrong Result after direct assignment` ).

    out->write( data = connection
                name = `Source Structure:` ).

    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
    out->write( |Component connection_nested-carrier_name : { connection_nested-carrier_name  }| ).

* Example 4: Assigning Structures using CORRESPONDING #( )
**********************************************************************
    CLEAR connection_nested.
    connection_nested = CORRESPONDING #(  connection ).  "

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 4: Correct Result after assignment with CORRESPONDING` ).

    out->write( data = connection
                name = `Source Structure:` ).

    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
    out->write( |Component connection_nested-carrier_name : { connection_nested-carrier_name  }| ).

**********************************************************************
**********************************************************************
* Inner Joins and Structured Data Objects in ABAP SQL ****************
**********************************************************************
    TYPES: BEGIN OF st_connection_short,
             DepartureAirport   TYPE /dmo/airport_from_id,
             DestinationAirport TYPE /dmo/airport_to_id,
           END OF st_connection_short.

    DATA connection_short TYPE st_connection_short.

* Example 1: Correspondence between FIELDS and INTO
**********************************************************************

    SELECT SINGLE
       FROM /DMO/I_Connection
     FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
      WHERE AirlineID = 'LH'
        AND ConnectionID = '0400'
       INTO @connection.

    out->write(  `------------------------------` ).
    out->write(  `Example 1: Field List and INTO` ).
    out->write( connection ).

* Example 2: FIELDS *
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS *
     WHERE AirlineID = 'LH'
       AND ConnectionID = '0400'
      INTO @connection_full.

    out->write(  `----------------------------` ).
    out->write(  `Example 2: FIELDS * and INTO` ).
    out->write( connection_full ).

* Example 3: INTO CORRESPONDING FIELDS
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS *
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO CORRESPONDING FIELDS OF @connection_short.

    out->write(  `----------------------------------------------------` ).
    out->write(  `Example 3: FIELDS * and INTO CORRESPONDING FIELDS OF` ).
    out->write( connection_short ).

* Example 4: Alias Names for Fields
**********************************************************************

    CLEAR connection.

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport AS airport_from_id,
           \_Airline-Name   AS carrier_name
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO CORRESPONDING FIELDS OF @connection.

    out->write(  `---------------------------------------------------` ).
    out->write(  `Example 4: Aliases and INTO CORRESPONDING FIELDS OF` ).
    out->write( connection ).

* Example 5: Inline Declaration
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport,
           DestinationAirport AS ArrivalAirport,
           \_Airline-Name     AS carrier_name
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO @DATA(connection_inline).

    out->write(  `-----------------------------------------` ).
    out->write(  `Example 5: Aliases and Inline Declaration` ).
    out->write( connection_inline ).

* Example 6: Joins
**********************************************************************

    SELECT SINGLE
      FROM (  /dmo/connection AS c
      LEFT OUTER JOIN /dmo/airport AS f
        ON c~airport_from_id = f~airport_id )
      LEFT OUTER JOIN /dmo/airport AS t
        ON c~airport_to_id = t~airport_id
    FIELDS c~airport_from_id, c~airport_to_id,
           f~name AS airport_from_name, t~name AS airport_to_name
     WHERE c~carrier_id    = 'LH'
       AND c~connection_id = '0400'
      INTO @DATA(connection_join).

    out->write(  `------------------------------------------` ).
    out->write(  `Example 6: Join of Connection and Airports` ).
    out->write( connection_join ).

**********************************************************************
**********************************************************************
*In this exercise, you declare a structured attribute, fill it using a SELECT statement and access the structure components.
**********************************************************************

    DATA: lcl_connection TYPE REF TO lcl_connection,

          connections    TYPE TABLE OF REF TO lcl_connection.

* First Instance
**********************************************************************
    TRY.
        lcl_connection = NEW #( i_carrier_id    = 'LH'  i_connection_id = '0400' ).

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

    APPEND lcl_connection TO connections.

    LOOP AT connections INTO lcl_connection.

      out->write( lcl_connection->get_output( ) ).

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

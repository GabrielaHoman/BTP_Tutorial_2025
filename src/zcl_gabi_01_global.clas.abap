CLASS zcl_gabi_01_global DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gabi_01_global IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: connection    TYPE REF TO lcl_connection,
          connection2   TYPE REF TO lcl_connection,

          connections   TYPE TABLE OF REF TO lcl_connection,

          carrier_id    TYPE        /dmo/carrier_id,
          connection_id TYPE        /dmo/connection_id.

* First Instance
**********************************************************************
    TRY.
        connection = NEW #( i_carrier_id    = 'LH'  i_connection_id = '0400' ).

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

    APPEND connection TO connections.


*    connection->carrier_id = 'LH'.
*    connection->connection_id = '0400'.
*
*    APPEND connection TO connections.

*    TRY.
*        connection->set_attributes(
*          EXPORTING
*            i_carrier_id    = 'LH'
*            i_connection_id = '0400'
*        ).
*
*        APPEND connection TO connections.
*
*      CATCH cx_abap_invalid_value.
*        out->write( `Method call failed` ).
*    ENDTRY.

* Second Instance
**********************************************************************
*    connection2 = connection.
*    APPEND connection2 TO connections.
    TRY.
        connection = NEW #( i_carrier_id    = 'AA' i_connection_id = '0017' ).

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

    APPEND connection TO connections.

*    TRY.
*        connection->set_attributes(
*          EXPORTING
*            i_carrier_id    = 'AA'
*            i_connection_id = '0017'
*        ).
*
*
*        APPEND connection TO connections.
*
*      CATCH cx_abap_invalid_value.
*        out->write( `Method call failed` ).
*    ENDTRY.

* Third Instance
**********************************************************************
    TRY.
        connection = NEW #( i_carrier_id    = 'SQ'  i_connection_id = '0001' ).

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

    APPEND connection TO connections.

*    connection->carrier_id    = 'AA'.
*    connection->connection_id = '0017'.
*
*    APPEND connection TO connections.

*    TRY.
*        connection->set_attributes(
*          EXPORTING
*            i_carrier_id    = 'SQ'
*            i_connection_id = '0001'
*        ).
*
*        APPEND connection TO connections.
*
*      CATCH cx_abap_invalid_value.
*        out->write( `Method call failed` ).
*    ENDTRY.

** Fourth Instance
***********************************************************************
*    connection = NEW #(  ).
*    connection->carrier_id    = 'SQ'.
*    connection->connection_id = '0001'.
*
*    APPEND connection TO connections.
*
*    LOOP AT connections INTO connection .
*
** Call Method and Handle Exception
***********************************************************************
*      out->write(  |i_carrier_id    = '{ connection->carrier_id }' | ).
*      out->write(  |i_connection_id = '{ connection->connection_id }'| ).
*
*      TRY.
*          connection->set_attributes(
*            EXPORTING
*              i_carrier_id    = connection->carrier_id
*              i_connection_id = connection->connection_id
*          ).
*
*          APPEND connection TO connections.
*          out->write( `Method call successful` ).
*        CATCH cx_abap_invalid_value.
*          out->write( `Method call failed`     ).
*      ENDTRY.
*
*
** Calling Functional Method
***********************************************************************
*      " in a value assignment (with inline declaration for result)
*      DATA(result) = connection->get_output( ).
*
*      " in logical expression
*      IF connection->get_output(  ) IS NOT INITIAL.
*
*        " as operand in a statement
*        LOOP AT connection->get_output(  ) INTO DATA(line).
*
*        ENDLOOP.
*
*        "  to supply input parameter of another method
*        out->write( data = connection->get_output( )
*                    name = `  ` ).
*
*      ENDIF.
*
*      out->write( connection->get_output( ) ).
*
**      connection->get_attributes(
**        IMPORTING
**          e_carrier_id    = carrier_id
**          e_connection_id = connection_id ).
*
*    ENDLOOP.

* Output
**********************************************************************
    LOOP AT connections INTO connection.

      out->write( connection->get_output( ) ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

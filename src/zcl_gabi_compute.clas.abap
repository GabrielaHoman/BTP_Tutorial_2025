CLASS zcl_gabi_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GABI_COMPUTE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*
** Declarations
***************************
*    DATA number1 TYPE i.
*    DATA number2 TYPE i.
*
*    DATA result TYPE p LENGTH 8 DECIMALS 2.
*
** Input Values
***************************
*    number1 = -8.
*    number2 =  3.
*
** Calculation
***************************
**    DATA(result) = number1 / number2.   "with inline declaration
*    result = number1 / number2.
*
*    DATA(output) = |{ number1 } / { number2 } = { result }|.
*
** Output
***************************
*    out->write( result ).
*
*    out->write( output ).

**********************************************************************
**********************************************************************
**********************************************************************
* Declarations
**********************************************************************

*    CONSTANTS c_number TYPE i VALUE 0.
**    CONSTANTS c_number TYPE i VALUE 1.
**    CONSTANTS c_number TYPE i VALUE 2.
**    CONSTANTS c_number TYPE i VALUE -1.
**    CONSTANTS c_number TYPE i VALUE -2.
*
** Example 1: Simple IF ... ENDIF.
***********************************************************************
*
*    out->write(  `--------------------------------` ).
*    out->write(  `Example 1: Simple IF ... ENDIF.` ).
*    out->write(  `-------------------------------` ).
*
*    IF c_number = 0.
*      out->write( `The value of C_NUMBER equals zero`   ).
*    ELSE.
*      out->write( `The value of C_NUMBER is NOT zero`   ).
*    ENDIF.
*
** Example 2: Optional Branches ELSEIF and ELSE
***********************************************************************
*
*    out->write(  `--------------------------------------------` ).
*    out->write(  `Example 2: Optional Branches ELSEIF and ELSE` ).
*    out->write(  `--------------------------------------------` ).
*
*    IF c_number = 0.
*      out->write( `The value of C_NUMBER equals zero`            ).
*    ELSEIF c_number > 0.
*      out->write( `The value of C_NUMBER is greater than zero`   ).
*    ELSE.
*      out->write( `The value of C_NUMBER is less than zero`      ).
*    ENDIF.
*
** Example 3: CASE ... ENDCASE
***********************************************************************
*
*    out->write(  `---------------------------` ).
*    out->write(  `Example 3: CASE ... ENDCASE` ).
*    out->write(  `---------------------------` ).
*
*    CASE c_number.
*      WHEN 0.
*        out->write( `The value of C_NUMBER equals zero`             ).
*      WHEN 1.
*        out->write( `The value of C_NUMBER equals one`              ).
*      WHEN 2.
*        out->write( `The value of C_NUMBER equals two`              ).
*      WHEN OTHERS.
*        out->write( `The value of C_NUMBER equals non of the above` ).
*    ENDCASE.

***********************************************************************
***********************************************************************
***********************************************************************
* Exception Handling **************************************************

** Declarations
***********************************************************************
*    DATA result TYPE i.
*
*    DATA numbers TYPE TABLE OF i.
*
** Preparation
***********************************************************************
*
*    APPEND 123 TO numbers.
*
** Example 1: Conversion Error (no Number)
***********************************************************************
*
*    CONSTANTS c_text TYPE string VALUE 'ABC'.
**    CONSTANTS c_text TYPE string VALUE '123'.
*
*    out->write(  `---------------------------` ).
*    out->write(  `Example 1: Conversion Error` ).
*    out->write(  `---------------------------` ).
*
*    TRY.
*        result = c_text.
*        out->write( |Converted content is { result }|  ).
*      CATCH cx_sy_conversion_no_number.
*        out->write( |Error: { c_text } is not a number!| ).
*    ENDTRY.
*
** Example 2: Division by Zero
***********************************************************************
*
*    CONSTANTS c_number TYPE i VALUE 0.
**    CONSTANTS c_number TYPE i VALUE 7.
*
*    out->write(  `---------------------------` ).
*    out->write(  `Example 2: Division by Zero` ).
*    out->write(  `---------------------------` ).
*
*    TRY.
*        result = 100 / c_number.
*        out->write( |100 divided by { c_number } equals { result }| ).
*      CATCH cx_sy_zerodivide.
*        out->write(  `Error: Division by zero is not defined!` ).
*    ENDTRY.
*
** Example 3: Itab Error (Line Not Found)
***********************************************************************
*
*    CONSTANTS c_index TYPE i VALUE 2.
**    CONSTANTS c_index TYPE i VALUE 1.
*
*    out->write(  `-------------------------` ).
*    out->write(  `Example 3: Line Not Found` ).
*    out->write(  `-------------------------` ).
*
*    TRY.
*        result = numbers[ c_index ].
*        out->write( |Content of row { c_index } equals { result }| ).
*      CATCH cx_sy_itab_line_not_found.
*        out->write(  `Error: Itab has less than { c_index } rows!` ).
*    ENDTRY.
*
*
** Example 4: Combination of Different Exceptions
***********************************************************************
**    CONSTANTS c_char TYPE c LENGTH 1 VALUE 'X'.
**    CONSTANTS c_char TYPE c length 1 value '0'.
*    CONSTANTS c_char TYPE c LENGTH 1 VALUE '1'.
**    CONSTANTS c_char TYPE c length 1 value '2'.
*
*    out->write(  `----------------------` ).
*    out->write(  `Example 4: Combination` ).
*    out->write(  `----------------------` ).
*
*    TRY.
*        result = numbers[ 2 / c_char ].
*        out->write( |Result: { result } | ).
*      CATCH cx_sy_zerodivide.
*        out->write( `Error: Division by zero is not defined`  ).
*      CATCH cx_sy_conversion_no_number.
*        out->write( |Error: { c_char } is not a number! | ).
*      CATCH cx_sy_itab_line_not_found.
*        out->write( |Error: Itab contains less than { 2 / c_char } rows| ).
*    ENDTRY.

***********************************************************************
***********************************************************************
***********************************************************************
* Itirations    *******************************************************

** Declarations
***********************************************************************
*
*    CONSTANTS c_number TYPE i VALUE 3.
**    CONSTANTS c_number TYPE i VALUE 5.
**    CONSTANTS c_number TYPE i VALUE 10.
*
*    DATA number TYPE i.
*
** Example 1: DO ... ENDDO with TIMES
***********************************************************************
*
*    out->write(  `----------------------------------` ).
*    out->write(  `Example 1: DO ... ENDDO with TIMES` ).
*    out->write(  `----------------------------------` ).
*
*    DO c_number TIMES.
*      out->write(  `Hello World` ).
*    ENDDO.
*
** Example 2: DO ... ENDDO with Abort Condition
***********************************************************************
*
*    out->write(  `-------------------------------` ).
*    out->write(  `Example 2: With Abort Condition` ).
*    out->write(  `-------------------------------` ).
*
*    number = c_number * c_number.
*
*    " count backwards from number to c_number.
*    DO.
*
*      out->write( |{ sy-index }: Value of number: {  number }| ).
*      number = number - 1.
*
*      "abort condition
*      IF number <= c_number.
*        EXIT.
*      ENDIF.

*    ENDDO.

***********************************************************************
***********************************************************************
***********************************************************************
* Simple Internal Tables **********************************************

* Declarations
**********************************************************************

    " Internal tables
    DATA numbers TYPE TABLE OF i.

    "Table type (local)
    TYPES tt_strings TYPE TABLE OF string.
    DATA texts1      TYPE tt_strings.

    " Table type (global)
    DATA texts2 TYPE string_table.

    " work areas
    DATA number TYPE i VALUE 1234.
    DATA text TYPE string.

* Example 1: APPEND
**********************************************************************

    APPEND 4711       TO numbers.
    APPEND number     TO numbers.
    APPEND 2 * number TO numbers.

    out->write(  `-----------------` ).
    out->write(  `Example 1: APPEND` ).
    out->write(  `-----------------` ).

    out->write( numbers ).

* Example 2: CLEAR
**********************************************************************

    CLEAR numbers.

    out->write(  `----------------` ).
    out->write(  `Example 2: CLEAR` ).
    out->write(  `----------------` ).

    out->write( numbers ).

* Example 3: table expression
**********************************************************************
    APPEND 4711       TO numbers.
    APPEND number     TO numbers.
    APPEND 2 * number TO numbers.

    out->write(  `---------------------------` ).
    out->write(  `Example 3: Table Expression` ).
    out->write(  `---------------------------` ).

    number = numbers[ 2 ] .

    out->write( |Content of row 2: { number }|    ).
    "Direct use of expression in string template
    out->write( |Content of row 1: { numbers[ 1 ]  }| ).

* Example 4: LOOP ... ENDLOOP
**********************************************************************
    out->write(  `---------------------------` ).
    out->write(  `Example 4: LOOP ... ENDLOOP` ).
    out->write(  `---------------------------` ).

    LOOP AT numbers INTO number.

      out->write( |Row: { sy-tabix } Content { number }| ).

    ENDLOOP.

* Example 5: Inline declaration in LOOP ... ENDLOOP
**********************************************************************
    out->write(  `-----------------------------` ).
    out->write(  `Example 5: Inline Declaration` ).
    out->write(  `-----------------------------` ).

    LOOP AT numbers INTO DATA(number_inline).
      out->write( |Row: { sy-tabix } Content { number_inline }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

*&---------------------------------------------------------------------*
*& Report ZSAM_UNIT_TEST_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSAM_UNIT_TEST_DEMO.
*----------------------------------------------------------------------*
*       CLASS math DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS math DEFINITION.
  PUBLIC SECTION.
    METHODS divide
            IMPORTING opr1    TYPE i
                      opr2    TYPE i
            EXPORTING result  TYPE f
            RAISING   cx_sy_arithmetic_error.
    METHODS factorial
       IMPORTING n TYPE i
       RETURNING value(fact) TYPE i.
ENDCLASS.                              "math DEFINITION
*----------------------------------------------------------------------*
*       CLASS math IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS math IMPLEMENTATION.
  METHOD divide.
    result = opr2 / opr1.
  ENDMETHOD.                           "divide
  METHOD factorial.
    fact = 1.
    IF n = 0.
      RETURN.
    ELSE.
      DO n TIMES.
        fact = fact * sy-index.
      ENDDO.
    ENDIF.
  ENDMETHOD.                           "factorial
ENDCLASS.                              "math IMPLEMENTATION
START-OF-SELECTION.
  DATA w_obj TYPE REF TO math.
  DATA exc  TYPE REF TO cx_sy_arithmetic_error.
  DATA res  TYPE f.
  DATA result TYPE i.
  DATA text TYPE string.
  CREATE OBJECT w_obj.
  TRY.
      w_obj->divide( EXPORTING opr1 = 32 opr2 = 4
                         IMPORTING result = res ).
      WRITE : res.
      text = res.
    CATCH cx_sy_arithmetic_error INTO exc.
      text = exc->get_text( ).
      MESSAGE text TYPE 'I'.
  ENDTRY.
  CREATE OBJECT w_obj.
  COMPUTE result = w_obj->factorial( 4 ).
  WRITE :/ 'The result for factorial is:',result.
*----------------------------------------------------------------------*
*       CLASS mytest DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS mytest DEFINITION  "#AU Risk_Level Harmless
            FOR TESTING. "#AU Duration Short
  PRIVATE SECTION.
    METHODS mytest FOR TESTING.
ENDCLASS.                    "mytest DEFINITION
*----------------------------------------------------------------------*
*       CLASS mytest IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS mytest IMPLEMENTATION.
  METHOD mytest.
    CREATE OBJECT w_obj.
    result = w_obj->factorial( 4 ).
    cl_aunit_assert=>assert_equals( act    = result
                                    exp    = '23'
                                    msg    = 'Factorial Not calculated Correctly'
                                    level  = '0'
                                    quit   = '2'
                                    tol    = '0.999'
                                     ).
  ENDMETHOD.                    "mytest
ENDCLASS.                    "mytest IMPLEMENTATION

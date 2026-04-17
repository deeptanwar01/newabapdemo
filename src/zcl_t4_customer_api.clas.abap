* Singleton Class: Ensures only ONE instance of this class exists
CLASS zcl_t4_customer_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "Static method to access the single instance of the class
    "This is the ONLY way consumers should get the object reference
    CLASS-METHODS get_instance
      RETURNING VALUE(ro_instance) TYPE REF TO zcl_t4_customer_api.

  PROTECTED SECTION.
  PRIVATE SECTION.

    "Static attribute to hold the single instance (shared across all calls)
    CLASS-DATA mo_instance TYPE REF TO zcl_t4_customer_api.

ENDCLASS.



CLASS zcl_t4_customer_api IMPLEMENTATION.

  METHOD get_instance.

    "Singleton logic:
    "If instance already exists → reuse it
    "If not → create a new instance

    ro_instance = mo_instance = COND #(
      WHEN mo_instance IS BOUND      "Check if instance already exists
      THEN mo_instance              "Reuse existing instance
      ELSE NEW #( )                 "Create new instance
    ).

    "Explanation:
    "mo_instance = ... → stores the instance (so next call reuses it)
    "ro_instance = ... → returns the instance to caller

  ENDMETHOD.

ENDCLASS.

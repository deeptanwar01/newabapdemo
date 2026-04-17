CLASS zcl_t4n_customer_um_api DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "==================== RAP TYPE DEFINITIONS ====================
    " These types are automatically aligned with your RAP BO (CDS view)

    TYPES tt_entities        TYPE TABLE FOR CREATE zt4n_c_customer\\customer. " Input for CREATE
    TYPES tt_mapped          TYPE RESPONSE FOR MAPPED EARLY zt4n_c_customer.   " Used to return generated keys (e.g., UUID)
    TYPES tt_failed          TYPE RESPONSE FOR FAILED EARLY zt4n_c_customer.   " Used to return failed records
    TYPES tt_reported        TYPE RESPONSE FOR REPORTED EARLY zt4n_c_customer. " Used for messages (early phase)
    TYPES tt_reported_late   TYPE RESPONSE FOR REPORTED LATE zt4n_c_customer.  " Used for messages during SAVE
    TYPES tt_entities_update TYPE TABLE FOR UPDATE zt4n_c_customer\\customer. " Input for UPDATE
    TYPES tt_keys_delete     TYPE TABLE FOR DELETE zt4n_c_customer\\customer. " Keys for DELETE
    TYPES tt_keys_read       TYPE TABLE FOR READ IMPORT zt4n_c_customer\\customer. " Keys for READ
    TYPES tt_result          TYPE TABLE FOR READ RESULT zt4n_c_customer\\customer. " Output of READ

    "==================== SINGLETON ACCESS ====================
    " Ensures only one instance of this class is used
    CLASS-METHODS get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_t4n_customer_um_api.

    "==================== RAP OPERATIONS ====================

    " Called BEFORE CREATE → used for generating keys (UUID)
    METHODS earlynumbering_create
      IMPORTING !entities TYPE   tt_entities
      CHANGING  !mapped   TYPE tt_mapped
                !failed   TYPE tt_failed
                !reported TYPE tt_reported.

    " CREATE → prepare data (NO DB operation yet)
    METHODS create
      IMPORTING !entities TYPE tt_entities
      CHANGING  !mapped   TYPE tt_mapped
                !failed   TYPE tt_failed
                !reported TYPE tt_reported.

    " SAVE → actual DB insert/update/delete happens here
    METHODS save
      CHANGING !reported TYPE tt_reported_late.

    " UPDATE → prepare updated data (NO DB operation yet)
    METHODS update
      IMPORTING !entities TYPE  tt_entities_update
      CHANGING  !mapped   TYPE tt_mapped
                !failed   TYPE tt_failed
                !reported TYPE tt_reported.

    " DELETE → collect records to delete (NO DB yet)
    METHODS delete
      IMPORTING !keys     TYPE tt_keys_delete
      CHANGING  !mapped   TYPE tt_mapped
                !failed   TYPE tt_failed
                !reported TYPE tt_reported.

    " READ → fetch data from DB immediately
    METHODS read
      IMPORTING !keys     TYPE tt_keys_read
      CHANGING  !result   TYPE tt_result
                !failed   TYPE tt_failed
                !reported TYPE tt_reported.

  PRIVATE SECTION.
    "==================== INTERNAL DATA ====================

    CLASS-DATA mo_instance TYPE REF TO zcl_t4n_customer_um_api. " Singleton instance

    " Buffers used in unmanaged RAP (very important concept)
    DATA it_customer      TYPE STANDARD TABLE OF zt4ncustomer. " For create/update
    DATA gt_customer_dele TYPE STANDARD TABLE OF zt4ncustomer. " For delete
    DATA it_customer_read TYPE STANDARD TABLE OF zt4ncustomer. " For read

ENDCLASS.


CLASS zcl_t4n_customer_um_api IMPLEMENTATION.
  METHOD get_instance.
    " If instance already exists → reuse it
    " Else → create new instance
    mo_instance = COND #( WHEN mo_instance IS BOUND
                          THEN mo_instance
                          ELSE NEW #( ) ).

    ro_instance = mo_instance.
  ENDMETHOD.


  METHOD earlynumbering_create.

    " TODO: parameter FAILED is never used or assigned (ABAP cleaner)
    " TODO: parameter REPORTED is never used or assigned (ABAP cleaner)

    " Generate UUID (primary key)
    DATA(newID) = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).

    IF entities IS NOT INITIAL.

      " Return generated ID to RAP framework
      " This allows UI to know the key BEFORE save
      mapped-customer = VALUE #( ( %cid      = entities[ 1 ]-%cid   " Temporary client-side ID
                                   %is_draft = entities[ 1 ]-%is_draft
                                   Id        = newID ) ).           " Generated UUID

    ENDIF.
  ENDMETHOD.


  METHOD create.
    " TODO: parameter MAPPED is never used or assigned (ABAP cleaner)
    " TODO: parameter FAILED is never used or assigned (ABAP cleaner)
    " TODO: parameter REPORTED is never used or assigned (ABAP cleaner)

    " Convert RAP entity structure → DB structure
    it_customer = CORRESPONDING #( entities ).

    IF it_customer IS NOT INITIAL.

      " Manual field mapping (because unmanaged RAP)
      it_customer[ 1 ]-first_name   = entities[ 1 ]-FirstName.
      it_customer[ 1 ]-last_name    = entities[ 1 ]-LastName.
      it_customer[ 1 ]-email        = entities[ 1 ]-Email.
      it_customer[ 1 ]-phone_number = entities[ 1 ]-PhoneNumber.

      " Set audit fields
      GET TIME STAMP FIELD DATA(tsl).
      it_customer[ 1 ]-last_changed_at       = tsl.
      it_customer[ 1 ]-local_last_changed_at = tsl.
      it_customer[ 1 ]-created_at            = tsl.
      it_customer[ 1 ]-created_by            = sy-uname.

    ENDIF.

    " NOTE:
    " No database insert here!
    " Data is only stored in internal buffer (it_customer)
  ENDMETHOD.


  METHOD save.
    " TODO: parameter REPORTED is never used or assigned (ABAP cleaner)

    " Insert/Update records in DB
    IF it_customer IS NOT INITIAL.

      " MODIFY works as INSERT or UPDATE depending on key
      MODIFY zt4ncustomer FROM TABLE @it_customer.

    ENDIF.

    " Delete records from DB
    IF gt_customer_dele IS NOT INITIAL.

      DELETE zt4ncustomer FROM TABLE @gt_customer_dele.

      " Clear delete buffer after operation
      FREE gt_customer_dele.

    ENDIF.
  ENDMETHOD.


  METHOD update.
    " TODO: parameter MAPPED is never used or assigned (ABAP cleaner)
    " TODO: parameter FAILED is never used or assigned (ABAP cleaner)
    " TODO: parameter REPORTED is never used or assigned (ABAP cleaner)

    " Move update data into buffer
    it_customer = CORRESPONDING #( entities ).

    IF it_customer IS NOT INITIAL.

      " Update fields manually
      it_customer[ 1 ]-first_name   = entities[ 1 ]-FirstName.
      it_customer[ 1 ]-last_name    = entities[ 1 ]-LastName.
      it_customer[ 1 ]-email        = entities[ 1 ]-Email.
      it_customer[ 1 ]-phone_number = entities[ 1 ]-PhoneNumber.

      " Update timestamps
      GET TIME STAMP FIELD DATA(tsl).
      it_customer[ 1 ]-last_changed_at       = tsl.
      it_customer[ 1 ]-local_last_changed_at = tsl.

    ENDIF.

    " NOTE:
    " Still no DB update here!
  ENDMETHOD.


  METHOD delete.
    " TODO: parameter MAPPED is never used or assigned (ABAP cleaner)
    " TODO: parameter FAILED is never used or assigned (ABAP cleaner)
    " TODO: parameter REPORTED is never used or assigned (ABAP cleaner)

    " Fetch records to delete and store in buffer
    SELECT * FROM zt4ncustomer
      FOR ALL ENTRIES IN @keys
      WHERE id = @keys-Id
      INTO TABLE @gt_customer_dele.

    " Actual deletion happens in SAVE method
  ENDMETHOD.

  METHOD read.
    " TODO: parameter FAILED is never used or assigned (ABAP cleaner)
    " TODO: parameter REPORTED is never used or assigned (ABAP cleaner)

    " Fetch data from DB based on keys
    SELECT * FROM zt4ncustomer
      FOR ALL ENTRIES IN @keys
      WHERE id = @keys-Id
      INTO TABLE @it_customer_read.

    IF sy-subrc = 0.

      " Convert DB structure → RAP response structure
      result = CORRESPONDING #( it_customer_read ).

    ENDIF.
  ENDMETHOD.
ENDCLASS.

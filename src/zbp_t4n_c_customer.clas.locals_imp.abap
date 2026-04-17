
"====================================================================
" BEHAVIOR HANDLER CLASS
"====================================================================
CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    "================ AUTHORIZATION ================="
* Triggered only for specific instance ex for one specifc data set
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customer RESULT result.
* this will trigger on global bases like Create Button
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Customer RESULT result.

    "================ CRUD OPERATIONS ================="
* In managed this is automaticlly handeled and they dont show-up in managed.
* here we have to manage all

* only in transaction buffer and not commited to DB
    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Customer.

* this method is triggerd when we click on Create button, after that control will go to Create.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Customer.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Customer.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Customer.
* Before we edit anything we have to read data first, so in Unmanaged frame work does that, but in unmanaged we have to handle this
    METHODS read FOR READ
      IMPORTING keys FOR READ Customer RESULT result.

    "================ LOCK ================="

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Customer.

    "================ ACTIONS ================="

    METHODS upload FOR MODIFY
      IMPORTING keys FOR ACTION Customer~upload.

    METHODS copy FOR MODIFY
      IMPORTING keys FOR ACTION Customer~copy.

    METHODS CopyFromTemp FOR MODIFY
      IMPORTING keys FOR ACTION Customer~CopyFromTemp.

ENDCLASS.



CLASS lhc_Customer IMPLEMENTATION.

  "------------------------------------------------------------
  " Instance-level authorization (not implemented here)
  "------------------------------------------------------------
  METHOD get_instance_authorizations.
  ENDMETHOD.


  "------------------------------------------------------------
  " Global authorization check (demo logic)
  "------------------------------------------------------------
  METHOD get_global_authorizations.

    DATA(auth_check) = abap_true.

    IF auth_check = abap_true.

      "Allow all operations
      result-%create = if_abap_behv=>auth-allowed.
      result-%update = if_abap_behv=>auth-allowed.
      result-%delete = if_abap_behv=>auth-allowed.
      result-%action-edit = if_abap_behv=>auth-allowed.

    ELSE.

      "Deny all operations
      result-%create = if_abap_behv=>auth-unauthorized.
      result-%update = if_abap_behv=>auth-unauthorized.
      result-%delete = if_abap_behv=>auth-unauthorized.

      "Send error message to UI
      APPEND VALUE #(
        %msg = new_message_with_text(
                 text     = 'Not Authorized'
                 severity = if_abap_behv_message=>severity-error )
        %global = if_abap_behv=>mk-on )
      TO reported-customer.

    ENDIF.

  ENDMETHOD.


  "------------------------------------------------------------
  " CREATE → delegate to API class
  "------------------------------------------------------------
  METHOD create.

    zcl_t4n_customer_um_api=>get_instance( )->create(
      EXPORTING entities = entities
      CHANGING  mapped   = mapped
                failed   = failed
                reported = reported ).

  ENDMETHOD.


  "------------------------------------------------------------
  " EARLY NUMBERING → UUID generation
  "------------------------------------------------------------
  METHOD earlynumbering_create.

    zcl_t4n_customer_um_api=>get_instance( )->earlynumbering_create(
      EXPORTING entities = entities
      CHANGING  mapped   = mapped
                failed   = failed
                reported = reported ).

  ENDMETHOD.


  "------------------------------------------------------------
  " UPDATE → delegate
  "------------------------------------------------------------
  METHOD update.

    zcl_t4n_customer_um_api=>get_instance( )->update(
      EXPORTING entities = entities
      CHANGING  mapped   = mapped
                failed   = failed
                reported = reported ).

  ENDMETHOD.


  "------------------------------------------------------------
  " DELETE → delegate
  "------------------------------------------------------------
  METHOD delete.

    zcl_t4n_customer_um_api=>get_instance( )->delete(
      EXPORTING keys = keys
      CHANGING  mapped   = mapped
                failed   = failed
                reported = reported ).

  ENDMETHOD.


  "------------------------------------------------------------
  " READ → delegate
  "------------------------------------------------------------
  METHOD read.

    zcl_t4n_customer_um_api=>get_instance( )->read(
      EXPORTING keys = keys
      CHANGING  result   = result
                failed   = failed
                reported = reported ).

  ENDMETHOD.


  "------------------------------------------------------------
  " LOCK → prevents parallel editing
  "------------------------------------------------------------
  METHOD lock.

    TRY.
        DATA(o_lock) = cl_abap_lock_object_factory=>get_instance(
                          iv_name = 'EZ_ZT4NCUSTOMER' ).
      CATCH cx_abap_lock_failure INTO DATA(error).
        RAISE SHORTDUMP error.
    ENDTRY.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).

      TRY.
          o_lock->enqueue(
            it_parameter = VALUE #(
              ( name = 'ID' value = REF #( <key>-id ) ) ) ).

        CATCH cx_abap_foreign_lock INTO DATA(foreign_lock).

          APPEND VALUE #(
            id = <key>-id
            %msg = new_message_with_text(
                     text     = |Record locked by user { foreign_lock->user_name }|
                     severity = if_abap_behv_message=>severity-error ) )
          TO reported-customer.

        CATCH cx_abap_lock_failure INTO error.
          RAISE SHORTDUMP error.

      ENDTRY.

    ENDLOOP.

  ENDMETHOD.


  "------------------------------------------------------------
  " ACTION: upload (not implemented)
  "------------------------------------------------------------
  METHOD upload.
  ENDMETHOD.


  "------------------------------------------------------------
  " ACTION: copy existing record
  "------------------------------------------------------------
  METHOD copy.

    DATA customer TYPE TABLE FOR CREATE zt4n_c_customer\\customer.

    READ ENTITIES OF zt4n_c_customer
      IN LOCAL MODE ENTITY Customer
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_customer)
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_reported).

    LOOP AT lt_customer ASSIGNING FIELD-SYMBOL(<customer>).

      "Prepare new record (copy old data except ID)
      APPEND VALUE #(
        %cid      = keys[ KEY entity %key = <customer>-%key ]-%cid
        %is_draft = keys[ KEY entity %key = <customer>-%key ]-%param-%is_draft
        %data     = CORRESPONDING #( <customer> EXCEPT id ) )
      TO customer ASSIGNING FIELD-SYMBOL(<new_customer>).

      "Set timestamps
      GET TIME STAMP FIELD DATA(tsl).
      <new_customer>-LastChangedAt      = tsl.
      <new_customer>-LocalLastChangedAt = tsl.
      <new_customer>-CreatedAt          = tsl.
      <new_customer>-CreatedBy          = sy-uname.

      "Generate new UUID
      <new_customer>-Id = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).

    ENDLOOP.

    "Create new record in RAP runtime
    MODIFY ENTITIES OF zt4n_c_customer IN LOCAL MODE
      ENTITY Customer
      CREATE FIELDS ( Id FirstName LastName Email CreatedAt CreatedBy LastChangedAt LocalLastChangedAt PhoneNumber )
      WITH customer
      MAPPED DATA(mapped_create).

    mapped-Customer = mapped_create-Customer.

  ENDMETHOD.


  "------------------------------------------------------------
  " ACTION: copy from template
  "------------------------------------------------------------
  METHOD copyfromtemp.

    DATA customer TYPE TABLE FOR CREATE zt4n_c_customer\\customer.

    GET TIME STAMP FIELD DATA(tsl).

    customer = VALUE #(
      ( %cid      = keys[ 1 ]-%cid
        %is_draft = keys[ 1 ]-%param-%is_draft

        %data = VALUE #(
          FirstName          = 'First Name'
          LastName           = 'Last Name'
          Email              = '@test.com'
          PhoneNumber        = '999-222-3333'
          Id                 = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( )
          LastChangedAt      = tsl
          LocalLastChangedAt = tsl ) ) ).

    MODIFY ENTITIES OF zt4n_c_customer IN LOCAL MODE
      ENTITY Customer
      CREATE FIELDS ( Id FirstName LastName Email CreatedAt CreatedBy LastChangedAt LocalLastChangedAt PhoneNumber )
      WITH customer
      MAPPED DATA(mapped_create).

    mapped-Customer = mapped_create-Customer.

  ENDMETHOD.

ENDCLASS.



"====================================================================
" SAVER CLASS (final DB commit happens here)
"====================================================================
CLASS lsc_ZT4N_C_CUSTOMER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize          REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
    METHODS cleanup           REDEFINITION.
    METHODS cleanup_finalize  REDEFINITION.

ENDCLASS.



CLASS lsc_ZT4N_C_CUSTOMER IMPLEMENTATION.

  "Called after save logic preparation
* Data is formated and finalized in this.
  METHOD finalize.
  ENDMETHOD.

  "Validation before DB commit, this is final validation and last option to not commit data
  METHOD check_before_save.
  ENDMETHOD.

* if we use Late Numbering we will see another method here i.e. ADJUST_NUMBERS
* METHODS adjust_numbers REDEFINITION.

  "ACTUAL DATABASE SAVE TRIGGER
  METHOD save.

    zcl_t4n_customer_um_api=>get_instance( )->save(
      CHANGING reported = reported ).

  ENDMETHOD.

  "Cleanup memory buffers - After DB commit we can write code here
  METHOD cleanup.
  ENDMETHOD.

  "Final cleanup after everything - If some data was finalized, but in commit before save we have error, both Save and Cleanup wont trigger
  " and this method will trigger where we can do clean-up of internal tables, vairables
  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

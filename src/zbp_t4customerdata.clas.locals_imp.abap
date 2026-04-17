**********************************************************************
*Handler Class*
**********************************************************************
CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    " Below two methods are also included in Manager Scenario
    "  Authorization applicable for that specific instance i.e. specific to a data which is being displayed
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customer RESULT result.

    " Applicable to the entire BO for ex Authorization on Create or Delete button
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Customer RESULT result.
* In managed below actions are automatically handelled, but in Unmanaged we have handle.
* All these methods keep data in transactin buffer i.e. its not added to DB until managed later.
    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Customer.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Customer.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Customer.

    METHODS read FOR READ
      IMPORTING keys FOR READ Customer RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Customer.

ENDCLASS.

CLASS lhc_Customer IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*Saves Class* and Saver Methods below
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
CLASS lsc_ZT4CUSTOMERDATA DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
" We weite determination, for ex user inputs specifc data but before save we want to drive more data for other fields
" all that logi is written in this method as name suggests.
    METHODS finalize REDEFINITION.

" after that check before save is called and final validaitons on data is done here, and we can stop commit here.
    METHODS check_before_save REDEFINITION.

" As we have used late numbering, we can add logic to identify next numebr and use that
    METHODS adjust_numbers REDEFINITION.

" next call is Save, once this is triggered data is saved in DB
    METHODS save REDEFINITION.

" after Save, clean-up is called to remove data from internal tabls for ex.
    METHODS cleanup REDEFINITION.

" if we have error in Check Before save or issue in Finalize, this method is called and we do clear variables or tables here.
    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZT4CUSTOMERDATA IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD adjust_numbers.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

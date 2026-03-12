CLASS zcl_t2_customer DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_t2_customer IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    DATA lt_output TYPE TABLE OF zt2_custom_entity.

    TRY.
"Filter Condition being created as range table
        DATA(lt_filters) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range.

    ENDTRY.
" reading the filter into range
    IF lines( lt_filters ) > 0.
      DATA(r_customer) = lt_filters[ name = 'CUSTOMERID' ]-range.
    ENDIF.
" selecting data from the table or this can be an BAPI too
    SELECT customer_id, first_name, last_name
      FROM /dmo/customer
      WHERE customer_id IN @r_customer
      INTO TABLE @DATA(lt_customer).
" As field names are different b/t table and CDS, mapping is needed
    lt_output = CORRESPONDING #( lt_customer MAPPING
                                  CustomerId = customer_id
                                  FirstName = first_name
                                  LastName = last_name ).

    TRY.
        " TODO: variable is assigned but never used (ABAP cleaner)
" If we dont use this paging it will give run time error
        DATA(lv_top) = io_request->get_paging( )->get_page_size( ).
" Setting total number of records
        io_response->set_total_number_of_records( lines( lt_output ) ).
" Displaying the data
        io_response->set_data( it_data = lt_output ).
      CATCH cx_rap_query_response_set_twic.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

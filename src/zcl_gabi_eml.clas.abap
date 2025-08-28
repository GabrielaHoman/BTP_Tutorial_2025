CLASS zcl_gabi_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gabi_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: update_tab   TYPE TABLE FOR UPDATE /DMO/R_AgencyTP,

          agencies_upd TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.

    update_tab = VALUE #( ( AgencyID = '070002' Name = 'Gabi Modified' ) ) .

    agencies_upd = VALUE #( ( agencyid = '070050' name = 'Some fancy new name Gabi' ) ).

    MODIFY ENTITIES OF /DMO/R_AgencyTP
      ENTITY /dmo/agency
      UPDATE FIELDS ( Name )
      WITH update_tab.

    MODIFY ENTITIES OF /dmo/i_agencytp
      ENTITY /dmo/agency
      UPDATE FIELDS ( name )
        WITH agencies_upd.

    COMMIT ENTITIES.

    out->write( `Method execution finished!`  ).

  ENDMETHOD.

ENDCLASS.

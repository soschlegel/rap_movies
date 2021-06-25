CLASS zsdf_generator DEFINITION
  PUBLIC
   INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.

    METHODS main REDEFINITION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zsdf_generator IMPLEMENTATION.

  METHOD main.


    DATA(json_string) = |\{\r\n| &
                        |  "implementationType": "managed_uuid",\r\n| &
                        |  "namespace": "ZSDF_",\r\n| &
                        |  "suffix": "_M",  \r\n| &
                        |  "package": "ZSDF_MOVIES",\r\n| &
                        |  "datasourcetype": "table",\r\n| &
                        |  "bindingtype": "odata_v2_ui",\r\n| &
                        |  "draftenabled": false,  \r\n| &
                        |  "hierarchy": \{\r\n| &
                        |    "entityName": "Movie",\r\n| &
                        |    "dataSource": "zsdf_movie",    \r\n| &
                        |    "objectId": "title",\r\n| &
                        |    "uuid": "movie_id",\r\n| &
                        |    "lastChangedAt": "last_changed_at"\r\n| &
                        |  \}\r\n| &
                        |\}|.

    DATA(rap_generator) = NEW /dmo/cl_rap_generator( json_string ).
    DATA(todos) = rap_generator->generate_bo(  ).
    DATA(rap_bo_name) = rap_generator->root_node->rap_root_node_objects-service_binding.
    out->write( |RAP BO { rap_bo_name }  generated successfully| ).
    out->write( |Todo's:| ).
    LOOP AT todos INTO DATA(todo).
      out->write( todo ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

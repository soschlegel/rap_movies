@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View for Person'
define root view entity ZSDF_I_PERSON_U as select from zsdf_person
 {
    
    key person_id  as PersonId,
        first_name as FirstName,
        last_name  as LastName,
        last_changed_at as LastChangedAt

}

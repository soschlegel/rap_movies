@EndUserText.label: 'Projection for ZSDF_C_Person_U'
@AccessControl.authorizationCheck: #CHECK

@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZSDF_C_PERSON_U as projection on ZSDF_I_PERSON_U {
    
    key PersonId,
        FirstName,
        LastName,
        LastChangedAt
}

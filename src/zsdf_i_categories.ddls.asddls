@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZSDF_I_Categories
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZSDF_CATEGORY' )
{
//https://blogs.sap.com/2020/02/08/using-texts-in-fiori-apps/
  key   value_low as Category,
        @Semantics.text: true
        text
}
where
  language = $session.system_language

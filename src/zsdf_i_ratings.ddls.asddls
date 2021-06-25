@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZSDF_I_Ratings
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZSDF_RATING' )
{
  key   value_low as Rating,
        @Semantics.text: true
        text
}
where
  language = $session.system_language

public class DAO_LeadSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Lead.id
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Lead.sObjectType;
    }
    
    public List<Lead> selectWithBlankSource(Integer quantity){
        return (List<Lead>) Database.query(
                newQueryFactory()
                        .setCondition('leadSource = null')
                        .setLimit(quantity)
                        .toSOQL()
        );
    	
    }
}
public class DAO_OpportunityLineItemsSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
                OpportunityLineItem.unitPrice
        };
    }

    public Schema.SObjectType getSObjectType() {
        return OpportunityLineItem.sObjectType;
    }
}
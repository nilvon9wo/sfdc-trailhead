public class DAO_OpportunityLineItemsSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>
        {
                OpportunityLineItem.id,
                OpportunityLineItem.listPrice,
                OpportunityLineItem.opportunityId,
                OpportunityLineItem.pricebookEntryId,
                OpportunityLineItem.quantity,
                OpportunityLineItem.sortOrder,
                OpportunityLineItem.totalPrice,
                OpportunityLineItem.unitPrice
        };
    }

    public Schema.SObjectType getSObjectType() {
        return OpportunityLineItem.sObjectType;
    }
}
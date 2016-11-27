@isTest 
public class MOCK_OpportunityLineItemFactory {
	public static OpportunityLineItem create(fflib_SObjectUnitOfWork unitOfWork, Opportunity opportunity, PricebookEntry pricebookEntry) {
		OpportunityLineItem opportunityLineItem =  new OpportunityLineItem(
			quantity = 1,
			totalPrice = 10
		);
		
		Schema.sObjectField relatedPricebookEntryField = Schema.SObjectType.OpportunityLineItem.fields.PricebookEntryId.getSObjectField();
		unitOfWork.registerRelationship(opportunityLineItem, relatedPricebookEntryField, pricebookEntry);
		
		Schema.sObjectField relatedOpportunityField = Schema.SObjectType.OpportunityLineItem.fields.opportunityId.getSObjectField();
		unitOfWork.registerNew(opportunityLineItem, relatedOpportunityField, opportunity);
		return opportunityLineItem;		 
	}
}
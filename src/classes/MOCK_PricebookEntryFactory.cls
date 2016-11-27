@isTest 
public class MOCK_PricebookEntryFactory {
	public static PricebookEntry create(fflib_SObjectUnitOfWork unitOfWork, Product2 product) {
		PricebookEntry pricebookEntry = new PricebookEntry(
			unitPrice = 10,
			isActive = true,
			useStandardPrice = false,
			pricebook2Id = Test.getStandardPricebookId()		
		);
		
		Schema.sObjectField relatedField = Schema.SObjectType.PricebookEntry.fields.Product2Id.getSObjectField();
		unitOfWork.registerNew(pricebookEntry, relatedField, product);  
		return pricebookEntry;		
	}
}
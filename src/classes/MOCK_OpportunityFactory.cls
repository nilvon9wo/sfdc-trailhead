@isTest 
public class MOCK_OpportunityFactory {
	private static fflib_SObjectUnitOfWork unitOfWork = createUnitOfWork();
	private static Map<SObjectType, List<SObject>> sObjectListBySObjectMap = createSObjectListBySObjectMap();

	public static Map<SObjectType, List<SObject>> createList(Integer quantity, TEST_DummyInsertModeEnum insertMode) {
		for (Integer i = 0; i < quantity; i++) {
			create(i);
		} 
		 
		unitOfWork.commitWork(insertMode);
		return sObjectListBySObjectMap;
	}

	public static Opportunity createWithAccount(fflib_SObjectUnitOfWork unitOfWork2, Account account){
		return createWithAccount(unitOfWork2, account, 1); 
	}
	
	public static Opportunity createWithAccount(fflib_SObjectUnitOfWork unitOfWork2, Account account, Integer i){
		Opportunity opportunity = new Opportunity (
			name = account.Name + ' Opportunity ' + i,
			accountId = account.id,
			stageName = 'Prospecting',
			type = 'New Customer',
			closeDate = System.today().addMonths(1)
		);
		unitOfWork2.registerNew(opportunity);
		return opportunity;	
	}

	private static Opportunity create(Integer i){
		Opportunity opportunity = new Opportunity (
			name = 'Opportunity ' + i,
			stageName = 'Open',
			type = 'New Customer',
			closeDate = System.today()
		);
		unitOfWork.registerNew(opportunity);				
 
		for (Integer j = 0; j < i + 1; j++) {
			createRelationships(opportunity, i, j);
		}  
		sObjectListBySObjectMap.get(Opportunity.getSObjectType()).add(opportunity);
		return opportunity;
	}
	
	private static Map<SObjectType, List<SObject>> createRelationships (Opportunity opportunity, Integer i, Integer j){
		Product2 product = MOCK_ProductFactory.create(unitOfWork, opportunity, i);
		PricebookEntry pricebookEntry = MOCK_PricebookEntryFactory.create(unitOfWork, product);
		OpportunityLineItem opportunityLineItem = MOCK_OpportunityLineItemFactory.create(unitOfWork, opportunity, pricebookEntry);

		sObjectListBySObjectMap.get(Product2.getSObjectType()).add(product);
		sObjectListBySObjectMap.get(PricebookEntry.getSObjectType()).add(pricebookEntry);
		sObjectListBySObjectMap.get(OpportunityLineItem.getSObjectType()).add(opportunityLineItem);
		return sObjectListBySObjectMap;
	}
	
	// ------------------------------------------------------------------------------------
	
	private static fflib_SObjectUnitOfWork createUnitOfWork() {
		return new fflib_SObjectUnitOfWork (
			new Schema.SObjectType[]{
				Product2.SObjectType,
				PricebookEntry.SObjectType,
				Opportunity.SObjectType,
				OpportunityLineItem.SObjectType
			}
		);
	}
	
	private static Map<SObjectType, List<SObject>> createSObjectListBySObjectMap(){
		return new Map<SObjectType, List<SObject>> {
			Opportunity.getSObjectType() => new List<Opportunity>(),
			Product2.getSObjectType() => new List<Product2>(),
			PricebookEntry.getSObjectType() => new List<PricebookEntry>(),
			OpportunityLineItem.getSObjectType() => new List<OpportunityLineItem>()
		};
	}
}